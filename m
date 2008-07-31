Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 115ADDDEE4
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 13:51:44 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <6827a84e83495f49c991a33b2cef07614273fa0a.1217476198.git.tony@bakeyournoodle.com>
In-Reply-To: <cac86e24e42bd05087b43663b687f04df91326ba.1217476198.git.tony@bakeyournoodle.com>
References: <cac86e24e42bd05087b43663b687f04df91326ba.1217476198.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 5/8] Silence warning in arch/powerpc/mm/ppc_mmu_32.c
Date: Thu, 31 Jul 2008 13:51:43 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

total_memory is a 'phys_addr_t', cast to unsigned long to silence
warning.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/mm/ppc_mmu_32.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index c53145f..9c19655 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -237,7 +237,7 @@ void __init MMU_init_hw(void)
 	Hash_end = (struct hash_pte *) ((unsigned long)Hash + Hash_size);
 
 	printk("Total memory = %ldMB; using %ldkB for hash table (at %p)\n",
-	       total_memory >> 20, Hash_size >> 10, Hash);
+	       (unsigned long)total_memory >> 20, Hash_size >> 10, Hash);
 
 
 	/*
-- 
1.5.6.3
