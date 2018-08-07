Return-Path: <srs0=mudr=kw=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lGn05SkbzDqGD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 00:17:24 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41lGn04gs2z8vB4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 00:17:24 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41lGn00MTcz9s3x
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2018 00:17:23 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w77EFC31011349
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2018 10:17:22 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kqay6ee2x-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 07 Aug 2018 10:17:22 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 7 Aug 2018 15:17:19 +0100
Subject: [PATCH v7 5/9] powerpc/pseries: flush SLB contents on SLB MCE errors.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Michal Suchanek <msuchanek@suse.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>, Ananth Narayan <ananth@in.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 07 Aug 2018 19:47:14 +0530
In-Reply-To: <153365127532.14256.1965469477086140841.stgit@jupiter.in.ibm.com>
References: <153365127532.14256.1965469477086140841.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153365142349.14256.9954484737438718329.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

On pseries, as of today system crashes if we get a machine check
exceptions due to SLB errors. These are soft errors and can be fixed by
flushing the SLBs so the kernel can continue to function instead of
system crash. We do this in real mode before turning on MMU. Otherwise
we would run into nested machine checks. This patch now fetches the
rtas error log in real mode and flushes the SLBs on SLB errors.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Michal Suchanek <msuchanek@suse.com>
---

Changes in V7:
- Fold Michal's patch into this patch.
- Handle MSR_RI=0 and evil context case in MC handler.
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |    1 
 arch/powerpc/include/asm/machdep.h            |    1 
 arch/powerpc/kernel/exceptions-64s.S          |  112 +++++++++++++++++++++++++
 arch/powerpc/kernel/mce.c                     |   15 +++
 arch/powerpc/mm/slb.c                         |    6 +
 arch/powerpc/platforms/powernv/setup.c        |   11 ++
 arch/powerpc/platforms/pseries/pseries.h      |    1 
 arch/powerpc/platforms/pseries/ras.c          |   51 +++++++++++
 arch/powerpc/platforms/pseries/setup.c        |    1 
 9 files changed, 195 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 50ed64fba4ae..cc00a7088cf3 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -487,6 +487,7 @@ extern void hpte_init_native(void);
 
 extern void slb_initialize(void);
 extern void slb_flush_and_rebolt(void);
