Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D1F6EDDD0C
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Nov 2008 03:31:54 +1100 (EST)
Date: Tue, 4 Nov 2008 10:31:05 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 1/1] irq: Maintain user set affinity
Message-ID: <Pine.LNX.4.64.0811041030520.25054@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From 819ad3ed4660f4238e053728a8b5aa93d22b13d7 Mon Sep 17 00:00:00 2001
From: Kumar Gala <galak@kernel.crashing.org>
Date: Tue, 4 Nov 2008 10:13:53 -0600
Subject: [PATCH 1/1] irq: Maintain user set affinity

This addresses a regression in that if a user specified an affinity
for an interrupt that affinity information would get reset between
a request_irq(), free_irq() and request_irq() for the same irq.

On example of this is bringing up an ethernet interface, taking
it down and bringing it back up again.

Instead of always using the irq_default_affinity we use the
previous setting of the IRQs affinity with the assumption that
at boot the IRQs affinity will be set to irq_default_affinity.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 kernel/irq/manage.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c498a1b..ea7d11b 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -115,9 +115,12 @@ int irq_select_affinity(unsigned int irq)
 	if (!irq_can_set_affinity(irq))
 		return 0;

-	cpus_and(mask, cpu_online_map, irq_default_affinity);
-
 	desc = irq_to_desc(irq);
+
+	mask = desc->affinity;
+
+	cpus_and(mask, cpu_online_map, mask);
+
 	desc->affinity = mask;
 	desc->chip->set_affinity(irq, mask);

-- 
1.5.5.1
