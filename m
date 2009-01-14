Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 14 Jan 2009 16:58:10 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [PATCH 02/13] powerpc/ps3: use dma_addr_t down through the stack
Message-Id: <20090114165810.a6a6c3ab.sfr@canb.auug.org.au>
In-Reply-To: <20090114165450.ebbc11a7.sfr@canb.auug.org.au>
References: <20090114165450.ebbc11a7.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Push the dma_addr_t type usage all the way down to where the actual
values are manipulated.

Now that u64 is "unsigned long long", this removes warnings like:

arch/powerpc/platforms/ps3/system-bus.c:532: warning: passing argument 4 of 'ps3_dma_map' from incompatible pointer type
arch/powerpc/platforms/ps3/system-bus.c:649: warning: passing argument 4 of 'ps3_dma_map' from incompatible pointer type

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/asm/ps3.h          |    8 +++---
 arch/powerpc/platforms/ps3/mm.c         |   32 ++++++++++++++++--------------
 arch/powerpc/platforms/ps3/system-bus.c |    4 +-
 3 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/ps3.h b/arch/powerpc/include/asm/ps3.h
index eead5c6..67f1812 100644
--- a/arch/powerpc/include/asm/ps3.h
+++ b/arch/powerpc/include/asm/ps3.h
@@ -103,10 +103,10 @@ struct ps3_dma_region_ops {
 	int (*map)(struct ps3_dma_region *,
 		   unsigned long virt_addr,
 		   unsigned long len,
-		   unsigned long *bus_addr,
+		   dma_addr_t *bus_addr,
 		   u64 iopte_pp);
 	int (*unmap)(struct ps3_dma_region *,
-		     unsigned long bus_addr,
+		     dma_addr_t bus_addr,
 		     unsigned long len);
 };
 /**
@@ -124,9 +124,9 @@ int ps3_dma_region_init(struct ps3_system_bus_device *dev,
 int ps3_dma_region_create(struct ps3_dma_region *r);
 int ps3_dma_region_free(struct ps3_dma_region *r);
 int ps3_dma_map(struct ps3_dma_region *r, unsigned long virt_addr,
-	unsigned long len, unsigned long *bus_addr,
+	unsigned long len, dma_addr_t *bus_addr,
 	u64 iopte_pp);
-int ps3_dma_unmap(struct ps3_dma_region *r, unsigned long bus_addr,
+int ps3_dma_unmap(struct ps3_dma_region *r, dma_addr_t bus_addr,
 	unsigned long len);
 
 /* mmio routines */
diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
index a4d49dd..4761e2d 100644
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -777,7 +777,7 @@ static int dma_ioc0_region_free(struct ps3_dma_region *r)
  */
 
 static int dma_sb_map_area(struct ps3_dma_region *r, unsigned long virt_addr,
-	   unsigned long len, unsigned long *bus_addr,
+	   unsigned long len, dma_addr_t *bus_addr,
 	   u64 iopte_flag)
 {
 	int result;
@@ -800,7 +800,7 @@ static int dma_sb_map_area(struct ps3_dma_region *r, unsigned long virt_addr,
 		DBG("%s:%d lpar_addr %lxh\n", __func__, __LINE__,
 			lpar_addr);
 		DBG("%s:%d len       %lxh\n", __func__, __LINE__, len);
-		DBG("%s:%d bus_addr  %lxh (%lxh)\n", __func__, __LINE__,
+		DBG("%s:%d bus_addr  %llxh (%lxh)\n", __func__, __LINE__,
 		*bus_addr, len);
 	}
 
@@ -832,7 +832,7 @@ static int dma_sb_map_area(struct ps3_dma_region *r, unsigned long virt_addr,
 }
 
 static int dma_ioc0_map_area(struct ps3_dma_region *r, unsigned long virt_addr,
-	     unsigned long len, unsigned long *bus_addr,
+	     unsigned long len, dma_addr_t *bus_addr,
 	     u64 iopte_flag)
 {
 	int result;
@@ -872,7 +872,7 @@ static int dma_ioc0_map_area(struct ps3_dma_region *r, unsigned long virt_addr,
 		return result;
 	}
 	*bus_addr = c->bus_addr + phys_addr - aligned_phys;
-	DBG("%s: va=%#lx pa=%#lx a_pa=%#lx bus=%#lx\n", __func__,
+	DBG("%s: va=%#lx pa=%#lx a_pa=%#lx bus=%#llx\n", __func__,
 	    virt_addr, phys_addr, aligned_phys, *bus_addr);
 	c->usage_count = 1;
 
@@ -889,7 +889,7 @@ static int dma_ioc0_map_area(struct ps3_dma_region *r, unsigned long virt_addr,
  * This is the common dma unmap routine.
  */
 
-static int dma_sb_unmap_area(struct ps3_dma_region *r, unsigned long bus_addr,
+static int dma_sb_unmap_area(struct ps3_dma_region *r, dma_addr_t bus_addr,
 	unsigned long len)
 {
 	unsigned long flags;
@@ -903,7 +903,7 @@ static int dma_sb_unmap_area(struct ps3_dma_region *r, unsigned long bus_addr,
 			1 << r->page_size);
 		unsigned long aligned_len = _ALIGN_UP(len + bus_addr
 			- aligned_bus, 1 << r->page_size);
-		DBG("%s:%d: not found: bus_addr %lxh\n",
+		DBG("%s:%d: not found: bus_addr %llxh\n",
 			__func__, __LINE__, bus_addr);
 		DBG("%s:%d: not found: len %lxh\n",
 			__func__, __LINE__, len);
@@ -926,12 +926,12 @@ static int dma_sb_unmap_area(struct ps3_dma_region *r, unsigned long bus_addr,
 }
 
 static int dma_ioc0_unmap_area(struct ps3_dma_region *r,
-			unsigned long bus_addr, unsigned long len)
+			dma_addr_t bus_addr, unsigned long len)
 {
 	unsigned long flags;
 	struct dma_chunk *c;
 
-	DBG("%s: start a=%#lx l=%#lx\n", __func__, bus_addr, len);
+	DBG("%s: start a=%#llx l=%#lx\n", __func__, bus_addr, len);
 	spin_lock_irqsave(&r->chunk_list.lock, flags);
 	c = dma_find_chunk(r, bus_addr, len);
 
@@ -941,7 +941,7 @@ static int dma_ioc0_unmap_area(struct ps3_dma_region *r,
 		unsigned long aligned_len = _ALIGN_UP(len + bus_addr
 						      - aligned_bus,
 						      1 << r->page_size);
-		DBG("%s:%d: not found: bus_addr %lxh\n",
+		DBG("%s:%d: not found: bus_addr %llxh\n",
 		    __func__, __LINE__, bus_addr);
 		DBG("%s:%d: not found: len %lxh\n",
 		    __func__, __LINE__, len);
@@ -975,7 +975,8 @@ static int dma_ioc0_unmap_area(struct ps3_dma_region *r,
 static int dma_sb_region_create_linear(struct ps3_dma_region *r)
 {
 	int result;
-	unsigned long virt_addr, len, tmp;
+	unsigned long virt_addr, len;
+	dma_addr_t tmp;
 
 	if (r->len > 16*1024*1024) {	/* FIXME: need proper fix */
 		/* force 16M dma pages for linear mapping */
@@ -1027,7 +1028,8 @@ static int dma_sb_region_create_linear(struct ps3_dma_region *r)
 static int dma_sb_region_free_linear(struct ps3_dma_region *r)
 {
 	int result;
-	unsigned long bus_addr, len, lpar_addr;
+	dma_addr_t bus_addr;
+	unsigned long len, lpar_addr;
 
 	if (r->offset < map.rm.size) {
 		/* Unmap (part of) 1st RAM chunk */
@@ -1072,7 +1074,7 @@ static int dma_sb_region_free_linear(struct ps3_dma_region *r)
  */
 
 static int dma_sb_map_area_linear(struct ps3_dma_region *r,
-	unsigned long virt_addr, unsigned long len, unsigned long *bus_addr,
+	unsigned long virt_addr, unsigned long len, dma_addr_t *bus_addr,
 	u64 iopte_flag)
 {
 	unsigned long phys_addr = is_kernel_addr(virt_addr) ? __pa(virt_addr)
@@ -1091,7 +1093,7 @@ static int dma_sb_map_area_linear(struct ps3_dma_region *r,
  */
 
 static int dma_sb_unmap_area_linear(struct ps3_dma_region *r,
-	unsigned long bus_addr, unsigned long len)
+	dma_addr_t bus_addr, unsigned long len)
 {
 	return 0;
 };
@@ -1169,13 +1171,13 @@ int ps3_dma_region_free(struct ps3_dma_region *r)
 EXPORT_SYMBOL(ps3_dma_region_free);
 
 int ps3_dma_map(struct ps3_dma_region *r, unsigned long virt_addr,
-	unsigned long len, unsigned long *bus_addr,
+	unsigned long len, dma_addr_t *bus_addr,
 	u64 iopte_flag)
 {
 	return r->region_ops->map(r, virt_addr, len, bus_addr, iopte_flag);
 }
 
-int ps3_dma_unmap(struct ps3_dma_region *r, unsigned long bus_addr,
+int ps3_dma_unmap(struct ps3_dma_region *r, dma_addr_t bus_addr,
 	unsigned long len)
 {
 	return r->region_ops->unmap(r, bus_addr, len);
diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index ee0d229..70ef793 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -568,7 +568,7 @@ static dma_addr_t ps3_sb_map_page(struct device *_dev, struct page *page,
 {
 	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
 	int result;
-	unsigned long bus_addr;
+	dma_addr_t bus_addr;
 	void *ptr = page_address(page) + offset;
 
 	result = ps3_dma_map(dev->d_region, (unsigned long)ptr, size,
@@ -590,7 +590,7 @@ static dma_addr_t ps3_ioc0_map_page(struct device *_dev, struct page *page,
 {
 	struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
 	int result;
-	unsigned long bus_addr;
+	dma_addr_t bus_addr;
 	u64 iopte_flag;
 	void *ptr = page_address(page) + offset;
 
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
