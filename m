Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYjJM4dyFzDsTQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 10:35:47 +1000 (AEST)
Date: Wed, 14 Sep 2016 10:12:39 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [RFC] KVM: PPC: Book3S HV: Fall back to same size HPT in
 allocation ioctl
Message-ID: <20160914001239.GB27379@fergus.ozlabs.ibm.com>
References: <1473678797-22069-1-git-send-email-khandual@linux.vnet.ibm.com>
 <87bmzrpd37.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87bmzrpd37.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 14, 2016 at 09:57:48AM +1000, Michael Ellerman wrote:
> Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
> 
> > When the HPT size is explicitly passed on from the userspace, currently
> > the KVM_PPC_ALLOCATE_HTAB will try to allocate the requested size of HPT
> > from reserved CMA area and if that is not possible, the allocation just
> > fails. With the commit 572abd563befd56 ("KVM: PPC: Book3S HV: Don't fall
> > back to smaller HPT size in allocation ioctl"), it does not even try to
> > allocate the same order pages from the page allocator before failing for
> > good. Same order allocation should be attempted from the page allocator
> > as a fallback option when the CMA allocation attempt fails.
> 
> It looks like if CMA is not configured we will just fail instantly.
> 
> So this does look like something we should fix.
> 
> But I think it is just a bug in commit 572abd563bef ("KVM: PPC: Book3S
> HV: Don't fall back to smaller HPT size in allocation ioctl"), which did:
> 
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 1f9c0a17f445..10722b1e38b5 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -70,7 +70,8 @@ long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
>         }
>  
>         /* Lastly try successively smaller sizes from the page allocator */
> -       while (!hpt && order > PPC_MIN_HPT_ORDER) {
> +       /* Only do this if userspace didn't specify a size via ioctl */
> +       while (!hpt && order > PPC_MIN_HPT_ORDER && !htab_orderp) {
>                 hpt = __get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_REPEAT|
>                                        __GFP_NOWARN, order - PAGE_SHIFT);
>                 if (!hpt)
> 
> 
> Instead of guarding the loop entry with !htab_orderp, it should have
> allowed the loop to enter, but prevented it from iterating if the
> allocation fails and htab_orderp != 0.

You're right.  I'll fix it.

Paul.
