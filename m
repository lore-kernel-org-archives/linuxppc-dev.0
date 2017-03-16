Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkMkw5Bq5zDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 19:55:52 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc: handle simultaneous interrupts at once
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20170316085545.EEE4A68481@localhost.localdomain>
Date: Thu, 16 Mar 2017 09:55:45 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It often happens to have simultaneous interrupts, for instance
when having double Ethernet attachment. With the current
implementation, we suffer the cost of kernel entry/exit for each
interrupt.

This patch introduces a loop in __do_irq() to handle all interrupts
at once before returning.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
Changed from v1(RFC): simplified following remark from benh

 arch/powerpc/kernel/irq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index a018f5cae899..ba0cb6c2ee7d 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -522,7 +522,11 @@ void __do_irq(struct pt_regs *regs)
 	if (unlikely(!irq))
 		__this_cpu_inc(irq_stat.spurious_irqs);
 	else
-		generic_handle_irq(irq);
+		do {
+			generic_handle_irq(irq);
+
+			irq = ppc_md.get_irq();
+		} while (irq);
 
 	trace_irq_exit(regs);
 
-- 
2.12.0
