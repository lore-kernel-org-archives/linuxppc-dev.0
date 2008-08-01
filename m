Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id A3F4DDE197
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 11:38:40 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <80bdb63106f6dbdbe81a36272ad8da32fd1c1470.1217487365.git.tony@bakeyournoodle.com>
Message-Id: <875b61197621acbbc7f510eac20ccf21a8b453da.1217553660.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH v3] Force printing of 'total_memory' to unsigned long long in
	ppc_mmu_32.c
Date: Fri,  1 Aug 2008 11:38:39 +1000 (EST)
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
 - correctly use 64bit type as phys_addr_t wont always be 32bits.  Thanks to
   sfr for showing me the error of my ways ;P

Changes since v2:
 - correctly cast the result of the shift NOT just total_memory.  Thanks Milton
   for catching that.

 arch/powerpc/mm/ppc_mmu_32.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index c53145f..6aa1208 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -236,8 +236,8 @@ void __init MMU_init_hw(void)
 
 	Hash_end = (struct hash_pte *) ((unsigned long)Hash + Hash_size);
 
-	printk("Total memory = %ldMB; using %ldkB for hash table (at %p)\n",
-	       total_memory >> 20, Hash_size >> 10, Hash);
+	printk("Total memory = %lldMB; using %ldkB for hash table (at %p)\n",
+	       (unsigned long long)(total_memory >> 20), Hash_size >> 10, Hash);
 
 
 	/*
-- 
1.5.6.3
