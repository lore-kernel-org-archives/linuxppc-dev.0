Return-Path: <anton@samba.org>
Message-Id: <20110725114754.228268270@samba.org>
Date: Mon, 25 Jul 2011 21:46:34 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 paulus@samba.org
Subject: [PATCH 3/3] powerpc/pseries: Simplify vpa deregistration functions
References: <20110725114631.778346293@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The VPA, SLB shadow and DTL degistration functions do not need an
address, so simplify things and remove it.

Also cleanup pseries_kexec_cpu_down a bit by storing the cpu IDs
in local variables.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/platforms/pseries/hotplug-cpu.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/platforms/pseries/hotplug-cpu.c	2011-07-25 21:06:49.390411273 +1000
+++ linux-powerpc/arch/powerpc/platforms/pseries/hotplug-cpu.c	2011-07-25 21:06:57.380555950 +1000
@@ -135,7 +135,7 @@ static void pseries_mach_cpu_die(void)
 		get_lppaca()->idle = 0;
 
 		if (get_preferred_offline_state(cpu) == CPU_STATE_ONLINE) {
-			unregister_slb_shadow(hwcpu, __pa(get_slb_shadow()));
+			unregister_slb_shadow(hwcpu);
 
 			/*
 			 * Call to start_secondary_resume() will not return.
@@ -150,7 +150,7 @@ static void pseries_mach_cpu_die(void)
 	WARN_ON(get_preferred_offline_state(cpu) != CPU_STATE_OFFLINE);
 
 	set_cpu_current_state(cpu, CPU_STATE_OFFLINE);
-	unregister_slb_shadow(hwcpu, __pa(get_slb_shadow()));
+	unregister_slb_shadow(hwcpu);
 	rtas_stop_self();
 
 	/* Should never get here... */
Index: linux-powerpc/arch/powerpc/platforms/pseries/kexec.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/platforms/pseries/kexec.c	2011-07-25 21:06:56.260535670 +1000
+++ linux-powerpc/arch/powerpc/platforms/pseries/kexec.c	2011-07-25 21:09:20.033141478 +1000
@@ -25,34 +25,30 @@ static void pseries_kexec_cpu_down(int c
 {
 	/* Don't risk a hypervisor call if we're crashing */
 	if (firmware_has_feature(FW_FEATURE_SPLPAR) && !crash_shutdown) {
-		unsigned long addr;
 		int ret;
+		int cpu = smp_processor_id();
+		int hwcpu = hard_smp_processor_id();
 
 		if (get_lppaca()->dtl_enable_mask) {
-			ret = unregister_dtl(hard_smp_processor_id());
+			ret = unregister_dtl(hwcpu);
 			if (ret) {
 				pr_err("WARNING: DTL deregistration for cpu "
 				       "%d (hw %d) failed with %d\n",
-				       smp_processor_id(),
-				       hard_smp_processor_id(), ret);
+				       cpu, hwcpu, ret);
 			}
 		}
 
-		addr = __pa(get_slb_shadow());
-		ret = unregister_slb_shadow(hard_smp_processor_id(), addr);
+		ret = unregister_slb_shadow(hwcpu);
 		if (ret) {
 			pr_err("WARNING: SLB shadow buffer deregistration "
 			       "for cpu %d (hw %d) failed with %d\n",
-			       smp_processor_id(),
-			       hard_smp_processor_id(), ret);
+			       cpu, hwcpu, ret);
 		}
 
-		addr = __pa(get_lppaca());
-		ret = unregister_vpa(hard_smp_processor_id(), addr);
+		ret = unregister_vpa(hwcpu);
 		if (ret) {
 			pr_err("WARNING: VPA deregistration for cpu %d "
-			       "(hw %d) failed with %d\n", smp_processor_id(),
-			       hard_smp_processor_id(), ret);
+			       "(hw %d) failed with %d\n", cpu, hwcpu, ret);
 		}
 	}
 }
Index: linux-powerpc/arch/powerpc/platforms/pseries/plpar_wrappers.h
===================================================================
--- linux-powerpc.orig/arch/powerpc/platforms/pseries/plpar_wrappers.h	2011-07-25 21:06:52.340464687 +1000
+++ linux-powerpc/arch/powerpc/platforms/pseries/plpar_wrappers.h	2011-07-25 21:06:57.380555950 +1000
@@ -53,9 +53,9 @@ static inline long vpa_call(unsigned lon
 	return plpar_hcall_norets(H_REGISTER_VPA, flags, cpu, vpa);
 }
 
-static inline long unregister_vpa(unsigned long cpu, unsigned long vpa)
+static inline long unregister_vpa(unsigned long cpu)
 {
-	return vpa_call(0x5, cpu, vpa);
+	return vpa_call(0x5, cpu, 0);
 }
 
 static inline long register_vpa(unsigned long cpu, unsigned long vpa)
@@ -63,9 +63,9 @@ static inline long register_vpa(unsigned
 	return vpa_call(0x1, cpu, vpa);
 }
 
-static inline long unregister_slb_shadow(unsigned long cpu, unsigned long vpa)
+static inline long unregister_slb_shadow(unsigned long cpu)
 {
-	return vpa_call(0x7, cpu, vpa);
+	return vpa_call(0x7, cpu, 0);
 }
 
 static inline long register_slb_shadow(unsigned long cpu, unsigned long vpa)
