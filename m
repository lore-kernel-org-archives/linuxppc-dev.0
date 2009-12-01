Return-Path: <jacmet@gmail.com>
Received: from mail-ew0-f215.google.com (mail-ew0-f215.google.com
	[209.85.219.215]) by ozlabs.org (Postfix) with ESMTP id AE20C1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Dec 2009 07:48:27 +1100 (EST)
Received: by ewy7 with SMTP id 7so6199057ewy.8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 01 Dec 2009 12:48:24 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] show_interrupts: use irq_chip::name if available
Date: Tue,  1 Dec 2009 21:48:12 +0100
Message-Id: <1259700494-17869-1-git-send-email-jacmet@sunsite.dk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

struct irq_chip::typename is going away (replaced by name). Use name if
set instead of typename in show_interrupt to make ease transition.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/powerpc/kernel/irq.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index e5d1211..33e1130 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -203,7 +203,8 @@ int show_interrupts(struct seq_file *p, void *v)
 		seq_printf(p, "%10u ", kstat_irqs(i));
 #endif /* CONFIG_SMP */
 		if (desc->chip)
-			seq_printf(p, " %s ", desc->chip->typename);
+			seq_printf(p, " %s ", desc->chip->name ?
+				   desc->chip->name : desc->chip->typename);
 		else
 			seq_puts(p, "  None      ");
 		seq_printf(p, "%s", (desc->status & IRQ_LEVEL) ? "Level " : "Edge  ");
-- 
1.6.5
