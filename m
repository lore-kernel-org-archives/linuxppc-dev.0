Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zMlL90vGpzF0lJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 00:34:25 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org
Cc: greg@kroah.com,
	linuxppc-dev@ozlabs.org
Subject: [PATCH v4.14 backport 01/10] powerpc/pseries: Add
 H_GET_CPU_CHARACTERISTICS flags & wrapper
Date: Fri, 19 Jan 2018 00:34:01 +1100
Message-Id: <20180118133410.18716-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Neuling <mikey@neuling.org>

commit 191eccb1580939fb0d47deb405b82a85b0379070 upstream.

A new hypervisor call has been defined to communicate various
characteristics of the CPU to guests. Add definitions for the hcall
number, flags and a wrapper function.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/hvcall.h         | 17 +++++++++++++++++
 arch/powerpc/include/asm/plpar_wrappers.h | 14 ++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index a409177be8bd..f0461618bf7b 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -241,6 +241,7 @@
 #define H_GET_HCA_INFO          0x1B8
 #define H_GET_PERF_COUNT        0x1BC
 #define H_MANAGE_TRACE          0x1C0
+#define H_GET_CPU_CHARACTERISTICS 0x1C8
 #define H_FREE_LOGICAL_LAN_BUFFER 0x1D4
 #define H_QUERY_INT_STATE       0x1E4
 #define H_POLL_PENDING		0x1D8
@@ -330,6 +331,17 @@
 #define H_SIGNAL_SYS_RESET_ALL_OTHERS		-2
 /* >= 0 values are CPU number */
 
+/* H_GET_CPU_CHARACTERISTICS return values */
+#define H_CPU_CHAR_SPEC_BAR_ORI31	(1ull << 63) // IBM bit 0
+#define H_CPU_CHAR_BCCTRL_SERIALISED	(1ull << 62) // IBM bit 1
+#define H_CPU_CHAR_L1D_FLUSH_ORI30	(1ull << 61) // IBM bit 2
+#define H_CPU_CHAR_L1D_FLUSH_TRIG2	(1ull << 60) // IBM bit 3
+#define H_CPU_CHAR_L1D_THREAD_PRIV	(1ull << 59) // IBM bit 4
+
+#define H_CPU_BEHAV_FAVOUR_SECURITY	(1ull << 63) // IBM bit 0
+#define H_CPU_BEHAV_L1D_FLUSH_PR	(1ull << 62) // IBM bit 1
+#define H_CPU_BEHAV_BNDS_CHK_SPEC_BAR	(1ull << 61) // IBM bit 2
+
 /* Flag values used in H_REGISTER_PROC_TBL hcall */
 #define PROC_TABLE_OP_MASK	0x18
 #define PROC_TABLE_DEREG	0x10
@@ -436,6 +448,11 @@ static inline unsigned int get_longbusy_msecs(int longbusy_rc)
 	}
 }
 
+struct h_cpu_char_result {
+	u64 character;
+	u64 behaviour;
+};
+
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_HVCALL_H */
diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index 7f01b22fa6cb..55eddf50d149 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -326,4 +326,18 @@ static inline long plapr_signal_sys_reset(long cpu)
 	return plpar_hcall_norets(H_SIGNAL_SYS_RESET, cpu);
 }
 
+static inline long plpar_get_cpu_characteristics(struct h_cpu_char_result *p)
+{
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+	long rc;
+
+	rc = plpar_hcall(H_GET_CPU_CHARACTERISTICS, retbuf);
+	if (rc == H_SUCCESS) {
+		p->character = retbuf[0];
+		p->behaviour = retbuf[1];
+	}
+
+	return rc;
+}
+
 #endif /* _ASM_POWERPC_PLPAR_WRAPPERS_H */
-- 
2.14.3
