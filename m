Return-Path: <anton@samba.org>
Message-Id: <20110725114754.034462876@samba.org>
Date: Mon, 25 Jul 2011 21:46:32 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 paulus@samba.org
Subject: [PATCH 1/3] powerpc/pseries: Fix kexec on recent firmware versions
References: <20110725114631.778346293@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recent versions of firmware will fail to unmap the virtual processor
area if we have a dispatch trace log registered. This causes kexec
to fail.

If a trace log is registered this patch unregisters it before the
SLB shadow and virtual processor areas, fixing the problem.

The address argument is ignored by firmware on unregister so we
may as well remove it.

Signed-off-by: Anton Blanchard <anton@samba.org>
Cc: <stable@kernel.org>
---

Index: linux-powerpc/arch/powerpc/platforms/pseries/kexec.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/platforms/pseries/kexec.c	2011-07-25 21:06:49.510413446 +1000
+++ linux-powerpc/arch/powerpc/platforms/pseries/kexec.c	2011-07-25 21:06:52.340464687 +1000
@@ -26,6 +26,17 @@ static void pseries_kexec_cpu_down(int c
 	/* Don't risk a hypervisor call if we're crashing */
 	if (firmware_has_feature(FW_FEATURE_SPLPAR) && !crash_shutdown) {
 		unsigned long addr;
+		int ret;
+
+		if (get_lppaca()->dtl_enable_mask) {
+			ret = unregister_dtl(hard_smp_processor_id());
+			if (ret) {
+				pr_err("WARNING: DTL deregistration for cpu "
+				       "%d (hw %d) failed with %d\n",
+				       smp_processor_id(),
+				       hard_smp_processor_id(), ret);
+			}
+		}
 
 		addr = __pa(get_slb_shadow());
 		if (unregister_slb_shadow(hard_smp_processor_id(), addr))
Index: linux-powerpc/arch/powerpc/platforms/pseries/dtl.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/platforms/pseries/dtl.c	2011-07-25 21:06:49.520413628 +1000
+++ linux-powerpc/arch/powerpc/platforms/pseries/dtl.c	2011-07-25 21:06:52.340464687 +1000
@@ -181,7 +181,7 @@ static void dtl_stop(struct dtl *dtl)
 
 	lppaca_of(dtl->cpu).dtl_enable_mask = 0x0;
 
-	unregister_dtl(hwcpu, __pa(dtl->buf));
+	unregister_dtl(hwcpu);
 }
 
 static u64 dtl_current_index(struct dtl *dtl)
Index: linux-powerpc/arch/powerpc/platforms/pseries/plpar_wrappers.h
===================================================================
--- linux-powerpc.orig/arch/powerpc/platforms/pseries/plpar_wrappers.h	2011-07-25 21:06:49.500413264 +1000
+++ linux-powerpc/arch/powerpc/platforms/pseries/plpar_wrappers.h	2011-07-25 21:06:52.340464687 +1000
@@ -73,9 +73,9 @@ static inline long register_slb_shadow(u
 	return vpa_call(0x3, cpu, vpa);
 }
 
-static inline long unregister_dtl(unsigned long cpu, unsigned long vpa)
+static inline long unregister_dtl(unsigned long cpu)
 {
-	return vpa_call(0x6, cpu, vpa);
+	return vpa_call(0x6, cpu, 0);
 }
 
 static inline long register_dtl(unsigned long cpu, unsigned long vpa)
