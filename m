Return-Path: <anton@samba.org>
Date: Wed, 22 Jan 2014 08:40:28 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Fix endian issues in kexec and crash dump code
Message-ID: <20140122084028.62e6a6b2@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


We expose a number of OF properties in the kexec and crash dump code
and these need to be big endian.

Cc: stable@vger.kernel.org # v3.13
Signed-off-by: Anton Blanchard <anton@samba.org>
--

diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index 75d4f73..015ae55 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -196,7 +196,9 @@ int overlaps_crashkernel(unsigned long start, unsigned long size)
 
 /* Values we need to export to the second kernel via the device tree. */
 static phys_addr_t kernel_end;
+static phys_addr_t crashk_base;
 static phys_addr_t crashk_size;
+static unsigned long long mem_limit;
 
 static struct property kernel_end_prop = {
 	.name = "linux,kernel-end",
@@ -207,7 +209,7 @@ static struct property kernel_end_prop = {
 static struct property crashk_base_prop = {
 	.name = "linux,crashkernel-base",
 	.length = sizeof(phys_addr_t),
-	.value = &crashk_res.start,
+	.value = &crashk_base
 };
 
 static struct property crashk_size_prop = {
@@ -219,9 +221,11 @@ static struct property crashk_size_prop = {
 static struct property memory_limit_prop = {
 	.name = "linux,memory-limit",
 	.length = sizeof(unsigned long long),
-	.value = &memory_limit,
+	.value = &mem_limit,
 };
 
+#define cpu_to_be_ulong	__PASTE(cpu_to_be, BITS_PER_LONG)
+
 static void __init export_crashk_values(struct device_node *node)
 {
 	struct property *prop;
@@ -237,8 +241,9 @@ static void __init export_crashk_values(struct device_node *node)
 		of_remove_property(node, prop);
 
 	if (crashk_res.start != 0) {
+		crashk_base = cpu_to_be_ulong(crashk_res.start),
 		of_add_property(node, &crashk_base_prop);
-		crashk_size = resource_size(&crashk_res);
+		crashk_size = cpu_to_be_ulong(resource_size(&crashk_res));
 		of_add_property(node, &crashk_size_prop);
 	}
 
@@ -246,6 +251,7 @@ static void __init export_crashk_values(struct device_node *node)
 	 * memory_limit is required by the kexec-tools to limit the
 	 * crash regions to the actual memory used.
 	 */
+	mem_limit = cpu_to_be_ulong(memory_limit);
 	of_update_property(node, &memory_limit_prop);
 }
 
@@ -264,7 +270,7 @@ static int __init kexec_setup(void)
 		of_remove_property(node, prop);
 
 	/* information needed by userspace when using default_machine_kexec */
-	kernel_end = __pa(_end);
+	kernel_end = cpu_to_be_ulong(__pa(_end));
 	of_add_property(node, &kernel_end_prop);
 
 	export_crashk_values(node);
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index be4e6d6..59d229a 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -369,6 +369,7 @@ void default_machine_kexec(struct kimage *image)
 
 /* Values we need to export to the second kernel via the device tree. */
 static unsigned long htab_base;
+static unsigned long htab_size;
 
 static struct property htab_base_prop = {
 	.name = "linux,htab-base",
@@ -379,7 +380,7 @@ static struct property htab_base_prop = {
 static struct property htab_size_prop = {
 	.name = "linux,htab-size",
 	.length = sizeof(unsigned long),
-	.value = &htab_size_bytes,
+	.value = &htab_size,
 };
 
 static int __init export_htab_values(void)
@@ -403,8 +404,9 @@ static int __init export_htab_values(void)
 	if (prop)
 		of_remove_property(node, prop);
 
-	htab_base = __pa(htab_address);
+	htab_base = cpu_to_be64(__pa(htab_address));
 	of_add_property(node, &htab_base_prop);
+	htab_size = cpu_to_be64(htab_size_bytes);
 	of_add_property(node, &htab_size_prop);
 
 	of_node_put(node);
