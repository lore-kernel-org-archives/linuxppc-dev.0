Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <46B3DC2A.408@am.sony.com>
Date: Fri, 03 Aug 2007 18:53:46 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2] cell: move SPU affinity init to spu_management_of_ops
References: <200707252342.50244.adetsch@br.ibm.com>
In-Reply-To: <200707252342.50244.adetsch@br.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: hch@lst.de, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Andre Detsch <adetsch@br.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Andre Detsch <adetsch@br.ibm.com>

This patch moves affinity initialization code from spu_base.c to a
new spu_management_of_ops function (init_affinity), which is empty
in the case of PS3. This fixes a linking problem that was happening
when compiling for PS3.
Also, some small code style changes were made.

Signed-off-by: Andre Detsch <adetsch@br.ibm.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---

Arnd,

I rebased this to to Paul's powerpc git tree.  This needs to go
in for 2.6.23, as it fixes build breakage for PS3-only configs.
Please check and ack.

-Geoff

 arch/powerpc/platforms/cell/spu_base.c   |  141 --------------------------
 arch/powerpc/platforms/cell/spu_manage.c |  163 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/ps3/spu.c         |    6 +
 include/asm-powerpc/spu_priv1.h          |    7 +
 4 files changed, 177 insertions(+), 140 deletions(-)

--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -36,7 +36,6 @@
 #include <asm/spu_priv1.h>
 #include <asm/xmon.h>
 #include <asm/prom.h>
-#include "spu_priv1_mmio.h"
 
 const struct spu_management_ops *spu_management_ops;
 EXPORT_SYMBOL_GPL(spu_management_ops);
