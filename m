Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1S2d0fFqzDr4B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 23:02:01 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v6 03/10] powerpc/kprobes: Move kprobes over to
 patch_instruction()
Date: Mon,  3 Jul 2017 23:01:47 +1000
Message-Id: <1499086914-25695-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1499086914-25695-1-git-send-email-mpe@ellerman.id.au>
References: <1499086914-25695-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Balbir Singh <bsingharora@gmail.com>

arch_arm/disarm_probe() use direct assignment for copying
instructions, replace them with patch_instruction(). We don't need to
call flush_icache_range() because patch_instruction() does it for us.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/kprobes.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index fc4343514bed..697d1fbb0f77 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -158,17 +158,13 @@ NOKPROBE_SYMBOL(arch_prepare_kprobe);
 
 void arch_arm_kprobe(struct kprobe *p)
 {
-	*p->addr = BREAKPOINT_INSTRUCTION;
-	flush_icache_range((unsigned long) p->addr,
-			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
+	patch_instruction(p->addr, BREAKPOINT_INSTRUCTION);
 }
 NOKPROBE_SYMBOL(arch_arm_kprobe);
 
 void arch_disarm_kprobe(struct kprobe *p)
 {
-	*p->addr = p->opcode;
-	flush_icache_range((unsigned long) p->addr,
-			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
+	patch_instruction(p->addr, p->opcode);
 }
 NOKPROBE_SYMBOL(arch_disarm_kprobe);
 
-- 
2.7.4
