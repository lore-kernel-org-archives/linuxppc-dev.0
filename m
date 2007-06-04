Return-Path: <arnd@arndb.de>
Message-Id: <20070604181739.631548216@arndb.de>
References: <20070604181438.569356702@arndb.de>
Date: Mon, 04 Jun 2007 20:14:41 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [patch 3/3] scc_sio: fix link failure
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, Christoph Hellwig <hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christoph Hellwig <hch@lst.de>
scc_sio.o should only be built if the txx9 serial driver is actually built
into the kernel.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/celleb/Makefile
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/celleb/Makefile
+++ linux-2.6/arch/powerpc/platforms/celleb/Makefile
@@ -4,5 +4,5 @@ obj-y				+= interrupt.o iommu.o setup.o 
 
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_PPC_UDBG_BEAT)	+= udbg_beat.o
-obj-$(CONFIG_HAS_TXX9_SERIAL)	+= scc_sio.o
+obj-$(CONFIG_SERIAL_TXX9)	+= scc_sio.o
 obj-$(CONFIG_SPU_BASE)		+= spu_priv1.o

--
