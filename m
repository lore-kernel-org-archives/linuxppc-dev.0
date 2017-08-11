Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTFM023bFzDr38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 16:23:40 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: mpe@ellerman.id.au
Cc: arbab@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org, sbaskaran@nvidia.com,
 fbarrat@linux.vnet.ibm.com, Alistair Popple <alistair@popple.id.au>,
 stable@vger.kernel.org
Subject: [PATCH 1/2] powerpc/powernv/npu: Move tlb flush before launching ATSD
Date: Fri, 11 Aug 2017 16:22:56 +1000
Message-Id: <1502432577-5911-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The nest mmu tlb flush needs to happen before the GPU translation shootdown
is launched to avoid the GPU refilling its tlb with stale nmmu translations
prior to the nmmu flush completing.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
Cc: stable@vger.kernel.org
---
 arch/powerpc/platforms/powernv/npu-dma.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index b5d960d..3d4f879 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -546,6 +546,12 @@ static void mmio_invalidate(struct npu_context *npu_context, int va,
 	unsigned long pid = npu_context->mm->context.id;
 
 	/*
+	 * Unfortunately the nest mmu does not support flushing specific
+	 * addresses so we have to flush the whole mm.
+	 */
+	flush_tlb_mm(npu_context->mm);
+
+	/*
 	 * Loop over all the NPUs this process is active on and launch
 	 * an invalidate.
 	 */
@@ -576,12 +582,6 @@ static void mmio_invalidate(struct npu_context *npu_context, int va,
 		}
 	}
 
-	/*
-	 * Unfortunately the nest mmu does not support flushing specific
-	 * addresses so we have to flush the whole mm.
-	 */
-	flush_tlb_mm(npu_context->mm);
-
 	mmio_invalidate_wait(mmio_atsd_reg, flush);
 	if (flush)
 		/* Wait for the flush to complete */
-- 
2.1.4
