Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGdt16LfHzF0T0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 17:10:49 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc: Make newline in cpuinfo unconditional
Date: Wed, 10 Jan 2018 17:10:13 +1100
Message-Id: <20180110061014.29181-2-benh@kernel.crashing.org>
In-Reply-To: <20180110061014.29181-1-benh@kernel.crashing.org>
References: <20180110061014.29181-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We used to not put the newline between the CPU part and the summary
part on UP kernels. This is a rather pointless ifdef so take it out.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/setup-common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 8fd3a70047f1..c1df4ba0094c 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -346,10 +346,8 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		   loops_per_jiffy / (500000/HZ),
 		   (loops_per_jiffy / (5000/HZ)) % 100);
 #endif
-
-#ifdef CONFIG_SMP
 	seq_printf(m, "\n");
-#endif
+
 	/* If this is the last cpu, print the summary */
 	if (cpumask_next(cpu_id, cpu_online_mask) >= nr_cpu_ids)
 		show_cpuinfo_summary(m);
-- 
2.14.3