+extern void slb_flush_and_rebolt_realmode(void);
 
 extern void slb_vmalloc_update(void);
 extern void slb_set_size(u16 size);
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index a47de82fb8e2..b4831f1338db 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -108,6 +108,7 @@ struct machdep_calls {
 
 	/* Early exception handlers called in realmode */
 	int		(*hmi_exception_early)(struct pt_regs *regs);
+	long		(*machine_check_early)(struct pt_regs *regs);
 
 	/* Called during machine check exception to retrive fixup address. */
 	bool		(*mce_check_early_recovery)(struct pt_regs *regs);
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 285c6465324a..cb06f219570a 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -332,6 +332,9 @@ TRAMP_REAL_BEGIN(machine_check_pSeries)
 machine_check_fwnmi:
 	SET_SCRATCH0(r13)		/* save r13 */
 	EXCEPTION_PROLOG_0(PACA_EXMC)
+BEGIN_FTR_SECTION
+	b	machine_check_pSeries_early
+END_FTR_SECTION_IFCLR(CPU_FTR_HVMODE)
 machine_check_pSeries_0:
 	EXCEPTION_PROLOG_1(PACA_EXMC, KVMTEST_PR, 0x200)
 	/*
@@ -343,6 +346,90 @@ machine_check_pSeries_0:
 
 TRAMP_KVM_SKIP(PACA_EXMC, 0x200)
 
+TRAMP_REAL_BEGIN(machine_check_pSeries_early)
+BEGIN_FTR_SECTION
+	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
+	mr	r10,r1			/* Save r1 */
+	ld	r1,PACAMCEMERGSP(r13)	/* Use MC emergency stack */
+	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame		*/
+	mfspr	r11,SPRN_SRR0		/* Save SRR0 */
+	mfspr	r12,SPRN_SRR1		/* Save SRR1 */
+	EXCEPTION_PROLOG_COMMON_1()
+	EXCEPTION_PROLOG_COMMON_2(PACA_EXMC)
+	EXCEPTION_PROLOG_COMMON_3(0x200)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	BRANCH_LINK_TO_FAR(machine_check_early) /* Function call ABI */
+	ld	r12,_MSR(r1)
+	andi.	r11,r12,MSR_PR		/* See if coming from user. */
+	bne	2f			/* continue in V mode if we are. */
+
+	/*
+	 * At this point we are not sure about what context we come from.
+	 * We may be in the middle of swithing stack. r1 may not be valid.
+	 * Hence stay on emergency stack, call machine_check_exception and
+	 * return from the interrupt.
+	 * But before that, check if this is an un-recoverable exception.
+	 * If yes, then stay on emergency stack and panic.
+	 */
+	andi.	r11,r12,MSR_RI
+	bne	1f
+
+	/*
+	 * Check if we have successfully handled/recovered from error, if not
+	 * then stay on emergency stack and panic.
+	 */
+	cmpdi	r3,0		/* see if we handled MCE successfully */
+	bne	1f		/* if handled then return from interrupt */
+
+	LOAD_HANDLER(r10,unrecover_mce)
+	mtspr	SPRN_SRR0,r10
+	ld	r10,PACAKMSR(r13)
+	/*
+	 * We are going down. But there are chances that we might get hit by
+	 * another MCE during panic path and we may run into unstable state
+	 * with no way out. Hence, turn ME bit off while going down, so that
+	 * when another MCE is hit during panic path, hypervisor will
+	 * power cycle the lpar, instead of getting into MCE loop.
+	 */
+	li	r3,MSR_ME
+	andc	r10,r10,r3		/* Turn off MSR_ME */
+	mtspr	SPRN_SRR1,r10
+	RFI_TO_KERNEL
+	b	.
+
+	/* Stay on emergency stack and return from interrupt. */
+1:	LOAD_HANDLER(r10,mce_return)
+	mtspr	SPRN_SRR0,r10
+	ld	r10,PACAKMSR(r13)
+	mtspr	SPRN_SRR1,r10
+	RFI_TO_KERNEL
+	b	.
+
+	/* Move original SRR0 and SRR1 into the respective regs */
+2:	ld	r9,_MSR(r1)
+	mtspr	SPRN_SRR1,r9
+	ld	r3,_NIP(r1)
+	mtspr	SPRN_SRR0,r3
+	ld	r9,_CTR(r1)
+	mtctr	r9
+	ld	r9,_XER(r1)
+	mtxer	r9
+	ld	r9,_LINK(r1)
+	mtlr	r9
+	REST_GPR(0, r1)
+	REST_8GPRS(2, r1)
+	REST_GPR(10, r1)
+	ld	r11,_CCR(r1)
+	mtcr	r11
+	REST_GPR(11, r1)
+	REST_2GPRS(12, r1)
+	/* restore original r1. */
+	ld	r1,GPR1(r1)
+	SET_SCRATCH0(r13)		/* save r13 */
+	EXCEPTION_PROLOG_0(PACA_EXMC)
+	b	machine_check_pSeries_0
+END_FTR_SECTION_IFCLR(CPU_FTR_HVMODE)
+
 EXC_COMMON_BEGIN(machine_check_common)
 	/*
 	 * Machine check is different because we use a different
@@ -536,6 +623,31 @@ EXC_COMMON_BEGIN(unrecover_mce)
 	bl	unrecoverable_exception
 	b	1b
 
+EXC_COMMON_BEGIN(mce_return)
+	/* Invoke machine_check_exception to print MCE event and return. */
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	machine_check_exception
+	ld	r9,_MSR(r1)
+	mtspr	SPRN_SRR1,r9
+	ld	r3,_NIP(r1)
+	mtspr	SPRN_SRR0,r3
+	ld	r9,_CTR(r1)
+	mtctr	r9
+	ld	r9,_XER(r1)
+	mtxer	r9
+	ld	r9,_LINK(r1)
+	mtlr	r9
+	REST_GPR(0, r1)
+	REST_8GPRS(2, r1)
+	REST_GPR(10, r1)
+	ld	r11,_CCR(r1)
+	mtcr	r11
+	REST_GPR(11, r1)
+	REST_2GPRS(12, r1)
+	/* restore original r1. */
+	ld	r1,GPR1(r1)
+	RFI_TO_KERNEL
+	b	.
 
 EXC_REAL(data_access, 0x300, 0x80)
 EXC_VIRT(data_access, 0x4300, 0x80, 0x300)
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index efdd16a79075..ae17d8aa60c4 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -488,10 +488,19 @@ long machine_check_early(struct pt_regs *regs)
 {
 	long handled = 0;
 
-	__this_cpu_inc(irq_stat.mce_exceptions);
+	/*
+	 * For pSeries we count mce when we go into virtual mode machine
+	 * check handler. Hence skip it. Also, We can't access per cpu
+	 * variables in real mode for LPAR.
+	 */
+	if (early_cpu_has_feature(CPU_FTR_HVMODE))
+		__this_cpu_inc(irq_stat.mce_exceptions);
 
-	if (cur_cpu_spec && cur_cpu_spec->machine_check_early)
-		handled = cur_cpu_spec->machine_check_early(regs);
+	/*
+	 * See if platform is capable of handling machine check.
+	 */
+	if (ppc_md.machine_check_early)
+		handled = ppc_md.machine_check_early(regs);
 	return handled;
 }
 
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index cb796724a6fc..e89f675f1b5e 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -145,6 +145,12 @@ void slb_flush_and_rebolt(void)
 	get_paca()->slb_cache_ptr = 0;
 }
 
