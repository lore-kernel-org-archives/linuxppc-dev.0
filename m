Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BC59C2C0199
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2013 13:10:04 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Alexander Graf <agraf@suse.de>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: [PATCH v2 1/4] powerpc: hard_irq_disable(): Call trace_hardirqs_off
 after disabling
Date: Thu, 9 May 2013 22:09:41 -0500
Message-ID: <1368155384-11035-2-git-send-email-scottwood@freescale.com>
In-Reply-To: <1368155384-11035-1-git-send-email-scottwood@freescale.com>
References: <1368155384-11035-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

lockdep.c has this:
        /*
         * So we're supposed to get called after you mask local IRQs,
         * but for some reason the hardware doesn't quite think you did
         * a proper job.
         */
	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
		return;

Since irqs_disabled() is based on soft_enabled(), that (not just the
hard EE bit) needs to be 0 before we call trace_hardirqs_off.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/hw_irq.h |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index d615b28..ba713f1 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -96,11 +96,12 @@ static inline bool arch_irqs_disabled(void)
 #endif
 
 #define hard_irq_disable()	do {			\
+	u8 _was_enabled = get_paca()->soft_enabled;	\
 	__hard_irq_disable();				\
-	if (local_paca->soft_enabled)			\
-		trace_hardirqs_off();			\
 	get_paca()->soft_enabled = 0;			\
 	get_paca()->irq_happened |= PACA_IRQ_HARD_DIS;	\
+	if (_was_enabled)				\
+		trace_hardirqs_off();			\
 } while(0)
 
 static inline bool lazy_irq_pending(void)
-- 
1.7.10.4
