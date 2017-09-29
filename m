Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y3HBL4Gz0zDsQS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 13:30:18 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id e69so116208pfg.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 20:30:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 6/6] powerpc/powernv: implement NMI IPI with
 OPAL_SIGNAL_SYSTEM_RESET
Date: Fri, 29 Sep 2017 13:29:42 +1000
Message-Id: <20170929032942.4321-7-npiggin@gmail.com>
In-Reply-To: <20170929032942.4321-1-npiggin@gmail.com>
References: <20170929032942.4321-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This allows MSR[EE]=0 lockups to be detected on an OPAL (bare metal)
system similarly to the hcall NMI IPI on pseries guests, when the
platform/firmware supports it.

This is an example of CPU10 spinning with interrupts hard disabled:

Watchdog CPU:32 detected Hard LOCKUP other CPUS:10
Watchdog CPU:10 Hard LOCKUP
CPU: 10 PID: 4410 Comm: bash Not tainted 4.13.0-rc7-00074-ge89ce1f89f62-dirty #34
task: c0000003a82b4400 task.stack: c0000003af55c000
NIP: c0000000000a7b38 LR: c000000000659044 CTR: c0000000000a7b00
REGS: c00000000fd23d80 TRAP: 0100   Not tainted  (4.13.0-rc7-00074-ge89ce1f89f62-dirty)
MSR: 90000000000c1033 <SF,HV,ME,IR,DR,RI,LE>
CR: 28422222  XER: 20000000
CFAR: c0000000000a7b38 SOFTE: 0
GPR00: c000000000659044 c0000003af55fbb0 c000000001072a00 0000000000000078
GPR04: c0000003c81b5c80 c0000003c81cc7e8 9000000000009033 0000000000000000
GPR08: 0000000000000000 c0000000000a7b00 0000000000000001 9000000000001003
GPR12: c0000000000a7b00 c00000000fd83200 0000000010180df8 0000000010189e60
GPR16: 0000000010189ed8 0000000010151270 000000001018bd88 000000001018de78
GPR20: 00000000370a0668 0000000000000001 00000000101645e0 0000000010163c10
GPR24: 00007fffd14d6294 00007fffd14d6290 c000000000fba6f0 0000000000000004
GPR28: c000000000f351d8 0000000000000078 c000000000f4095c 0000000000000000
NIP [c0000000000a7b38] sysrq_handle_xmon+0x38/0x40
LR [c000000000659044] __handle_sysrq+0xe4/0x270
Call Trace:
[c0000003af55fbd0] [c000000000659044] __handle_sysrq+0xe4/0x270
[c0000003af55fc70] [c000000000659810] write_sysrq_trigger+0x70/0xa0
[c0000003af55fca0] [c0000000003da650] proc_reg_write+0xb0/0x110
[c0000003af55fcf0] [c0000000003423bc] __vfs_write+0x6c/0x1b0
[c0000003af55fd90] [c000000000344398] vfs_write+0xd8/0x240
[c0000003af55fde0] [c00000000034632c] SyS_write+0x6c/0x110
[c0000003af55fe30] [c00000000000b220] system_call+0x58/0x6c

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/opal-api.h            |  1 +
 arch/powerpc/include/asm/opal.h                |  2 +
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 arch/powerpc/platforms/powernv/setup.c         |  1 +
 arch/powerpc/platforms/powernv/smp.c           | 52 ++++++++++++++++++++++++++
 5 files changed, 57 insertions(+)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 450a60b81d2a..9d191ebea706 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -188,6 +188,7 @@
 #define OPAL_XIVE_DUMP				142
 #define OPAL_XIVE_RESERVED3			143
 #define OPAL_XIVE_RESERVED4			144
