Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 8A84FDDF83
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 16:57:45 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <6827a84e83495f49c991a33b2cef07614273fa0a.1217476198.git.tony@bakeyournoodle.com>
Message-Id: <80bdb63106f6dbdbe81a36272ad8da32fd1c1470.1217487365.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH v2] Force printing of 'total_memory' to unsigned long long in
	ppc_mmu_32.c
Date: Thu, 31 Jul 2008 16:57:44 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

total_memory is a 'phys_addr_t', Which can be either 64 or 32 bits.
Force printing as unsigned long long to silence the warning.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
Changes since v1:
 - correctly use 64bit type as phys_addr_t wont always be 32bits.  Thanks to sfr for showing me the error of my ways ;P

 arch/powerpc/mm/ppc_mmu_32.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index c53145f..07473e0 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -236,8 +236,8 @@ void __init MMU_init_hw(void)
 
 	Hash_end = (struct hash_pte *) ((unsigned long)Hash + Hash_size);
 
-	printk("Total memory = %ldMB; using %ldkB for hash table (at %p)\n",
-	       total_memory >> 20, Hash_size >> 10, Hash);
+	printk("Total memory = %lldMB; using %ldkB for hash table (at %p)\n",
+	       (unsigned long long)total_memory >> 20, Hash_size >> 10, Hash);
 
 
 	/*
-- 
1.5.6.3
