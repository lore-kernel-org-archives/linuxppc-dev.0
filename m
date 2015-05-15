Return-Path: <apopple@au1.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A8911A048F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 14:07:50 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <apopple@au1.ibm.com>;
 Fri, 15 May 2015 14:07:48 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 13AFA3578053
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 14:07:46 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4F47bRp7143558
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 14:07:46 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4F47Doa021988
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 14:07:13 +1000
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH v4 1/9] powerpc/powernv: Reorder OPAL subsystem initialisation
Date: Fri, 15 May 2015 14:06:36 +1000
Message-Id: <1431662804-16851-2-git-send-email-alistair@popple.id.au>
In-Reply-To: <1431662804-16851-1-git-send-email-alistair@popple.id.au>
References: <1431662804-16851-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>, linux-kernel@vger.kernel.org,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Most of the OPAL subsystems are always compiled in for PowerNV and
many of them need to be initialised before or after other OPAL
subsystems. Rather than trying to control this ordering through
machine initcalls it is clearer and easier to control initialisation
order with explicit calls in opal_init.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
Cc: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h                     |  3 +++
 arch/powerpc/platforms/powernv/opal-async.c         |  3 +--
 arch/powerpc/platforms/powernv/opal-hmi.c           |  3 +--
 arch/powerpc/platforms/powernv/opal-memory-errors.c |  2 +-
 arch/powerpc/platforms/powernv/opal-sensor.c        |  3 +--
 arch/powerpc/platforms/powernv/opal.c               | 13 ++++++++++++-
 6 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 042af1a..518a22e 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -239,6 +239,9 @@ extern int opal_elog_init(void);
 extern void opal_platform_dump_init(void);
 extern void opal_sys_param_init(void);
 extern void opal_msglog_init(void);
+extern int opal_async_comp_init(void);
+extern int opal_sensor_init(void);
+extern int opal_hmi_handler_init(void);
 
 extern int opal_machine_check(struct pt_regs *regs);
 extern bool opal_mce_check_early_recovery(struct pt_regs *regs);
diff --git a/arch/powerpc/platforms/powernv/opal-async.c b/arch/powerpc/platforms/powernv/opal-async.c
index 693b6cd..bdc8c0c 100644
--- a/arch/powerpc/platforms/powernv/opal-async.c
+++ b/arch/powerpc/platforms/powernv/opal-async.c
@@ -151,7 +151,7 @@ static struct notifier_block opal_async_comp_nb = {
 		.priority	= 0,
 };
 
-static int __init opal_async_comp_init(void)
+int __init opal_async_comp_init(void)
 {
 	struct device_node *opal_node;
 	const __be32 *async;
@@ -205,4 +205,3 @@ out_opal_node:
 out:
 	return err;
 }
-machine_subsys_initcall(powernv, opal_async_comp_init);
diff --git a/arch/powerpc/platforms/powernv/opal-hmi.c b/arch/powerpc/platforms/powernv/opal-hmi.c
index b322bfb..a8f49d3 100644
--- a/arch/powerpc/platforms/powernv/opal-hmi.c
+++ b/arch/powerpc/platforms/powernv/opal-hmi.c
@@ -170,7 +170,7 @@ static struct notifier_block opal_hmi_handler_nb = {
 	.priority	= 0,
 };
 
-static int __init opal_hmi_handler_init(void)
+int __init opal_hmi_handler_init(void)
 {
 	int ret;
 
@@ -186,4 +186,3 @@ static int __init opal_hmi_handler_init(void)
 	}
 	return 0;
 }
-machine_subsys_initcall(powernv, opal_hmi_handler_init);
diff --git a/arch/powerpc/platforms/powernv/opal-memory-errors.c b/arch/powerpc/platforms/powernv/opal-memory-errors.c
index 43db213..00a2943 100644
--- a/arch/powerpc/platforms/powernv/opal-memory-errors.c
+++ b/arch/powerpc/platforms/powernv/opal-memory-errors.c
@@ -144,4 +144,4 @@ static int __init opal_mem_err_init(void)
 	}
 	return 0;
 }
-machine_subsys_initcall(powernv, opal_mem_err_init);
+machine_device_initcall(powernv, opal_mem_err_init);
diff --git a/arch/powerpc/platforms/powernv/opal-sensor.c b/arch/powerpc/platforms/powernv/opal-sensor.c
index 6552504..a06059d 100644
--- a/arch/powerpc/platforms/powernv/opal-sensor.c
+++ b/arch/powerpc/platforms/powernv/opal-sensor.c
@@ -77,7 +77,7 @@ out:
 }
 EXPORT_SYMBOL_GPL(opal_get_sensor_data);
 
-static __init int opal_sensor_init(void)
+int __init opal_sensor_init(void)
 {
 	struct platform_device *pdev;
 	struct device_node *sensor;
@@ -93,4 +93,3 @@ static __init int opal_sensor_init(void)
 
 	return PTR_ERR_OR_ZERO(pdev);
 }
-machine_subsys_initcall(powernv, opal_sensor_init);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 2241565..eb3decc 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -393,7 +393,6 @@ static int __init opal_message_init(void)
 	}
 	return 0;
 }
-machine_early_initcall(powernv, opal_message_init);
 
 int opal_get_chars(uint32_t vtermno, char *buf, int count)
 {
@@ -807,6 +806,18 @@ static int __init opal_init(void)
 		of_node_put(consoles);
 	}
 
+	/* Initialise OPAL messaging system */
+	opal_message_init();
+
+	/* Initialise OPAL asynchronous completion interface */
+	opal_async_comp_init();
+
+	/* Initialise OPAL sensor interface */
+	opal_sensor_init();
+
+	/* Initialise OPAL hypervisor maintainence interrupt handling */
+	opal_hmi_handler_init();
+
 	/* Create i2c platform devices */
 	opal_i2c_create_devs();
 
-- 
1.8.3.2
