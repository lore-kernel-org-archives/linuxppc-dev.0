Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 01 Dec 2008 15:53:40 +1100
Subject: [PATCH] powerpc: Fix dma_map_sg() cache flushing on non coherent
	platforms
Message-Id: <20081201045413.1E539DDD0C@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On PowerPC 4xx or other non cache coherent platforms, we lost the
appropriate cache flushing in dma_map_sg() when merging the 32
and 64-bit DMA code.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Oops .. nobody spotted that when Becky patches went in !

Paul: This is a 2.6.28 regression and should be merged asap

 arch/powerpc/kernel/dma.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-work.orig/arch/powerpc/kernel/dma.c	2008-12-01 15:44:55.000000000 +1100
+++ linux-work/arch/powerpc/kernel/dma.c	2008-12-01 15:45:13.000000000 +1100
@@ -75,6 +75,7 @@ static int dma_direct_map_sg(struct devi
 	for_each_sg(sgl, sg, nents, i) {
 		sg->dma_address = sg_phys(sg) + get_dma_direct_offset(dev);
 		sg->dma_length = sg->length;
+		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
 	}
 
 	return nents;
