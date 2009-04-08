Return-Path: <tony@thor.ozlabs.ibm.com>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D63C2DE0C9
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 14:36:36 +1000 (EST)
Received: from thor.ozlabs.ibm.com (localhost [127.0.0.1])
	by bilbo.ozlabs.org (Postfix) with ESMTP id B8935B6F35
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 14:36:36 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
Message-Id: <2c4bcf8d1d7083ff53ce5b556765e96676a007fb.1239165378.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH] Quieten arch/powerpc in a allmodconfig build.
Date: Wed,  8 Apr 2009 14:36:36 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch silences all the warnings generated in arch/powerpc for
allmodconfig build.

It does:
 * Where appropriate use the uninitialized_var() macro to help GCC
   understand we know what's going on.
 * Explicitly casts PHYSICAL_START in one printk()
 * Initialise a few variables, as it's "neater" than using uninitialized_var()

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
Only compile tested.

 arch/powerpc/kernel/cacheinfo.c           |    4 ++--
 arch/powerpc/kernel/pci_dn.c              |    2 +-
 arch/powerpc/kernel/setup_64.c            |    4 ++--
 arch/powerpc/platforms/cell/axon_msi.c    |    2 +-
 arch/powerpc/platforms/cell/beat_iommu.c  |    2 +-
 arch/powerpc/platforms/iseries/pci.c      |   24 ++++++++++++------------
 arch/powerpc/platforms/powermac/low_i2c.c |    5 ++---
 arch/powerpc/platforms/pseries/msi.c      |    2 +-
 8 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
