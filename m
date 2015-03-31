Return-Path: <jstancek@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 715551A03DB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 03:11:59 +1100 (AEDT)
From: Jan Stancek <jstancek@redhat.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: fix memory corruption by pnv_alloc_idle_core_states
Date: Tue, 31 Mar 2015 18:11:46 +0200
Message-Id: <67174f780b3615749546d5a6d5bfba4c4f26a855.1427818011.git.jstancek@redhat.com>
Cc: mikey@neuling.org, shreyas@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 sbest@redhat.com, paulus@samba.org, preeti@linux.vnet.ibm.com,
 jstancek@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Space allocated for paca is based off nr_cpu_ids,
but pnv_alloc_idle_core_states() iterates paca with
cpu_nr_cores()*threads_per_core, which is using NR_CPUS.

This causes pnv_alloc_idle_core_states() to write over memory,
which is outside of paca array and may later lead to various panics.

Fixes: 7cba160ad789 (powernv/cpuidle: Redesign idle states management)
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 arch/powerpc/include/asm/cputhreads.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
index 2bf8e93..4c8ad59 100644
--- a/arch/powerpc/include/asm/cputhreads.h
+++ b/arch/powerpc/include/asm/cputhreads.h
@@ -55,7 +55,7 @@ static inline cpumask_t cpu_thread_mask_to_cores(const struct cpumask *threads)
 
 static inline int cpu_nr_cores(void)
 {
-	return NR_CPUS >> threads_shift;
+	return nr_cpu_ids >> threads_shift;
 }
 
 static inline cpumask_t cpu_online_cores_map(void)
-- 
1.8.3.1
