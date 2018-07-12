Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41R7sZ2cLJzF35P
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 18:10:26 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id c41-v6so10354072plj.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 01:10:25 -0700 (PDT)
Date: Thu, 12 Jul 2018 18:10:17 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson
 <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Alex Williamson
 <alex.williamson@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul
 Mackerras <paulus@ozlabs.org>, Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH kernel v6 2/2] KVM: PPC: Check if IOMMU page is
 contained in the pinned physical page
Message-ID: <20180712181017.667642d7@roar.ozlabs.ibm.com>
In-Reply-To: <20180711110044.15939-3-aik@ozlabs.ru>
References: <20180711110044.15939-1-aik@ozlabs.ru>
 <20180711110044.15939-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 11 Jul 2018 21:00:44 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

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
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> @@ -199,6 +209,25 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
>  			}
>  		}
>  populate:
> +		pageshift = PAGE_SHIFT;
> +		if (PageCompound(page)) {
> +			pte_t *pte;
> +			struct page *head = compound_head(page);
> +			unsigned int compshift = compound_order(head);
> +
> +			local_irq_save(flags); /* disables as well */
> +			pte = find_linux_pte(mm->pgd, ua, NULL, &pageshift);
> +			local_irq_restore(flags);
> +			if (!pte) {
> +				ret = -EFAULT;
> +				goto unlock_exit;
> +			}
> +			/* Double check it is still the same pinned page */
> +			if (pte_page(*pte) == head && pageshift == compshift)
> +				pageshift = max_t(unsigned int, pageshift,
> +						PAGE_SHIFT);

I don't understand this logic. If the page was different, the shift
would be wrong. You're not retrying but instead ignoring it in that
case.

I think I would be slightly happier with the definitely-not-racy
get_user_pages slow approach. Anything lock-less like this would be
a premature optimisation without performance numbers...

Thanks,
Nick
