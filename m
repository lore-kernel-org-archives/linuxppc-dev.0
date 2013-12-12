Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	Ulrich.Weigand@de.ibm.com
Subject: [PATCH 4/8] powerpc/pseries: Fix endian issues in /proc/ppc64/lparcfg
Date: Thu, 12 Dec 2013 15:59:37 +1100
Message-Id: <1386824381-14032-5-git-send-email-anton@samba.org>
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

Some obvious issues:

cat /proc/ppc64/lparcfg
...
partition_id=16777216
...
partition_potential_processors=268435456

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/platforms/pseries/lparcfg.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index e738007..c9fecf0 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -157,7 +157,7 @@ static void parse_ppp_data(struct seq_file *m)
 {
 	struct hvcall_ppp_data ppp_data;
 	struct device_node *root;
-	const int *perf_level;
+	const __be32 *perf_level;
 	int rc;
 
 	rc = h_get_ppp(&ppp_data);
@@ -201,7 +201,7 @@ static void parse_ppp_data(struct seq_file *m)
 		perf_level = of_get_property(root,
 				"ibm,partition-performance-parameters-level",
 					     NULL);
-		if (perf_level && (*perf_level >= 1)) {
+		if (perf_level && (be32_to_cpup(perf_level) >= 1)) {
 			seq_printf(m,
 			    "physical_procs_allocated_to_virtualization=%d\n",
 				   ppp_data.phys_platform_procs);
@@ -435,7 +435,7 @@ static int pseries_lparcfg_data(struct seq_file *m, void *v)
 	int partition_potential_processors;
 	int partition_active_processors;
 	struct device_node *rtas_node;
-	const int *lrdrp = NULL;
+	const __be32 *lrdrp = NULL;
 
 	rtas_node = of_find_node_by_path("/rtas");
 	if (rtas_node)
@@ -444,7 +444,7 @@ static int pseries_lparcfg_data(struct seq_file *m, void *v)
 	if (lrdrp == NULL) {
 		partition_potential_processors = vdso_data->processorCount;
 	} else {
-		partition_potential_processors = *(lrdrp + 4);
+		partition_potential_processors = be32_to_cpup(lrdrp + 4);
 	}
 	of_node_put(rtas_node);
 
@@ -654,7 +654,7 @@ static int lparcfg_data(struct seq_file *m, void *v)
 	const char *model = "";
 	const char *system_id = "";
 	const char *tmp;
-	const unsigned int *lp_index_ptr;
+	const __be32 *lp_index_ptr;
 	unsigned int lp_index = 0;
 
 	seq_printf(m, "%s %s\n", MODULE_NAME, MODULE_VERS);
@@ -670,7 +670,7 @@ static int lparcfg_data(struct seq_file *m, void *v)
 		lp_index_ptr = of_get_property(rootdn, "ibm,partition-no",
 					NULL);
 		if (lp_index_ptr)
-			lp_index = *lp_index_ptr;
+			lp_index = be32_to_cpup(lp_index_ptr);
 		of_node_put(rootdn);
 	}
 	seq_printf(m, "serial_number=%s\n", system_id);
-- 
1.8.3.2
