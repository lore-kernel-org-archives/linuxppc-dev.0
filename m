Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 14 Jan 2009 17:02:39 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: [PATCH 06/13] powerpc/ps3: printing fixups for l64 to ll64
	conversion: arch/powerpc
Message-Id: <20090114170239.7741b23c.sfr@canb.auug.org.au>
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


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/ps3/device-init.c |   26 +++++++++++++-------------
 arch/powerpc/platforms/ps3/htab.c        |    2 +-
 arch/powerpc/platforms/ps3/interrupt.c   |   16 ++++++++--------
 arch/powerpc/platforms/ps3/mm.c          |   10 +++++-----
 arch/powerpc/platforms/ps3/os-area.c     |    2 +-
 arch/powerpc/platforms/ps3/repository.c  |   22 +++++++++++-----------
 arch/powerpc/platforms/ps3/system-bus.c  |    6 +++---
 7 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/device-init.c b/arch/powerpc/platforms/ps3/device-init.c
index ca71a12..bb028f1 100644
--- a/arch/powerpc/platforms/ps3/device-init.c
+++ b/arch/powerpc/platforms/ps3/device-init.c
@@ -82,7 +82,7 @@ static int __init ps3_register_lpm_devices(void)
 		goto fail_rights;
 	}
 
-	pr_debug("%s:%d: pu_id %lu, rights %lu(%lxh)\n",
+	pr_debug("%s:%d: pu_id %llu, rights %llu(%llxh)\n",
 		__func__, __LINE__, dev->lpm.pu_id, dev->lpm.rights,
 		dev->lpm.rights);
 
@@ -348,7 +348,7 @@ static int ps3_setup_storage_dev(const struct ps3_repository_device *repo,
 		return -ENODEV;
 	}
 
-	pr_debug("%s:%u: (%u:%u:%u): port %lu blk_size %lu num_blocks %lu "
+	pr_debug("%s:%u: (%u:%u:%u): port %llu blk_size %llu num_blocks %llu "
 		 "num_regions %u\n", __func__, __LINE__, repo->bus_index,
 		 repo->dev_index, repo->dev_type, port, blk_size, num_blocks,
 		 num_regions);
@@ -394,7 +394,7 @@ static int ps3_setup_storage_dev(const struct ps3_repository_device *repo,
 			result = -ENODEV;
 			goto fail_read_region;
 		}
-		pr_debug("%s:%u: region %u: id %u start %lu size %lu\n",
+		pr_debug("%s:%u: region %u: id %u start %llu size %llu\n",
 			 __func__, __LINE__, i, id, start, size);
 
 		p->regions[i].id = id;
@@ -662,13 +662,13 @@ static void ps3_find_and_add_device(u64 bus_id, u64 dev_id)
 		if (rem)
 			break;
 	}
-	pr_warning("%s:%u: device %lu:%lu not found\n", __func__, __LINE__,
+	pr_warning("%s:%u: device %llu:%llu not found\n", __func__, __LINE__,
 		   bus_id, dev_id);
 	return;
 
 found:
 	if (retries)
-		pr_debug("%s:%u: device %lu:%lu found after %u retries\n",
+		pr_debug("%s:%u: device %llu:%llu found after %u retries\n",
 			 __func__, __LINE__, bus_id, dev_id, retries);
 
 	ps3_setup_dynamic_device(&repo);
@@ -715,14 +715,14 @@ static irqreturn_t ps3_notification_interrupt(int irq, void *data)
 	res = lv1_storage_get_async_status(PS3_NOTIFICATION_DEV_ID, &tag,
 					   &status);
 	if (tag != dev->tag)
-		pr_err("%s:%u: tag mismatch, got %lx, expected %lx\n",
+		pr_err("%s:%u: tag mismatch, got %llx, expected %llx\n",
 		       __func__, __LINE__, tag, dev->tag);
 
 	if (res) {
-		pr_err("%s:%u: res %d status 0x%lx\n", __func__, __LINE__, res,
+		pr_err("%s:%u: res %d status 0x%llx\n", __func__, __LINE__, res,
 		       status);
 	} else {
-		pr_debug("%s:%u: completed, status 0x%lx\n", __func__,
+		pr_debug("%s:%u: completed, status 0x%llx\n", __func__,
 			 __LINE__, status);
 		dev->lv1_status = status;
 		complete(&dev->done);
@@ -761,7 +761,7 @@ static int ps3_notification_read_write(struct ps3_notification_device *dev,
 	}
 
 	if (dev->lv1_status) {
-		pr_err("%s:%u: %s not completed, status 0x%lx\n", __func__,
+		pr_err("%s:%u: %s not completed, status 0x%llx\n", __func__,
 		       __LINE__, op, dev->lv1_status);
 		return -EIO;
 	}
@@ -850,16 +850,16 @@ static int ps3_probe_thread(void *data)
 		if (res)
 			break;
 
-		pr_debug("%s:%u: notify event type 0x%lx bus id %lu dev id %lu"
-			 " type %lu port %lu\n", __func__, __LINE__,
+		pr_debug("%s:%u: notify event type 0x%llx bus id %llu dev id %llu"
+			 " type %llu port %llu\n", __func__, __LINE__,
 			 notify_event->event_type, notify_event->bus_id,
 			 notify_event->dev_id, notify_event->dev_type,
 			 notify_event->dev_port);
 
 		if (notify_event->event_type != notify_region_probe ||
 		    notify_event->bus_id != dev.sbd.bus_id) {
-			pr_warning("%s:%u: bad notify_event: event %lu, "
-				   "dev_id %lu, dev_type %lu\n",
+			pr_warning("%s:%u: bad notify_event: event %llu, "
+				   "dev_id %llu, dev_type %llu\n",
 				   __func__, __LINE__, notify_event->event_type,
 				   notify_event->dev_id,
 				   notify_event->dev_type);
diff --git a/arch/powerpc/platforms/ps3/htab.c b/arch/powerpc/platforms/ps3/htab.c
index 6eb1d4d..1e8a1e3 100644
--- a/arch/powerpc/platforms/ps3/htab.c
+++ b/arch/powerpc/platforms/ps3/htab.c
@@ -75,7 +75,7 @@ static long ps3_hpte_insert(unsigned long hpte_group, unsigned long va,
 
 	if (result) {
 		/* all entries bolted !*/
-		pr_info("%s:result=%d va=%lx pa=%lx ix=%lx v=%lx r=%lx\n",
+		pr_info("%s:result=%d va=%lx pa=%lx ix=%lx v=%llx r=%llx\n",
 			__func__, result, va, pa, hpte_group, hpte_v, hpte_r);
 		BUG();
 	}
diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index 3ea6e51..8ec5ccf 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -104,7 +104,7 @@ static void ps3_chip_mask(unsigned int virq)
 	struct ps3_private *pd = get_irq_chip_data(virq);
 	unsigned long flags;
 
-	pr_debug("%s:%d: thread_id %lu, virq %d\n", __func__, __LINE__,
+	pr_debug("%s:%d: thread_id %llu, virq %d\n", __func__, __LINE__,
 		pd->thread_id, virq);
 
 	local_irq_save(flags);
@@ -125,7 +125,7 @@ static void ps3_chip_unmask(unsigned int virq)
 	struct ps3_private *pd = get_irq_chip_data(virq);
 	unsigned long flags;
 
-	pr_debug("%s:%d: thread_id %lu, virq %d\n", __func__, __LINE__,
+	pr_debug("%s:%d: thread_id %llu, virq %d\n", __func__, __LINE__,
 		pd->thread_id, virq);
 
 	local_irq_save(flags);
@@ -223,7 +223,7 @@ static int ps3_virq_destroy(unsigned int virq)
 {
 	const struct ps3_private *pd = get_irq_chip_data(virq);
 
-	pr_debug("%s:%d: ppe_id %lu, thread_id %lu, virq %u\n", __func__,
+	pr_debug("%s:%d: ppe_id %llu, thread_id %llu, virq %u\n", __func__,
 		__LINE__, pd->ppe_id, pd->thread_id, virq);
 
 	set_irq_chip_data(virq, NULL);
@@ -293,7 +293,7 @@ int ps3_irq_plug_destroy(unsigned int virq)
 	int result;
 	const struct ps3_private *pd = get_irq_chip_data(virq);
 
-	pr_debug("%s:%d: ppe_id %lu, thread_id %lu, virq %u\n", __func__,
+	pr_debug("%s:%d: ppe_id %llu, thread_id %llu, virq %u\n", __func__,
 		__LINE__, pd->ppe_id, pd->thread_id, virq);
 
 	ps3_chip_mask(virq);
@@ -693,7 +693,7 @@ void __init ps3_register_ipi_debug_brk(unsigned int cpu, unsigned int virq)
 
 	pd->bmp.ipi_debug_brk_mask = 0x8000000000000000UL >> virq;
 
-	pr_debug("%s:%d: cpu %u, virq %u, mask %lxh\n", __func__, __LINE__,
+	pr_debug("%s:%d: cpu %u, virq %u, mask %llxh\n", __func__, __LINE__,
 		cpu, virq, pd->bmp.ipi_debug_brk_mask);
 }
 
@@ -712,7 +712,7 @@ static unsigned int ps3_get_irq(void)
 	plug &= 0x3f;
 
 	if (unlikely(plug == NO_IRQ)) {
-		pr_debug("%s:%d: no plug found: thread_id %lu\n", __func__,
+		pr_debug("%s:%d: no plug found: thread_id %llu\n", __func__,
 			__LINE__, pd->thread_id);
 		dump_bmp(&per_cpu(ps3_private, 0));
 		dump_bmp(&per_cpu(ps3_private, 1));
@@ -747,7 +747,7 @@ void __init ps3_init_IRQ(void)
 		pd->thread_id = get_hard_smp_processor_id(cpu);
 		spin_lock_init(&pd->bmp.lock);
 
-		pr_debug("%s:%d: ppe_id %lu, thread_id %lu, bmp %lxh\n",
+		pr_debug("%s:%d: ppe_id %llu, thread_id %llu, bmp %lxh\n",
 			__func__, __LINE__, pd->ppe_id, pd->thread_id,
 			ps3_mm_phys_to_lpar(__pa(&pd->bmp)));
 
@@ -772,6 +772,6 @@ void ps3_shutdown_IRQ(int cpu)
 	lv1_get_logical_ppe_id(&ppe_id);
 	result = lv1_configure_irq_state_bitmap(ppe_id, thread_id, 0);
 
-	DBG("%s:%d: lv1_configure_irq_state_bitmap (%lu:%lu/%d) %s\n", __func__,
+	DBG("%s:%d: lv1_configure_irq_state_bitmap (%llu:%llu/%d) %s\n", __func__,
 		__LINE__, ppe_id, thread_id, cpu, ps3_result(result));
 }
diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
index 715508c..67de6bf 100644
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -354,7 +354,7 @@ static unsigned long dma_sb_lpar_to_bus(struct ps3_dma_region *r,
 static void  __maybe_unused _dma_dump_region(const struct ps3_dma_region *r,
 	const char *func, int line)
 {
-	DBG("%s:%d: dev        %lu:%lu\n", func, line, r->dev->bus_id,
+	DBG("%s:%d: dev        %llu:%llu\n", func, line, r->dev->bus_id,
 		r->dev->dev_id);
 	DBG("%s:%d: page_size  %u\n", func, line, r->page_size);
 	DBG("%s:%d: bus_addr   %lxh\n", func, line, r->bus_addr);
@@ -389,7 +389,7 @@ struct dma_chunk {
 static void _dma_dump_chunk (const struct dma_chunk* c, const char* func,
 	int line)
 {
-	DBG("%s:%d: r.dev        %lu:%lu\n", func, line,
+	DBG("%s:%d: r.dev        %llu:%llu\n", func, line,
 		c->region->dev->bus_id, c->region->dev->dev_id);
 	DBG("%s:%d: r.bus_addr   %lxh\n", func, line, c->region->bus_addr);
 	DBG("%s:%d: r.page_size  %u\n", func, line, c->region->page_size);
@@ -595,7 +595,7 @@ static int dma_ioc0_map_pages(struct ps3_dma_region *r, unsigned long phys_addr,
 
 	/* build ioptes for the area */
 	pages = len >> r->page_size;
-	DBG("%s: pgsize=%#x len=%#lx pages=%#x iopteflag=%#lx\n", __func__,
+	DBG("%s: pgsize=%#x len=%#lx pages=%#x iopteflag=%#llx\n", __func__,
 	    r->page_size, r->len, pages, iopte_flag);
 	for (iopage = 0; iopage < pages; iopage++) {
 		offset = (1 << r->page_size) * iopage;
@@ -654,7 +654,7 @@ static int dma_sb_region_create(struct ps3_dma_region *r)
 	BUG_ON(!r);
 
 	if (!r->dev->bus_id) {
-		pr_info("%s:%d: %lu:%lu no dma\n", __func__, __LINE__,
+		pr_info("%s:%d: %llu:%llu no dma\n", __func__, __LINE__,
 			r->dev->bus_id, r->dev->dev_id);
 		return 0;
 	}
@@ -723,7 +723,7 @@ static int dma_sb_region_free(struct ps3_dma_region *r)
 	BUG_ON(!r);
 
 	if (!r->dev->bus_id) {
-		pr_info("%s:%d: %lu:%lu no dma\n", __func__, __LINE__,
+		pr_info("%s:%d: %llu:%llu no dma\n", __func__, __LINE__,
 			r->dev->bus_id, r->dev->dev_id);
 		return 0;
 	}
diff --git a/arch/powerpc/platforms/ps3/os-area.c b/arch/powerpc/platforms/ps3/os-area.c
index 1d20178..e1c83c2 100644
--- a/arch/powerpc/platforms/ps3/os-area.c
+++ b/arch/powerpc/platforms/ps3/os-area.c
@@ -306,7 +306,7 @@ static void _dump_params(const struct os_area_params *p, const char *func,
 {
 	pr_debug("%s:%d: p.boot_flag:       %u\n", func, line, p->boot_flag);
 	pr_debug("%s:%d: p.num_params:      %u\n", func, line, p->num_params);
-	pr_debug("%s:%d: p.rtc_diff         %ld\n", func, line, p->rtc_diff);
+	pr_debug("%s:%d: p.rtc_diff         %lld\n", func, line, p->rtc_diff);
 	pr_debug("%s:%d: p.av_multi_out     %u\n", func, line, p->av_multi_out);
 	pr_debug("%s:%d: p.ctrl_button:     %u\n", func, line, p->ctrl_button);
 	pr_debug("%s:%d: p.static_ip_addr:  %u.%u.%u.%u\n", func, line,
diff --git a/arch/powerpc/platforms/ps3/repository.c b/arch/powerpc/platforms/ps3/repository.c
index 22063ad..5e304c2 100644
--- a/arch/powerpc/platforms/ps3/repository.c
+++ b/arch/powerpc/platforms/ps3/repository.c
@@ -44,7 +44,7 @@ static void _dump_field(const char *hdr, u64 n, const char *func, int line)
 		s[i] = (in[i] <= 126 && in[i] >= 32) ? in[i] : '.';
 	s[i] = 0;
 
-	pr_debug("%s:%d: %s%016lx : %s\n", func, line, hdr, n, s);
+	pr_debug("%s:%d: %s%016llx : %s\n", func, line, hdr, n, s);
 #endif
 }
 
@@ -70,8 +70,8 @@ static void _dump_node(unsigned int lpar_id, u64 n1, u64 n2, u64 n3, u64 n4,
 	_dump_field("n2: ", n2, func, line);
 	_dump_field("n3: ", n3, func, line);
 	_dump_field("n4: ", n4, func, line);
-	pr_debug("%s:%d: v1: %016lx\n", func, line, v1);
-	pr_debug("%s:%d: v2: %016lx\n", func, line, v2);
+	pr_debug("%s:%d: v1: %016llx\n", func, line, v1);
+	pr_debug("%s:%d: v2: %016llx\n", func, line, v2);
 }
 
 /**
@@ -149,10 +149,10 @@ static int read_node(unsigned int lpar_id, u64 n1, u64 n2, u64 n3, u64 n4,
 		*_v2 = v2;
 
 	if (v1 && !_v1)
-		pr_debug("%s:%d: warning: discarding non-zero v1: %016lx\n",
+		pr_debug("%s:%d: warning: discarding non-zero v1: %016llx\n",
 			__func__, __LINE__, v1);
 	if (v2 && !_v2)
-		pr_debug("%s:%d: warning: discarding non-zero v2: %016lx\n",
+		pr_debug("%s:%d: warning: discarding non-zero v2: %016llx\n",
 			__func__, __LINE__, v2);
 
 	return 0;
@@ -327,7 +327,7 @@ int ps3_repository_find_device(struct ps3_repository_device *repo)
 		return result;
 	}
 
-	pr_debug("%s:%d: bus_type %u, bus_index %u, bus_id %lu, num_dev %u\n",
+	pr_debug("%s:%d: bus_type %u, bus_index %u, bus_id %llu, num_dev %u\n",
 		__func__, __LINE__, tmp.bus_type, tmp.bus_index, tmp.bus_id,
 		num_dev);
 
@@ -353,7 +353,7 @@ int ps3_repository_find_device(struct ps3_repository_device *repo)
 		return result;
 	}
 
-	pr_debug("%s:%d: found: dev_type %u, dev_index %u, dev_id %lu\n",
+	pr_debug("%s:%d: found: dev_type %u, dev_index %u, dev_id %llu\n",
 		__func__, __LINE__, tmp.dev_type, tmp.dev_index, tmp.dev_id);
 
 	*repo = tmp;
@@ -367,7 +367,7 @@ int ps3_repository_find_device_by_id(struct ps3_repository_device *repo,
 	struct ps3_repository_device tmp;
 	unsigned int num_dev;
 
-	pr_debug(" -> %s:%u: find device by id %lu:%lu\n", __func__, __LINE__,
+	pr_debug(" -> %s:%u: find device by id %llu:%llu\n", __func__, __LINE__,
 		 bus_id, dev_id);
 
 	for (tmp.bus_index = 0; tmp.bus_index < 10; tmp.bus_index++) {
@@ -382,7 +382,7 @@ int ps3_repository_find_device_by_id(struct ps3_repository_device *repo,
 		if (tmp.bus_id == bus_id)
 			goto found_bus;
 
-		pr_debug("%s:%u: skip, bus_id %lu\n", __func__, __LINE__,
+		pr_debug("%s:%u: skip, bus_id %llu\n", __func__, __LINE__,
 			 tmp.bus_id);
 	}
 	pr_debug(" <- %s:%u: bus not found\n", __func__, __LINE__);
@@ -416,7 +416,7 @@ found_bus:
 		if (tmp.dev_id == dev_id)
 			goto found_dev;
 
-		pr_debug("%s:%u: skip, dev_id %lu\n", __func__, __LINE__,
+		pr_debug("%s:%u: skip, dev_id %llu\n", __func__, __LINE__,
 			 tmp.dev_id);
 	}
 	pr_debug(" <- %s:%u: dev not found\n", __func__, __LINE__);
@@ -430,7 +430,7 @@ found_dev:
 		return result;
 	}
 
-	pr_debug(" <- %s:%u: found: type (%u:%u) index (%u:%u) id (%lu:%lu)\n",
+	pr_debug(" <- %s:%u: found: type (%u:%u) index (%u:%u) id (%llu:%llu)\n",
 		 __func__, __LINE__, tmp.bus_type, tmp.dev_type, tmp.bus_index,
 		 tmp.dev_index, tmp.bus_id, tmp.dev_id);
 	*repo = tmp;
diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
index 9bd4d67..58311a8 100644
--- a/arch/powerpc/platforms/ps3/system-bus.c
+++ b/arch/powerpc/platforms/ps3/system-bus.c
@@ -182,7 +182,7 @@ int ps3_open_hv_device(struct ps3_system_bus_device *dev)
 	case PS3_MATCH_ID_SYSTEM_MANAGER:
 		pr_debug("%s:%d: unsupported match_id: %u\n", __func__,
 			__LINE__, dev->match_id);
-		pr_debug("%s:%d: bus_id: %lu\n", __func__, __LINE__,
+		pr_debug("%s:%d: bus_id: %llu\n", __func__, __LINE__,
 			dev->bus_id);
 		BUG();
 		return -EINVAL;
@@ -220,7 +220,7 @@ int ps3_close_hv_device(struct ps3_system_bus_device *dev)
 	case PS3_MATCH_ID_SYSTEM_MANAGER:
 		pr_debug("%s:%d: unsupported match_id: %u\n", __func__,
 			__LINE__, dev->match_id);
-		pr_debug("%s:%d: bus_id: %lu\n", __func__, __LINE__,
+		pr_debug("%s:%d: bus_id: %llu\n", __func__, __LINE__,
 			dev->bus_id);
 		BUG();
 		return -EINVAL;
@@ -240,7 +240,7 @@ EXPORT_SYMBOL_GPL(ps3_close_hv_device);
 static void _dump_mmio_region(const struct ps3_mmio_region* r,
 	const char* func, int line)
 {
-	pr_debug("%s:%d: dev       %lu:%lu\n", func, line, r->dev->bus_id,
+	pr_debug("%s:%d: dev       %llu:%llu\n", func, line, r->dev->bus_id,
 		r->dev->dev_id);
 	pr_debug("%s:%d: bus_addr  %lxh\n", func, line, r->bus_addr);
 	pr_debug("%s:%d: len       %lxh\n", func, line, r->len);
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
