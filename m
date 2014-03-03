Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 20C292C0078
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2014 02:29:03 +1100 (EST)
Received: from /spool/local
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Mon, 3 Mar 2014 12:28:57 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 2CAD51DC0050
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Mar 2014 10:28:54 -0500 (EST)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s23FSnjm50397298
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Mar 2014 12:28:49 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s23FSrJK016858
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Mar 2014 12:28:53 -0300
Date: Mon, 3 Mar 2014 12:28:51 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH] vfio-pci: avoid deadlock between unbind and
 VFIO_DEVICE_RESET
Message-ID: <20140303152851.GA20894@oc0268524204.ibm.com>
References: <1393857192-28360-1-git-send-email-cascardo@linux.vnet.ibm.com>
 <1393859362.2895.34.camel@ul30vt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1393859362.2895.34.camel@ul30vt.home>
Cc: kvm@vger.kernel.org, aik@ozlabs.ru, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 03, 2014 at 08:09:22AM -0700, Alex Williamson wrote:
> On Mon, 2014-03-03 at 11:33 -0300, Thadeu Lima de Souza Cascardo wrote:
> > When we unbind vfio-pci from a device, while running a guest, we might
> > have a deadlock when such a guest reboots.
> > 
> > Unbind takes device_lock at device_release_driver, and waits for
> > release_q at vfio_del_group_dev.
> > 
> > release_q will only be woken up when all references to vfio_device are
> > gone, and that includes open file descriptors, like the ones a guest
> > on qemu will hold.
> > 
> > If you try to reboot the guest, it will call VFIO_DEVICE_RESET, which
> > calls pci_reset_function, which now grabs the device_lock, and we are
> > deadlocked.
> > 
> > Using device_trylock allow us to handle the case when the lock is
> > already taken, and avoid this situation.
> > 
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
> > ---
> > 
> > Not tested yet, but I would like some comments now, like would it be
> > better to have a pci_try_reset_function, or do trylock on
> > pci_reset_function itself?
> 
> 
> We already have it:
> 
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=61cf16d8bd38c3dc52033ea75d5b1f8368514a17
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=890ed578df82f5b7b5a874f9f2fa4f117305df5f
> 
> Is there something insufficient about these or are you testing on and
> older kernel?  Thanks,
> 
> Alex

Sorry I missed it. On the rush to report and fix it, I looked only on my
local branch. Should we backport those two patches to long term stable
3.10? I can reproduce the issue there.

Thanks.
Cascardo.

> 
> 
> > ---
> >  drivers/vfio/pci/vfio_pci.c |   14 ++++++++++++--
> >  1 files changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> > index 3b76dc8..d1d2242 100644
> > --- a/drivers/vfio/pci/vfio_pci.c
> > +++ b/drivers/vfio/pci/vfio_pci.c
> > @@ -513,8 +513,18 @@ static long vfio_pci_ioctl(void *device_data,
> >  		return ret;
> >  
> >  	} else if (cmd == VFIO_DEVICE_RESET) {
> > -		return vdev->reset_works ?
> > -			pci_reset_function(vdev->pdev) : -EINVAL;
> > +		struct pci_dev *pdev = vdev->pdev;
> > +		int ret = -EBUSY;
> > +		if (!vdev->reset_works)
> > +			return -EINVAL;
> > +		if (pci_cfg_access_trylock(pdev)) {
> > +			if (device_trylock(&pdev->dev)) {
> > +				ret = __pci_reset_function_locked(pdev);
> > +				device_unlock(&pdev->dev);
> > +			}
> > +			pci_cfg_access_unlock(pdev);
> > +		}
> > +		return ret;
> >  
> >  	} else if (cmd == VFIO_DEVICE_GET_PCI_HOT_RESET_INFO) {
> >  		struct vfio_pci_hot_reset_info hdr;
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
