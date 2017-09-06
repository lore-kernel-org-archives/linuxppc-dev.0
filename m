Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xn62N2prNzDqNY
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 11:49:16 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Cc: fbarrat@linux.vnet.ibm.com, arbab@linux.vnet.ibm.com, mpe@ellerman.id.au,
 andrew.donnellan@au1.ibm.com, Alistair Popple <alistair@popple.id.au>
Subject: [PATCH v2 1/2] powerpc/npu: Use flush_all_mm() instead of
 flush_tlb_mm()
Date: Wed,  6 Sep 2017 11:48:59 +1000
Message-Id: <1504662540-27527-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With the optimisations introduced by commit a46cc7a908 ("powerpc/mm/radix:
Improve TLB/PWC flushes"), flush_tlb_mm() no longer flushes the page walk
cache with radix. Switch to using flush_all_mm() to ensure the pwc and tlb
are properly flushed on the nmmu.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/platforms/powernv/npu-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 2cb6cbe..2fff9a65 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -549,7 +549,7 @@ static void mmio_invalidate(struct npu_context *npu_context, int va,
 	 * Unfortunately the nest mmu does not support flushing specific
 	 * addresses so we have to flush the whole mm.
 	 */
-	flush_tlb_mm(npu_context->mm);
+	flush_all_mm(npu_context->mm);
 
 	/*
 	 * Loop over all the NPUs this process is active on and launch
-- 
2.1.4
