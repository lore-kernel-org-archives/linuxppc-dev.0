Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 13AEBDDDF4
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 19:35:02 +1100 (EST)
Date: Tue, 04 Dec 2007 17:34:53 +0900 (JST)
Message-Id: <20071204.173453.-1300514021.kouish@swc.toshiba.co.jp>
To: paulus@samba.org
Subject: [PATCH 1/3] cell: fix undefined reference to mmio_nvram_init
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

This patch fixes the following link error with
CONFIG_PPC_CELL_NATIVE=y and CONFIG_PPC_CELL_BLADE=n:

arch/powerpc/platforms/built-in.o: In function `.cell_setup_arch':
setup.c:(.init.text+0xe80): undefined reference to `.mmio_nvram_init'

Signed-off-by: Kou Ishizaki <Kou.Ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/platforms/cell/setup.c
===================================================================
--- linux-powerpc-git.orig/arch/powerpc/platforms/cell/setup.c
+++ linux-powerpc-git/arch/powerpc/platforms/cell/setup.c
@@ -179,7 +179,9 @@ static void __init cell_setup_arch(void)
 	conswitchp = &dummy_con;
 #endif
 
+#ifdef CONFIG_MMIO_NVRAM
 	mmio_nvram_init();
+#endif
 }
 
 static int __init cell_probe(void)
