Return-Path: <srs0=mams=lk=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41zgTT2FP3zF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 04:31:57 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41zgTT18x4z8tQV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2018 04:31:57 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41zgTS4J9Xz9s3C
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2018 04:31:56 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7RIVj9T012643
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2018 14:31:54 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m4pga8bh0-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Aug 2018 14:31:54 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 27 Aug 2018 19:31:52 +0100
Subject: [PATCH v9 2/5] powerpc/pseries: flush SLB contents on SLB MCE errors.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Michal Suchanek <msuchanek@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
 Ananth Narayan <ananth@in.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>
Date: Tue, 28 Aug 2018 00:01:47 +0530
In-Reply-To: <153539459821.20001.16391636830334046461.stgit@jupiter.in.ibm.com>
References: <153539459821.20001.16391636830334046461.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <153539470748.20001.12704607859946860507.stgit@jupiter.in.ibm.com>
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
rtas error log in real mode and flushes the SLBs on SLB/ERAT errors.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Signed-off-by: Michal Suchanek <msuchanek@suse.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
---

Changes in V9:
- Move mce_exceptions counting to powernv's virtual mode handler.
- Recover from ERAT errors.
---
 arch/powerpc/include/asm/machdep.h       |    1 
 arch/powerpc/include/asm/mce.h           |    3 +
 arch/powerpc/kernel/exceptions-64s.S     |  129 ++++++++++++++++++++++++++++++
 arch/powerpc/kernel/mce.c                |    9 +-
 arch/powerpc/kernel/mce_power.c          |    2 
 arch/powerpc/platforms/powernv/opal.c    |    2 
 arch/powerpc/platforms/powernv/setup.c   |   11 +++
 arch/powerpc/platforms/pseries/pseries.h |    1 
 arch/powerpc/platforms/pseries/ras.c     |   60 ++++++++++++++
 arch/powerpc/platforms/pseries/setup.c   |    1 
 10 files changed, 213 insertions(+), 6 deletions(-)

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
diff --git a/arch/powerpc/include/asm/mce.h b/arch/powerpc/include/asm/mce.h
index 3a1226e9b465..78a1da95a394 100644
--- a/arch/powerpc/include/asm/mce.h
+++ b/arch/powerpc/include/asm/mce.h
@@ -210,4 +210,7 @@ extern void release_mce_event(void);
 extern void machine_check_queue_event(void);
 extern void machine_check_print_event_info(struct machine_check_event *evt,
 					   bool user_mode);
+#ifdef CONFIG_PPC_BOOK3S_64
+extern void flush_and_reload_slb(void);
+#endif /* CONFIG_PPC_BOOK3S_64 */
 #endif /* __ASM_PPC64_MCE_H__ */
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 285c6465324a..43258faa8289 100644
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
@@ -343,6 +346,103 @@ machine_check_pSeries_0:
 
 TRAMP_KVM_SKIP(PACA_EXMC, 0x200)
 
