Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7A5067C27
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 20:25:43 +1100 (EST)
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id kAF9PdAZ017874
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 18:25:39 +0900 (JST)
Received: (from root@localhost) by wall11.toshiba.co.jp  id kAF9Pdc3023481
	for linuxppc-dev@ozlabs.org; Wed, 15 Nov 2006 18:25:39 +0900 (JST)
Received: from mx.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id kAF9PcSp000279
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 18:25:38 +0900 (JST)
Date: Wed, 15 Nov 2006 18:25:33 +0900 (JST)
Message-Id: <200611150925.kAF9PYiO018978@toshiba.co.jp>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/16] Cell closs-building
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for cross-building by SCE toolchain.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-2.6.19/arch/powerpc/Makefile
diff -u linux-2.6.19/arch/powerpc/Makefile:1.1.1.1 linux-2.6.19/arch/powerpc/Makefile:1.2
--- linux-2.6.19/arch/powerpc/Makefile:1.1.1.1	Fri Oct  6 10:40:02 2006
+++ linux-2.6.19/arch/powerpc/Makefile	Fri Oct  6 12:26:35 2006
@@ -110,6 +110,7 @@
 CFLAGS		+= -mcpu=powerpc
 endif
 
+cpu-as-$(CONFIG_PPC_CELL)	+= -Wa,-mcellppu
 cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_6xx)		+= -Wa,-maltivec
 cpu-as-$(CONFIG_POWER4)		+= -Wa,-maltivec
