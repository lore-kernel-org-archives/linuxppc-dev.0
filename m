Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <a9e38f55dcc6487125ca1ab1f455b58d565fd397.1255499081.git.michael@ellerman.id.au>
In-Reply-To: <a6fc612b826ff12628e62601203d565df00c6436.1255499081.git.michael@ellerman.id.au>
References: <a6fc612b826ff12628e62601203d565df00c6436.1255499081.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 4/6] powerpc: Make virq_debug_show() cope with sparse irq_descs
Date: Wed, 14 Oct 2009 16:44:56 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/irq.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 6563221..baa49eb 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -1065,8 +1065,11 @@ static int virq_debug_show(struct seq_file *m, void *private)
 	seq_printf(m, "%-5s  %-7s  %-15s  %s\n", "virq", "hwirq",
 		      "chip name", "host name");
 
-	for (i = 1; i < NR_IRQS; i++) {
+	for (i = 1; i < nr_irqs; i++) {
 		desc = irq_to_desc(i);
+		if (!desc)
+			continue;
+
 		spin_lock_irqsave(&desc->lock, flags);
 
 		if (desc->action && desc->action->handler) {
-- 
1.6.2.1
