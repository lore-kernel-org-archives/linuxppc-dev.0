Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 402182C0172
 for <linuxppc-dev@ozlabs.org>; Mon, 15 Jul 2013 12:35:18 +1000 (EST)
From: Tiejun Chen <tiejun.chen@windriver.com>
To: <benh@kernel.crashing.org>
Subject: [v1][PATCH 1/1] powerpc: to access local paca after hard irq disabled
Date: Mon, 15 Jul 2013 10:36:04 +0800
Message-ID: <1373855764-5115-1-git-send-email-tiejun.chen@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can access paca directly after hard interrupt disabled, and
this can avoid accessing wrong paca when using get_paca() in
preempt case.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 arch/powerpc/include/asm/hw_irq.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index ba713f1..10be1dd 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -96,10 +96,11 @@ static inline bool arch_irqs_disabled(void)
 #endif
 
 #define hard_irq_disable()	do {			\
-	u8 _was_enabled = get_paca()->soft_enabled;	\
+	u8 _was_enabled;				\
 	__hard_irq_disable();				\
-	get_paca()->soft_enabled = 0;			\
-	get_paca()->irq_happened |= PACA_IRQ_HARD_DIS;	\
+	_was_enabled = local_paca->soft_enabled;	\
+	local_paca->soft_enabled = 0;			\
+	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;	\
 	if (_was_enabled)				\
 		trace_hardirqs_off();			\
 } while(0)
-- 
1.7.9.5
