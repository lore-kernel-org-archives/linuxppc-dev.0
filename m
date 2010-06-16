Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (he.sipsolutions.net [78.46.109.217])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 97D88B7D69
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jun 2010 20:09:45 +1000 (EST)
Subject: [PATCH 2.6.35 v3] powerpc: fix logic error in fixup_irqs
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1276289669.3918.3.camel@jlt3.sipsolutions.net>
References: <1276289669.3918.3.camel@jlt3.sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Jun 2010 12:09:35 +0200
Message-ID: <1276682975.3640.15.camel@jlt3.sipsolutions.net>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, alastair.bridgewater@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When SPARSE_IRQ is set, irq_to_desc() can
return NULL. While the code here has a
check for NULL, it's not really correct.
Fix it by separating the check for it.

This fixes CPU hot unplug for me.

Reported-by: Alastair Bridgewater <alastair.bridgewater@gmail.com>
Cc: stable@kernel.org [2.6.32+]
Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
---
v2: cc Alastair, sorry
v3: indicate stable versions

 arch/powerpc/kernel/irq.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- wireless-testing.orig/arch/powerpc/kernel/irq.c	2010-06-11 22:51:08.000000000 +0200
+++ wireless-testing/arch/powerpc/kernel/irq.c	2010-06-11 22:54:11.000000000 +0200
@@ -295,7 +295,10 @@ void fixup_irqs(const struct cpumask *ma
 
 	for_each_irq(irq) {
 		desc = irq_to_desc(irq);
-		if (desc && desc->status & IRQ_PER_CPU)
+		if (!desc)
+			continue;
+
+		if (desc->status & IRQ_PER_CPU)
 			continue;
 
 		cpumask_and(mask, desc->affinity, map);
