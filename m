Return-Path: <hellozzy1988@126.com>
Received: from m15-113.126.com (m15-113.126.com [220.181.15.113])
 by lists.ozlabs.org (Postfix) with ESMTP id 5E1A11A06B3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Dec 2015 16:15:15 +1100 (AEDT)
From: Zhang Zhuoyu <hellozzy1988@126.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 tglx@linutronix.de, jiang.liu@linux.intel.com,
 zhangzhuoyu@cmss.chinamobile.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] powerpc/irq: tidy up inconsistent context in
 migrate_irqs()
Date: Wed, 16 Dec 2015 00:14:56 -0500
Message-Id: <1450242896-8322-1-git-send-email-hellozzy1988@126.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Zhang Zhuoyu <zhangzhuoyu@cmss.chinamobile.com>

Remove paradoxical and unnecessary lines before disable local interrupt.

Signed-off-by: Zhang Zhuoyu <zhangzhuoyu@cmss.chinamobile.com>
---
 arch/powerpc/kernel/irq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 290559d..03fa686 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -454,8 +454,6 @@ void migrate_irqs(void)
 
 	free_cpumask_var(mask);
 
-	local_irq_enable();
-	mdelay(1);
 	local_irq_disable();
 }
 #endif
-- 
1.8.3.1
