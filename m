Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id AA86E2C16E9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 06:46:28 +1100 (EST)
Message-ID: <1363808782.24132.534.camel@bling.home>
Subject: Re: [PATCH 2/3] VFIO: VFIO_DEVICE_SET_ADDR_MAPPING command
From: Alex Williamson <alex.williamson@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 20 Mar 2013 13:46:22 -0600
In-Reply-To: <1363807906.17680.11.camel@pasglop>
References: <1363332390-12754-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1363332390-12754-3-git-send-email-shangw@linux.vnet.ibm.com>
 <1363375740.16793.12.camel@ul30vt.home>
 <20130316013417.GA3873@shangw.(null)> <1363412256.1244.20.camel@pasglop>
 <1363640474.24132.433.camel@bling.home>
 <20130319032410.GA22591@shangw.(null)>
 <1363666721.24132.472.camel@bling.home> <1363668309.18880.10.camel@pasglop>
 <1363805280.24132.529.camel@bling.home> <1363807906.17680.11.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@ozlabs.ru, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <shangw@linux.vnet.ibm.com>, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-03-20 at 20:31 +0100, Benjamin Herrenschmidt wrote:
> On Wed, 2013-03-20 at 12:48 -0600, Alex Williamson wrote:
> > Perhaps my problem is that I don't have a clear picture of where
> > you're
> > going with this like I do for AER.  For AER we're starting with
> > notification of an error, from that we build into how to retrieve the
> > error information, and finally how to perform corrective action.  Each
> > of these will be done through vifo-pci.
> > 
> > Here we're starting by registering a mapping that's really only useful
> > to the vfio "accelerator" path, but we don't even have a hint of what
> > the non-accelerated path is and how vfio is involved with it.  Thanks,
> 
> I'm surprised that you are building so much policy around AER ... can't
> you just pass the raw stuff down to the guest and let the guest do it's
> own corrective actions ?

How does the guest get the raw stuff?  We need to get the AER interrupt
out to the guest so it can be injected into the virtual PCIe port, then
we need to be able to retrieve the physical device log and pass it to
the qemu to mangle to match the guest topology.  We don't have existing
firmware interfaces for the guest to do that, so it's all being routed
through vfio-pci.

> As for EEH, I will let Gavin describe in more details what he is doing,
> though I wouldn't be surprised if so far he doesn't have a
> non-accelerated path :-) Which indeed makes things oddball, granted ...
> at least for now. I *think* what Gavin's doing right now is a
> pass-through to the host EEH directly in the kernel, so without a slow
> path...
> 
> Gavin, it really boils down to that. In-kernel EEH for guests is a
> KVMism that ends up not involving VFIO in any other way than
> establishing the mapping, then arguably it could be done via a VM ioctl.
> 
> If there's more going through VFIO and shared state, then it should
> probably go through VFIO-PCI.

Exactly my thinking.  Thanks,

Alex
