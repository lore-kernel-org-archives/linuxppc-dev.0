Return-Path: <dmitry.torokhov@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCmQr2MYNzDqC3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 12:54:44 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id 75so32585279pgf.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 17:54:44 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 Kumar Gala <galak@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] powerpc: make use of for_each_node_by_type() instead of
 open-coding it
Date: Tue, 31 Jan 2017 17:54:38 -0800
Message-Id: <20170201015438.18826-2-dmitry.torokhov@gmail.com>
In-Reply-To: <20170201015438.18826-1-dmitry.torokhov@gmail.com>
References: <20170201015438.18826-1-dmitry.torokhov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of manually coding the loop with of_find_node_by_type(), let's
switch to the standard macro for iterating over nodes with given type.

Also fixed a couple of refcount leaks in the aforementioned loops.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/powerpc/kernel/setup-common.c       | 9 +++++++--
 arch/powerpc/platforms/cell/spu_manage.c | 4 ++--
 arch/powerpc/platforms/powermac/pic.c    | 7 ++++---
 arch/powerpc/platforms/powermac/smp.c    | 4 ++--
 arch/powerpc/platforms/pseries/lparcfg.c | 4 ++--
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index f516ac508ae3..4a36360c0a67 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -452,13 +452,13 @@ static void __init cpu_init_thread_core_maps(int tpc)
  */
 void __init smp_setup_cpu_maps(void)
 {
-	struct device_node *dn = NULL;
+	struct device_node *dn;
 	int cpu = 0;
 	int nthreads = 1;
 
 	DBG("smp_setup_cpu_maps()\n");
 
-	while ((dn = of_find_node_by_type(dn, "cpu")) && cpu < nr_cpu_ids) {
+	for_each_node_by_type(dn, "cpu") {
 		const __be32 *intserv;
 		__be32 cpu_be;
 		int j, len;
@@ -498,6 +498,11 @@ void __init smp_setup_cpu_maps(void)
 			set_cpu_possible(cpu, true);
 			cpu++;
 		}
+
+		if (cpu >= nr_cpu_ids) {
+			of_node_put(dn);
+			break;
+		}
 	}
 
 	/* If no SMT supported, nthreads is forced to 1 */
diff --git a/arch/powerpc/platforms/cell/spu_manage.c b/arch/powerpc/platforms/cell/spu_manage.c
index 672d310dcf14..4a28d647911c 100644
--- a/arch/powerpc/platforms/cell/spu_manage.c
+++ b/arch/powerpc/platforms/cell/spu_manage.c
@@ -292,12 +292,12 @@ static int __init of_enumerate_spus(int (*fn)(void *data))
 	unsigned int n = 0;
 
 	ret = -ENODEV;
-	for (node = of_find_node_by_type(NULL, "spe");
-			node; node = of_find_node_by_type(node, "spe")) {
+	for_each_node_by_type(node, "spe") {
 		ret = fn(node);
 		if (ret) {
 			printk(KERN_WARNING "%s: Error initializing %s\n",
 				__func__, node->name);
+			of_node_put(node);
 			break;
 		}
 		n++;
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index f5f9ad7c3398..057c0c4003ae 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -486,15 +486,16 @@ static int __init pmac_pic_probe_mpic(void)
 	struct device_node *np, *master = NULL, *slave = NULL;
 
 	/* We can have up to 2 MPICs cascaded */
-	for (np = NULL; (np = of_find_node_by_type(np, "open-pic"))
-		     != NULL;) {
+	for_each_node_by_type(np, "open-pic") {
 		if (master == NULL &&
 		    of_get_property(np, "interrupts", NULL) == NULL)
 			master = of_node_get(np);
 		else if (slave == NULL)
 			slave = of_node_get(np);
-		if (master && slave)
+		if (master && slave) {
+			of_node_put(np);
 			break;
+		}
 	}
 
 	/* Check for bogus setups */
diff --git a/arch/powerpc/platforms/powermac/smp.c b/arch/powerpc/platforms/powermac/smp.c
index c9eb7d6540ea..1109850d12bd 100644
--- a/arch/powerpc/platforms/powermac/smp.c
+++ b/arch/powerpc/platforms/powermac/smp.c
@@ -772,8 +772,8 @@ static void __init smp_core99_probe(void)
 	if (ppc_md.progress) ppc_md.progress("smp_core99_probe", 0x345);
 
 	/* Count CPUs in the device-tree */
-       	for (cpus = NULL; (cpus = of_find_node_by_type(cpus, "cpu")) != NULL;)
-	       	++ncpus;
+	for_each_node_by_type(cpus, "cpu")
+		++ncpus;
 
 	printk(KERN_INFO "PowerMac SMP probe found %d cpus\n", ncpus);
 
diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index 779fc2a1c8f7..1c1668c6b8c7 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -370,10 +370,10 @@ static void parse_system_parameter_string(struct seq_file *m)
  */
 static int lparcfg_count_active_processors(void)
 {
-	struct device_node *cpus_dn = NULL;
+	struct device_node *cpus_dn;
 	int count = 0;
 
-	while ((cpus_dn = of_find_node_by_type(cpus_dn, "cpu"))) {
+	for_each_node_by_type(cpus_dn, "cpu") {
 #ifdef LPARCFG_DEBUG
 		printk(KERN_ERR "cpus_dn %p\n", cpus_dn);
 #endif
-- 
2.11.0.483.g087da7b7c-goog
