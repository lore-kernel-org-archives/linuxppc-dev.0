Return-Path: <B35336@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8A73C2C0294
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2013 19:04:36 +1100 (EST)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] mpic: fix Destination Registers init problem
Date: Thu, 7 Feb 2013 16:07:00 +0800
Message-ID: <1360224420-5009-1-git-send-email-chenhui.zhao@freescale.com>
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

The Freescale implementation of the MPIC only allows a single CPU
destination for non-IPI interrupts. Test the flag MPIC_SINGLE_DEST_CPU
to check if the Destination registers should be set.

This prevents more than one bit is set at secondary processors
initilizing time if the flag MPIC_SINGLE_DEST_CPU is set.

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/mpic.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 9c6e535..cc537f8 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1675,7 +1675,7 @@ void mpic_setup_this_cpu(void)
 	 * it differently, then we should make sure we also change the default
 	 * values of irq_desc[].affinity in irq.c.
  	 */
-	if (distribute_irqs) {
+	if (distribute_irqs && !(mpic->flags & MPIC_SINGLE_DEST_CPU)) {
 	 	for (i = 0; i < mpic->num_sources ; i++)
 			mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION),
 				mpic_irq_read(i, MPIC_INFO(IRQ_DESTINATION)) | msk);
-- 
1.7.1
