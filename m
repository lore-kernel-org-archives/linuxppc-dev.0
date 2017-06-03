Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfsrs4rBrzDqKs
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Jun 2017 17:19:09 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id s62so4052558pgc.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Jun 2017 00:19:09 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	mpe@ellerman.id.au
Cc: naveen.n.rao@linux.vnet.ibm.com, christophe.leroy@c-s.fr, paulus@samba.org,
 rashmica.g@gmail.com, labbott@redhat.com,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v2 2/9] powerpc/kprobes: Move kprobes over to patch_instruction
Date: Sat,  3 Jun 2017 17:18:36 +1000
Message-Id: <20170603071843.11966-3-bsingharora@gmail.com>
In-Reply-To: <20170603071843.11966-1-bsingharora@gmail.com>
References: <20170603071843.11966-1-bsingharora@gmail.com>
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
index fc43435..b49f8f0 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -158,7 +158,7 @@ NOKPROBE_SYMBOL(arch_prepare_kprobe);
 
 void arch_arm_kprobe(struct kprobe *p)
 {
-	*p->addr = BREAKPOINT_INSTRUCTION;
+	patch_instruction(p->addr, BREAKPOINT_INSTRUCTION);
 	flush_icache_range((unsigned long) p->addr,
 			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
 }
@@ -166,7 +166,7 @@ NOKPROBE_SYMBOL(arch_arm_kprobe);
 
 void arch_disarm_kprobe(struct kprobe *p)
 {
-	*p->addr = p->opcode;
+	patch_instruction(p->addr, p->opcode);
 	flush_icache_range((unsigned long) p->addr,
 			   (unsigned long) p->addr + sizeof(kprobe_opcode_t));
 }
-- 
2.9.3
