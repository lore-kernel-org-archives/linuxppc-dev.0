Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 00E791A0297
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jan 2016 08:43:11 +1100 (AEDT)
Message-ID: <1451943775.12575.6.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH v2 3/3] vfio-pci: Allow to mmap MSI-X table if EEH
 is supported
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>, Yongji Xie
 <xyjxie@linux.vnet.ibm.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, corbet@lwn.net, aik@ozlabs.ru, paulus@samba.org,
 mpe@ellerman.id.au, warrier@linux.vnet.ibm.com,
 zhong@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com
Date: Tue, 05 Jan 2016 08:42:55 +1100
In-Reply-To: <1451941655.6585.8.camel@redhat.com>
References: <1451551844-11732-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1451551844-11732-4-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1451941655.6585.8.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-01-04 at 14:07 -0700, Alex Williamson wrote:
> On Thu, 2015-12-31 at 16:50 +0800, Yongji Xie wrote:
> > Current vfio-pci implementation disallows to mmap MSI-X
> > table in case that user get to touch this directly.
> > 
> > However, EEH mechanism can ensure that a given pci device
> > can only shoot the MSIs assigned for its PE. So we think
> > it's safe to expose the MSI-X table to userspace because
> > the exposed MSI-X table can't be used to do harm to other
> > memory space.
> > 
> > And with MSI-X table mmapped, some performance issues which
> > are caused when PCI adapters have critical registers in the
> > same page as the MSI-X table also can be resolved.
> > 
> > So this patch adds a Kconfig option, VFIO_PCI_MMAP_MSIX,
> > to support for mmapping MSI-X table.
> > 
> > Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> > ---
> >  drivers/vfio/pci/Kconfig    |    4 ++++
> >  drivers/vfio/pci/vfio_pci.c |    6 ++++--
> >  2 files changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
> > index 02912f1..67b0a2c 100644
> > --- a/drivers/vfio/pci/Kconfig
> > +++ b/drivers/vfio/pci/Kconfig
> > @@ -23,6 +23,10 @@ config VFIO_PCI_MMAP
> >  	depends on VFIO_PCI
> >  	def_bool y if !S390
> >  
> > +config VFIO_PCI_MMAP_MSIX
> > +	depends on VFIO_PCI_MMAP
> > +	def_bool y if EEH
> 
> Does CONFIG_EEH necessarily mean the EEH is enabled?  Could the
> system
> not support EEH or could EEH be disabled via kernel commandline
> options?

EEH is definitely the wrong thing to test here anyway. What needs to be
tested is that the PCI Host bridge supports filtering of MSIs, so
ideally this should be some kind of host bridge attribute set by the
architecture backend.

This can happen with or without CONFIG_EEH and you are right,
CONFIG_EEH can be enabled and the machine not support it.

Any IODA bridge will support this.

Cheers,
Ben.

> > +
> >  config VFIO_PCI_INTX
> >  	depends on VFIO_PCI
> >  	def_bool y if !S390
> > diff --git a/drivers/vfio/pci/vfio_pci.c
> > b/drivers/vfio/pci/vfio_pci.c
> > index 09b3805..d536985 100644
> > --- a/drivers/vfio/pci/vfio_pci.c
> > +++ b/drivers/vfio/pci/vfio_pci.c
> > @@ -555,7 +555,8 @@ static long vfio_pci_ioctl(void *device_data,
> >  			    IORESOURCE_MEM && (info.size >=
> > PAGE_SIZE ||
> >  			    pci_resource_page_aligned)) {
> >  				info.flags |=
> > VFIO_REGION_INFO_FLAG_MMAP;
> > -				if (info.index == vdev->msix_bar)
> > {
> > +				if
> > (!IS_ENABLED(CONFIG_VFIO_PCI_MMAP_MSIX) &&
> > +				    info.index == vdev->msix_bar)
> > {
> >  					ret =
> > msix_sparse_mmap_cap(vdev, &caps);
> >  					if (ret)
> >  						return ret;
> > @@ -967,7 +968,8 @@ static int vfio_pci_mmap(void *device_data,
> > struct vm_area_struct *vma)
> >  	if (phys_len < PAGE_SIZE || req_start + req_len >
> > phys_len)
> >  		return -EINVAL;
> >  
> > -	if (index == vdev->msix_bar) {
> > +	if (!IS_ENABLED(CONFIG_VFIO_PCI_MMAP_MSIX) &&
> > +	    index == vdev->msix_bar) {
> >  		/*
> >  		 * Disallow mmaps overlapping the MSI-X table;
> > users
> > don't
> >  		 * get to touch this directly.  We could find
> > somewhere
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