+#define OPAL_SIGNAL_SYSTEM_RESET		145
 #define OPAL_NPU_INIT_CONTEXT			146
 #define OPAL_NPU_DESTROY_CONTEXT		147
 #define OPAL_NPU_MAP_LPAR			148
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 726c23304a57..7d7613c49f2b 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -281,6 +281,8 @@ int opal_get_power_shift_ratio(u32 handle, int token, u32 *psr);
 int opal_set_power_shift_ratio(u32 handle, int token, u32 psr);
 int opal_sensor_group_clear(u32 group_hndl, int token);
 
+int64_t opal_signal_system_reset(int32_t cpu);
+
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
 				   int depth, void *data);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 8c1ede2d3f7e..37cd170201a2 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -307,6 +307,7 @@ OPAL_CALL(opal_xive_get_vp_info,		OPAL_XIVE_GET_VP_INFO);
 OPAL_CALL(opal_xive_set_vp_info,		OPAL_XIVE_SET_VP_INFO);
 OPAL_CALL(opal_xive_sync,			OPAL_XIVE_SYNC);
 OPAL_CALL(opal_xive_dump,			OPAL_XIVE_DUMP);
+OPAL_CALL(opal_signal_system_reset,		OPAL_SIGNAL_SYSTEM_RESET);
 OPAL_CALL(opal_npu_init_context,		OPAL_NPU_INIT_CONTEXT);
 OPAL_CALL(opal_npu_destroy_context,		OPAL_NPU_DESTROY_CONTEXT);
 OPAL_CALL(opal_npu_map_lpar,			OPAL_NPU_MAP_LPAR);
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 897aa1400eb8..cf52d53da460 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -282,6 +282,7 @@ static void __init pnv_setup_machdep_opal(void)
 	ppc_md.restart = pnv_restart;
 	pm_power_off = pnv_power_off;
 	ppc_md.halt = pnv_halt;
+	/* ppc_md.system_reset_exception gets filled in by pnv_smp_init() */
 	ppc_md.machine_check_exception = opal_machine_check;
 	ppc_md.mce_check_early_recovery = opal_mce_check_early_recovery;
 	ppc_md.hmi_exception_early = opal_hmi_exception_early;
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index c17f81e433f7..c52b351716b2 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -290,6 +290,54 @@ static void __init pnv_smp_probe(void)
 	}
 }
 
+static int pnv_system_reset_exception(struct pt_regs *regs)
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
+	if (cpu >= 0) {
+		rc = opal_signal_system_reset(get_hard_smp_processor_id(cpu));
+		if (rc != OPAL_SUCCESS)
+			return 0;
+		return 1;
+
+	} else if (cpu == NMI_IPI_ALL_OTHERS) {
+		bool success = true;
+		int c;
+
+
+		/*
+		 * We do not use broadcasts (yet), because it's not clear
+		 * exactly what semantics Linux wants or the firmware should
+		 * provide.
+		 */
+		for_each_online_cpu(c) {
+			if (c == smp_processor_id())
+				continue;
+
+			rc = opal_signal_system_reset(
+						get_hard_smp_processor_id(c));
+			if (rc != OPAL_SUCCESS)
+				success = false;
+		}
+		if (success)
+			return 1;
+
+		/*
+		 * Caller will fall back to doorbells, which may pick
+		 * up the remainders.
+		 */
+	}
+
+	return 0;
+}
+
 static struct smp_ops_t pnv_smp_ops = {
 	.message_pass	= NULL, /* Use smp_muxed_ipi_message_pass */
 	.cause_ipi	= NULL,	/* Filled at runtime by pnv_smp_probe() */
@@ -308,6 +356,10 @@ static struct smp_ops_t pnv_smp_ops = {
 /* This is called very early during platform setup_arch */
 void __init pnv_smp_init(void)
 {
+	if (opal_check_token(OPAL_SIGNAL_SYSTEM_RESET)) {
+		ppc_md.system_reset_exception = pnv_system_reset_exception;
+		pnv_smp_ops.cause_nmi_ipi = pnv_cause_nmi_ipi;
+	}
 	smp_ops = &pnv_smp_ops;
 
 #ifdef CONFIG_HOTPLUG_CPU
-- 
2.13.3
