Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ABCEA1A1A3C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 09:46:31 +1100 (AEDT)
Message-ID: <1454021188.23148.7.camel@redhat.com>
Subject: Re: [RFC PATCH v3 5/5] vfio-pci: Allow to mmap MSI-X table if host
 bridge supports filtering of MSIs
From: Alex Williamson <alex.williamson@redhat.com>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org
Cc: bhelgaas@google.com, corbet@lwn.net, aik@ozlabs.ru,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 warrier@linux.vnet.ibm.com, zhong@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com
Date: Thu, 28 Jan 2016 15:46:28 -0700
In-Reply-To: <1452841574-2781-6-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1452841574-2781-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1452841574-2781-6-git-send-email-xyjxie@linux.vnet.ibm.com>
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

On Fri, 2016-01-15 at 15:06 +0800, Yongji Xie wrote:
> Current vfio-pci implementation disallows to mmap MSI-X
> table in case that user get to touch this directly.
> 
> But we should allow to mmap these MSI-X tables if the PCI
> host bridge supports filtering of MSIs.
> 
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 11fd0f0..4d68f6a 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -555,7 +555,8 @@ static long vfio_pci_ioctl(void *device_data,
>  			    IORESOURCE_MEM && !pci_resources_share_page(pdev,
>  			    info.index)) {
>  				info.flags |= VFIO_REGION_INFO_FLAG_MMAP;
> -				if (info.index == vdev->msix_bar) {
> +				if (!pci_host_bridge_msi_filtered_enabled(pdev) &&
> +				    info.index == vdev->msix_bar) {
>  					ret = msix_sparse_mmap_cap(vdev, &caps);
>  					if (ret)
>  						return ret;
> @@ -967,7 +968,8 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
>  	if (phys_len < PAGE_SIZE || req_start + req_len > phys_len)
>  		return -EINVAL;
>  
> -	if (index == vdev->msix_bar) {
> +	if (!pci_host_bridge_msi_filtered_enabled(pdev) &&
> +	    index == vdev->msix_bar) {
>  		/*
>  		 * Disallow mmaps overlapping the MSI-X table; users don't
>  		 * get to touch this directly.  We could find somewhere

What about read()/write() access, why would we allow mmap() but not
those?
