Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073FEC64EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 08:18:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81AE62087C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 08:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AE62087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TCt03G25zF3BQ
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 19:18:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=maddy@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TCqt2h2kzDrMp
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 19:16:22 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w988EI5j113795
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Oct 2018 04:16:20 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n008hrkgy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Oct 2018 04:16:19 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 8 Oct 2018 09:16:18 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 8 Oct 2018 09:16:16 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w988GFur64028708
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Oct 2018 08:16:15 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12DE511C05B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 11:15:50 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8EFC211C069
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 11:15:49 +0100 (BST)
Received: from [9.126.30.56] (unknown [9.126.30.56])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 11:15:49 +0100 (BST)
Subject: Re: [PATCH v5 05/33] KVM: PPC: Book3S HV: Extract PMU save/restore
 operations as C-callable functions
To: linuxppc-dev@lists.ozlabs.org
References: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
 <1538976679-1363-6-git-send-email-paulus@ozlabs.org>
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Mon, 8 Oct 2018 13:46:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538976679-1363-6-git-send-email-paulus@ozlabs.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18100808-0016-0000-0000-0000020FEC17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100808-0017-0000-0000-0000326749A5
Message-Id: <be854dce-87cd-571b-32eb-64475cdd84a9@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-08_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810080083
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



On Monday 08 October 2018 11:00 AM, Paul Mackerras wrote:
> This pulls out the assembler code that is responsible for saving and
> restoring the PMU state for the host and guest into separate functions
> so they can be used from an alternate entry path.  The calling
> convention is made compatible with C.

