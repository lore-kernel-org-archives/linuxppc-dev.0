Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 1E348100843
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:44 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <817ac482cbc66586496ef9fec80d84e472582e24.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:28:55 -0500
Subject: [PATCH 07/37] powerpc: call no-longer static setup_nr_cpu_ids instead
	of replicating it
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

c1854e00727f50f7ac99e98d26ece04c087ef785 (powerpc: Set nr_cpu_ids early
and use it to free PACAs) copied the formerly static setup_nr_cpu_ids
from init/main.c but 34db18a054c600b6f81787165669dc572fe4de25 (smp:
move smp setup functions to kernel/smp.c) moved it to kernel/smp.c
with a declaration in include/linux/smp.h, so we can call it instead of
replicating it.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
I found this cleanup while c1854e was being merged, but saved it from the
end to ease backporting.
---
 arch/powerpc/kernel/setup-common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index fce759b..ef33a08 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -510,7 +510,7 @@ void __init smp_setup_cpu_maps(void)
 	cpu_init_thread_core_maps(nthreads);
 
 	/* Now that possible cpus are set, set nr_cpu_ids for later use */
-	nr_cpu_ids = find_last_bit(cpumask_bits(cpu_possible_mask),NR_CPUS) + 1;
+	setup_nr_cpu_ids();
 
 	free_unused_pacas();
 }
-- 
1.7.0.4
