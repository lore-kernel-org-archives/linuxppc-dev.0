Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 15/63] powerpc: Make logical to real cpu mapping code endian
 safe
Date: Wed,  7 Aug 2013 02:01:32 +1000
Message-Id: <1375804940-22050-16-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/setup-common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 63d051f..ee0e055 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -436,7 +436,7 @@ void __init smp_setup_cpu_maps(void)
 	DBG("smp_setup_cpu_maps()\n");
 
 	while ((dn = of_find_node_by_type(dn, "cpu")) && cpu < nr_cpu_ids) {
-		const int *intserv;
+		const __be32 *intserv;
 		int j, len;
 
 		DBG("  * %s...\n", dn->full_name);
@@ -456,9 +456,9 @@ void __init smp_setup_cpu_maps(void)
 
 		for (j = 0; j < nthreads && cpu < nr_cpu_ids; j++) {
 			DBG("    thread %d -> cpu %d (hard id %d)\n",
-			    j, cpu, intserv[j]);
+			    j, cpu, be32_to_cpu(intserv[j]));
 			set_cpu_present(cpu, true);
-			set_hard_smp_processor_id(cpu, intserv[j]);
+			set_hard_smp_processor_id(cpu, be32_to_cpu(intserv[j]));
 			set_cpu_possible(cpu, true);
 			cpu++;
 		}
-- 
1.8.1.2