Reviewed-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
>   arch/powerpc/include/asm/asm-prototypes.h |   5 +
>   arch/powerpc/kvm/book3s_hv_interrupts.S   |  95 ++++----
>   arch/powerpc/kvm/book3s_hv_rmhandlers.S   | 363 ++++++++++++++++--------------
>   3 files changed, 253 insertions(+), 210 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
> index 1f4691c..024e8fc 100644
> --- a/arch/powerpc/include/asm/asm-prototypes.h
> +++ b/arch/powerpc/include/asm/asm-prototypes.h
> @@ -150,4 +150,9 @@ extern s32 patch__memset_nocache, patch__memcpy_nocache;
>
>   extern long flush_count_cache;
>
> +void kvmhv_save_host_pmu(void);
> +void kvmhv_load_host_pmu(void);
> +void kvmhv_save_guest_pmu(struct kvm_vcpu *vcpu, bool pmu_in_use);
> +void kvmhv_load_guest_pmu(struct kvm_vcpu *vcpu);
> +
>   #endif /* _ASM_POWERPC_ASM_PROTOTYPES_H */
> diff --git a/arch/powerpc/kvm/book3s_hv_interrupts.S b/arch/powerpc/kvm/book3s_hv_interrupts.S
> index 666b91c..a6d1001 100644
> --- a/arch/powerpc/kvm/book3s_hv_interrupts.S
> +++ b/arch/powerpc/kvm/book3s_hv_interrupts.S
> @@ -64,52 +64,7 @@ BEGIN_FTR_SECTION
>   END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
>
>   	/* Save host PMU registers */
> -BEGIN_FTR_SECTION
> -	/* Work around P8 PMAE bug */
> -	li	r3, -1
> -	clrrdi	r3, r3, 10
> -	mfspr	r8, SPRN_MMCR2
> -	mtspr	SPRN_MMCR2, r3		/* freeze all counters using MMCR2 */
> -	isync
> -END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> -	li	r3, 1
> -	sldi	r3, r3, 31		/* MMCR0_FC (freeze counters) bit */
> -	mfspr	r7, SPRN_MMCR0		/* save MMCR0 */
> -	mtspr	SPRN_MMCR0, r3		/* freeze all counters, disable interrupts */
> -	mfspr	r6, SPRN_MMCRA
> -	/* Clear MMCRA in order to disable SDAR updates */
> -	li	r5, 0
> -	mtspr	SPRN_MMCRA, r5
> -	isync
> -	lbz	r5, PACA_PMCINUSE(r13)	/* is the host using the PMU? */
> -	cmpwi	r5, 0
> -	beq	31f			/* skip if not */
> -	mfspr	r5, SPRN_MMCR1
> -	mfspr	r9, SPRN_SIAR
> -	mfspr	r10, SPRN_SDAR
> -	std	r7, HSTATE_MMCR0(r13)
> -	std	r5, HSTATE_MMCR1(r13)
> -	std	r6, HSTATE_MMCRA(r13)
> -	std	r9, HSTATE_SIAR(r13)
> -	std	r10, HSTATE_SDAR(r13)
> -BEGIN_FTR_SECTION
> -	mfspr	r9, SPRN_SIER
> -	std	r8, HSTATE_MMCR2(r13)
> -	std	r9, HSTATE_SIER(r13)
> -END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> -	mfspr	r3, SPRN_PMC1
> -	mfspr	r5, SPRN_PMC2
> -	mfspr	r6, SPRN_PMC3
> -	mfspr	r7, SPRN_PMC4
> -	mfspr	r8, SPRN_PMC5
> -	mfspr	r9, SPRN_PMC6
> -	stw	r3, HSTATE_PMC1(r13)
> -	stw	r5, HSTATE_PMC2(r13)
> -	stw	r6, HSTATE_PMC3(r13)
> -	stw	r7, HSTATE_PMC4(r13)
> -	stw	r8, HSTATE_PMC5(r13)
> -	stw	r9, HSTATE_PMC6(r13)
> -31:
> +	bl	kvmhv_save_host_pmu
>
>   	/*
>   	 * Put whatever is in the decrementer into the
> @@ -161,3 +116,51 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>   	ld	r0, PPC_LR_STKOFF(r1)
>   	mtlr	r0
>   	blr
> +
> +_GLOBAL(kvmhv_save_host_pmu)
> +BEGIN_FTR_SECTION
> +	/* Work around P8 PMAE bug */
> +	li	r3, -1
> +	clrrdi	r3, r3, 10
> +	mfspr	r8, SPRN_MMCR2
> +	mtspr	SPRN_MMCR2, r3		/* freeze all counters using MMCR2 */
> +	isync
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> +	li	r3, 1
> +	sldi	r3, r3, 31		/* MMCR0_FC (freeze counters) bit */
> +	mfspr	r7, SPRN_MMCR0		/* save MMCR0 */
> +	mtspr	SPRN_MMCR0, r3		/* freeze all counters, disable interrupts */
> +	mfspr	r6, SPRN_MMCRA
> +	/* Clear MMCRA in order to disable SDAR updates */
> +	li	r5, 0
> +	mtspr	SPRN_MMCRA, r5
> +	isync
> +	lbz	r5, PACA_PMCINUSE(r13)	/* is the host using the PMU? */
> +	cmpwi	r5, 0
> +	beq	31f			/* skip if not */
> +	mfspr	r5, SPRN_MMCR1
> +	mfspr	r9, SPRN_SIAR
> +	mfspr	r10, SPRN_SDAR
> +	std	r7, HSTATE_MMCR0(r13)
> +	std	r5, HSTATE_MMCR1(r13)
> +	std	r6, HSTATE_MMCRA(r13)
> +	std	r9, HSTATE_SIAR(r13)
> +	std	r10, HSTATE_SDAR(r13)
> +BEGIN_FTR_SECTION
> +	mfspr	r9, SPRN_SIER
> +	std	r8, HSTATE_MMCR2(r13)
> +	std	r9, HSTATE_SIER(r13)
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> +	mfspr	r3, SPRN_PMC1
> +	mfspr	r5, SPRN_PMC2
> +	mfspr	r6, SPRN_PMC3
> +	mfspr	r7, SPRN_PMC4
> +	mfspr	r8, SPRN_PMC5
> +	mfspr	r9, SPRN_PMC6
> +	stw	r3, HSTATE_PMC1(r13)
> +	stw	r5, HSTATE_PMC2(r13)
> +	stw	r6, HSTATE_PMC3(r13)
> +	stw	r7, HSTATE_PMC4(r13)
> +	stw	r8, HSTATE_PMC5(r13)
> +	stw	r9, HSTATE_PMC6(r13)
> +31:	blr
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index 6752da1..5b2ae34 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -28,6 +28,7 @@
>   #include <asm/exception-64s.h>
>   #include <asm/kvm_book3s_asm.h>
>   #include <asm/book3s/64/mmu-hash.h>
> +#include <asm/export.h>
>   #include <asm/tm.h>
>   #include <asm/opal.h>
>   #include <asm/xive-regs.h>
> @@ -113,45 +114,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
>   	mtspr	SPRN_SPRG_VDSO_WRITE,r3
>
>   	/* Reload the host's PMU registers */
> -	lbz	r4, PACA_PMCINUSE(r13) /* is the host using the PMU? */
> -	cmpwi	r4, 0
> -	beq	23f			/* skip if not */
> -BEGIN_FTR_SECTION
> -	ld	r3, HSTATE_MMCR0(r13)
> -	andi.	r4, r3, MMCR0_PMAO_SYNC | MMCR0_PMAO
> -	cmpwi	r4, MMCR0_PMAO
> -	beql	kvmppc_fix_pmao
> -END_FTR_SECTION_IFSET(CPU_FTR_PMAO_BUG)
> -	lwz	r3, HSTATE_PMC1(r13)
> -	lwz	r4, HSTATE_PMC2(r13)
> -	lwz	r5, HSTATE_PMC3(r13)
> -	lwz	r6, HSTATE_PMC4(r13)
> -	lwz	r8, HSTATE_PMC5(r13)
> -	lwz	r9, HSTATE_PMC6(r13)
> -	mtspr	SPRN_PMC1, r3
> -	mtspr	SPRN_PMC2, r4
> -	mtspr	SPRN_PMC3, r5
> -	mtspr	SPRN_PMC4, r6
> -	mtspr	SPRN_PMC5, r8
> -	mtspr	SPRN_PMC6, r9
> -	ld	r3, HSTATE_MMCR0(r13)
> -	ld	r4, HSTATE_MMCR1(r13)
> -	ld	r5, HSTATE_MMCRA(r13)
> -	ld	r6, HSTATE_SIAR(r13)
> -	ld	r7, HSTATE_SDAR(r13)
> -	mtspr	SPRN_MMCR1, r4
> -	mtspr	SPRN_MMCRA, r5
> -	mtspr	SPRN_SIAR, r6
> -	mtspr	SPRN_SDAR, r7
> -BEGIN_FTR_SECTION
> -	ld	r8, HSTATE_MMCR2(r13)
> -	ld	r9, HSTATE_SIER(r13)
> -	mtspr	SPRN_MMCR2, r8
> -	mtspr	SPRN_SIER, r9
> -END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> -	mtspr	SPRN_MMCR0, r3
> -	isync
> -23:
> +	bl	kvmhv_load_host_pmu
>
>   	/*
>   	 * Reload DEC.  HDEC interrupts were disabled when
> @@ -805,57 +768,12 @@ END_FTR_SECTION(CPU_FTR_TM | CPU_FTR_P9_TM_HV_ASSIST, 0)
>   91:
>   #endif
>
> -	/* Load guest PMU registers */
> -	/* R4 is live here (vcpu pointer) */
> -	li	r3, 1
> -	sldi	r3, r3, 31		/* MMCR0_FC (freeze counters) bit */
> -	mtspr	SPRN_MMCR0, r3		/* freeze all counters, disable ints */
> -	isync
> -BEGIN_FTR_SECTION
> -	ld	r3, VCPU_MMCR(r4)
> -	andi.	r5, r3, MMCR0_PMAO_SYNC | MMCR0_PMAO
> -	cmpwi	r5, MMCR0_PMAO
> -	beql	kvmppc_fix_pmao
> -END_FTR_SECTION_IFSET(CPU_FTR_PMAO_BUG)
> -	lwz	r3, VCPU_PMC(r4)	/* always load up guest PMU registers */
> -	lwz	r5, VCPU_PMC + 4(r4)	/* to prevent information leak */
> -	lwz	r6, VCPU_PMC + 8(r4)
> -	lwz	r7, VCPU_PMC + 12(r4)
> -	lwz	r8, VCPU_PMC + 16(r4)
> -	lwz	r9, VCPU_PMC + 20(r4)
> -	mtspr	SPRN_PMC1, r3
> -	mtspr	SPRN_PMC2, r5
> -	mtspr	SPRN_PMC3, r6
> -	mtspr	SPRN_PMC4, r7
> -	mtspr	SPRN_PMC5, r8
> -	mtspr	SPRN_PMC6, r9
> -	ld	r3, VCPU_MMCR(r4)
> -	ld	r5, VCPU_MMCR + 8(r4)
> -	ld	r6, VCPU_MMCR + 16(r4)
> -	ld	r7, VCPU_SIAR(r4)
> -	ld	r8, VCPU_SDAR(r4)
> -	mtspr	SPRN_MMCR1, r5
> -	mtspr	SPRN_MMCRA, r6
> -	mtspr	SPRN_SIAR, r7
> -	mtspr	SPRN_SDAR, r8
> -BEGIN_FTR_SECTION
> -	ld	r5, VCPU_MMCR + 24(r4)
> -	ld	r6, VCPU_SIER(r4)
> -	mtspr	SPRN_MMCR2, r5
> -	mtspr	SPRN_SIER, r6
> -BEGIN_FTR_SECTION_NESTED(96)
> -	lwz	r7, VCPU_PMC + 24(r4)
> -	lwz	r8, VCPU_PMC + 28(r4)
> -	ld	r9, VCPU_MMCR + 32(r4)
> -	mtspr	SPRN_SPMC1, r7
> -	mtspr	SPRN_SPMC2, r8
> -	mtspr	SPRN_MMCRS, r9
> -END_FTR_SECTION_NESTED(CPU_FTR_ARCH_300, 0, 96)
> -END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> -	mtspr	SPRN_MMCR0, r3
> -	isync
> +	/* Load guest PMU registers; r4 = vcpu pointer here */
> +	mr	r3, r4
> +	bl	kvmhv_load_guest_pmu
>
>   	/* Load up FP, VMX and VSX registers */
> +	ld	r4, HSTATE_KVM_VCPU(r13)
>   	bl	kvmppc_load_fp
>
>   	ld	r14, VCPU_GPR(R14)(r4)
> @@ -1766,83 +1684,12 @@ END_FTR_SECTION(CPU_FTR_TM | CPU_FTR_P9_TM_HV_ASSIST, 0)
>   25:
>   	/* Save PMU registers if requested */
>   	/* r8 and cr0.eq are live here */
> -BEGIN_FTR_SECTION
> -	/*
> -	 * POWER8 seems to have a hardware bug where setting
> -	 * MMCR0[PMAE] along with MMCR0[PMC1CE] and/or MMCR0[PMCjCE]
> -	 * when some counters are already negative doesn't seem
> -	 * to cause a performance monitor alert (and hence interrupt).
> -	 * The effect of this is that when saving the PMU state,
> -	 * if there is no PMU alert pending when we read MMCR0
> -	 * before freezing the counters, but one becomes pending
> -	 * before we read the counters, we lose it.
> -	 * To work around this, we need a way to freeze the counters
> -	 * before reading MMCR0.  Normally, freezing the counters
> -	 * is done by writing MMCR0 (to set MMCR0[FC]) which
> -	 * unavoidably writes MMCR0[PMA0] as well.  On POWER8,
> -	 * we can also freeze the counters using MMCR2, by writing
> -	 * 1s to all the counter freeze condition bits (there are
> -	 * 9 bits each for 6 counters).
> -	 */
> -	li	r3, -1			/* set all freeze bits */
> -	clrrdi	r3, r3, 10
> -	mfspr	r10, SPRN_MMCR2
> -	mtspr	SPRN_MMCR2, r3
> -	isync
> -END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> -	li	r3, 1
> -	sldi	r3, r3, 31		/* MMCR0_FC (freeze counters) bit */
> -	mfspr	r4, SPRN_MMCR0		/* save MMCR0 */
> -	mtspr	SPRN_MMCR0, r3		/* freeze all counters, disable ints */
> -	mfspr	r6, SPRN_MMCRA
> -	/* Clear MMCRA in order to disable SDAR updates */
> -	li	r7, 0
> -	mtspr	SPRN_MMCRA, r7
> -	isync
> +	mr	r3, r9
> +	li	r4, 1
>   	beq	21f			/* if no VPA, save PMU stuff anyway */
> -	lbz	r7, LPPACA_PMCINUSE(r8)
> -	cmpwi	r7, 0			/* did they ask for PMU stuff to be saved? */
> -	bne	21f
> -	std	r3, VCPU_MMCR(r9)	/* if not, set saved MMCR0 to FC */
> -	b	22f
> -21:	mfspr	r5, SPRN_MMCR1
> -	mfspr	r7, SPRN_SIAR
> -	mfspr	r8, SPRN_SDAR
> -	std	r4, VCPU_MMCR(r9)
> -	std	r5, VCPU_MMCR + 8(r9)
> -	std	r6, VCPU_MMCR + 16(r9)
> -BEGIN_FTR_SECTION
> -	std	r10, VCPU_MMCR + 24(r9)
> -END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> -	std	r7, VCPU_SIAR(r9)
> -	std	r8, VCPU_SDAR(r9)
> -	mfspr	r3, SPRN_PMC1
> -	mfspr	r4, SPRN_PMC2
> -	mfspr	r5, SPRN_PMC3
> -	mfspr	r6, SPRN_PMC4
> -	mfspr	r7, SPRN_PMC5
> -	mfspr	r8, SPRN_PMC6
> -	stw	r3, VCPU_PMC(r9)
> -	stw	r4, VCPU_PMC + 4(r9)
> -	stw	r5, VCPU_PMC + 8(r9)
> -	stw	r6, VCPU_PMC + 12(r9)
> -	stw	r7, VCPU_PMC + 16(r9)
> -	stw	r8, VCPU_PMC + 20(r9)
> -BEGIN_FTR_SECTION
> -	mfspr	r5, SPRN_SIER
> -	std	r5, VCPU_SIER(r9)
> -BEGIN_FTR_SECTION_NESTED(96)
> -	mfspr	r6, SPRN_SPMC1
> -	mfspr	r7, SPRN_SPMC2
> -	mfspr	r8, SPRN_MMCRS
> -	stw	r6, VCPU_PMC + 24(r9)
> -	stw	r7, VCPU_PMC + 28(r9)
> -	std	r8, VCPU_MMCR + 32(r9)
> -	lis	r4, 0x8000
> -	mtspr	SPRN_MMCRS, r4
> -END_FTR_SECTION_NESTED(CPU_FTR_ARCH_300, 0, 96)
> -END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> -22:
> +	lbz	r4, LPPACA_PMCINUSE(r8)
> +21:	bl	kvmhv_save_guest_pmu
> +	ld	r9, HSTATE_KVM_VCPU(r13)
>
>   	/* Restore host values of some registers */
>   BEGIN_FTR_SECTION
> @@ -3388,6 +3235,194 @@ kvmppc_msr_interrupt:
>   	blr
>
>   /*
> + * Load up guest PMU state.  R3 points to the vcpu struct.
> + */
> +_GLOBAL(kvmhv_load_guest_pmu)
> +EXPORT_SYMBOL_GPL(kvmhv_load_guest_pmu)
> +	mr	r4, r3
> +	mflr	r0
> +	li	r3, 1
> +	sldi	r3, r3, 31		/* MMCR0_FC (freeze counters) bit */
> +	mtspr	SPRN_MMCR0, r3		/* freeze all counters, disable ints */
> +	isync
> +BEGIN_FTR_SECTION
> +	ld	r3, VCPU_MMCR(r4)
> +	andi.	r5, r3, MMCR0_PMAO_SYNC | MMCR0_PMAO
> +	cmpwi	r5, MMCR0_PMAO
> +	beql	kvmppc_fix_pmao
> +END_FTR_SECTION_IFSET(CPU_FTR_PMAO_BUG)
> +	lwz	r3, VCPU_PMC(r4)	/* always load up guest PMU registers */
> +	lwz	r5, VCPU_PMC + 4(r4)	/* to prevent information leak */
> +	lwz	r6, VCPU_PMC + 8(r4)
> +	lwz	r7, VCPU_PMC + 12(r4)
> +	lwz	r8, VCPU_PMC + 16(r4)
> +	lwz	r9, VCPU_PMC + 20(r4)
> +	mtspr	SPRN_PMC1, r3
> +	mtspr	SPRN_PMC2, r5
> +	mtspr	SPRN_PMC3, r6
> +	mtspr	SPRN_PMC4, r7
> +	mtspr	SPRN_PMC5, r8
> +	mtspr	SPRN_PMC6, r9
> +	ld	r3, VCPU_MMCR(r4)
> +	ld	r5, VCPU_MMCR + 8(r4)
> +	ld	r6, VCPU_MMCR + 16(r4)
> +	ld	r7, VCPU_SIAR(r4)
> +	ld	r8, VCPU_SDAR(r4)
> +	mtspr	SPRN_MMCR1, r5
> +	mtspr	SPRN_MMCRA, r6
> +	mtspr	SPRN_SIAR, r7
> +	mtspr	SPRN_SDAR, r8
> +BEGIN_FTR_SECTION
> +	ld	r5, VCPU_MMCR + 24(r4)
> +	ld	r6, VCPU_SIER(r4)
> +	mtspr	SPRN_MMCR2, r5
> +	mtspr	SPRN_SIER, r6
> +BEGIN_FTR_SECTION_NESTED(96)
> +	lwz	r7, VCPU_PMC + 24(r4)
> +	lwz	r8, VCPU_PMC + 28(r4)
> +	ld	r9, VCPU_MMCR + 32(r4)
> +	mtspr	SPRN_SPMC1, r7
> +	mtspr	SPRN_SPMC2, r8
> +	mtspr	SPRN_MMCRS, r9
> +END_FTR_SECTION_NESTED(CPU_FTR_ARCH_300, 0, 96)
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> +	mtspr	SPRN_MMCR0, r3
> +	isync
> +	mtlr	r0
> +	blr
> +
> +/*
> + * Reload host PMU state saved in the PACA by kvmhv_save_host_pmu.
> + */
> +_GLOBAL(kvmhv_load_host_pmu)
> +EXPORT_SYMBOL_GPL(kvmhv_load_host_pmu)
> +	mflr	r0
> +	lbz	r4, PACA_PMCINUSE(r13) /* is the host using the PMU? */
> +	cmpwi	r4, 0
> +	beq	23f			/* skip if not */
> +BEGIN_FTR_SECTION
> +	ld	r3, HSTATE_MMCR0(r13)
> +	andi.	r4, r3, MMCR0_PMAO_SYNC | MMCR0_PMAO
> +	cmpwi	r4, MMCR0_PMAO
> +	beql	kvmppc_fix_pmao
> +END_FTR_SECTION_IFSET(CPU_FTR_PMAO_BUG)
> +	lwz	r3, HSTATE_PMC1(r13)
> +	lwz	r4, HSTATE_PMC2(r13)
> +	lwz	r5, HSTATE_PMC3(r13)
> +	lwz	r6, HSTATE_PMC4(r13)
> +	lwz	r8, HSTATE_PMC5(r13)
> +	lwz	r9, HSTATE_PMC6(r13)
> +	mtspr	SPRN_PMC1, r3
> +	mtspr	SPRN_PMC2, r4
> +	mtspr	SPRN_PMC3, r5
> +	mtspr	SPRN_PMC4, r6
> +	mtspr	SPRN_PMC5, r8
> +	mtspr	SPRN_PMC6, r9
> +	ld	r3, HSTATE_MMCR0(r13)
> +	ld	r4, HSTATE_MMCR1(r13)
> +	ld	r5, HSTATE_MMCRA(r13)
> +	ld	r6, HSTATE_SIAR(r13)
> +	ld	r7, HSTATE_SDAR(r13)
> +	mtspr	SPRN_MMCR1, r4
> +	mtspr	SPRN_MMCRA, r5
> +	mtspr	SPRN_SIAR, r6
> +	mtspr	SPRN_SDAR, r7
> +BEGIN_FTR_SECTION
> +	ld	r8, HSTATE_MMCR2(r13)
> +	ld	r9, HSTATE_SIER(r13)
> +	mtspr	SPRN_MMCR2, r8
> +	mtspr	SPRN_SIER, r9
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> +	mtspr	SPRN_MMCR0, r3
> +	isync
> +	mtlr	r0
> +23:	blr
> +
> +/*
> + * Save guest PMU state into the vcpu struct.
> + * r3 = vcpu, r4 = full save flag (PMU in use flag set in VPA)
> + */
> +_GLOBAL(kvmhv_save_guest_pmu)
> +EXPORT_SYMBOL_GPL(kvmhv_save_guest_pmu)
> +	mr	r9, r3
> +	mr	r8, r4
> +BEGIN_FTR_SECTION
> +	/*
> +	 * POWER8 seems to have a hardware bug where setting
> +	 * MMCR0[PMAE] along with MMCR0[PMC1CE] and/or MMCR0[PMCjCE]
> +	 * when some counters are already negative doesn't seem
> +	 * to cause a performance monitor alert (and hence interrupt).
> +	 * The effect of this is that when saving the PMU state,
> +	 * if there is no PMU alert pending when we read MMCR0
> +	 * before freezing the counters, but one becomes pending
> +	 * before we read the counters, we lose it.
> +	 * To work around this, we need a way to freeze the counters
> +	 * before reading MMCR0.  Normally, freezing the counters
> +	 * is done by writing MMCR0 (to set MMCR0[FC]) which
> +	 * unavoidably writes MMCR0[PMA0] as well.  On POWER8,
> +	 * we can also freeze the counters using MMCR2, by writing
> +	 * 1s to all the counter freeze condition bits (there are
> +	 * 9 bits each for 6 counters).
> +	 */
> +	li	r3, -1			/* set all freeze bits */
> +	clrrdi	r3, r3, 10
> +	mfspr	r10, SPRN_MMCR2
> +	mtspr	SPRN_MMCR2, r3
> +	isync
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> +	li	r3, 1
> +	sldi	r3, r3, 31		/* MMCR0_FC (freeze counters) bit */
> +	mfspr	r4, SPRN_MMCR0		/* save MMCR0 */
> +	mtspr	SPRN_MMCR0, r3		/* freeze all counters, disable ints */
> +	mfspr	r6, SPRN_MMCRA
> +	/* Clear MMCRA in order to disable SDAR updates */
> +	li	r7, 0
> +	mtspr	SPRN_MMCRA, r7
> +	isync
> +	cmpwi	r8, 0			/* did they ask for PMU stuff to be saved? */
> +	bne	21f
> +	std	r3, VCPU_MMCR(r9)	/* if not, set saved MMCR0 to FC */
> +	b	22f
> +21:	mfspr	r5, SPRN_MMCR1
> +	mfspr	r7, SPRN_SIAR
> +	mfspr	r8, SPRN_SDAR
> +	std	r4, VCPU_MMCR(r9)
> +	std	r5, VCPU_MMCR + 8(r9)
> +	std	r6, VCPU_MMCR + 16(r9)
> +BEGIN_FTR_SECTION
> +	std	r10, VCPU_MMCR + 24(r9)
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> +	std	r7, VCPU_SIAR(r9)
> +	std	r8, VCPU_SDAR(r9)
> +	mfspr	r3, SPRN_PMC1
> +	mfspr	r4, SPRN_PMC2
> +	mfspr	r5, SPRN_PMC3
> +	mfspr	r6, SPRN_PMC4
> +	mfspr	r7, SPRN_PMC5
> +	mfspr	r8, SPRN_PMC6
> +	stw	r3, VCPU_PMC(r9)
> +	stw	r4, VCPU_PMC + 4(r9)
> +	stw	r5, VCPU_PMC + 8(r9)
> +	stw	r6, VCPU_PMC + 12(r9)
> +	stw	r7, VCPU_PMC + 16(r9)
> +	stw	r8, VCPU_PMC + 20(r9)
> +BEGIN_FTR_SECTION
> +	mfspr	r5, SPRN_SIER
> +	std	r5, VCPU_SIER(r9)
> +BEGIN_FTR_SECTION_NESTED(96)
> +	mfspr	r6, SPRN_SPMC1
> +	mfspr	r7, SPRN_SPMC2
> +	mfspr	r8, SPRN_MMCRS
> +	stw	r6, VCPU_PMC + 24(r9)
> +	stw	r7, VCPU_PMC + 28(r9)
> +	std	r8, VCPU_MMCR + 32(r9)
> +	lis	r4, 0x8000
> +	mtspr	SPRN_MMCRS, r4
> +END_FTR_SECTION_NESTED(CPU_FTR_ARCH_300, 0, 96)
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> +22:	blr
> +
> +/*
>    * This works around a hardware bug on POWER8E processors, where
>    * writing a 1 to the MMCR0[PMAO] bit doesn't generate a
>    * performance monitor interrupt.  Instead, when we need to have

