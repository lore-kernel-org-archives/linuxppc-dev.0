Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 17 Apr 2007 11:43:12 +1000
Subject: [PATCH] Initialise spinlock in the DEBUG_PAGEALLOC code
Message-Id: <20070417014331.85276DDEBC@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fixes:

BUG: spinlock bad magic on CPU#0, swapper/0
 lock: c00000000064ec30, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
Call Trace:
[c00000000062b980] [c00000000000f920] .show_stack+0x6c/0x1a0 (unreliable)
[c00000000062ba20] [c0000000001c2b40] .spin_bug+0xb0/0xd4
[c00000000062bab0] [c0000000001c2ed0] ._raw_spin_lock+0x44/0x184
[c00000000062bb50] [c0000000003a42b4] ._spin_lock+0x10/0x24
[c00000000062bbd0] [c00000000002b4dc] .kernel_map_pages+0x198/0x278
[c00000000062bc90] [c000000000079720] .free_hot_cold_page+0x124/0x418
[c00000000062bd70] [c000000000530278] .free_all_bootmem_core+0x14c/0x224
[c00000000062be50] [c00000000052a178] .mem_init+0x68/0x170
[c00000000062bee0] [c00000000051d874] .start_kernel+0x2a0/0x37c
[c00000000062bf90] [c0000000000084c8] .start_here_common+0x54/0x8c


Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/mm/hash_utils_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: powerpc/arch/powerpc/mm/hash_utils_64.c
===================================================================
--- powerpc.orig/arch/powerpc/mm/hash_utils_64.c
+++ powerpc/arch/powerpc/mm/hash_utils_64.c
@@ -103,7 +103,7 @@ int mmu_ci_restrictions;
 #ifdef CONFIG_DEBUG_PAGEALLOC
 static u8 *linear_map_hash_slots;
 static unsigned long linear_map_hash_count;
-static spinlock_t linear_map_hash_lock;
+static spinlock_t linear_map_hash_lock = SPIN_LOCK_UNLOCKED;
 #endif /* CONFIG_DEBUG_PAGEALLOC */
 
 /* There are definitions of page sizes arrays to be used when none
