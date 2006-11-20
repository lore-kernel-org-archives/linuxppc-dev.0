Return-Path: <arnd@arndb.de>
Message-Id: <20061120180523.464008000@arndb.de>
References: <20061120174454.067872000@arndb.de>
Date: Mon, 20 Nov 2006 18:45:03 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: [PATCH 09/22] spufs: return correct event for data storage interrupt
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When we attempt an MFC DMA to an unmapped address, the event
returned from spu_run should be SPE_EVENT_SPE_DATA_STORAGE,
not SPE_EVENT_INVALID_DMA.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
Index: linux-2.6/arch/powerpc/platforms/cell/spufs/run.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/run.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/run.c
@@ -26,6 +26,7 @@ void spufs_dma_callback(struct spu *spu,
 	} else {
 		switch (type) {
 		case SPE_EVENT_DMA_ALIGNMENT:
+		case SPE_EVENT_SPE_DATA_STORAGE:
 		case SPE_EVENT_INVALID_DMA:
 			force_sig(SIGBUS, /* info, */ current);
 			break;
Index: linux-2.6/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6/arch/powerpc/platforms/cell/spu_base.c
@@ -507,7 +507,7 @@ int spu_irq_class_1_bottom(struct spu *s
 	if (!error) {
 		spu_restart_dma(spu);
 	} else {
-		__spu_trap_invalid_dma(spu);
+		spu->dma_callback(spu, SPE_EVENT_SPE_DATA_STORAGE);
 	}
 	return ret;
 }

--
