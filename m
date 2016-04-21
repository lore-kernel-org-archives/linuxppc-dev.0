Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrYnB3NmPzDqhB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 08:48:14 +1000 (AEST)
Message-ID: <1461278876.3135.18.camel@kernel.crashing.org>
Subject: Re: [PATCH V2] powerpc/infiniband: Use cache inhibitted and guarded
 mapping on powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Mike Marciniszyn <infinipath@intel.com>,
 Doug Ledford <dledford@redhat.com>, Sean Hefty <sean.hefty@intel.com>, Hal
 Rosenstock <hal.rosenstock@gmail.com>, linux-rdma@vger.kernel.org
Date: Fri, 22 Apr 2016 08:47:56 +1000
In-Reply-To: <1461139097-10213-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1461139097-10213-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On Wed, 2016-04-20 at 03:58 -0400, Aneesh Kumar K.V wrote:
> The driver was requesting for a writethrough mapping. But with thoses
> flags we will end up with a SAO mapping because we now have memory
> conherence always enabled. ie, the existing mapping will end up with
> a WIMG value 0b1110 which is Strong Access Order.
> 
> Update this to use cache inhibitted guarded mapping

Why guarded ? If it's performance sensitive (and the driver has
appropriate barriers where needed), you will get write combining
without guarded, you won't with it.

Cheers,
Ben.

> Cc: Mike Marciniszyn <infinipath@intel.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Sean Hefty <sean.hefty@intel.com>
> Cc: Hal Rosenstock <hal.rosenstock@gmail.com>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
> Changes from v1:
> * resend because V1 never reached mailing list.
> 
> NOTE: This is only compile tested and I am also not sure why ppc64
> needs special handling.
> We need this patch because the series at http://mid.gmane.org/1460182
> 444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com
> will drop _PAGE_WRITETHRU
> 
>  drivers/infiniband/hw/qib/qib_file_ops.c | 5 +----
>  drivers/infiniband/hw/qib/qib_pcie.c     | 6 ------
>  2 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c
> b/drivers/infiniband/hw/qib/qib_file_ops.c
> index e449e394963f..a3d593f546ec 100644
> --- a/drivers/infiniband/hw/qib/qib_file_ops.c
> +++ b/drivers/infiniband/hw/qib/qib_file_ops.c
> @@ -822,10 +822,7 @@ static int mmap_piobufs(struct vm_area_struct
> *vma,
>  	phys = dd->physaddr + piobufs;
>  
>  #if defined(__powerpc__)
> -	/* There isn't a generic way to specify writethrough
> mappings */
> -	pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE;
> -	pgprot_val(vma->vm_page_prot) |= _PAGE_WRITETHRU;
> -	pgprot_val(vma->vm_page_prot) &= ~_PAGE_GUARDED;
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>  #endif
>  
>  	/*
> diff --git a/drivers/infiniband/hw/qib/qib_pcie.c
> b/drivers/infiniband/hw/qib/qib_pcie.c
> index 4758a3801ae8..6abe1c621aa4 100644
> --- a/drivers/infiniband/hw/qib/qib_pcie.c
> +++ b/drivers/infiniband/hw/qib/qib_pcie.c
> @@ -144,13 +144,7 @@ int qib_pcie_ddinit(struct qib_devdata *dd,
> struct pci_dev *pdev,
>  	addr = pci_resource_start(pdev, 0);
>  	len = pci_resource_len(pdev, 0);
>  
> -#if defined(__powerpc__)
> -	/* There isn't a generic way to specify writethrough
> mappings */
> -	dd->kregbase = __ioremap(addr, len, _PAGE_NO_CACHE |
> _PAGE_WRITETHRU);
> -#else
>  	dd->kregbase = ioremap_nocache(addr, len);
> -#endif
> -
>  	if (!dd->kregbase)
>  		return -ENOMEM;
>  
