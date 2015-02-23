Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B6EC31A0C04
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 15:21:27 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: stable@vger.kernel.org
Subject: [PATCH 3/3] cxl: Add missing return statement after handling AFU
 errror
Date: Mon, 23 Feb 2015 15:21:21 +1100
Message-Id: <1424665281-25431-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1424665281-25431-1-git-send-email-mpe@ellerman.id.au>
References: <1424665281-25431-1-git-send-email-mpe@ellerman.id.au>
Cc: grimm@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org, imunsie@au.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

Commit a6130ed253a931d2169c26ab0958d81b0dce4d6e upstream.

We were missing a return statement in the PSL interrupt handler in the
case of an AFU error, which would trigger an "Unhandled CXL PSL IRQ"
warning. We do actually handle these type of errors (by notifying
userspace), so add the missing return IRQ_HANDLED so we don't throw
unecessary warnings.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/misc/cxl/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index c294925f73ee..bfbe3c8ae7d6 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -167,6 +167,7 @@ static irqreturn_t cxl_irq(int irq, void *data, struct cxl_irq_info *irq_info)
 		}
 
 		cxl_ack_irq(ctx, CXL_PSL_TFC_An_A, 0);
+		return IRQ_HANDLED;
 	}
 	if (dsisr & CXL_PSL_DSISR_An_OC)
 		pr_devel("CXL interrupt: OS Context Warning\n");
-- 
2.1.0
