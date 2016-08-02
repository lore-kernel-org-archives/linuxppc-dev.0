Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3Sy020N0zDrKT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 17:48:56 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id ez1so11418505pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Aug 2016 00:48:56 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: sjitindarsingh@gmail.com
Subject: [RFC] [PATCH 2/3] powernv/setup: Initialise opal_oppanel and display
 information on boot
Date: Tue,  2 Aug 2016 17:48:36 +1000
Message-Id: <1470124117-24419-2-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1470124117-24419-1-git-send-email-sjitindarsingh@gmail.com>
References: <1470124117-24419-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have the ability to access the operator panel display from
within the kernel print out some platform information on boot.

Update the opal initialisation function to call the init function for the
new oppanel interface, this also removes the need to explicitly create the
platform device as this is now handled in the oppanel init function.

Now that we are able to access the operator panel display from the kernel
update the powernv platform progress function to write to the display.
Add a function to print some platform information to the display on
boot.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c  |  8 +++++---
 arch/powerpc/platforms/powernv/setup.c | 27 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 228751a..62ea5e5 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -705,6 +705,11 @@ static int __init opal_init(void)
 	/* Initialise OPAL asynchronous completion interface */
 	opal_async_comp_init();
 
+#if defined(CONFIG_POWERNV_OP_PANEL) || defined(CONFIG_POWERNV_OP_PANEL_MODULE)
+	/* Initialise OPAL oppanel interface */
+	opal_oppanel_init();
+#endif /* CONFIG_POWERNV_OP_PANEL */
+
 	/* Initialise OPAL sensor interface */
 	opal_sensor_init();
 
@@ -751,9 +756,6 @@ static int __init opal_init(void)
 	opal_pdev_init(opal_node, "ibm,opal-flash");
 	opal_pdev_init(opal_node, "ibm,opal-prd");
 
-	/* Initialise platform device: oppanel interface */
-	opal_pdev_init(opal_node, "ibm,opal-oppanel");
-
 	/* Initialise OPAL kmsg dumper for flushing console on panic */
 	opal_kmsg_init();
 
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index ee6430b..0f0e557 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -27,6 +27,7 @@
 #include <linux/interrupt.h>
 #include <linux/bug.h>
 #include <linux/pci.h>
+#include <linux/utsname.h>
 #include <linux/cpufreq.h>
 
 #include <asm/machdep.h>
@@ -58,6 +59,29 @@ static void __init pnv_setup_arch(void)
 	/* XXX PMCS */
 }
 
+static int __init pnv_late_init(void)
+{
+#if defined(CONFIG_POWERNV_OP_PANEL) || defined(CONFIG_POWERNV_OP_PANEL_MODULE)
+	char msg[17] = {'\0'};
+#endif /* CONFIG_POWERNV_OP_PANEL */
+	/* Manually leave the kernel version on the panel */
+#ifdef __BIG_ENDIAN__
+	ppc_md.progress("Linux ppc64\n", 0);
+#else
+	ppc_md.progress("Linux ppc64le\n", 0);
+#endif
+#if defined(CONFIG_POWERNV_OP_PANEL) || defined(CONFIG_POWERNV_OP_PANEL_MODULE)
+	/* Limit what we print to 16 chars so the previous line remains */
+	memcpy(msg, init_utsname()->release, 16);
+	ppc_md.progress(msg, 0);
+#else
+	ppc_md.progress(init_utsname()->release, 0);
+#endif /* CONFIG_POWERNV_OP_PANEL */
+
+	return 0;
+}
+machine_late_initcall(powernv, pnv_late_init);
+
 static void __init pnv_init_early(void)
 {
 	/*
@@ -159,6 +183,9 @@ static void __noreturn pnv_halt(void)
 
 static void pnv_progress(char *s, unsigned short hex)
 {
+#if defined(CONFIG_POWERNV_OP_PANEL) || defined(CONFIG_POWERNV_OP_PANEL_MODULE)
+	opal_oppanel_write(s);
+#endif /* CONFIG_POWERNV_OP_PANEL */
 }
 
 static void pnv_shutdown(void)
-- 
2.5.5
