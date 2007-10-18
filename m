Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 84011DDEA3
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 11:25:51 +1000 (EST)
Subject: [PATCH] synchronize_irq needs a barrier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain
Date: Thu, 18 Oct 2007 11:25:42 +1000
Message-Id: <1192670742.12879.5.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	akpm <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

synchronize_irq needs at the very least a compiler barrier and a
read barrier on SMP, but there are enough cases around where a
write barrier is also needed and it's not a hot path so I prefer
using a full smp_mb() here.

It will degrade to a compiler barrier on !SMP.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Index: linux-work/kernel/irq/manage.c
===================================================================
--- linux-work.orig/kernel/irq/manage.c	2007-10-18 11:22:16.000000000 +1000
+++ linux-work/kernel/irq/manage.c	2007-10-18 11:22:20.000000000 +1000
@@ -33,6 +33,7 @@ void synchronize_irq(unsigned int irq)
 	if (irq >= NR_IRQS)
 		return;
 
+	smp_mb();
 	while (desc->status & IRQ_INPROGRESS)
 		cpu_relax();
 }
