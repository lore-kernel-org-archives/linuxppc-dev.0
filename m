Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 92CAADDEF4
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 20:01:01 +1000 (EST)
Date: Thu, 26 Jul 2007 19:00:56 +0900 (JST)
Message-Id: <20070726.190056.-432813248.kouish@swc.toshiba.co.jp>
Subject: [PATCH 2/4] fix celleb sio section warning
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

Fix following warning:
WARNING: vmlinux.o(.text+0x45fd4): Section mismatch: reference to .init.text:.early_serial_txx9_setup (between '.txx9_serial_init' and '.txx9_serial_config')

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/platforms/celleb/scc_sio.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/celleb/scc_sio.c
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/scc_sio.c
@@ -39,7 +39,7 @@ static struct {
 	{ 0x800, 1 }	/* 0xFF2800 */
 };
 
-static int txx9_serial_init(void)
+static int __init txx9_serial_init(void)
 {
 	extern int early_serial_txx9_setup(struct uart_port *port);
 	struct device_node *node;
