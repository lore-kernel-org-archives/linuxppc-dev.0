Return-Path: <vipin@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTT8K2z52zDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 20:14:41 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1N9Dlob069391
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 04:14:39 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28svjugy2a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 04:14:39 -0500
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vipin@linux.vnet.ibm.com>;
 Thu, 23 Feb 2017 14:44:36 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 58966125804F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 14:44:40 +0530 (IST)
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1N9EWHd9830580
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 14:44:32 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1N9EVHM025388
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 14:44:32 +0530
Subject: Re: [PATCH v2] KVM: PPC: Book3S: Ratelimit copy data failure error
 messages
To: kvm-ppc@vger.kernel.org
References: <1487265026-25473-1-git-send-email-vipin@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
From: Vipin K Parashar <vipin@linux.vnet.ibm.com>
Date: Thu, 23 Feb 2017 14:44:31 +0530
MIME-Version: 1.0
In-Reply-To: <1487265026-25473-1-git-send-email-vipin@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <c5892d92-0a4d-626e-9191-fb4ff3b8f3f6@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch uses "printk_ratelimited" in place of
"printk_ratelimit" used in v1


On Thursday 16 February 2017 10:40 PM, Vipin K Parashar wrote:
> kvm_ppc_mmu_book3s_32/64 xlat() logs "KVM can't copy data" error
> upon failing to copy user data to kernel space. This floods kernel
> log once such fails occur in short time period. Ratelimit this
> error to avoid flooding kernel logs upon copy data failures.
>
> Signed-off-by: Vipin K Parashar <vipin@linux.vnet.ibm.com>
> ---
>   arch/powerpc/kvm/book3s_32_mmu.c | 3 ++-
>   arch/powerpc/kvm/book3s_64_mmu.c | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kvm/book3s_32_mmu.c b/arch/powerpc/kvm/book3s_32_mmu.c
> index a2eb6d3..1992676 100644
> --- a/arch/powerpc/kvm/book3s_32_mmu.c
> +++ b/arch/powerpc/kvm/book3s_32_mmu.c
> @@ -224,7 +224,8 @@ static int kvmppc_mmu_book3s_32_xlate_pte(struct kvm_vcpu *vcpu, gva_t eaddr,
>   	ptem = kvmppc_mmu_book3s_32_get_ptem(sre, eaddr, primary);
>
>   	if(copy_from_user(pteg, (void __user *)ptegp, sizeof(pteg))) {
> -		printk(KERN_ERR "KVM: Can't copy data from 0x%lx!\n", ptegp);
> +		printk_ratelimited(KERN_ERR
> +			"KVM: Can't copy data from 0x%lx!\n", ptegp);
>   		goto no_page_found;
>   	}
>
> diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_64_mmu.c
> index b9131aa..7015357 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu.c
> @@ -265,7 +265,8 @@ static int kvmppc_mmu_book3s_64_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
>   		goto no_page_found;
>
>   	if(copy_from_user(pteg, (void __user *)ptegp, sizeof(pteg))) {
> -		printk(KERN_ERR "KVM can't copy data from 0x%lx!\n", ptegp);
> +		printk_ratelimited(KERN_ERR
> +			"KVM: Can't copy data from 0x%lx!\n", ptegp);
>   		goto no_page_found;
>   	}
>
