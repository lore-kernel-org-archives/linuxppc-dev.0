Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDj2b13zwzDq9d
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 01:25:27 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id 75so1967588pgf.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Feb 2017 06:25:27 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH] powerpc/powernv: implement NMI IPI with
 OPAL_SIGNAL_SYSTEM_RESET
Date: Fri,  3 Feb 2017 00:25:11 +1000
Message-Id: <20170202142511.14158-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Hi,

This goes with the previous NMI IPI series, and a new version of
Alistair's opal API I posted to the skiboot list.

Only RFC until the firmware API is agreed on.

Thanks,
Nick

 arch/powerpc/include/asm/opal-api.h            | 21 ++++++++++++++++++++-
 arch/powerpc/include/asm/opal.h                |  1 +
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 arch/powerpc/platforms/powernv/powernv.h       |  1 +
 arch/powerpc/platforms/powernv/setup.c         |  3 +++
 arch/powerpc/platforms/powernv/smp.c           | 24 ++++++++++++++++++++++++
 6 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 0e2e57bcab50..53f1c09cab5d 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -167,7 +167,26 @@
 #define OPAL_INT_EOI				124
 #define OPAL_INT_SET_MFRR			125
 #define OPAL_PCI_TCE_KILL			126
-#define OPAL_LAST				126
+#define OPAL_NMMU_SET_PTCR			127
+#define OPAL_XIVE_RESET				128
+#define OPAL_XIVE_GET_IRQ_INFO			129
+#define OPAL_XIVE_GET_IRQ_CONFIG		130
+#define OPAL_XIVE_SET_IRQ_CONFIG		131
+#define OPAL_XIVE_GET_QUEUE_INFO		132
+#define OPAL_XIVE_SET_QUEUE_INFO		133
+#define OPAL_XIVE_DONATE_PAGE			134
+#define OPAL_XIVE_ALLOCATE_VP_BLOCK		135
+#define OPAL_XIVE_FREE_VP_BLOCK			136
+#define OPAL_XIVE_GET_VP_INFO			137
+#define OPAL_XIVE_SET_VP_INFO			138
+#define OPAL_XIVE_ALLOCATE_IRQ			139
+#define OPAL_XIVE_FREE_IRQ			140
+#define OPAL_XIVE_RESERVED1			141
+#define OPAL_XIVE_RESERVED2			142
+#define OPAL_XIVE_RESERVED3			143
+#define OPAL_XIVE_RESERVED4			144
+#define OPAL_SIGNAL_SYSTEM_RESET		145
+#define OPAL_LAST				145
 
 /* Device tree flags */
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 5c7db0f1a708..893d422febf6 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -232,6 +232,7 @@ int64_t opal_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
 int64_t opal_rm_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
 			     uint32_t pe_num, uint32_t tce_size,
 			     uint64_t dma_addr, uint32_t npages);
+int64_t opal_signal_system_reset(int32_t cpu);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 3aa40f1b20f5..e1e9ef11f100 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -312,3 +312,4 @@ OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
 OPAL_CALL_REAL(opal_rm_int_set_mfrr,		OPAL_INT_SET_MFRR);
 OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
 OPAL_CALL_REAL(opal_rm_pci_tce_kill,		OPAL_PCI_TCE_KILL);
+OPAL_CALL(opal_signal_system_reset,		OPAL_SIGNAL_SYSTEM_RESET);
diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
index da7c843ac7f1..6b17bf7190e7 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -3,6 +3,7 @@
 
 #ifdef CONFIG_SMP
 extern void pnv_smp_init(void);
+extern int pnv_system_reset_exception(struct pt_regs *regs);
 #else
 static inline void pnv_smp_init(void) { }
 #endif
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index d50c7d99baaf..2ebb429e272e 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -260,6 +260,9 @@ static void __init pnv_setup_machdep_opal(void)
 	ppc_md.restart = pnv_restart;
 	pm_power_off = pnv_power_off;
 	ppc_md.halt = pnv_halt;
+#ifdef CONFIG_SMP
+	ppc_md.system_reset_exception = pnv_system_reset_exception;
+#endif
 	ppc_md.machine_check_exception = opal_machine_check;
 	ppc_md.mce_check_early_recovery = opal_mce_check_early_recovery;
 	ppc_md.hmi_exception_early = opal_hmi_exception_early;
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 092ec1f7b58d..f90555f75723 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -241,6 +241,28 @@ static int pnv_cpu_bootable(unsigned int nr)
 	return smp_generic_cpu_bootable(nr);
 }
 
+int pnv_system_reset_exception(struct pt_regs *regs)
+{
+	if (smp_handle_nmi_ipi(regs))
+		return 1;
+	return 0;
+}
+
+static int pnv_cause_nmi_ipi(int cpu)
+{
+	int64_t rc;
+
+	rc = opal_signal_system_reset(cpu);
+	if (rc == OPAL_SUCCESS)
+		return 1;
+
+	/*
+	 * Don't cope with OPAL_PARTIAL yet (just punt to regular IPI)
+	 */
+
+	return 0;
+}
+
 static struct smp_ops_t pnv_smp_ops = {
 	.message_pass	= smp_muxed_ipi_message_pass,
 	.cause_ipi	= NULL,	/* Filled at runtime by xics_smp_probe() */
@@ -258,6 +280,8 @@ static struct smp_ops_t pnv_smp_ops = {
 /* This is called very early during platform setup_arch */
 void __init pnv_smp_init(void)
 {
+	if (opal_check_token(OPAL_SIGNAL_SYSTEM_RESET))
+		pnv_smp_ops.cause_nmi_ipi = pnv_cause_nmi_ipi;
 	smp_ops = &pnv_smp_ops;
 
 #ifdef CONFIG_HOTPLUG_CPU
-- 
2.11.0
