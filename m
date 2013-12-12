Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	Ulrich.Weigand@de.ibm.com
Subject: [PATCH 3/8] powerpc: Fix topology core_id endian issue on LE builds
Date: Thu, 12 Dec 2013 15:59:36 +1100
Message-Id: <1386824381-14032-4-git-send-email-anton@samba.org>
In-Reply-To: <1386824381-14032-1-git-send-email-anton@samba.org>
References: <1386824381-14032-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

cpu_to_core_id() is missing a byteswap:

cat /sys/devices/system/cpu/cpu63/topology/core_id
201326592

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 19d654b..ac2621a 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -575,7 +575,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 int cpu_to_core_id(int cpu)
 {
 	struct device_node *np;
-	const int *reg;
+	const __be32 *reg;
 	int id = -1;
 
 	np = of_get_cpu_node(cpu, NULL);
@@ -586,7 +586,7 @@ int cpu_to_core_id(int cpu)
 	if (!reg)
 		goto out;
 
-	id = *reg;
+	id = be32_to_cpup(reg);
 out:
 	of_node_put(np);
 	return id;
-- 
1.8.3.2
