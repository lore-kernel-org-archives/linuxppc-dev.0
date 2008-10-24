Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EFDD5DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 02:58:26 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] genirq: Set initial default irq affinity to just CPU0
Date: Fri, 24 Oct 2008 10:57:38 -0500
Message-Id: <1224863858-7933-1-git-send-email-galak@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, maxk@qualcomm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 18404756765c713a0be4eb1082920c04822ce588 introduced a regression
on a subset of SMP based PPC systems whose interrupt controller only
allow setting an irq to a single processor.  The previous behavior
was only CPU0 was initially setup to get interrupts.  Revert back
to that behavior.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 kernel/irq/manage.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c498a1b..728d36a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -17,7 +17,7 @@
 
 #ifdef CONFIG_SMP
 
-cpumask_t irq_default_affinity = CPU_MASK_ALL;
+cpumask_t irq_default_affinity = CPU_MASK_CPU0;
 
 /**
  *	synchronize_irq - wait for pending IRQ handlers (on other CPUs)
-- 
1.5.5.1
