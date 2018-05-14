Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40l0tC37G3zF2Ct
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2018 22:50:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: alistair@popple.id.au,
	paulus@samba.org
Subject: [PATCH 3/3] powerpc/powernv: Use __raw_[rm_]writeq_be() in npu-dma.c
Date: Mon, 14 May 2018 22:50:33 +1000
Message-Id: <20180514125033.12000-3-mpe@ellerman.id.au>
In-Reply-To: <20180514125033.12000-1-mpe@ellerman.id.au>
References: <20180514125033.12000-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This allows us to squash some sparse warnings and also avoids having
to do explicity endian conversions in the code.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/npu-dma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 525e966dce34..8cdf91f5d3a4 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -459,10 +459,9 @@ static void mmio_launch_invalidate(struct mmio_atsd_reg *mmio_atsd_reg,
 	struct npu *npu = mmio_atsd_reg->npu;
 	int reg = mmio_atsd_reg->reg;
 
-	__raw_writeq(cpu_to_be64(va),
-		npu->mmio_atsd_regs[reg] + XTS_ATSD_AVA);
+	__raw_writeq_be(va, npu->mmio_atsd_regs[reg] + XTS_ATSD_AVA);
 	eieio();
-	__raw_writeq(cpu_to_be64(launch), npu->mmio_atsd_regs[reg]);
+	__raw_writeq_be(launch, npu->mmio_atsd_regs[reg]);
 }
 
 static void mmio_invalidate_pid(struct mmio_atsd_reg mmio_atsd_reg[NV_MAX_NPUS],
-- 
2.14.1
