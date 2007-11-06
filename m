Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 894C0DDE42
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 09:40:38 +1100 (EST)
Date: Wed, 7 Nov 2007 01:40:41 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <1416528026.20071107014041@emcraft.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] [PPC 44x] enable L2-cache for ALPR, Katmai, Ocotea,
	and Taishan
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sr@denx.de, dzu@denx.de
Reply-To: Yuri Tikhonov <yur@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 This patch introduces the L2_CACHE configuration option available
for the ppc44x-based boards with L2-cache enabled.

Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
Signed-off-by: Pavel Kolesnikov <concord@emcraft.com>

--
diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
index 1d2ca42..ad6b581 100644
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -396,4 +396,12 @@ config SERIAL_SICC_CONSOLE
        bool
        depends on SERIAL_SICC && UART0_TTYS1
        default y
+
+config L2_CACHE
+       bool "Enable Level-2 Cache"
+       depends on NOT_COHERENT_CACHE && (KATMAI || TAISHAN || OCOTEA || ALPR)
+       default y
+       help
+         This option enables L2-cache on ppc44x controllers.
+         If unsure, say Y.
 endmenu
diff --git a/arch/ppc/platforms/4xx/alpr.c b/arch/ppc/platforms/4xx/alpr.c
index 3b6519f..0623801 100644
--- a/arch/ppc/platforms/4xx/alpr.c
+++ b/arch/ppc/platforms/4xx/alpr.c
@@ -537,10 +537,12 @@ static void __init alpr_setup_arch(void)
        printk("Prodrive ALPR port (DENX Software Engineering <sr@denx.de>)\n");
 }
 
+#ifdef CONFIG_L2_CACHE
 static void __init alpr_init(void)
 {
        ibm440gx_l2c_setup(&clocks);
 }
+#endif
 
 static void alpr_progress(char *buf, unsigned short val)
 {
@@ -567,7 +569,9 @@ void __init platform_init(unsigned long r3, unsigned long r4,
 #ifdef CONFIG_KGDB
        ppc_md.early_serial_map = alpr_early_serial_map;
 #endif
+#ifdef CONFIG_L2_CACHE
        ppc_md.init = alpr_init;
+#endif
        ppc_md.restart = alpr_restart;
 }
 
diff --git a/arch/ppc/platforms/4xx/katmai.c b/arch/ppc/platforms/4xx/katmai.c
index d29ebf6..01f1baf 100644
--- a/arch/ppc/platforms/4xx/katmai.c
+++ b/arch/ppc/platforms/4xx/katmai.c
@@ -219,6 +219,7 @@ katmai_show_cpuinfo(struct seq_file *m)
 {
        seq_printf(m, "vendor\t\t: AMCC\n");
        seq_printf(m, "machine\t\t: PPC440SPe EVB (Katmai)\n");
+       ibm440gx_show_cpuinfo(m);
 
        return 0;
 }
@@ -584,6 +585,13 @@ static void katmai_restart(char *cmd)
        mtspr(SPRN_DBCR0, DBCR0_RST_CHIP);
 }
 
+#ifdef CONFIG_L2_CACHE
+static void __init katmai_init(void)
+{
+       ibm440gx_l2c_setup(&clocks);
+}
+#endif
+
 void __init platform_init(unsigned long r3, unsigned long r4,
                          unsigned long r5, unsigned long r6, unsigned long r7)
 {
@@ -599,4 +607,7 @@ void __init platform_init(unsigned long r3, unsigned long r4,
        ppc_md.early_serial_map = katmai_early_serial_map;
 #endif
        ppc_md.restart = katmai_restart;
+#ifdef CONFIG_L2_CACHE
+       ppc_md.init = katmai_init;
+#endif
 }
diff --git a/arch/ppc/platforms/4xx/ocotea.c b/arch/ppc/platforms/4xx/ocotea.c
index a7435aa..8b13811 100644
--- a/arch/ppc/platforms/4xx/ocotea.c
+++ b/arch/ppc/platforms/4xx/ocotea.c
@@ -321,10 +321,12 @@ ocotea_setup_arch(void)
        printk("IBM Ocotea port (MontaVista Software, Inc. <source@mvista.com>)\n");
 }
 
+#ifdef CONFIG_L2_CACHE
 static void __init ocotea_init(void)
 {
        ibm440gx_l2c_setup(&clocks);
 }
+#endif
 
 void __init platform_init(unsigned long r3, unsigned long r4,
                unsigned long r5, unsigned long r6, unsigned long r7)
@@ -345,5 +347,7 @@ void __init platform_init(unsigned long r3, unsigned long r4,
 #ifdef CONFIG_KGDB
        ppc_md.early_serial_map = ocotea_early_serial_map;
 #endif
+#ifdef CONFIG_L2_CACHE
        ppc_md.init = ocotea_init;
+#endif
 }
diff --git a/arch/ppc/platforms/4xx/taishan.c b/arch/ppc/platforms/4xx/taishan.c
index f4b9435..8bb6f15 100644
--- a/arch/ppc/platforms/4xx/taishan.c
+++ b/arch/ppc/platforms/4xx/taishan.c
@@ -370,10 +370,12 @@ taishan_setup_arch(void)
        printk("AMCC PowerPC 440GX Taishan Platform\n");
 }
 
+#ifdef CONFIG_L2_CACHE
 static void __init taishan_init(void)
 {
        ibm440gx_l2c_setup(&clocks);
 }
+#endif
 
 void __init platform_init(unsigned long r3, unsigned long r4,
                unsigned long r5, unsigned long r6, unsigned long r7)
@@ -389,6 +391,8 @@ void __init platform_init(unsigned long r3, unsigned long r4,
 #ifdef CONFIG_KGDB
        ppc_md.early_serial_map = taishan_early_serial_map;
 #endif
+#ifdef CONFIG_L2_CACHE
        ppc_md.init = taishan_init;
+#endif
 }
   
