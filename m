Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hXQw3jr4zF2By
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 22:22:00 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id 59-v6so1208267plc.13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 05:22:00 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/powernv: call OPAL_QUIESCE before
 OPAL_SIGNAL_SYSTEM_RESET
Date: Thu, 10 May 2018 22:21:48 +1000
Message-Id: <20180510122148.3996-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Although it is often possible to recover a CPU that was interrupted
from OPAL with a system reset NMI, it's undesirable to interrupt them
for a few reasons. Firstly because dump/debug code itself needs to
call firmware, so it could hang on a lock or possibly corrupt a
per-cpu data structure if it or another CPU was interrupted from
OPAL. Secondly, the kexec crash dump code will not return from
interrupt to unwind the OPAL call.

Call OPAL_QUIESCE with QUIESCE_HOLD before sending an NMI IPI to
another CPU, which wait for it to leave firmware (or time out) to
avoid this problem in normal conditions. Firmware bugs may still
result in a timeout and interrupting OPAL, but that is the best
option (stops the CPU, and possibly allows firmware to be debugged).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/opal-api.h            |  7 +++++++
 arch/powerpc/include/asm/opal.h                |  1 +
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 arch/powerpc/platforms/powernv/smp.c           | 17 ++++++++++++++++-
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index d886a5b7ff21..f523c72d845f 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -201,6 +201,7 @@
 #define OPAL_SET_POWER_SHIFT_RATIO		155
 #define OPAL_SENSOR_GROUP_CLEAR			156
 #define OPAL_PCI_SET_P2P			157
+#define OPAL_QUIESCE				158
 #define OPAL_NPU_SPA_SETUP			159
 #define OPAL_NPU_SPA_CLEAR_CACHE		160
 #define OPAL_NPU_TL_SET				161
@@ -208,6 +209,12 @@
 #define OPAL_PCI_SET_PBCQ_TUNNEL_BAR		165
 #define OPAL_LAST				165
 
+#define QUIESCE_HOLD			1 /* Spin all calls at entry */
+#define QUIESCE_REJECT			2 /* Fail all calls with OPAL_BUSY */
+#define QUIESCE_LOCK_BREAK		3 /* Set to ignore locks. */
+#define QUIESCE_RESUME			4 /* Un-quiesce */
+#define QUIESCE_RESUME_FAST_REBOOT	5 /* Un-quiesce, fast reboot */
+
 /* Device tree flags */
 
 /*
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 03e1a920491e..aa677a45dafe 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -293,6 +293,7 @@ int opal_set_power_shift_ratio(u32 handle, int token, u32 psr);
 int opal_sensor_group_clear(u32 group_hndl, int token);
 
 s64 opal_signal_system_reset(s32 cpu);
+s64 opal_quiesce(u64 shutdown_type, s32 cpu);
 
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 3da30c2f26b4..5eb1466665a4 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -320,6 +320,7 @@ OPAL_CALL(opal_set_powercap,			OPAL_SET_POWERCAP);
 OPAL_CALL(opal_get_power_shift_ratio,		OPAL_GET_POWER_SHIFT_RATIO);
 OPAL_CALL(opal_set_power_shift_ratio,		OPAL_SET_POWER_SHIFT_RATIO);
 OPAL_CALL(opal_sensor_group_clear,		OPAL_SENSOR_GROUP_CLEAR);
+OPAL_CALL(opal_quiesce,				OPAL_QUIESCE);
 OPAL_CALL(opal_npu_spa_setup,			OPAL_NPU_SPA_SETUP);
 OPAL_CALL(opal_npu_spa_clear_cache,		OPAL_NPU_SPA_CLEAR_CACHE);
 OPAL_CALL(opal_npu_tl_set,			OPAL_NPU_TL_SET);
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 19af6de6b6f0..b80909957792 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -334,7 +334,16 @@ static int pnv_cause_nmi_ipi(int cpu)
 	int64_t rc;
 
 	if (cpu >= 0) {
-		rc = opal_signal_system_reset(get_hard_smp_processor_id(cpu));
+		int h = get_hard_smp_processor_id(cpu);
+
+		if (opal_check_token(OPAL_QUIESCE))
+			opal_quiesce(QUIESCE_HOLD, h);
+
+		rc = opal_signal_system_reset(h);
+
+		if (opal_check_token(OPAL_QUIESCE))
+			opal_quiesce(QUIESCE_RESUME, h);
+
 		if (rc != OPAL_SUCCESS)
 			return 0;
 		return 1;
@@ -343,6 +352,8 @@ static int pnv_cause_nmi_ipi(int cpu)
 		bool success = true;
 		int c;
 
+		if (opal_check_token(OPAL_QUIESCE))
+			opal_quiesce(QUIESCE_HOLD, -1);
 
 		/*
 		 * We do not use broadcasts (yet), because it's not clear
@@ -358,6 +369,10 @@ static int pnv_cause_nmi_ipi(int cpu)
 			if (rc != OPAL_SUCCESS)
 				success = false;
 		}
+
+		if (opal_check_token(OPAL_QUIESCE))
+			opal_quiesce(QUIESCE_RESUME, -1);
+
 		if (success)
 			return 1;
 
-- 
2.17.0
