Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9441C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 09:22:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B0862086C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 09:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0862086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444Bvk0NKBzDqDf
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 20:22:26 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444BsZ4HFRzDqCc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 20:20:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 444BsZ36M1z8t7s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 20:20:34 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 444BsZ2hLRz9s8m; Wed, 20 Feb 2019 20:20:34 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=aravinda@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 444BsY6lWrz9s5R
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2019 20:20:33 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x1K9AGuM083089
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2019 04:20:31 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qs200wsh5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2019 04:20:30 -0500
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Wed, 20 Feb 2019 09:20:30 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e36.co.us.ibm.com (192.168.1.136) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 20 Feb 2019 09:20:28 -0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x1K9KRrZ31916268
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Feb 2019 09:20:27 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 42ACBBE051;
 Wed, 20 Feb 2019 09:20:27 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DD048BE054;
 Wed, 20 Feb 2019 09:20:25 +0000 (GMT)
Received: from [9.124.31.45] (unknown [9.124.31.45])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 20 Feb 2019 09:20:25 +0000 (GMT)
Subject: Re: [PATCH 1/2] KVM: PPC: Book3S HV: Simplify machine check handling
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
References: <20190220010550.GD5353@blackberry>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Wed, 20 Feb 2019 14:50:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190220010550.GD5353@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19022009-0020-0000-0000-00000EBE7B84
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010630; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01163706; UDB=6.00607639; IPR=6.00944291; 
 MB=3.00025666; MTD=3.00000008; XFM=3.00000015; UTC=2019-02-20 09:20:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19022009-0021-0000-0000-000064DB47F9
