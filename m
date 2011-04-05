Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <ec654e72aedba49af13f2ea0c076be22b962c801.1301984955.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc/nohash: Allocate stale_map[cpu] on CPU_UP_PREPARE not
	CPU_ONLINE
Date: Tue,  5 Apr 2011 16:29:18 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we allocate the stale_map for a cpu when it comes online,
this leaves open a small window where a process can be scheduled
on the cpu before the stale_map is allocated. Instead allocate
the stale_map at CPU_UP_PREPARE time, that way it will be always
available before tasks start running.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/mm/mmu_context_nohash.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index c0aab52..1bde0e8 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -338,8 +338,8 @@ static int __cpuinit mmu_context_cpu_notify(struct notifier_block *self,
 		return NOTIFY_OK;
 
 	switch (action) {
-	case CPU_ONLINE:
-	case CPU_ONLINE_FROZEN:
+	case CPU_UP_PREPARE:
+	case CPU_UP_PREPARE_FROZEN:
 		pr_devel("MMU: Allocating stale context map for CPU %d\n", cpu);
 		stale_map[cpu] = kzalloc(CTX_MAP_SIZE, GFP_KERNEL);
 		break;
-- 
1.7.1
