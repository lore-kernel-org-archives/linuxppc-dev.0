Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYqpF2RRlzDrqB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 15:28:37 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8E5SRmW005612
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 01:28:34 -0400
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25evyusj4m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 01:28:34 -0400
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 14 Sep 2016 15:28:06 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id F059B3578053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 15:28:04 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8E5S4IA50331680
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 15:28:04 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8E5S4s8003773
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 15:28:04 +1000
Date: Wed, 14 Sep 2016 10:58:03 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
CC: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [RFC] KVM: PPC: Book3S HV: Fall back to same size HPT in
 allocation ioctl
References: <1473678797-22069-1-git-send-email-khandual@linux.vnet.ibm.com>
 <87bmzrpd37.fsf@concordia.ellerman.id.au>
In-Reply-To: <87bmzrpd37.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <57D8DFE3.50700@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/14/2016 05:27 AM, Michael Ellerman wrote:
> Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:

Not sure whether this mail ever went. Sending it again.

> 
>> > When the HPT size is explicitly passed on from the userspace, currently
>> > the KVM_PPC_ALLOCATE_HTAB will try to allocate the requested size of HPT
>> > from reserved CMA area and if that is not possible, the allocation just
>> > fails. With the commit 572abd563befd56 ("KVM: PPC: Book3S HV: Don't fall
>> > back to smaller HPT size in allocation ioctl"), it does not even try to
>> > allocate the same order pages from the page allocator before failing for
>> > good. Same order allocation should be attempted from the page allocator
>> > as a fallback option when the CMA allocation attempt fails.
> It looks like if CMA is not configured we will just fail instantly.

Right and also we have this fallback registered any way. I wonder
why we are still debating about the need of a fallback mechanism
when we already have got one.

> 
> So this does look like something we should fix.
> 
> But I think it is just a bug in commit 572abd563bef ("KVM: PPC: Book3S
> HV: Don't fall back to smaller HPT size in allocation ioctl"), which did:

Hmm, I think its something the commit missed to accommodate for.
But maybe yes, its a bug in the commit.

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

Right and thats what Aneesh's proposed patch (in the other thread) does.
