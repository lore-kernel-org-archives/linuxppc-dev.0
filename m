Return-Path: <anton@samba.org>
Message-Id: <20110725114754.127913137@samba.org>
Date: Mon, 25 Jul 2011 21:46:33 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 paulus@samba.org
Subject: [PATCH 2/3] powerpc/pseries: Cleanup VPA registration and
	deregistration errors
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

Make the VPA, SLB shadow and DTL registration and deregistration
functions print consistent messages on error. I needed the firmware
error code while chasing a kexec bug but we weren't printing it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/platforms/pseries/kexec.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/platforms/pseries/kexec.c	2011-07-25 21:06:52.340464687 +1000
+++ linux-powerpc/arch/powerpc/platforms/pseries/kexec.c	2011-07-25 21:06:56.260535670 +1000
@@ -39,17 +39,20 @@ static void pseries_kexec_cpu_down(int c
 		}
 
 		addr = __pa(get_slb_shadow());
-		if (unregister_slb_shadow(hard_smp_processor_id(), addr))
-			printk("SLB shadow buffer deregistration of "
-			       "cpu %u (hw_cpu_id %d) failed\n",
+		ret = unregister_slb_shadow(hard_smp_processor_id(), addr);
+		if (ret) {
+			pr_err("WARNING: SLB shadow buffer deregistration "
+			       "for cpu %d (hw %d) failed with %d\n",
 			       smp_processor_id(),
-			       hard_smp_processor_id());
+			       hard_smp_processor_id(), ret);
+		}
 
 		addr = __pa(get_lppaca());
-		if (unregister_vpa(hard_smp_processor_id(), addr)) {
-			printk("VPA deregistration of cpu %u (hw_cpu_id %d) "
-					"failed\n", smp_processor_id(),
-					hard_smp_processor_id());
+		ret = unregister_vpa(hard_smp_processor_id(), addr);
+		if (ret) {
+			pr_err("WARNING: VPA deregistration for cpu %d "
+			       "(hw %d) failed with %d\n", smp_processor_id(),
+			       hard_smp_processor_id(), ret);
 		}
 	}
 }
Index: linux-powerpc/arch/powerpc/platforms/pseries/lpar.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/platforms/pseries/lpar.c	2011-07-25 21:06:49.440412178 +1000
+++ linux-powerpc/arch/powerpc/platforms/pseries/lpar.c	2011-07-25 21:06:56.260535670 +1000
@@ -67,9 +67,8 @@ void vpa_init(int cpu)
 	ret = register_vpa(hwcpu, addr);
 
 	if (ret) {
-		printk(KERN_ERR "WARNING: vpa_init: VPA registration for "
-				"cpu %d (hw %d) of area %lx returns %ld\n",
-				cpu, hwcpu, addr, ret);
+		pr_err("WARNING: VPA registration for cpu %d (hw %d) of area "
+		       "%lx failed with %ld\n", cpu, hwcpu, addr, ret);
 		return;
 	}
 	/*
@@ -80,10 +79,9 @@ void vpa_init(int cpu)
 	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
 		ret = register_slb_shadow(hwcpu, addr);
 		if (ret)
-			printk(KERN_ERR
-			       "WARNING: vpa_init: SLB shadow buffer "
-			       "registration for cpu %d (hw %d) of area %lx "
-			       "returns %ld\n", cpu, hwcpu, addr, ret);
+			pr_err("WARNING: SLB shadow buffer registration for "
+			       "cpu %d (hw %d) of area %lx failed with %ld\n",
+			       cpu, hwcpu, addr, ret);
 	}
 
 	/*
@@ -100,8 +98,9 @@ void vpa_init(int cpu)
 		dtl->enqueue_to_dispatch_time = DISPATCH_LOG_BYTES;
 		ret = register_dtl(hwcpu, __pa(dtl));
 		if (ret)
-			pr_warn("DTL registration failed for cpu %d (%ld)\n",
-				cpu, ret);
+			pr_err("WARNING: DTL registration of cpu %d (hw %d) "
+			       "failed with %ld\n", smp_processor_id(),
+			       hwcpu, ret);
 		lppaca_of(cpu).dtl_enable_mask = 2;
 	}
 }
Index: linux-powerpc/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/platforms/pseries/setup.c	2011-07-25 21:06:49.450412359 +1000
+++ linux-powerpc/arch/powerpc/platforms/pseries/setup.c	2011-07-25 21:06:56.260535670 +1000
@@ -324,8 +324,9 @@ static int alloc_dispatch_logs(void)
 	dtl->enqueue_to_dispatch_time = DISPATCH_LOG_BYTES;
 	ret = register_dtl(hard_smp_processor_id(), __pa(dtl));
 	if (ret)
-		pr_warn("DTL registration failed for boot cpu %d (%d)\n",
-			smp_processor_id(), ret);
+		pr_err("WARNING: DTL registration of cpu %d (hw %d) failed "
+		       "with %d\n", smp_processor_id(),
+		       hard_smp_processor_id(), ret);
 	get_paca()->lppaca_ptr->dtl_enable_mask = 2;
 
 	return 0;