@@ -636,138 +635,6 @@ static ssize_t spu_stat_show(struct sys_
 
 static SYSDEV_ATTR(stat, 0644, spu_stat_show, NULL);
 
-/* Hardcoded affinity idxs for QS20 */
-#define SPES_PER_BE 8
-static int QS20_reg_idxs[SPES_PER_BE] =   { 0, 2, 4, 6, 7, 5, 3, 1 };
-static int QS20_reg_memory[SPES_PER_BE] = { 1, 1, 0, 0, 0, 0, 0, 0 };
-
-static struct spu *spu_lookup_reg(int node, u32 reg)
-{
-	struct spu *spu;
-
-	list_for_each_entry(spu, &cbe_spu_info[node].spus, cbe_list) {
-		if (*(u32 *)get_property(spu_devnode(spu), "reg", NULL) == reg)
-			return spu;
-	}
-	return NULL;
-}
-
-static void init_aff_QS20_harcoded(void)
-{
-	int node, i;
-	struct spu *last_spu, *spu;
-	u32 reg;
-
-	for (node = 0; node < MAX_NUMNODES; node++) {
-		last_spu = NULL;
-		for (i = 0; i < SPES_PER_BE; i++) {
-			reg = QS20_reg_idxs[i];
-			spu = spu_lookup_reg(node, reg);
-			if (!spu)
-				continue;
-			spu->has_mem_affinity = QS20_reg_memory[reg];
-			if (last_spu)
-				list_add_tail(&spu->aff_list,
-						&last_spu->aff_list);
-			last_spu = spu;
-		}
-	}
-}
-
-static int of_has_vicinity(void)
-{
-	struct spu* spu;
-
-	spu = list_entry(cbe_spu_info[0].spus.next, struct spu, cbe_list);
-	return of_find_property(spu_devnode(spu), "vicinity", NULL) != NULL;
-}
-
-static struct spu *aff_devnode_spu(int cbe, struct device_node *dn)
-{
-	struct spu *spu;
-
-	list_for_each_entry(spu, &cbe_spu_info[cbe].spus, cbe_list)
-		if (spu_devnode(spu) == dn)
-			return spu;
-	return NULL;
-}
-
-static struct spu *
-aff_node_next_to(int cbe, struct device_node *target, struct device_node *avoid)
-{
-	struct spu *spu;
-	const phandle *vic_handles;
-	int lenp, i;
-
-	list_for_each_entry(spu, &cbe_spu_info[cbe].spus, cbe_list) {
-		if (spu_devnode(spu) == avoid)
-			continue;
-		vic_handles = get_property(spu_devnode(spu), "vicinity", &lenp);
-		for (i=0; i < (lenp / sizeof(phandle)); i++) {
-			if (vic_handles[i] == target->linux_phandle)
-				return spu;
-		}
-	}
-	return NULL;
-}
-
-static void init_aff_fw_vicinity_node(int cbe)
-{
-	struct spu *spu, *last_spu;
-	struct device_node *vic_dn, *last_spu_dn;
-	phandle avoid_ph;
-	const phandle *vic_handles;
-	const char *name;
-	int lenp, i, added, mem_aff;
-
-	last_spu = list_entry(cbe_spu_info[cbe].spus.next, struct spu, cbe_list);
-	avoid_ph = 0;
-	for (added = 1; added < cbe_spu_info[cbe].n_spus; added++) {
-		last_spu_dn = spu_devnode(last_spu);
-		vic_handles = get_property(last_spu_dn, "vicinity", &lenp);
-
-		for (i = 0; i < (lenp / sizeof(phandle)); i++) {
-			if (vic_handles[i] == avoid_ph)
-				continue;
-
-			vic_dn = of_find_node_by_phandle(vic_handles[i]);
-			if (!vic_dn)
-				continue;
-
-			name = get_property(vic_dn, "name", NULL);
-			if (strcmp(name, "spe") == 0) {
-				spu = aff_devnode_spu(cbe, vic_dn);
-				avoid_ph = last_spu_dn->linux_phandle;
-			}
-			else {
-				mem_aff = strcmp(name, "mic-tm") == 0;
-				spu = aff_node_next_to(cbe, vic_dn, last_spu_dn);
-				if (!spu)
-					continue;
-				if (mem_aff) {
-					last_spu->has_mem_affinity = 1;
-					spu->has_mem_affinity = 1;
-				}
-				avoid_ph = vic_dn->linux_phandle;
-			}
-			list_add_tail(&spu->aff_list, &last_spu->aff_list);
-			last_spu = spu;
-			break;
-		}
-	}
-}
-
-static void init_aff_fw_vicinity(void)
-{
-	int cbe;
-
-	/* sets has_mem_affinity for each spu, as long as the
-	 * spu->aff_list list, linking each spu to its neighbors
-	 */
-	for (cbe = 0; cbe < MAX_NUMNODES; cbe++)
-		init_aff_fw_vicinity_node(cbe);
-}
-
 static int __init init_spu_base(void)
 {
 	int i, ret = 0;
@@ -811,13 +678,7 @@ static int __init init_spu_base(void)
 	mutex_unlock(&spu_full_list_mutex);
 	spu_add_sysdev_attr(&attr_stat);
 
-	if (of_has_vicinity()) {
-		init_aff_fw_vicinity();
-	} else {
-		long root = of_get_flat_dt_root();
-		if (of_flat_dt_is_compatible(root, "IBM,CPBW-1.0"))
-			init_aff_QS20_harcoded();
-	}
+	spu_init_affinity();
 
 	return 0;
 
--- a/arch/powerpc/platforms/cell/spu_manage.c
+++ b/arch/powerpc/platforms/cell/spu_manage.c
@@ -361,8 +361,171 @@ static int of_destroy_spu(struct spu *sp
 	return 0;
 }
 
+/* Hardcoded affinity idxs for qs20 */
+#define QS20_SPES_PER_BE 8
+static int qs20_reg_idxs[QS20_SPES_PER_BE] =   { 0, 2, 4, 6, 7, 5, 3, 1 };
+static int qs20_reg_memory[QS20_SPES_PER_BE] = { 1, 1, 0, 0, 0, 0, 0, 0 };
+
+static struct spu *spu_lookup_reg(int node, u32 reg)
+{
+	struct spu *spu;
+	u32 *spu_reg;
+
+	list_for_each_entry(spu, &cbe_spu_info[node].spus, cbe_list) {
+		spu_reg = (u32*)of_get_property(spu_devnode(spu), "reg", NULL);
+		if (*spu_reg == reg)
+			return spu;
+	}
+	return NULL;
+}
+
+static void init_affinity_qs20_harcoded(void)
+{
+	int node, i;
+	struct spu *last_spu, *spu;
+	u32 reg;
+
+	for (node = 0; node < MAX_NUMNODES; node++) {
+		last_spu = NULL;
+		for (i = 0; i < QS20_SPES_PER_BE; i++) {
+			reg = qs20_reg_idxs[i];
+			spu = spu_lookup_reg(node, reg);
+			if (!spu)
+				continue;
+			spu->has_mem_affinity = qs20_reg_memory[reg];
+			if (last_spu)
+				list_add_tail(&spu->aff_list,
+						&last_spu->aff_list);
+			last_spu = spu;
+		}
+	}
+}
+
+static int of_has_vicinity(void)
+{
+	struct spu* spu;
+
+	spu = list_first_entry(&cbe_spu_info[0].spus, struct spu, cbe_list);
+	return of_find_property(spu_devnode(spu), "vicinity", NULL) != NULL;
+}
+
+static struct spu *devnode_spu(int cbe, struct device_node *dn)
+{
+	struct spu *spu;
+
+	list_for_each_entry(spu, &cbe_spu_info[cbe].spus, cbe_list)
+		if (spu_devnode(spu) == dn)
+			return spu;
+	return NULL;
+}
+
+static struct spu *
+neighbour_spu(int cbe, struct device_node *target, struct device_node *avoid)
+{
+	struct spu *spu;
+	struct device_node *spu_dn;
+	const phandle *vic_handles;
+	int lenp, i;
+
+	list_for_each_entry(spu, &cbe_spu_info[cbe].spus, cbe_list) {
+		spu_dn = spu_devnode(spu);
+		if (spu_dn == avoid)
+			continue;
+		vic_handles = of_get_property(spu_dn, "vicinity", &lenp);
+		for (i=0; i < (lenp / sizeof(phandle)); i++) {
+			if (vic_handles[i] == target->linux_phandle)
+				return spu;
+		}
+	}
+	return NULL;
+}
+
+static void init_affinity_node(int cbe)
+{
+	struct spu *spu, *last_spu;
+	struct device_node *vic_dn, *last_spu_dn;
+	phandle avoid_ph;
+	const phandle *vic_handles;
+	const char *name;
+	int lenp, i, added;
+
+	last_spu = list_first_entry(&cbe_spu_info[cbe].spus, struct spu,
+								cbe_list);
+	avoid_ph = 0;
+	for (added = 1; added < cbe_spu_info[cbe].n_spus; added++) {
+		last_spu_dn = spu_devnode(last_spu);
+		vic_handles = of_get_property(last_spu_dn, "vicinity", &lenp);
+
+		/*
+		 * Walk through each phandle in vicinity property of the spu
+		 * (tipically two vicinity phandles per spe node)
+		 */
+		for (i = 0; i < (lenp / sizeof(phandle)); i++) {
+			if (vic_handles[i] == avoid_ph)
+				continue;
+
+			vic_dn = of_find_node_by_phandle(vic_handles[i]);
+			if (!vic_dn)
+				continue;
+
+			/* a neighbour might be spe, mic-tm, or bif0 */
+			name = of_get_property(vic_dn, "name", NULL);
+			if (!name)
+				continue;
+
+			if (strcmp(name, "spe") == 0) {
+				spu = devnode_spu(cbe, vic_dn);
+				avoid_ph = last_spu_dn->linux_phandle;
+			} else {
+				/*
+				 * "mic-tm" and "bif0" nodes do not have
+				 * vicinity property. So we need to find the
+				 * spe which has vic_dn as neighbour, but
+				 * skipping the one we came from (last_spu_dn)
+				 */
+				spu = neighbour_spu(cbe, vic_dn, last_spu_dn);
+				if (!spu)
+					continue;
+				if (!strcmp(name, "mic-tm")) {
+					last_spu->has_mem_affinity = 1;
+					spu->has_mem_affinity = 1;
+				}
+				avoid_ph = vic_dn->linux_phandle;
+			}
+
+			list_add_tail(&spu->aff_list, &last_spu->aff_list);
+			last_spu = spu;
+			break;
+		}
+	}
+}
+
+static void init_affinity_fw(void)
+{
+	int cbe;
+
+	for (cbe = 0; cbe < MAX_NUMNODES; cbe++)
+		init_affinity_node(cbe);
+}
+
+static int __init init_affinity(void)
+{
+	if (of_has_vicinity()) {
+		init_affinity_fw();
+	} else {
+		long root = of_get_flat_dt_root();
+		if (of_flat_dt_is_compatible(root, "IBM,CPBW-1.0"))
+			init_affinity_qs20_harcoded();
+		else
+			printk("No affinity configuration found");
+	}
+
+	return 0;
+}
+
 const struct spu_management_ops spu_management_of_ops = {
 	.enumerate_spus = of_enumerate_spus,
 	.create_spu = of_create_spu,
 	.destroy_spu = of_destroy_spu,
+	.init_affinity = init_affinity,
 };
--- a/arch/powerpc/platforms/ps3/spu.c
+++ b/arch/powerpc/platforms/ps3/spu.c
@@ -414,10 +414,16 @@ static int __init ps3_enumerate_spus(int
 	return num_resource_id;
 }
 
+static int ps3_init_affinity(void)
+{
+	return 0;
+}
+
 const struct spu_management_ops spu_management_ps3_ops = {
 	.enumerate_spus = ps3_enumerate_spus,
 	.create_spu = ps3_create_spu,
 	.destroy_spu = ps3_destroy_spu,
+	.init_affinity = ps3_init_affinity,
 };
 
 /* spu_priv1_ops */
--- a/include/asm-powerpc/spu_priv1.h
+++ b/include/asm-powerpc/spu_priv1.h
@@ -178,6 +178,7 @@ struct spu_management_ops {
 	int (*enumerate_spus)(int (*fn)(void *data));
 	int (*create_spu)(struct spu *spu, void *data);
 	int (*destroy_spu)(struct spu *spu);
+	int (*init_affinity)(void);
 };
 
 extern const struct spu_management_ops* spu_management_ops;
@@ -200,6 +201,12 @@ spu_destroy_spu (struct spu *spu)
 	return spu_management_ops->destroy_spu(spu);
 }
 
+static inline int
+spu_init_affinity (void)
+{
+	return spu_management_ops->init_affinity();
+}
+
 /*
  * The declarations folowing are put here for convenience
  * and only intended to be used by the platform setup code.
