Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxdNh0RDLzDr3T
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 17:49:24 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id z6so3670636pfk.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 00:49:23 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, christophe.leroy@c-s.fr, paulus@samba.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v4 2/9] powerpc/kprobes: Move kprobes over to patch_instruction
Date: Tue, 27 Jun 2017 17:48:56 +1000
Message-Id: <20170627074903.19324-3-bsingharora@gmail.com>
In-Reply-To: <20170627074903.19324-1-bsingharora@gmail.com>
References: <20170627074903.19324-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

arch_arm/disarm_probe use direct assignment for copying
instructions, replace them with patch_instruction

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/kernel/kprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 01addfb..a52bae8 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -164,7 +164,7 @@ NOKPROBE_SYMBOL(arch_prepare_kprobe);
 
 void arch_arm_kprobe(struct kprobe *p)
 {
-	*p->addr = BREAKPOINT_INSTRUCTION;
+	patch_instruction(p->addr, BREAKPOINT_INSTRUCTION);
 	flush_icache_range((unsigned long) p->addr,
 			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
 }
@@ -172,7 +172,7 @@ NOKPROBE_SYMBOL(arch_arm_kprobe);
 
 void arch_disarm_kprobe(struct kprobe *p)
 {
-	*p->addr = p->opcode;
+	patch_instruction(p->addr, p->opcode);
 	flush_icache_range((unsigned long) p->addr,
 			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
 }
-- 
2.9.4
