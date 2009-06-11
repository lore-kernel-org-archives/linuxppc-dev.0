Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1BC4CB7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 15:05:00 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
Message-Id: <f91eeceb158ac9661094de2c73fb0d21febdbe06.1244696691.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc: Fix warning in setup_64.c when CONFIG_RELOCATABLE=y
Date: Thu, 11 Jun 2009 15:05:00 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When CONFIG_RELOCATABLE is enabled, PHYSICAL_START is actually a
variable of type phys_addr_t. That means to print it we need to
cast to unsigned long long and use llx.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/setup_64.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index f46548e..1f68160 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -424,8 +424,8 @@ void __init setup_system(void)
 	printk("htab_hash_mask                = 0x%lx\n", htab_hash_mask);
 #endif /* CONFIG_PPC_STD_MMU_64 */
 	if (PHYSICAL_START > 0)
-		printk("physical_start                = 0x%lx\n",
-		       PHYSICAL_START);
+		printk("physical_start                = 0x%llx\n",
+		       (unsigned long long)PHYSICAL_START);
 	printk("-----------------------------------------------------\n");
 
 	DBG(" <- setup_system()\n");
-- 
1.6.2.1
