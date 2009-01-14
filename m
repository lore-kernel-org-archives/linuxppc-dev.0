Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 14 Jan 2009 16:59:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [PATCH 03/13] powerpc/ps3: the lv1_ routines have u64 parameters
Message-Id: <20090114165941.a3145499.sfr@canb.auug.org.au>
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

We just fix up the reference parameters as the others are dealt with by
arithmetic promotion rules and don't cause warnings.

This removes warnings like this:

arch/powerpc/platforms/ps3/interrupt.c:327: warning: passing argument 1 of 'lv1_construct_event_receive_port' from incompatible pointer type

Also, these:

drivers/ps3/ps3-vuart.c:462: warning: passing argument 4 of 'ps3_vuart_raw_read' from incompatible pointer type
drivers/ps3/ps3-vuart.c:592: warning: passing argument 4 of 'ps3_vuart_raw_read' from incompatible pointer type

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/ps3/interrupt.c  |    8 +++---
 arch/powerpc/platforms/ps3/mm.c         |   38 +++++++++++++++++-------------
 arch/powerpc/platforms/ps3/spu.c        |   12 ++++++---
 arch/powerpc/platforms/ps3/system-bus.c |    4 ++-
 drivers/ps3/ps3-vuart.c                 |   24 ++++++++++---------
 5 files changed, 49 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index e59634f..b746792 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -322,7 +322,7 @@ EXPORT_SYMBOL_GPL(ps3_irq_plug_destroy);
 int ps3_event_receive_port_setup(enum ps3_cpu_binding cpu, unsigned int *virq)
 {
 	int result;
-	unsigned long outlet;
+	u64 outlet;
 
 	result = lv1_construct_event_receive_port(&outlet);
 
@@ -468,7 +468,7 @@ int ps3_io_irq_setup(enum ps3_cpu_binding cpu, unsigned int interrupt_id,
 	unsigned int *virq)
 {
 	int result;
-	unsigned long outlet;
+	u64 outlet;
 
 	result = lv1_construct_io_irq_outlet(interrupt_id, &outlet);
 
@@ -525,7 +525,7 @@ int ps3_vuart_irq_setup(enum ps3_cpu_binding cpu, void* virt_addr_bmp,
 	unsigned int *virq)
 {
 	int result;
-	unsigned long outlet;
+	u64 outlet;
 	u64 lpar_addr;
 
 	BUG_ON(!is_kernel_addr((u64)virt_addr_bmp));
@@ -581,7 +581,7 @@ int ps3_spe_irq_setup(enum ps3_cpu_binding cpu, unsigned long spe_id,
 	unsigned int class, unsigned int *virq)
 {
 	int result;
-	unsigned long outlet;
+	u64 outlet;
 
 	BUG_ON(class > 2);
 
diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
index 4761e2d..5c8d066 100644
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -79,7 +79,7 @@ enum {
  */
 
 struct mem_region {
-	unsigned long base;
+	u64 base;
 	unsigned long size;
 	unsigned long offset;
 };
@@ -104,8 +104,8 @@ struct mem_region {
 
 struct map {
 	unsigned long total;
-	unsigned long vas_id;
-	unsigned long htab_size;
+	u64 vas_id;
+	u64 htab_size;
 	struct mem_region rm;
 	struct mem_region r1;
 };
@@ -116,9 +116,9 @@ static void __maybe_unused _debug_dump_map(const struct map *m,
 {
 	DBG("%s:%d: map.total     = %lxh\n", func, line, m->total);
 	DBG("%s:%d: map.rm.size   = %lxh\n", func, line, m->rm.size);
-	DBG("%s:%d: map.vas_id    = %lu\n", func, line, m->vas_id);
-	DBG("%s:%d: map.htab_size = %lxh\n", func, line, m->htab_size);
-	DBG("%s:%d: map.r1.base   = %lxh\n", func, line, m->r1.base);
+	DBG("%s:%d: map.vas_id    = %llu\n", func, line, m->vas_id);
+	DBG("%s:%d: map.htab_size = %llxh\n", func, line, m->htab_size);
+	DBG("%s:%d: map.r1.base   = %llxh\n", func, line, m->r1.base);
 	DBG("%s:%d: map.r1.offset = %lxh\n", func, line, m->r1.offset);
 	DBG("%s:%d: map.r1.size   = %lxh\n", func, line, m->r1.size);
 }
@@ -146,11 +146,11 @@ EXPORT_SYMBOL(ps3_mm_phys_to_lpar);
 void __init ps3_mm_vas_create(unsigned long* htab_size)
 {
 	int result;
-	unsigned long start_address;
-	unsigned long size;
-	unsigned long access_right;
-	unsigned long max_page_size;
-	unsigned long flags;
+	u64 start_address;
+	u64 size;
+	u64 access_right;
+	u64 max_page_size;
+	u64 flags;
 
 	result = lv1_query_logical_partition_address_region_info(0,
 		&start_address, &size, &access_right, &max_page_size,
@@ -164,7 +164,7 @@ void __init ps3_mm_vas_create(unsigned long* htab_size)
 	}
 
 	if (max_page_size < PAGE_SHIFT_16M) {
-		DBG("%s:%d: bad max_page_size %lxh\n", __func__, __LINE__,
+		DBG("%s:%d: bad max_page_size %llxh\n", __func__, __LINE__,
 			max_page_size);
 		goto fail;
 	}
@@ -208,7 +208,7 @@ void ps3_mm_vas_destroy(void)
 {
 	int result;
 
-	DBG("%s:%d: map.vas_id    = %lu\n", __func__, __LINE__, map.vas_id);
+	DBG("%s:%d: map.vas_id    = %llu\n", __func__, __LINE__, map.vas_id);
 
 	if (map.vas_id) {
 		result = lv1_select_virtual_address_space(0);
@@ -235,7 +235,7 @@ void ps3_mm_vas_destroy(void)
 static int ps3_mm_region_create(struct mem_region *r, unsigned long size)
 {
 	int result;
-	unsigned long muid;
+	u64 muid;
 
 	r->size = _ALIGN_DOWN(size, 1 << PAGE_SHIFT_16M);
 
@@ -277,7 +277,7 @@ static void ps3_mm_region_destroy(struct mem_region *r)
 {
 	int result;
 
-	DBG("%s:%d: r->base = %lxh\n", __func__, __LINE__, r->base);
+	DBG("%s:%d: r->base = %llxh\n", __func__, __LINE__, r->base);
 	if (r->base) {
 		result = lv1_release_memory(r->base);
 		BUG_ON(result);
@@ -648,6 +648,7 @@ fail_alloc:
 static int dma_sb_region_create(struct ps3_dma_region *r)
 {
 	int result;
+	u64 bus_addr;
 
 	DBG(" -> %s:%d:\n", __func__, __LINE__);
 
@@ -671,7 +672,8 @@ static int dma_sb_region_create(struct ps3_dma_region *r)
 
 	result = lv1_allocate_device_dma_region(r->dev->bus_id, r->dev->dev_id,
 		roundup_pow_of_two(r->len), r->page_size, r->region_type,
-		&r->bus_addr);
+		&bus_addr);
+	r->bus_addr = bus_addr;
 
 	if (result) {
 		DBG("%s:%d: lv1_allocate_device_dma_region failed: %s\n",
@@ -685,6 +687,7 @@ static int dma_sb_region_create(struct ps3_dma_region *r)
 static int dma_ioc0_region_create(struct ps3_dma_region *r)
 {
 	int result;
+	u64 bus_addr;
 
 	INIT_LIST_HEAD(&r->chunk_list.head);
 	spin_lock_init(&r->chunk_list.lock);
@@ -692,7 +695,8 @@ static int dma_ioc0_region_create(struct ps3_dma_region *r)
 	result = lv1_allocate_io_segment(0,
 					 r->len,
 					 r->page_size,
-					 &r->bus_addr);
+					 &bus_addr);
+	r->bus_addr = bus_addr;
 	if (result) {
 		DBG("%s:%d: lv1_allocate_io_segment failed: %s\n",
 			__func__, __LINE__, ps3_result(result));
diff --git a/arch/powerpc/platforms/ps3/spu.c b/arch/powerpc/platforms/ps3/spu.c
index ccae3d4..b3c6a99 100644
--- a/arch/powerpc/platforms/ps3/spu.c
+++ b/arch/powerpc/platforms/ps3/spu.c
@@ -149,7 +149,7 @@ EXPORT_SYMBOL_GPL(ps3_get_spe_id);
 
 static unsigned long get_vas_id(void)
 {
-	unsigned long id;
+	u64 id;
 
 	lv1_get_logical_ppe_id(&id);
 	lv1_get_virtual_address_space_id_of_ppe(id, &id);
@@ -160,14 +160,18 @@ static unsigned long get_vas_id(void)
 static int __init construct_spu(struct spu *spu)
 {
 	int result;
-	unsigned long unused;
+	u64 unused;
+	u64 problem_phys;
+	u64 local_store_phys;
 
 	result = lv1_construct_logical_spe(PAGE_SHIFT, PAGE_SHIFT, PAGE_SHIFT,
 		PAGE_SHIFT, PAGE_SHIFT, get_vas_id(), SPE_TYPE_LOGICAL,
-		&spu_pdata(spu)->priv2_addr, &spu->problem_phys,
-		&spu->local_store_phys, &unused,
+		&spu_pdata(spu)->priv2_addr, &problem_phys,
+		&local_store_phys, &unused,
 		&spu_pdata(spu)->shadow_addr,
 		&spu_pdata(spu)->spe_id);
+	spu->problem_phys = problem_phys;
+	spu->local_store_phys = local_store_phys;
 
 	if (result) {
 		pr_debug("%s:%d: lv1_construct_logical_spe failed: %s\n",
diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index 70ef793..9bd4d67 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -250,9 +250,11 @@ static void _dump_mmio_region(const struct ps3_mmio_region* r,
 static int ps3_sb_mmio_region_create(struct ps3_mmio_region *r)
 {
 	int result;
+	u64 lpar_addr;
 
 	result = lv1_map_device_mmio_region(r->dev->bus_id, r->dev->dev_id,
-		r->bus_addr, r->len, r->page_size, &r->lpar_addr);
+		r->bus_addr, r->len, r->page_size, &lpar_addr);
+	r->lpar_addr = lpar_addr;
 
 	if (result) {
 		pr_debug("%s:%d: lv1_map_device_mmio_region failed: %s\n",
diff --git a/drivers/ps3/ps3-vuart.c b/drivers/ps3/ps3-vuart.c
index 90c097a..264c447 100644
--- a/drivers/ps3/ps3-vuart.c
+++ b/drivers/ps3/ps3-vuart.c
@@ -159,11 +159,13 @@ int ps3_vuart_get_triggers(struct ps3_system_bus_device *dev,
 	struct vuart_triggers *trig)
 {
 	int result;
-	unsigned long size;
-	unsigned long val;
+	u64 size;
+	u64 val;
+	u64 tx;
 
 	result = lv1_get_virtual_uart_param(dev->port_number,
-		PARAM_TX_TRIGGER, &trig->tx);
+		PARAM_TX_TRIGGER, &tx);
+	trig->tx = tx;
 
 	if (result) {
 		dev_dbg(&dev->core, "%s:%d: tx_trigger failed: %s\n",
@@ -201,7 +203,7 @@ int ps3_vuart_set_triggers(struct ps3_system_bus_device *dev, unsigned int tx,
 	unsigned int rx)
 {
 	int result;
-	unsigned long size;
+	u64 size;
 
 	result = lv1_set_virtual_uart_param(dev->port_number,
 		PARAM_TX_TRIGGER, tx);
@@ -363,7 +365,7 @@ int ps3_vuart_disable_interrupt_disconnect(struct ps3_system_bus_device *dev)
  */
 
 static int ps3_vuart_raw_write(struct ps3_system_bus_device *dev,
-	const void *buf, unsigned int bytes, unsigned long *bytes_written)
+	const void *buf, unsigned int bytes, u64 *bytes_written)
 {
 	int result;
 	struct ps3_vuart_port_priv *priv = to_port_priv(dev);
@@ -379,7 +381,7 @@ static int ps3_vuart_raw_write(struct ps3_system_bus_device *dev,
 
 	priv->stats.bytes_written += *bytes_written;
 
-	dev_dbg(&dev->core, "%s:%d: wrote %lxh/%xh=>%lxh\n", __func__, __LINE__,
+	dev_dbg(&dev->core, "%s:%d: wrote %llxh/%xh=>%lxh\n", __func__, __LINE__,
 		*bytes_written, bytes, priv->stats.bytes_written);
 
 	return result;
@@ -393,7 +395,7 @@ static int ps3_vuart_raw_write(struct ps3_system_bus_device *dev,
  */
 
 static int ps3_vuart_raw_read(struct ps3_system_bus_device *dev, void *buf,
-	unsigned int bytes, unsigned long *bytes_read)
+	unsigned int bytes, u64 *bytes_read)
 {
 	int result;
 	struct ps3_vuart_port_priv *priv = to_port_priv(dev);
@@ -411,7 +413,7 @@ static int ps3_vuart_raw_read(struct ps3_system_bus_device *dev, void *buf,
 
 	priv->stats.bytes_read += *bytes_read;
 
-	dev_dbg(&dev->core, "%s:%d: read %lxh/%xh=>%lxh\n", __func__, __LINE__,
+	dev_dbg(&dev->core, "%s:%d: read %llxh/%xh=>%lxh\n", __func__, __LINE__,
 		*bytes_read, bytes, priv->stats.bytes_read);
 
 	return result;
@@ -500,7 +502,7 @@ int ps3_vuart_write(struct ps3_system_bus_device *dev, const void *buf,
 	spin_lock_irqsave(&priv->tx_list.lock, flags);
 
 	if (list_empty(&priv->tx_list.head)) {
-		unsigned long bytes_written;
+		u64 bytes_written;
 
 		result = ps3_vuart_raw_write(dev, buf, bytes, &bytes_written);
 
@@ -745,7 +747,7 @@ static int ps3_vuart_handle_interrupt_tx(struct ps3_system_bus_device *dev)
 
 	list_for_each_entry_safe(lb, n, &priv->tx_list.head, link) {
 
-		unsigned long bytes_written;
+		u64 bytes_written;
 
 		result = ps3_vuart_raw_write(dev, lb->head, lb->tail - lb->head,
 			&bytes_written);
@@ -762,7 +764,7 @@ static int ps3_vuart_handle_interrupt_tx(struct ps3_system_bus_device *dev)
 		if (bytes_written < lb->tail - lb->head) {
 			lb->head += bytes_written;
 			dev_dbg(&dev->core,
-				"%s:%d cleared buf_%lu, %lxh bytes\n",
+				"%s:%d cleared buf_%lu, %llxh bytes\n",
 				__func__, __LINE__, lb->dbg_number,
 				bytes_written);
 			goto port_full;
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
