Return-Path: <B35336@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6A7FE2C0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 May 2013 18:00:19 +1000 (EST)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH] powerpc/mpic: fix irq distribution problem when
 MPIC_SINGLE_DEST_CPU
Date: Tue, 28 May 2013 15:59:43 +0800
Message-ID: <1369727984-21505-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For the mpic with a flag MPIC_SINGLE_DEST_CPU, only one bit should be
set in interrupt destination registers.

The code is applicable to 64-bit platforms as well as 32-bit.

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
---
 arch/powerpc/sysdev/mpic.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 0a13ecb..3cc2f91 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -54,7 +54,7 @@ static DEFINE_RAW_SPINLOCK(mpic_lock);
 
 #ifdef CONFIG_PPC32	/* XXX for now */
 #ifdef CONFIG_IRQ_ALL_CPUS
-#define distribute_irqs	(!(mpic->flags & MPIC_SINGLE_DEST_CPU))
+#define distribute_irqs	(1)
 #else
 #define distribute_irqs	(0)
 #endif
@@ -1703,7 +1703,7 @@ void mpic_setup_this_cpu(void)
 	 * it differently, then we should make sure we also change the default
 	 * values of irq_desc[].affinity in irq.c.
  	 */
-	if (distribute_irqs) {
+	if (distribute_irqs && !(mpic->flags & MPIC_SINGLE_DEST_CPU)) {
 	 	for (i = 0; i < mpic->num_sources ; i++)
 			mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
 				mpic_irq_read(i, MPIC_INFO(IRQ_DESTINATION)) | msk);
-- 
1.7.3