index bb37b1d..fd6aef9 100644
--- a/arch/powerpc/kernel/cacheinfo.c
+++ b/arch/powerpc/kernel/cacheinfo.c
@@ -510,7 +510,7 @@ static struct cache *index_kobj_to_cache(struct kobject *k)
 
 static ssize_t size_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
 {
-	unsigned int size_kb;
+	unsigned int uninitialized_var(size_kb);
 	struct cache *cache;
 
 	cache = index_kobj_to_cache(k);
@@ -559,7 +559,7 @@ static struct kobj_attribute cache_nr_sets_attr =
 
 static ssize_t associativity_show(struct kobject *k, struct kobj_attribute *attr, char *buf)
 {
-	unsigned int associativity;
+	unsigned int uninitialized_var(associativity);
 	struct cache *cache;
 
 	cache = index_kobj_to_cache(k);
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 1c67de5..b9d66ed 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -83,7 +83,7 @@ void *traverse_pci_devices(struct device_node *start, traverse_func pre,
 		void *data)
 {
 	struct device_node *dn, *nextdn;
-	void *ret;
+	void *uninitialized_var(ret);
 
 	/* We started with a phb, iterate all childs */
 	for (dn = start->child; dn; dn = nextdn) {
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index c410c60..38968f1 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -421,8 +421,8 @@ void __init setup_system(void)
 		printk("htab_address                  = 0x%p\n", htab_address);
 	printk("htab_hash_mask                = 0x%lx\n", htab_hash_mask);
 	if (PHYSICAL_START > 0)
-		printk("physical_start                = 0x%lx\n",
-		       PHYSICAL_START);
+		printk("physical_start                = 0x%llx\n",
+		       (unsigned long long)PHYSICAL_START);
 	printk("-----------------------------------------------------\n");
 
 	DBG(" <- setup_system()\n");
diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
index 0ce45c2..dae4c7c 100644
--- a/arch/powerpc/platforms/cell/axon_msi.c
+++ b/arch/powerpc/platforms/cell/axon_msi.c
@@ -151,7 +151,7 @@ static struct axon_msic *find_msi_translator(struct pci_dev *dev)
 {
 	struct irq_host *irq_host;
 	struct device_node *dn, *tmp;
-	const phandle *ph;
+	const phandle *uninitialized_var(ph);
 	struct axon_msic *msic = NULL;
 
 	dn = of_node_get(pci_device_to_OF_node(dev));
diff --git a/arch/powerpc/platforms/cell/beat_iommu.c b/arch/powerpc/platforms/cell/beat_iommu.c
index 93b0efd..8230cd8 100644
--- a/arch/powerpc/platforms/cell/beat_iommu.c
+++ b/arch/powerpc/platforms/cell/beat_iommu.c
@@ -57,7 +57,7 @@ static unsigned long celleb_dma_direct_offset;
 static void __init celleb_init_direct_mapping(void)
 {
 	u64 lpar_addr, io_addr;
-	u64 io_space_id, ioid, dma_base, dma_size, io_page_size;
+	u64 io_space_id=0, ioid=0, dma_base=0, dma_size=0, io_page_size=0;
 
 	if (!find_dma_window(&io_space_id, &ioid, &dma_base, &dma_size,
 			     &io_page_size)) {
diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
index 02a634f..05f047d 100644
--- a/arch/powerpc/platforms/iseries/pci.c
+++ b/arch/powerpc/platforms/iseries/pci.c
@@ -616,8 +616,8 @@ static inline struct device_node *xlate_iomm_address(
  */
 static u8 iseries_readb(const volatile void __iomem *addr)
 {
-	u64 bar_offset;
-	u64 dsa;
+	u64 uninitialized_var(bar_offset);
+	u64 uninitialized_var(dsa);
 	int retry = 0;
 	struct HvCallPci_LoadReturn ret;
 	struct device_node *dn =
@@ -634,8 +634,8 @@ static u8 iseries_readb(const volatile void __iomem *addr)
 
 static u16 iseries_readw_be(const volatile void __iomem *addr)
 {
-	u64 bar_offset;
-	u64 dsa;
+	u64 uninitialized_var(bar_offset);
+	u64 uninitialized_var(dsa);
 	int retry = 0;
 	struct HvCallPci_LoadReturn ret;
 	struct device_node *dn =
@@ -653,8 +653,8 @@ static u16 iseries_readw_be(const volatile void __iomem *addr)
 
 static u32 iseries_readl_be(const volatile void __iomem *addr)
 {
-	u64 bar_offset;
-	u64 dsa;
+	u64 uninitialized_var(bar_offset);
+	u64 uninitialized_var(dsa);
 	int retry = 0;
 	struct HvCallPci_LoadReturn ret;
 	struct device_node *dn =
@@ -676,8 +676,8 @@ static u32 iseries_readl_be(const volatile void __iomem *addr)
  */
 static void iseries_writeb(u8 data, volatile void __iomem *addr)
 {
-	u64 bar_offset;
-	u64 dsa;
+	u64 uninitialized_var(bar_offset);
+	u64 uninitialized_var(dsa);
 	int retry = 0;
 	u64 rc;
 	struct device_node *dn =
@@ -692,8 +692,8 @@ static void iseries_writeb(u8 data, volatile void __iomem *addr)
 
 static void iseries_writew_be(u16 data, volatile void __iomem *addr)
 {
-	u64 bar_offset;
-	u64 dsa;
+	u64 uninitialized_var(bar_offset);
+	u64 uninitialized_var(dsa);
 	int retry = 0;
 	u64 rc;
 	struct device_node *dn =
@@ -708,8 +708,8 @@ static void iseries_writew_be(u16 data, volatile void __iomem *addr)
 
 static void iseries_writel_be(u32 data, volatile void __iomem *addr)
 {
-	u64 bar_offset;
-	u64 dsa;
+	u64 uninitialized_var(bar_offset);
+	u64 uninitialized_var(dsa);
 	int retry = 0;
 	u64 rc;
 	struct device_node *dn =
diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index 21226b7..5989427 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -1090,7 +1090,7 @@ EXPORT_SYMBOL_GPL(pmac_low_i2c_unlock);
 
 int pmac_i2c_open(struct pmac_i2c_bus *bus, int polled)
 {
-	int rc;
+	int rc = 0;
 
 	mutex_lock(&bus->mutex);
 	bus->polled = polled || pmac_i2c_force_poll;
@@ -1099,9 +1099,8 @@ int pmac_i2c_open(struct pmac_i2c_bus *bus, int polled)
 	if (bus->open && (rc = bus->open(bus)) != 0) {
 		bus->opened = 0;
 		mutex_unlock(&bus->mutex);
-		return rc;
 	}
-	return 0;
+	return rc;
 }
 EXPORT_SYMBOL_GPL(pmac_i2c_open);
 
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index bf2e1ac..d92f593 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -282,7 +282,7 @@ static int msi_quota_for_device(struct pci_dev *dev, int request)
 {
 	struct device_node *pe_dn;
 	struct msi_counts counts;
-	int total;
+	int uninitialized_var(total);
 
 	pr_debug("rtas_msi: calc quota for %s, request %d\n", pci_name(dev),
 		  request);
-- 
1.6.0.6
