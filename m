Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 36174DDE08
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 15:32:08 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id mB34W355021901
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Dec 2008 22:32:04 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Remove modpost warning with start_secondary
Date: Tue,  2 Dec 2008 22:32:03 -0600
Message-Id: <1228278723-1153-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

WARNING: vmlinux.o(.text+0x2aa): Section mismatch in reference from the variable __secondary_start to the function .devinit.text:start_secondary()
The function __secondary_start() references
the function __devinit start_secondary().

start_secondary gets called by __secondary_start which is in asm code so its
not marked as __devinit.  Its easier to just remove the __devinit from
start_secondary than try and deal with __secondary_start.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index a59d8d7..11c835e 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -487,7 +487,7 @@ static struct device_node *cpu_to_l2cache(int cpu)
 }
 
 /* Activate a secondary processor. */
-int __devinit start_secondary(void *unused)
+int start_secondary(void *unused)
 {
 	unsigned int cpu = smp_processor_id();
 	struct device_node *l2_cache;
-- 
1.5.6.5
