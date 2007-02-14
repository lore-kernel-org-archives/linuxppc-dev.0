Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DC80ADDDEB
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 17:59:25 +1100 (EST)
Date: Wed, 14 Feb 2007 15:59:15 +0900 (JST)
Message-Id: <200702140659.l1E6xLgj008828@toshiba.co.jp>
Subject: [PATCH] celleb: fix scc_uhc.c dependency
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

scc_uhc.c depends on CONFIG_PCI, not CONFIG_USB. Because CONFIG_PCI
is always "y" on Celleb platform, we move scc_uhc.o to obj-y.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
---

Index: linux-powerpc-git/arch/powerpc/platforms/celleb/Makefile
diff -u linux-powerpc-git/arch/powerpc/platforms/celleb/Makefile:1.1.1.1 linux-powerpc-git/arch/powerpc/platforms/celleb/Makefile:1.12
--- linux-powerpc-git/arch/powerpc/platforms/celleb/Makefile:1.1.1.1	Thu Feb  8 11:38:20 2007
+++ linux-powerpc-git/arch/powerpc/platforms/celleb/Makefile	Fri Feb  9 18:42:06 2007
@@ -1,9 +1,8 @@
 obj-y				+= interrupt.o iommu.o setup.o \
 				   htab.o beat.o pci.o \
-				   scc_epci.o hvCall.o
+				   scc_epci.o scc_uhc.o hvCall.o
 
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_PPC_UDBG_BEAT)	+= udbg_beat.o
-obj-$(CONFIG_USB)		+= scc_uhc.o
 obj-$(CONFIG_HAS_TXX9_SERIAL)	+= scc_sio.o
 obj-$(CONFIG_SPU_BASE)		+= spu_priv1.o
