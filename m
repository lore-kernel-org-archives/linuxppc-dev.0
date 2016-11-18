Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tL1Cl6Bm9zDvyJ
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Nov 2016 01:51:31 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tL1Cl23LVz9t3K
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2016 01:51:31 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAIEmo0Y070970
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2016 09:51:29 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26stsnsbcn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2016 09:51:28 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 18 Nov 2016 09:51:28 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 10/13] KVM: PPC: Book3S HV: Use msgsnd for IPIs to other
 cores on POWER9
In-Reply-To: <1479454122-26994-11-git-send-email-paulus@ozlabs.org>
References: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
 <1479454122-26994-11-git-send-email-paulus@ozlabs.org>
Date: Fri, 18 Nov 2016 20:17:25 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87vavkn8ua.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@ozlabs.org> writes:

> On POWER9, the msgsnd instruction is able to send interrupts to
> other cores, as well as other threads on the local core.  Since
> msgsnd is generally simpler and faster than sending an IPI via the
> XICS, we use msgsnd for all IPIs sent by KVM on POWER9.
>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
>  arch/powerpc/kvm/book3s_hv.c         | 11 ++++++++++-
>  arch/powerpc/kvm/book3s_hv_builtin.c | 10 ++++++++--
>  2 files changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 8395a7f..ace89df 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -147,12 +147,21 @@ static inline struct kvm_vcpu *next_runnable_thread(struct kvmppc_vcore *vc,
>  
>  static bool kvmppc_ipi_thread(int cpu)
>  {
> +	unsigned long msg = PPC_DBELL_TYPE(PPC_DBELL_SERVER);
> +
> +	/* On POWER9 we can use msgsnd to IPI any cpu */
> +	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> +		msg |= get_hard_smp_processor_id(cpu);
> +		smp_mb();
> +		__asm__ __volatile__ (PPC_MSGSND(%0) : : "r" (msg));
> +		return true;
> +	}
> +
>  	/* On POWER8 for IPIs to threads in the same core, use msgsnd */
>  	if (cpu_has_feature(CPU_FTR_ARCH_207S)) {
>  		preempt_disable();
>  		if (cpu_first_thread_sibling(cpu) ==
>  		    cpu_first_thread_sibling(smp_processor_id())) {
> -			unsigned long msg = PPC_DBELL_TYPE(PPC_DBELL_SERVER);
>  			msg |= cpu_thread_in_core(cpu);
>  			smp_mb();
>  			__asm__ __volatile__ (PPC_MSGSND(%0) : : "r" (msg));
> diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
> index 0c84d6b..37ed045 100644
> --- a/arch/powerpc/kvm/book3s_hv_builtin.c
> +++ b/arch/powerpc/kvm/book3s_hv_builtin.c
> @@ -205,12 +205,18 @@ static inline void rm_writeb(unsigned long paddr, u8 val)
>  void kvmhv_rm_send_ipi(int cpu)
>  {
>  	unsigned long xics_phys;
> +	unsigned long msg = PPC_DBELL_TYPE(PPC_DBELL_SERVER);
>  
> -	/* On POWER8 for IPIs to threads in the same core, use msgsnd */
> +	/* On POWER9 we can use msgsnd for any destination cpu. */
> +	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> +		msg |= get_hard_smp_processor_id(cpu);
> +		__asm__ __volatile__ (PPC_MSGSND(%0) : : "r" (msg));
> +		return;

Do we need a "sync" there  before msgsnd ?

> +	}
> +	/* On POWER8 for IPIs to threads in the same core, use msgsnd. */
>  	if (cpu_has_feature(CPU_FTR_ARCH_207S) &&
>  	    cpu_first_thread_sibling(cpu) ==
>  	    cpu_first_thread_sibling(raw_smp_processor_id())) {
> -		unsigned long msg = PPC_DBELL_TYPE(PPC_DBELL_SERVER);
>  		msg |= cpu_thread_in_core(cpu);
>  		__asm__ __volatile__ (PPC_MSGSND(%0) : : "r" (msg));
>  		return;
> -- 
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
