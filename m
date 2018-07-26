Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bwSs5mmhzF0PZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2018 01:07:57 +1000 (AEST)
Date: Thu, 26 Jul 2018 17:07:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 stable@vger.kernel.org, #@ozlabs.ru, v4.12+@ozlabs.ru
Subject: Re: [PATCH kernel for v4.14 and v4.17 stable] KVM: PPC: Check if
 IOMMU page is contained in the pinned physical page
Message-ID: <20180726150738.GB27305@kroah.com>
References: <20180724053247.26870-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180724053247.26870-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 24, 2018 at 03:32:47PM +1000, Alexey Kardashevskiy wrote:
> A VM which has:
>  - a DMA capable device passed through to it (eg. network card);
>  - running a malicious kernel that ignores H_PUT_TCE failure;
>  - capability of using IOMMU pages bigger that physical pages
> can create an IOMMU mapping that exposes (for example) 16MB of
> the host physical memory to the device when only 64K was allocated to the VM.
> 
> The remaining 16MB - 64K will be some other content of host memory, possibly
> including pages of the VM, but also pages of host kernel memory, host
> programs or other VMs.
> 
> The attacking VM does not control the location of the page it can map,
> and is only allowed to map as many pages as it has pages of RAM.
> 
> We already have a check in drivers/vfio/vfio_iommu_spapr_tce.c that
> an IOMMU page is contained in the physical page so the PCI hardware won't
> get access to unassigned host memory; however this check is missing in
> the KVM fastpath (H_PUT_TCE accelerated code). We were lucky so far and
> did not hit this yet as the very first time when the mapping happens
> we do not have tbl::it_userspace allocated yet and fall back to
> the userspace which in turn calls VFIO IOMMU driver, this fails and
> the guest does not retry,
> 
> This stores the smallest preregistered page size in the preregistered
> region descriptor and changes the mm_iommu_xxx API to check this against
> the IOMMU page size.
> 
> This calculates maximum page size as a minimum of the natural region
> alignment and compound page size. For the page shift this uses the shift
> returned by find_linux_pte() which indicates how the page is mapped to
> the current userspace - if the page is huge and this is not a zero, then
> it is a leaf pte and the page is mapped within the range.
> 
> Fixes: 121f80ba68f1 ("KVM: PPC: VFIO: Add in-kernel acceleration for VFIO")
> Cc: stable@vger.kernel.org # v4.12+
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> (cherry picked from commit 76fa4975f3ed12d15762bc979ca44078598ed8ee)
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> The original patch did not apply because of fad953ce which fixed
> all vmalloc's to use array_size() so the backport is pretty trivial
> and applies to v4.17 stable as well.

THanks for the backport, now queued up.

greg k-h
