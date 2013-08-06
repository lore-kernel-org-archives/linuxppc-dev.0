Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 10/63] powerpc: Make prom.c device tree accesses endian safe
Date: Wed,  7 Aug 2013 02:01:27 +1000
Message-Id: <1375804940-22050-11-git-send-email-anton@samba.org>
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

From: Ian Munsie <imunsie@au1.ibm.com>

On PowerPC the device tree is always big endian, but the CPU could be
either, so add be32_to_cpu where appropriate and change the types of
device tree data to __be32 etc to allow sparse to locate endian issues.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/kernel/prom.c | 60 ++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index eb23ac9..d072f67 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -215,16 +215,16 @@ static void __init check_cpu_pa_features(unsigned long node)
 #ifdef CONFIG_PPC_STD_MMU_64
 static void __init check_cpu_slb_size(unsigned long node)
 {
-	u32 *slb_size_ptr;
+	__be32 *slb_size_ptr;
 
 	slb_size_ptr = of_get_flat_dt_prop(node, "slb-size", NULL);
 	if (slb_size_ptr != NULL) {
-		mmu_slb_size = *slb_size_ptr;
+		mmu_slb_size = be32_to_cpup(slb_size_ptr);
 		return;
 	}
 	slb_size_ptr = of_get_flat_dt_prop(node, "ibm,slb-size", NULL);
 	if (slb_size_ptr != NULL) {
-		mmu_slb_size = *slb_size_ptr;
+		mmu_slb_size = be32_to_cpup(slb_size_ptr);
 	}
 }
 #else
