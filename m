Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 1E61810083F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:44 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <97d94cc156d8e8c199ab5d057d3375e6403aecf0.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:28:59 -0500
Subject: [PATCH 08/37] powerpc: mpic: limit NR_CPUS loop to 32 bit
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpic_physmask was looping NR_CPUS times over a mask that was passed as
a u32. Since mpic is architecturaly limited to 32 physical cpus, clamp
the logical cpus to 32 when compiling (we could also clamp at runtime
to nr_cpu_ids).

Signed-off-by: Milton Miller <miltonm@bga.com>
---
 arch/powerpc/sysdev/mpic.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 824a94f..a93da80 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -631,7 +631,7 @@ static inline u32 mpic_physmask(u32 cpumask)
 	int i;
 	u32 mask = 0;
 
-	for (i = 0; i < NR_CPUS; ++i, cpumask >>= 1)
+	for (i = 0; i < min(32, NR_CPUS); ++i, cpumask >>= 1)
 		mask |= (cpumask & 1) << get_hard_smp_processor_id(i);
 	return mask;
 }
-- 
1.7.0.4
