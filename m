Return-Path: <anton@ozlabs.org>
Date: Tue, 28 Mar 2006 14:08:39 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix some initcall return values
Message-ID: <20060328030839.GC23416@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Non zero initcalls (except for -ENODEV) have started warning at boot.
Fix smt_setup and init_ras_IRQ.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/arch/powerpc/kernel/sysfs.c
===================================================================
--- build.orig/arch/powerpc/kernel/sysfs.c	2005-11-12 14:48:05.000000000 +1100
+++ build/arch/powerpc/kernel/sysfs.c	2006-03-27 16:23:59.000000000 +1100
@@ -65,11 +65,11 @@ static int __init smt_setup(void)
 	unsigned int cpu;
 
 	if (!cpu_has_feature(CPU_FTR_SMT))
-		return 1;
+		return -ENODEV;
 
 	options = find_path_device("/options");
 	if (!options)
-		return 1;
+		return -ENODEV;
 
 	val = (unsigned int *)get_property(options, "ibm,smt-snooze-delay",
 					   NULL);
@@ -78,7 +78,7 @@ static int __init smt_setup(void)
 			per_cpu(smt_snooze_delay, cpu) = *val;
 	}
 
-	return 1;
+	return 0;
 }
 __initcall(smt_setup);
 
Index: build/arch/powerpc/platforms/pseries/ras.c
===================================================================
--- build.orig/arch/powerpc/platforms/pseries/ras.c	2006-01-10 13:53:24.000000000 +1100
+++ build/arch/powerpc/platforms/pseries/ras.c	2006-03-27 16:24:38.000000000 +1100
@@ -132,7 +132,7 @@ static int __init init_ras_IRQ(void)
 		of_node_put(np);
 	}
 
-	return 1;
+	return 0;
 }
 __initcall(init_ras_IRQ);
 
