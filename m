Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 58EBE2C0330
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 08:20:54 +1000 (EST)
Message-ID: <1380234044.24959.339.camel@snotra.buserror.net>
Subject: Re: [PATCH 5/7] iommu: supress loff_t compilation error on powerpc
From: Scott Wood <scottwood@freescale.com>
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Date: Thu, 26 Sep 2013 17:20:44 -0500
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D07183CA4@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1379575763-2091-6-git-send-email-Bharat.Bhushan@freescale.com>
 <1380127227.3030.316.camel@ul30vt.home>
 <6A3DF150A5B70D4F9B66A25E3F7C888D07183CA4@039-SN2MPN1-011.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "agraf@suse.de" <agraf@suse.de>, Wood Scott-B07421 <B07421@freescale.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-09-25 at 22:53 -0500, Bhushan Bharat-R65777 wrote:
> 
> > -----Original Message-----
> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Wednesday, September 25, 2013 10:10 PM
> > To: Bhushan Bharat-R65777
> > Cc: joro@8bytes.org; benh@kernel.crashing.org; galak@kernel.crashing.org; linux-
> > kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; linux-
> > pci@vger.kernel.org; agraf@suse.de; Wood Scott-B07421; iommu@lists.linux-
> > foundation.org; Bhushan Bharat-R65777
> > Subject: Re: [PATCH 5/7] iommu: supress loff_t compilation error on powerpc
> > 
> > On Thu, 2013-09-19 at 12:59 +0530, Bharat Bhushan wrote:
> > > Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
> > > ---
> > >  drivers/vfio/pci/vfio_pci_rdwr.c |    3 ++-
> > >  1 files changed, 2 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c
> > > b/drivers/vfio/pci/vfio_pci_rdwr.c
> > > index 210db24..8a8156a 100644
> > > --- a/drivers/vfio/pci/vfio_pci_rdwr.c
> > > +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
> > > @@ -181,7 +181,8 @@ ssize_t vfio_pci_vga_rw(struct vfio_pci_device *vdev, char
> > __user *buf,
> > >  			       size_t count, loff_t *ppos, bool iswrite)  {
> > >  	int ret;
> > > -	loff_t off, pos = *ppos & VFIO_PCI_OFFSET_MASK;
> > > +	loff_t off;
> > > +	u64 pos = (u64 )(*ppos & VFIO_PCI_OFFSET_MASK);
> > >  	void __iomem *iomem = NULL;
> > >  	unsigned int rsrc;
> > >  	bool is_ioport;
> > 
> > What's the compile error that this fixes?
> 
> I was getting below error; and after some googling I came to know that this is how it is fixed by other guys.
> 
> /home/r65777/linux-vfio/drivers/vfio/pci/vfio_pci_rdwr.c:193: undefined reference to `__cmpdi2'
> /home/r65777/linux-vfio/drivers/vfio/pci/vfio_pci_rdwr.c:193: undefined reference to `__cmpdi2'

It looks like PPC Linux implements __ucmpdi2, but not the signed
version.  That should be fixed, rather than hacking up random code to
avoid it.

-Scott