+TRAMP_REAL_BEGIN(machine_check_pSeries_early)
+BEGIN_FTR_SECTION
+	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
+	mr	r10,r1			/* Save r1 */
+	lhz	r11,PACA_IN_MCE(r13)
+	cmpwi	r11,0			/* Are we in nested machine check */
+	bne	0f			/* Yes, we are. */
+	/* First machine check entry */
+	ld	r1,PACAMCEMERGSP(r13)	/* Use MC emergency stack */
+0:	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame */
+	addi	r11,r11,1		/* increment paca->in_mce */
+	sth	r11,PACA_IN_MCE(r13)
+	/* Limit nested MCE to level 4 to avoid stack overflow */
+	cmpwi	r11,MAX_MCE_DEPTH
+	bgt	1f			/* Check if we hit limit of 4 */
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
+	 * We may be in the middle of switching stack. r1 may not be valid.
+	 * Hence stay on emergency stack, call machine_check_exception and
+	 * return from the interrupt.
+	 * But before that, check if this is an un-recoverable exception.
+	 * If yes, then stay on emergency stack and panic.
+	 */
+	andi.	r11,r12,MSR_RI
+	beq	1f
+
+	/*
+	 * Check if we have successfully handled/recovered from error, if not
+	 * then stay on emergency stack and panic.
+	 */
+	cmpdi	r3,0		/* see if we handled MCE successfully */
+	beq	1f		/* if !handled then panic */
+
+	/* Stay on emergency stack and return from interrupt. */
+	LOAD_HANDLER(r10,mce_return)
+	mtspr	SPRN_SRR0,r10
+	ld	r10,PACAKMSR(r13)
+	mtspr	SPRN_SRR1,r10
+	RFI_TO_KERNEL
+	b	.
+
+1:	LOAD_HANDLER(r10,unrecover_mce)
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
+	/* Decrement paca->in_mce. */
+	lhz	r12,PACA_IN_MCE(r13)
+	subi	r12,r12,1
+	sth	r12,PACA_IN_MCE(r13)
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
@@ -536,6 +636,35 @@ EXC_COMMON_BEGIN(unrecover_mce)
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
+	/* Decrement paca->in_mce. */
+	lhz	r12,PACA_IN_MCE(r13)
+	subi	r12,r12,1
+	sth	r12,PACA_IN_MCE(r13)
+	REST_GPR(11, r1)
+	REST_2GPRS(12, r1)
+	/* restore original r1. */
+	ld	r1,GPR1(r1)
+	RFI_TO_KERNEL
+	b	.
 
 EXC_REAL(data_access, 0x300, 0x80)
 EXC_VIRT(data_access, 0x4300, 0x80, 0x300)
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index efdd16a79075..bd933a75f0bc 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -488,10 +488,11 @@ long machine_check_early(struct pt_regs *regs)
 {
 	long handled = 0;
 
-	__this_cpu_inc(irq_stat.mce_exceptions);
-
-	if (cur_cpu_spec && cur_cpu_spec->machine_check_early)
-		handled = cur_cpu_spec->machine_check_early(regs);
+	/*
+	 * See if platform is capable of handling machine check.
+	 */
+	if (ppc_md.machine_check_early)
+		handled = ppc_md.machine_check_early(regs);
 	return handled;
 }
 
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index 368eb23f27c2..135b0b5a702e 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -60,7 +60,7 @@ static unsigned long addr_to_pfn(struct pt_regs *regs, unsigned long addr)
 
 /* flush SLBs and reload */
 #ifdef CONFIG_PPC_BOOK3S_64
-static void flush_and_reload_slb(void)
+void flush_and_reload_slb(void)
 {
 	/* Invalidate all SLBs */
 	slb_flush_all_realmode();
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 0d539c661748..c2d3c3f5f8de 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -502,6 +502,8 @@ int opal_machine_check(struct pt_regs *regs)
 {
 	struct machine_check_event evt;
 
+	__this_cpu_inc(irq_stat.mce_exceptions);
+
 	if (!get_mce_event(&evt, MCE_EVENT_RELEASE))
 		return 0;
 
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
index 3500ad982706..4c6f2b523293 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -27,6 +27,7 @@
 #include <asm/machdep.h>
 #include <asm/rtas.h>
 #include <asm/firmware.h>
+#include <asm/mce.h>
 
 #include "pseries.h"
 
@@ -522,6 +523,43 @@ int pSeries_system_reset_exception(struct pt_regs *regs)
 	return 0; /* need to perform reset */
 }
 
+static int mce_handle_error(struct rtas_error_log *errp)
+{
+	struct pseries_errorlog *pseries_log;
+	struct pseries_mc_errorlog *mce_log;
+	int disposition = rtas_error_disposition(errp);
+	u8 error_type;
+
+	if (!rtas_error_extended(errp))
+		goto out;
+
+	pseries_log = get_pseries_errorlog(errp, PSERIES_ELOG_SECT_ID_MCE);
+	if (pseries_log == NULL)
+		goto out;
+
+	mce_log = (struct pseries_mc_errorlog *)pseries_log->data;
+	error_type = mce_log->error_type;
+
+#ifdef CONFIG_PPC_BOOK3S_64
+	if (disposition == RTAS_DISP_NOT_RECOVERED) {
+		switch (error_type) {
+		case	MC_ERROR_TYPE_SLB:
+		case	MC_ERROR_TYPE_ERAT:
+			/* Store the old slb content someplace. */
+			flush_and_reload_slb();
+			disposition = RTAS_DISP_FULLY_RECOVERED;
+			rtas_set_disposition_recovered(errp);
+			break;
+		default:
+			break;
+		}
+	}
+#endif
+
+out:
+	return disposition;
+}
+
 /*
  * Process MCE rtas errlog event.
  */
@@ -598,11 +636,31 @@ int pSeries_machine_check_exception(struct pt_regs *regs)
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
index c557f45733bf..cbd1adf3e14f 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -1001,6 +1001,7 @@ define_machine(pseries) {
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= rtas_progress,
 	.system_reset_exception = pSeries_system_reset_exception,
+	.machine_check_early	= pSeries_machine_check_realmode,
 	.machine_check_exception = pSeries_machine_check_exception,
 #ifdef CONFIG_KEXEC_CORE
 	.machine_kexec          = pSeries_machine_kexec,