@@ -279,11 +279,11 @@ static void __init check_cpu_feature_properties(unsigned long node)
 {
 	unsigned long i;
 	struct feature_property *fp = feature_properties;
-	const u32 *prop;
+	const __be32 *prop;
 
 	for (i = 0; i < ARRAY_SIZE(feature_properties); ++i, ++fp) {
 		prop = of_get_flat_dt_prop(node, fp->name, NULL);
-		if (prop && *prop >= fp->min_value) {
+		if (prop && be32_to_cpup(prop) >= fp->min_value) {
 			cur_cpu_spec->cpu_features |= fp->cpu_feature;
 			cur_cpu_spec->cpu_user_features |= fp->cpu_user_ftr;
 		}
@@ -295,8 +295,8 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 					  void *data)
 {
 	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
-	const u32 *prop;
-	const u32 *intserv;
+	const __be32 *prop;
+	const __be32 *intserv;
 	int i, nthreads;
 	unsigned long len;
 	int found = -1;
@@ -324,8 +324,9 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 		 * version 2 of the kexec param format adds the phys cpuid of
 		 * booted proc.
 		 */
-		if (initial_boot_params->version >= 2) {
-			if (intserv[i] == initial_boot_params->boot_cpuid_phys) {
+		if (be32_to_cpu(initial_boot_params->version) >= 2) {
+			if (be32_to_cpu(intserv[i]) ==
+			    be32_to_cpu(initial_boot_params->boot_cpuid_phys)) {
 				found = boot_cpu_count;
 				found_thread = i;
 			}
@@ -347,9 +348,10 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 
 	if (found >= 0) {
 		DBG("boot cpu: logical %d physical %d\n", found,
-			intserv[found_thread]);
+			be32_to_cpu(intserv[found_thread]));
 		boot_cpuid = found;
-		set_hard_smp_processor_id(found, intserv[found_thread]);
+		set_hard_smp_processor_id(found,
+			be32_to_cpu(intserv[found_thread]));
 
 		/*
 		 * PAPR defines "logical" PVR values for cpus that
@@ -366,8 +368,8 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 		 * it uses 0x0f000001.
 		 */
 		prop = of_get_flat_dt_prop(node, "cpu-version", NULL);
-		if (prop && (*prop & 0xff000000) == 0x0f000000)
-			identify_cpu(0, *prop);
+		if (prop && (be32_to_cpup(prop) & 0xff000000) == 0x0f000000)
+			identify_cpu(0, be32_to_cpup(prop));
 
 		identical_pvr_fixup(node);
 	}
@@ -389,7 +391,7 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
 int __init early_init_dt_scan_chosen_ppc(unsigned long node, const char *uname,
 					 int depth, void *data)
 {
-	unsigned long *lprop;
+	unsigned long *lprop; /* All these set by kernel, so no need to convert endian */
 
 	/* Use common scan routine to determine if this is the chosen node */
 	if (early_init_dt_scan_chosen(node, uname, depth, data) == 0)
@@ -591,16 +593,16 @@ static void __init early_reserve_mem_dt(void)
 static void __init early_reserve_mem(void)
 {
 	u64 base, size;
-	u64 *reserve_map;
+	__be64 *reserve_map;
 	unsigned long self_base;
 	unsigned long self_size;
 
-	reserve_map = (u64 *)(((unsigned long)initial_boot_params) +
-					initial_boot_params->off_mem_rsvmap);
+	reserve_map = (__be64 *)(((unsigned long)initial_boot_params) +
+			be32_to_cpu(initial_boot_params->off_mem_rsvmap));
 
 	/* before we do anything, lets reserve the dt blob */
 	self_base = __pa((unsigned long)initial_boot_params);
-	self_size = initial_boot_params->totalsize;
+	self_size = be32_to_cpu(initial_boot_params->totalsize);
 	memblock_reserve(self_base, self_size);
 
 	/* Look for the new "reserved-regions" property in the DT */
@@ -620,15 +622,15 @@ static void __init early_reserve_mem(void)
 	 * Handle the case where we might be booting from an old kexec
 	 * image that setup the mem_rsvmap as pairs of 32-bit values
 	 */
-	if (*reserve_map > 0xffffffffull) {
+	if (be64_to_cpup(reserve_map) > 0xffffffffull) {
 		u32 base_32, size_32;
-		u32 *reserve_map_32 = (u32 *)reserve_map;
+		__be32 *reserve_map_32 = (__be32 *)reserve_map;
 
 		DBG("Found old 32-bit reserve map\n");
 
 		while (1) {
-			base_32 = *(reserve_map_32++);
-			size_32 = *(reserve_map_32++);
+			base_32 = be32_to_cpup(reserve_map_32++);
+			size_32 = be32_to_cpup(reserve_map_32++);
 			if (size_32 == 0)
 				break;
 			/* skip if the reservation is for the blob */
@@ -644,8 +646,8 @@ static void __init early_reserve_mem(void)
 
 	/* Handle the reserve map in the fdt blob if it exists */
 	while (1) {
-		base = *(reserve_map++);
-		size = *(reserve_map++);
+		base = be64_to_cpup(reserve_map++);
+		size = be64_to_cpup(reserve_map++);
 		if (size == 0)
 			break;
 		DBG("reserving: %llx -> %llx\n", base, size);
@@ -877,7 +879,7 @@ struct device_node *of_get_cpu_node(int cpu, unsigned int *thread)
 	hardid = get_hard_smp_processor_id(cpu);
 
 	for_each_node_by_type(np, "cpu") {
-		const u32 *intserv;
+		const __be32 *intserv;
 		unsigned int plen, t;
 
 		/* Check for ibm,ppc-interrupt-server#s. If it doesn't exist
@@ -886,10 +888,10 @@ struct device_node *of_get_cpu_node(int cpu, unsigned int *thread)
 		intserv = of_get_property(np, "ibm,ppc-interrupt-server#s",
 				&plen);
 		if (intserv == NULL) {
-			const u32 *reg = of_get_property(np, "reg", NULL);
+			const __be32 *reg = of_get_property(np, "reg", NULL);
 			if (reg == NULL)
 				continue;
-			if (*reg == hardid) {
+			if (be32_to_cpup(reg) == hardid) {
 				if (thread)
 					*thread = 0;
 				return np;
@@ -897,7 +899,7 @@ struct device_node *of_get_cpu_node(int cpu, unsigned int *thread)
 		} else {
 			plen /= sizeof(u32);
 			for (t = 0; t < plen; t++) {
-				if (hardid == intserv[t]) {
+				if (hardid == be32_to_cpu(intserv[t])) {
 					if (thread)
 						*thread = t;
 					return np;
@@ -917,7 +919,7 @@ static int __init export_flat_device_tree(void)
 	struct dentry *d;
 
 	flat_dt_blob.data = initial_boot_params;
-	flat_dt_blob.size = initial_boot_params->totalsize;
+	flat_dt_blob.size = be32_to_cpu(initial_boot_params->totalsize);
 
 	d = debugfs_create_blob("flat-device-tree", S_IFREG | S_IRUSR,
 				powerpc_debugfs_root, &flat_dt_blob);
-- 
1.8.1.2
