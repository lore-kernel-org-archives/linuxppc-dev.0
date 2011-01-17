Return-Path: <scottwood@freescale.com>
Received: from AM1EHSOBE005.bigfish.com (am1ehsobe005.messaging.microsoft.com
	[213.199.154.208])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D9F20B713A
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jan 2011 09:10:53 +1100 (EST)
Date: Mon, 17 Jan 2011 16:10:41 -0600
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/mpic: fix mask/unmask timeout message
Message-ID: <20110117221041.GA18662@udp111988uds.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Don't say that enable timed out when it was disable, and
show which IRQ had the problem.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/mpic.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 7c13426..b0c8469 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -674,7 +674,8 @@ void mpic_unmask_irq(unsigned int irq)
 	/* make sure mask gets to controller before we return to user */
 	do {
 		if (!loops--) {
-			printk(KERN_ERR "mpic_enable_irq timeout\n");
+			printk(KERN_ERR "%s: timeout on hwirq %u\n",
+			       __func__, src);
 			break;
 		}
 	} while(mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI)) & MPIC_VECPRI_MASK);
@@ -695,7 +696,8 @@ void mpic_mask_irq(unsigned int irq)
 	/* make sure mask gets to controller before we return to user */
 	do {
 		if (!loops--) {
-			printk(KERN_ERR "mpic_enable_irq timeout\n");
+			printk(KERN_ERR "%s: timeout on hwirq %u\n",
+			       __func__, src);
 			break;
 		}
 	} while(!(mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI)) & MPIC_VECPRI_MASK));
-- 
1.7.0.4
