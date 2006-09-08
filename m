Return-Path: <olaf@ibook.aepfle.de>
Received: from natlemon.rzone.de (natlemon.rzone.de [81.169.145.170])
	by ozlabs.org (Postfix) with ESMTP id AE94467A3A
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Sep 2006 07:27:18 +1000 (EST)
Received: from ibook.aepfle.de (p5493D69B.dip.t-dialin.net [84.147.214.155])
	by post.webmailer.de (8.13.6/8.13.6) with ESMTP id k88LR9Td026041
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Sep 2006 23:27:09 +0200 (MEST)
Date: Fri, 8 Sep 2006 23:27:09 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org
Subject: ADB keyboard not working in xmon
Message-ID: <20060908212709.GA4027@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


What is the best way to let do_initcalls wait until the adb probing task
has finished when xmon is enabled and system console is not on serial?
The patch below leads to a dead keyboard without the delay,
or without adb_sync as cmdline option and CONFIG_XMON_DEFAULT=n.


Index: linux-2.6/init/main.c
===================================================================
--- linux-2.6.orig/init/main.c
+++ linux-2.6/init/main.c
@@ -662,6 +662,8 @@ static void __init do_basic_setup(void)
 #endif
 
        do_initcalls();
+//     msleep(10 * 1000);
+       asm(".long 0x0\n");
 }
 
 static void do_pre_smp_initcalls(void)
Index: linux-2.6/arch/powerpc/platforms/powermac/udbg_adb.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/udbg_adb.c
+++ linux-2.6/arch/powerpc/platforms/powermac/udbg_adb.c
@@ -216,5 +216,11 @@ int udbg_adb_init(int force_btext)
        if (input_type == input_adb_none)
                return -ENODEV;
 
+#ifdef CONFIG_XMON_DEFAULT
+       {
+               extern int __adb_probe_sync;
+               __adb_probe_sync = 1;
+       }
+#endif
        return 0;
 }
