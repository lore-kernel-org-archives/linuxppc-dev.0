Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C3EEA2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 11:06:23 +1100 (EST)
Date: Wed, 20 Mar 2013 19:06:12 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/mm/nohash: ignore NULL stale_map entries
Message-ID: <20130321000612.GA5887@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This happens with threads that are offline due to CPU hotplug
(including threads that were never "plugged in" to begin with because
SMT is disabled).

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/mm/mmu_context_nohash.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
index e779642..810f8e4 100644
--- a/arch/powerpc/mm/mmu_context_nohash.c
+++ b/arch/powerpc/mm/mmu_context_nohash.c
@@ -112,8 +112,10 @@ static unsigned int steal_context_smp(unsigned int id)
 		 */
 		for_each_cpu(cpu, mm_cpumask(mm)) {
 			for (i = cpu_first_thread_sibling(cpu);
-			     i <= cpu_last_thread_sibling(cpu); i++)
-				__set_bit(id, stale_map[i]);
+			     i <= cpu_last_thread_sibling(cpu); i++) {
+				if (stale_map[i])
+					__set_bit(id, stale_map[i]);
+			}
 			cpu = i - 1;
 		}
 		return id;
@@ -272,7 +274,8 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
 		/* XXX This clear should ultimately be part of local_flush_tlb_mm */
 		for (i = cpu_first_thread_sibling(cpu);
 		     i <= cpu_last_thread_sibling(cpu); i++) {
-			__clear_bit(id, stale_map[i]);
+			if (stale_map[i])
+				__clear_bit(id, stale_map[i]);
 		}
 	}
 
-- 
1.7.9.5
