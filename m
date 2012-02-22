Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E0E24B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2012 10:50:21 +1100 (EST)
Message-ID: <1329954613.20389.15.camel@pasglop>
Subject: powerpc/mpic: Fix allocation of reverse-map for multi-ISU mpics
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 23 Feb 2012 10:50:13 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When using a multi-ISU MPIC, we can interrupts up to
isu_size * MPIC_MAX_ISU, not just isu_size, so allocate
the right size reverse map.

Without this, the code will constantly fallback to
a linear search.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 4e9ccb1..7fb3ab5 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1346,7 +1346,8 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	mpic->isu_mask = (1 << mpic->isu_shift) - 1;
 
 	mpic->irqhost = irq_alloc_host(mpic->node, IRQ_HOST_MAP_LINEAR,
-				       isu_size ? isu_size : mpic->num_sources,
+				       isu_size ? isu_size *  MPIC_MAX_ISU :
+				       mpic->num_sources,
 				       &mpic_host_ops,
 				       flags & MPIC_LARGE_VECTORS ? 2048 : 256);
 
