Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t02zL4B3ZzDvWg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 20:08:30 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id s8so5007501pfj.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Oct 2016 02:08:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC][PATCH] powerpc/pseries: implement NMI IPIs with
 H_SIGNAL_SYS_RESET hcall
Date: Thu, 20 Oct 2016 20:08:16 +1100
Message-Id: <20161020090816.22631-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a .cause_nmi_ipi() to smp_ops to support it. Although it's
possible to raise a system reset exception on this CPU, which
may (or may not) be useful to bring ourselves into a known state.
So perhaps it's better make this a platform operation?

Thanks,
Nick

---
 arch/powerpc/include/asm/hvcall.h         | 8 +++++++-
 arch/powerpc/include/asm/plpar_wrappers.h | 5 +++++
 arch/powerpc/include/asm/smp.h            | 4 ++++
 arch/powerpc/kernel/smp.c                 | 3 +++
 arch/powerpc/platforms/powermac/smp.c     | 1 +
 arch/powerpc/platforms/powernv/smp.c      | 1 +
 arch/powerpc/platforms/pseries/smp.c      | 8 ++++++++
 7 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 708edeb..a38171c 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -275,7 +275,8 @@
 #define H_COP			0x304
 #define H_GET_MPP_X		0x314
 #define H_SET_MODE		0x31C
-#define MAX_HCALL_OPCODE	H_SET_MODE
+#define H_SIGNAL_SYS_RESET	0x380
+#define MAX_HCALL_OPCODE	H_SIGNAL_SYS_RESET
 
 /* H_VIOCTL functions */
 #define H_GET_VIOA_DUMP_SIZE	0x01
@@ -306,6 +307,11 @@
 #define H_SET_MODE_RESOURCE_ADDR_TRANS_MODE	3
 #define H_SET_MODE_RESOURCE_LE			4
 
+/* Values for argument to H_SIGNAL_SYS_RESET */
+#define H_SIGNAL_SYS_RESET_ALL			-1
+#define H_SIGNAL_SYS_RESET_ALLBUTSELF		-2
+#define H_SIGNAL_SYS_RESET_CPU(x)		(x)
+
 #ifndef __ASSEMBLY__
 
 /**
diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index 1b39424..7fe5983 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -340,4 +340,9 @@ static inline long plapr_set_watchpoint0(unsigned long dawr0, unsigned long dawr
 	return plpar_set_mode(0, H_SET_MODE_RESOURCE_SET_DAWR, dawr0, dawrx0);
 }
 
+static inline long plapr_signal_system_reset(long cpu)
+{
+	return plpar_hcall_norets(H_SIGNAL_SYS_RESET, cpu);
+}
+
 #endif /* _ASM_POWERPC_PLPAR_WRAPPERS_H */
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 0d02c11..15eb615 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -37,11 +37,15 @@ extern int cpu_to_chip_id(int cpu);
 
 #ifdef CONFIG_SMP
 
+#define SMP_OP_NMI_ALL		-1
+#define SMP_OP_NMI_ALLBUTSELF	-2
+
 struct smp_ops_t {
 	void  (*message_pass)(int cpu, int msg);
 #ifdef CONFIG_PPC_SMP_MUXED_IPI
 	void  (*cause_ipi)(int cpu, unsigned long data);
 #endif
+	int   (*cause_nmi_ipi)(int cpu);
 	void  (*probe)(void);
 	int   (*kick_cpu)(int nr);
 	void  (*setup_cpu)(int nr);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 9c6f3fd..4a1161e 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -334,6 +334,9 @@ void smp_send_debugger_break(void)
 	if (unlikely(!smp_ops))
 		return;
 
+	if (smp_ops->cause_nmi_ipi && smp_ops->cause_nmi_ipi(SMP_OP_NMI_ALLBUTSELF))
+		return;
+
 	for_each_online_cpu(cpu)
 		if (cpu != me)
 			do_message_pass(cpu, PPC_MSG_DEBUGGER_BREAK);
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index c9eb7d6..1d76e15 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -446,6 +446,7 @@ void __init smp_psurge_give_timebase(void)
 struct smp_ops_t psurge_smp_ops = {
 	.message_pass	= NULL,	/* Use smp_muxed_ipi_message_pass */
 	.cause_ipi	= smp_psurge_cause_ipi,
+	.cause_nmi_ipi	= NULL,
 	.probe		= smp_psurge_probe,
 	.kick_cpu	= smp_psurge_kick_cpu,
 	.setup_cpu	= smp_psurge_setup_cpu,
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index c789258..092ec1f 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -244,6 +244,7 @@ static int pnv_cpu_bootable(unsigned int nr)
 static struct smp_ops_t pnv_smp_ops = {
 	.message_pass	= smp_muxed_ipi_message_pass,
 	.cause_ipi	= NULL,	/* Filled at runtime by xics_smp_probe() */
+	.cause_nmi_ipi	= NULL,
 	.probe		= xics_smp_probe,
 	.kick_cpu	= pnv_smp_kick_cpu,
 	.setup_cpu	= pnv_smp_setup_cpu,
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index f6f83ae..187b981 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -196,6 +196,13 @@ static void pSeries_cause_ipi_mux(int cpu, unsigned long data)
 		xics_cause_ipi(cpu, data);
 }
 
+static int smp_pSeries_cause_nmi_ipi(int cpu)
+{
+	if (plapr_signal_system_reset(cpu) == H_SUCCESS)
+		return 1;
+	return 0;
+}
+
 static __init void pSeries_smp_probe(void)
 {
 	xics_smp_probe();
@@ -209,6 +216,7 @@ static __init void pSeries_smp_probe(void)
 static struct smp_ops_t pseries_smp_ops = {
 	.message_pass	= NULL,	/* Use smp_muxed_ipi_message_pass */
 	.cause_ipi	= NULL,	/* Filled at runtime by pSeries_smp_probe() */
+	.cause_nmi_ipi	= smp_pSeries_cause_nmi_ipi,
 	.probe		= pSeries_smp_probe,
 	.kick_cpu	= smp_pSeries_kick_cpu,
 	.setup_cpu	= smp_setup_cpu,
-- 
2.9.3
