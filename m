Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3F88DDDDEB
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 17:55:20 +1100 (EST)
Date: Wed, 14 Feb 2007 15:55:14 +0900 (JST)
Message-Id: <200702140655.l1E6tFlp005523@toshiba.co.jp>
Subject: [PATCH] celleb: fix CONFIG_KEXEC dependency
To: paulus@samba.org
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

celleb_kexec_cpu_down() depends on CONFIG_KEXEC.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c
diff -u linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c:1.1.1.1 linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c:1.23
--- linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c:1.1.1.1	Thu Feb  8 11:38:20 2007
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/setup.c	Fri Feb  9 18:31:50 2007
@@ -137,10 +137,12 @@
 	return -ENODEV;
 }
 
+#ifdef CONFIG_KEXEC
 static void celleb_kexec_cpu_down(int crash, int secondary)
 {
 	beatic_deinit_IRQ();
 }
+#endif
 
 static struct of_device_id celleb_bus_ids[] = {
 	{ .type = "scc", },
