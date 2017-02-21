Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vS3Qj0H2DzDqGn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 12:52:13 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vS3Qh0FbNz9s8G
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 12:52:11 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1L1nHAE088601
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 20:52:10 -0500
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28r1202q26-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Feb 2017 20:52:10 -0500
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 21 Feb 2017 07:22:06 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4650F125805C
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 07:22:10 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1L1p0hm14221386
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 07:21:00 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1L1q3bQ014291
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Feb 2017 07:22:03 +0530
Subject: [RFC PATCH 2/7] powerpc/book3s: mce: Call opal mce handler to
 extract MCE error reason.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Date: Tue, 21 Feb 2017 07:22:02 +0530
In-Reply-To: <148764180622.19289.14009454092692029974.stgit@jupiter.in.ibm.com>
References: <148764180622.19289.14009454092692029974.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148764192219.19289.16692912616165807064.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

This is a RFC implementation that proposes an approach where linux would
still take an MCE interrupt but it would make opal call to handle all
chip specific processing to extract the error reason.

Opal will support OPAL_HANDLE_MACHINE_CHECK token if it implements
machine check handler currently installed FW. If this token is supported
then linux will populate ppc_md.machine_check_early() function pointer.

But if opal mce handler does not support processing/extracting MCE reason
for current chip, then it will return OPAL_UNSUPPORTED. e.g. new OPAL FW
installed on system with Power8 or below. In this case (i.e on Power8 system)
it will fallback to in-kernel MCE handler as it does today.

This patch uses OPAL_CALL_REAL() wrapper to be able to go back into OPAL on
machine check interrupt. The reason is, OPAL_CALL() wrapper makes it
difficult since it uses r13 to save PACASAVEDMSR which overwrites previous
MSR if we already in opal when MCE hit us.

We also need to make OPAL to stick to caller's stack to make opal call
re-entrant. Will send out a separate patch to skiboot mailing list.

The other approach could be let opal patch up 0x200 vector so that opal
takes up the interrupt and does the processing. comments welcome.

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h             |    2 ++
 arch/powerpc/include/asm/opal-api.h            |    3 ++-
 arch/powerpc/include/asm/opal.h                |    3 +++
 arch/powerpc/kernel/traps.c                    |   15 ++++++++++++++-
 arch/powerpc/platforms/powernv/opal-wrappers.S |    1 +
 arch/powerpc/platforms/powernv/opal.c          |   16 ++++++++++++++++
 arch/powerpc/platforms/powernv/setup.c         |    4 ++++
 7 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 5011b69..037ea19 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -108,6 +108,8 @@ struct machdep_calls {
 
 	/* Early exception handlers called in realmode */
 	int		(*hmi_exception_early)(struct pt_regs *regs);
+	int		(*machine_check_early)(struct pt_regs *regs,
+							long *handled);
 
 	/* Called during machine check exception to retrive fixup address. */
 	bool		(*mce_check_early_recovery)(struct pt_regs *regs);
diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 6851be6..8485e67 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -167,7 +167,8 @@
 #define OPAL_INT_EOI				124
 #define OPAL_INT_SET_MFRR			125
 #define OPAL_PCI_TCE_KILL			126
-#define OPAL_LAST				126
+#define OPAL_HANDLE_MACHINE_CHECK		145
+#define OPAL_LAST				145
 
 /* Device tree flags */
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 5c7db0f..4834e0d 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -189,6 +189,8 @@ int64_t opal_set_param(uint64_t token, uint32_t param_id, uint64_t buffer,
 		uint64_t length);
 int64_t opal_sensor_read(uint32_t sensor_hndl, int token, __be32 *sensor_data);
 int64_t opal_handle_hmi(void);
+int64_t opal_rm_handle_machine_check(uint64_t srr0, uint64_t srr1, uint64_t dar,
+					uint64_t dsisr, uint64_t *mce);
 int64_t opal_register_dump_region(uint32_t id, uint64_t start, uint64_t end);
 int64_t opal_unregister_dump_region(uint32_t id);
 int64_t opal_slw_set_reg(uint64_t cpu_pir, uint64_t sprn, uint64_t val);
@@ -279,6 +281,7 @@ extern int opal_hmi_handler_init(void);
 extern int opal_event_init(void);
 
 extern int opal_machine_check(struct pt_regs *regs);
+extern int opal_machine_check_early(struct pt_regs *regs, long *handled);
 extern bool opal_mce_check_early_recovery(struct pt_regs *regs);
 extern int opal_hmi_exception_early(struct pt_regs *regs);
 extern int opal_handle_hmi_exception(struct pt_regs *regs);
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index e6cc56b..62b587f 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -302,12 +302,25 @@ void system_reset_exception(struct pt_regs *regs)
 long machine_check_early(struct pt_regs *regs)
 {
 	long handled = 0;
+	int rc = 0;
 
 	__this_cpu_inc(irq_stat.mce_exceptions);
 
 	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
 
-	if (cur_cpu_spec && cur_cpu_spec->machine_check_early)
+	/*
+	 * See if platform is capable of handling machine check. (e.g. PowerNV
+	 * platform may take help from OPAL firmware to handle machine check.)
+	 * Otherwise fallthrough and allow CPU to handle this machine check.
+	 *
+	 * If rc == -1 then it means firmware does not provide support for
+	 * machine check handling for this CPU chip. Fallback to in-kernel
+	 * machine check handler.
+	 */
+	if (ppc_md.machine_check_early)
+		rc = ppc_md.machine_check_early(regs, &handled);
+
+	if (!rc && cur_cpu_spec && cur_cpu_spec->machine_check_early)
 		handled = cur_cpu_spec->machine_check_early(regs);
 	return handled;
 }
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 3aa40f1..3120d2e 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -312,3 +312,4 @@ OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
 OPAL_CALL_REAL(opal_rm_int_set_mfrr,		OPAL_INT_SET_MFRR);
 OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
 OPAL_CALL_REAL(opal_rm_pci_tce_kill,		OPAL_PCI_TCE_KILL);
+OPAL_CALL_REAL(opal_rm_handle_machine_check,		OPAL_HANDLE_MACHINE_CHECK);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 3eb0e94..263c57e 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -488,6 +488,22 @@ int opal_machine_check(struct pt_regs *regs)
 	return 0;
 }
 
+/* Early mce handler called in real mode. */
+int opal_machine_check_early(struct pt_regs *regs, long *handled)
+{
+	int rc;
+	struct OpalMachineCheckEvent evt = { 0 };
+
+	*handled = 0;
+
+	rc = opal_rm_handle_machine_check(regs->nip, regs->msr, regs->dar,
+					regs->dsisr, (uint64_t *)&evt);
+	if (rc != OPAL_SUCCESS)
+		return -1;
+
+	return 0;
+}
+
 /* Early hmi handler called in real mode. */
 int opal_hmi_exception_early(struct pt_regs *regs)
 {
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index d50c7d9..781478a 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -264,6 +264,10 @@ static void __init pnv_setup_machdep_opal(void)
 	ppc_md.mce_check_early_recovery = opal_mce_check_early_recovery;
 	ppc_md.hmi_exception_early = opal_hmi_exception_early;
 	ppc_md.handle_hmi_exception = opal_handle_hmi_exception;
+
+	/* Check if OPAL is capable of handling machine check. */
+	if (opal_check_token(OPAL_HANDLE_MACHINE_CHECK))
+		ppc_md.machine_check_early = opal_machine_check_early;
 }
 
 static int __init pnv_probe(void)
