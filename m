Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 550D767A63
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Jan 2005 17:34:42 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 17 Jan 2005 17:34:25 +1100
Message-Id: <1105943665.4534.4.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] ppc32: Fix pmac kernel build with oprofile
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

The recent oprofile changes for Motorola e500 broke oprofile for other
CPUs. This patch fixes the build.

Proper support for the G3/G4 PMCs would be interesting, and making sure the basic
interrupt PC sampling still works on CPUs that don't have supported PMCs too...

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc/oprofile/Makefile
===================================================================
--- linux-work.orig/arch/ppc/oprofile/Makefile	2005-01-17 14:07:24.000000000 +1100
+++ linux-work/arch/ppc/oprofile/Makefile	2005-01-17 14:08:51.000000000 +1100
@@ -6,4 +6,9 @@
 		oprofilefs.o oprofile_stats.o \
 		timer_int.o )
 
-oprofile-y := $(DRIVER_OBJS) common.o op_model_fsl_booke.o
+oprofile-y := $(DRIVER_OBJS) common.o
+
+ifeq ($(CONFIG_FSL_BOOKE),y)
+	oprofile-y += op_model_fsl_booke.o
+endif
+
Index: linux-work/arch/ppc/oprofile/common.c
===================================================================
--- linux-work.orig/arch/ppc/oprofile/common.c	2005-01-14 12:01:04.000000000 +1100
+++ linux-work/arch/ppc/oprofile/common.c	2005-01-17 14:30:14.000000000 +1100
@@ -124,7 +124,7 @@
 	.cpu_type	= NULL		/* To be filled in below. */
 };
 
-int __init oprofile_arch_init(struct oprofile_operations **ops)
+void __init oprofile_arch_init(struct oprofile_operations *ops)
 {
 	char *name;
 	int cpu_id = smp_processor_id();
@@ -133,13 +133,13 @@
 	model = &op_model_fsl_booke;
 #else
 	printk(KERN_ERR "oprofile enabled on unsupported processor!\n");
-	return -ENODEV;
+	return;
 #endif
 
 	name = kmalloc(32, GFP_KERNEL);
 
 	if (NULL == name)
-		return -ENOMEM;
+		return;
 
 	sprintf(name, "ppc/%s", cur_cpu_spec[cpu_id]->cpu_name);
 
@@ -147,12 +147,10 @@
 
 	model->num_counters = cur_cpu_spec[cpu_id]->num_pmcs;
 
-	*ops = &oprof_ppc32_ops;
+	*ops = oprof_ppc32_ops;
 
 	printk(KERN_INFO "oprofile: using %s performance monitoring.\n",
 	       oprof_ppc32_ops.cpu_type);
-
-	return 0;
 }
 
 void oprofile_arch_exit(void)