+void slb_flush_and_rebolt_realmode(void)
+{
+	__slb_flush_and_rebolt();
+	get_paca()->slb_cache_ptr = 0;
+}
+
 void slb_vmalloc_update(void)
 {
 	unsigned long vflags;
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index f96df0a25d05..b74c93bc2e55 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -431,6 +431,16 @@ static unsigned long pnv_get_proc_freq(unsigned int cpu)
 	return ret_freq;
 }
 
+static long pnv_machine_check_early(struct pt_regs *regs)
+{
+	long handled = 0;
+
+	if (cur_cpu_spec && cur_cpu_spec->machine_check_early)
+		handled = cur_cpu_spec->machine_check_early(regs);
+
+	return handled;
+}
+
 define_machine(powernv) {
 	.name			= "PowerNV",
 	.probe			= pnv_probe,
@@ -442,6 +452,7 @@ define_machine(powernv) {
 	.machine_shutdown	= pnv_shutdown,
 	.power_save             = NULL,
 	.calibrate_decr		= generic_calibrate_decr,
+	.machine_check_early	= pnv_machine_check_early,
 #ifdef CONFIG_KEXEC_CORE
 	.kexec_cpu_down		= pnv_kexec_cpu_down,
 #endif
diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 60db2ee511fb..ec2a5f61d4a4 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -24,6 +24,7 @@ struct pt_regs;
 
 extern int pSeries_system_reset_exception(struct pt_regs *regs);
 extern int pSeries_machine_check_exception(struct pt_regs *regs);
+extern long pSeries_machine_check_realmode(struct pt_regs *regs);
 
 #ifdef CONFIG_SMP
 extern void smp_init_pseries(void);
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 851ce326874a..e4420f7c8fda 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -427,6 +427,35 @@ int pSeries_system_reset_exception(struct pt_regs *regs)
 	return 0; /* need to perform reset */
 }
 
+static int mce_handle_error(struct rtas_error_log *errp)
+{
+	struct pseries_errorlog *pseries_log;
+	struct pseries_mc_errorlog *mce_log;
+	int disposition = rtas_error_disposition(errp);
+	uint8_t error_type;
+
+	if (!rtas_error_extended(errp))
+		goto out;
+
+	pseries_log = get_pseries_errorlog(errp, PSERIES_ELOG_SECT_ID_MCE);
+	if (pseries_log == NULL)
+		goto out;
+
+	mce_log = (struct pseries_mc_errorlog *)pseries_log->data;
+	error_type = rtas_mc_error_type(mce_log);
+
+	if ((disposition == RTAS_DISP_NOT_RECOVERED) &&
+			(error_type == PSERIES_MC_ERROR_TYPE_SLB)) {
+		/* Store the old slb content someplace. */
+		slb_flush_and_rebolt_realmode();
+		disposition = RTAS_DISP_FULLY_RECOVERED;
+		rtas_set_disposition_recovered(errp);
+	}
+
+out:
+	return disposition;
+}
+
 /*
  * Process MCE rtas errlog event.
  */
@@ -503,11 +532,31 @@ int pSeries_machine_check_exception(struct pt_regs *regs)
 	struct rtas_error_log *errp;
 
 	if (fwnmi_active) {
-		errp = fwnmi_get_errinfo(regs);
 		fwnmi_release_errinfo();
+		errp = fwnmi_get_errlog();
 		if (errp && recover_mce(regs, errp))
 			return 1;
 	}
 
 	return 0;
 }
+
+long pSeries_machine_check_realmode(struct pt_regs *regs)
+{
+	struct rtas_error_log *errp;
+	int disposition;
+
+	if (fwnmi_active) {
+		errp = fwnmi_get_errinfo(regs);
+		/*
+		 * Call to fwnmi_release_errinfo() in real mode causes kernel
+		 * to panic. Hence we will call it as soon as we go into
+		 * virtual mode.
+		 */
+		disposition = mce_handle_error(errp);
+		if (disposition == RTAS_DISP_FULLY_RECOVERED)
+			return 1;
+	}
+
+	return 0;
+}
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index b42087cd8c6b..7a9421d089d8 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -1000,6 +1000,7 @@ define_machine(pseries) {
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= rtas_progress,
 	.system_reset_exception = pSeries_system_reset_exception,
+	.machine_check_early	= pSeries_machine_check_realmode,
 	.machine_check_exception = pSeries_machine_check_exception,
 #ifdef CONFIG_KEXEC_CORE
 	.machine_kexec          = pSeries_machine_kexec,
