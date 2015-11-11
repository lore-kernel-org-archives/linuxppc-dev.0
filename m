Return-Path: <john.ogness@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 652AD1A01D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 01:11:22 +1100 (AEDT)
From: John Ogness <john.ogness@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: set IRQF_NO_THREAD for xmon/cascade handlers
Date: Wed, 11 Nov 2015 14:48:50 +0100
Message-ID: <874mgsoddp.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The xmon and cascade irq handlers must not run as threads.
pmac_pic_lock is already a raw_spinlock, but the irq flag
IRQF_NO_THREAD needs to be set as well.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 arch/powerpc/platforms/powermac/pic.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 6f4f8b0..9815463 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -258,13 +258,14 @@ static unsigned int pmac_pic_get_irq(void)
 #ifdef CONFIG_XMON
 static struct irqaction xmon_action = {
 	.handler	= xmon_irq,
-	.flags		= 0,
+	.flags		= IRQF_NO_THREAD,
 	.name		= "NMI - XMON"
 };
 #endif
 
 static struct irqaction gatwick_cascade_action = {
 	.handler	= gatwick_action,
+	.flags		= IRQF_NO_THREAD,
 	.name		= "cascade",
 };
 
-- 
1.7.10.4