Message-Id: <d1b0c0bb-06d7-3a17-5d25-da909bdce967@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-20_08:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902200067
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On Wednesday 20 February 2019 06:35 AM, Paul Mackerras wrote:
> This makes the handling of machine check interrupts that occur inside
> a guest simpler and more robust, with less done in assembler code and
> in real mode.
> 
> Now, when a machine check occurs inside a guest, we always get the
> machine check event struct and put a copy in the vcpu struct for the
> vcpu where the machine check occurred.  We no longer call
> machine_check_queue_event() from kvmppc_realmode_mc_power7(), because
> on POWER8, when a vcpu is running on an offline secondary thread and
> we call machine_check_queue_event(), that calls irq_work_queue(),
> which doesn't work because the CPU is offline, but instead triggers
> the WARN_ON(lazy_irq_pending()) in pnv_smp_cpu_kill_self() (which
> fires again and again because nothing clears the condition).
> 
> All that machine_check_queue_event() actually does is to cause the
> event to be printed to the console.  For a machine check occurring in
> the guest, we now print the event in kvmppc_handle_exit_hv()
> instead.
> 
> The assembly code at label machine_check_realmode now just calls C
> code and then continues exiting the guest.  We no longer either
> synthesize a machine check for the guest in assembly code or return
> to the guest without a machine check.
> 
> The code in kvmppc_handle_exit_hv() is extended to handle the case
> where the guest is not FWNMI-capable.  In that case we now always
> synthesize a machine check interrupt for the guest.  Previously, if
> the host thinks it has recovered the machine check fully, it would
> return to the guest without any notification that the machine check
> had occurred.  If the machine check was caused by some action of the
> guest (such as creating duplicate SLB entries), it is much better to
> tell the guest that it has caused a problem.  Therefore we now always
> generate a machine check interrupt for guests that are not
> FWNMI-capable.
> 
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
>  arch/powerpc/include/asm/kvm_ppc.h      |  3 +-
>  arch/powerpc/kvm/book3s.c               |  7 +++++
>  arch/powerpc/kvm/book3s_hv.c            | 18 +++++++++--
>  arch/powerpc/kvm/book3s_hv_ras.c        | 56 +++++++++------------------------
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 40 ++---------------------
>  5 files changed, 42 insertions(+), 82 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> index b3bf4f6..d283d31 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -143,6 +143,7 @@ extern void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu);
> 
>  extern int kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu);
>  extern int kvmppc_core_pending_dec(struct kvm_vcpu *vcpu);
> +extern void kvmppc_core_queue_machine_check(struct kvm_vcpu *vcpu, ulong flags);
>  extern void kvmppc_core_queue_program(struct kvm_vcpu *vcpu, ulong flags);
>  extern void kvmppc_core_queue_fpunavail(struct kvm_vcpu *vcpu);
>  extern void kvmppc_core_queue_vec_unavail(struct kvm_vcpu *vcpu);
> @@ -646,7 +647,7 @@ long int kvmppc_rm_h_confer(struct kvm_vcpu *vcpu, int target,
>                              unsigned int yield_count);
>  long kvmppc_h_random(struct kvm_vcpu *vcpu);
>  void kvmhv_commence_exit(int trap);
> -long kvmppc_realmode_machine_check(struct kvm_vcpu *vcpu);
> +void kvmppc_realmode_machine_check(struct kvm_vcpu *vcpu);
>  void kvmppc_subcore_enter_guest(void);
>  void kvmppc_subcore_exit_guest(void);
>  long kvmppc_realmode_hmi_handler(void);
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index 22a46c6..10c5579 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -195,6 +195,13 @@ void kvmppc_book3s_queue_irqprio(struct kvm_vcpu *vcpu, unsigned int vec)
>  }
>  EXPORT_SYMBOL_GPL(kvmppc_book3s_queue_irqprio);
> 
> +void kvmppc_core_queue_machine_check(struct kvm_vcpu *vcpu, ulong flags)
> +{
> +	/* might as well deliver this straight away */
> +	kvmppc_inject_interrupt(vcpu, BOOK3S_INTERRUPT_MACHINE_CHECK, flags);
> +}
> +EXPORT_SYMBOL_GPL(kvmppc_core_queue_machine_check);
> +
>  void kvmppc_core_queue_program(struct kvm_vcpu *vcpu, ulong flags)
>  {
>  	/* might as well deliver this straight away */
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 1860c0b..d8bf05a 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -1215,6 +1215,22 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
>  		r = RESUME_GUEST;
>  		break;
>  	case BOOK3S_INTERRUPT_MACHINE_CHECK:
> +		/* Print the MCE event to host console. */
> +		machine_check_print_event_info(&vcpu->arch.mce_evt, false);
> +
> +		/*
> +		 * If the guest can do FWNMI, exit to userspace so it can
> +		 * deliver a FWNMI to the guest.
> +		 * Otherwise we synthesize a machine check for the guest
> +		 * so that it knows that the machine check occurred.
> +		 */
> +		if (!vcpu->kvm->arch.fwnmi_enabled) {
> +			ulong flags = vcpu->arch.shregs.msr & 0x083c0000;
> +			kvmppc_core_queue_machine_check(vcpu, flags);
> +			r = RESUME_GUEST;
> +			break;
> +		}
> +
>  		/* Exit to guest with KVM_EXIT_NMI as exit reason */
>  		run->exit_reason = KVM_EXIT_NMI;
>  		run->hw.hardware_exit_reason = vcpu->arch.trap;
> @@ -1227,8 +1243,6 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
>  			run->flags |= KVM_RUN_PPC_NMI_DISP_NOT_RECOV;
> 
>  		r = RESUME_HOST;
> -		/* Print the MCE event to host console. */
> -		machine_check_print_event_info(&vcpu->arch.mce_evt, false);
>  		break;
>  	case BOOK3S_INTERRUPT_PROGRAM:
>  	{
> diff --git a/arch/powerpc/kvm/book3s_hv_ras.c b/arch/powerpc/kvm/book3s_hv_ras.c
> index 0787f12..9aa10b1 100644
> --- a/arch/powerpc/kvm/book3s_hv_ras.c
> +++ b/arch/powerpc/kvm/book3s_hv_ras.c
> @@ -69,7 +69,7 @@ static void reload_slb(struct kvm_vcpu *vcpu)
>   *
>   * Returns: 0 => exit guest, 1 => deliver machine check to guest

You have to remove the above comment as the function now returns nothing.

Reviewed-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>

Regards,
Aravinda

>   */
> -static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
> +static void kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
>  {
>  	unsigned long srr1 = vcpu->arch.shregs.msr;
>  	struct machine_check_event mce_evt;
> @@ -111,52 +111,24 @@ static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
>  	}
> 
>  	/*
> -	 * See if we have already handled the condition in the linux host.
> -	 * We assume that if the condition is recovered then linux host
> -	 * will have generated an error log event that we will pick
> -	 * up and log later.
> -	 * Don't release mce event now. We will queue up the event so that
> -	 * we can log the MCE event info on host console.
> +	 * Now get the event and stash it in the vcpu struct so it can
> +	 * be handled by the primary thread in virtual mode.  We can't
> +	 * call machine_check_queue_event() here if we are running on
> +	 * an offline secondary thread.
>  	 */
> -	if (!get_mce_event(&mce_evt, MCE_EVENT_DONTRELEASE))
> -		goto out;
> -
> -	if (mce_evt.version == MCE_V1 &&
> -	    (mce_evt.severity == MCE_SEV_NO_ERROR ||
> -	     mce_evt.disposition == MCE_DISPOSITION_RECOVERED))
> -		handled = 1;
> -
> -out:
> -	/*
> -	 * For guest that supports FWNMI capability, hook the MCE event into
> -	 * vcpu structure. We are going to exit the guest with KVM_EXIT_NMI
> -	 * exit reason. On our way to exit we will pull this event from vcpu
> -	 * structure and print it from thread 0 of the core/subcore.
> -	 *
> -	 * For guest that does not support FWNMI capability (old QEMU):
> -	 * We are now going enter guest either through machine check
> -	 * interrupt (for unhandled errors) or will continue from
> -	 * current HSRR0 (for handled errors) in guest. Hence
> -	 * queue up the event so that we can log it from host console later.
> -	 */
> -	if (vcpu->kvm->arch.fwnmi_enabled) {
> -		/*
> -		 * Hook up the mce event on to vcpu structure.
> -		 * First clear the old event.
> -		 */
> -		memset(&vcpu->arch.mce_evt, 0, sizeof(vcpu->arch.mce_evt));
> -		if (get_mce_event(&mce_evt, MCE_EVENT_RELEASE)) {
> -			vcpu->arch.mce_evt = mce_evt;
> -		}
> -	} else
> -		machine_check_queue_event();
> +	if (get_mce_event(&mce_evt, MCE_EVENT_RELEASE)) {
> +		if (handled && mce_evt.version == MCE_V1)
> +			mce_evt.disposition = MCE_DISPOSITION_RECOVERED;
> +	} else {
> +		memset(&mce_evt, 0, sizeof(mce_evt));
> +	}
> 
> -	return handled;
> +	vcpu->arch.mce_evt = mce_evt;
>  }
> 
> -long kvmppc_realmode_machine_check(struct kvm_vcpu *vcpu)
> +void kvmppc_realmode_machine_check(struct kvm_vcpu *vcpu)
>  {
> -	return kvmppc_realmode_mc_power7(vcpu);
> +	kvmppc_realmode_mc_power7(vcpu);
>  }
> 
>  /* Check if dynamic split is in force and return subcore size accordingly. */
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index 9b8d50a..f24f6a2 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -2826,49 +2826,15 @@ kvm_cede_exit:
>  #endif /* CONFIG_KVM_XICS */
>  3:	b	guest_exit_cont
> 
> -	/* Try to handle a machine check in real mode */
> +	/* Try to do machine check recovery in real mode */
>  machine_check_realmode:
>  	mr	r3, r9		/* get vcpu pointer */
>  	bl	kvmppc_realmode_machine_check
>  	nop
> +	/* all machine checks go to virtual mode for further handling */
>  	ld	r9, HSTATE_KVM_VCPU(r13)
>  	li	r12, BOOK3S_INTERRUPT_MACHINE_CHECK
> -	/*
> -	 * For the guest that is FWNMI capable, deliver all the MCE errors
> -	 * (handled/unhandled) by exiting the guest with KVM_EXIT_NMI exit
> -	 * reason. This new approach injects machine check errors in guest
> -	 * address space to guest with additional information in the form
> -	 * of RTAS event, thus enabling guest kernel to suitably handle
> -	 * such errors.
> -	 *
> -	 * For the guest that is not FWNMI capable (old QEMU) fallback
> -	 * to old behaviour for backward compatibility:
> -	 * Deliver unhandled/fatal (e.g. UE) MCE errors to guest either
> -	 * through machine check interrupt (set HSRR0 to 0x200).
> -	 * For handled errors (no-fatal), just go back to guest execution
> -	 * with current HSRR0.
> -	 * if we receive machine check with MSR(RI=0) then deliver it to
> -	 * guest as machine check causing guest to crash.
> -	 */
> -	ld	r11, VCPU_MSR(r9)
> -	rldicl.	r0, r11, 64-MSR_HV_LG, 63 /* check if it happened in HV mode */
> -	bne	guest_exit_cont		/* if so, exit to host */
> -	/* Check if guest is capable of handling NMI exit */
> -	ld	r10, VCPU_KVM(r9)
> -	lbz	r10, KVM_FWNMI(r10)
> -	cmpdi	r10, 1			/* FWNMI capable? */
> -	beq	guest_exit_cont		/* if so, exit with KVM_EXIT_NMI. */
> -
> -	/* if not, fall through for backward compatibility. */
> -	andi.	r10, r11, MSR_RI	/* check for unrecoverable exception */
> -	beq	1f			/* Deliver a machine check to guest */
> -	ld	r10, VCPU_PC(r9)
> -	cmpdi	r3, 0		/* Did we handle MCE ? */
> -	bne	2f	/* Continue guest execution. */
> -	/* If not, deliver a machine check.  SRR0/1 are already set */
> -1:	li	r10, BOOK3S_INTERRUPT_MACHINE_CHECK
> -	bl	kvmppc_msr_interrupt
> -2:	b	fast_interrupt_c_return
> +	b	guest_exit_cont
> 
>  /*
>   * Call C code to handle a HMI in real mode.
> 

-- 
Regards,
Aravinda

