Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 56AEB1A0B62
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jan 2016 11:46:11 +1100 (AEDT)
Received: from mail-pf0-x231.google.com (mail-pf0-x231.google.com
 [IPv6:2607:f8b0:400e:c00::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2EC481402C0
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Jan 2016 11:46:09 +1100 (AEDT)
Received: by mail-pf0-x231.google.com with SMTP id e65so175800226pfe.1
 for <linuxppc-dev@ozlabs.org>; Tue, 05 Jan 2016 16:46:09 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH 1/2] powerpc: sparse: static-ify some things
Date: Wed,  6 Jan 2016 11:45:50 +1100
Message-Id: <1452041151-2387-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As sparse suggests, these should be made static.

Signed-off-by: Daniel Axtens <dja@axtens.net>

---

These are random fixes in arch/powerpc/kernel: there's no real
pattern to them. It doesn't fix everything.
---
 arch/powerpc/kernel/eeh_event.c | 2 +-
 arch/powerpc/kernel/ibmebus.c   | 2 +-
 arch/powerpc/kernel/mce.c       | 2 +-
 arch/powerpc/kernel/rtasd.c     | 2 +-
 arch/powerpc/kernel/vio.c       | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_event.c
index 4eefb6e34dbb..82e7327e3cd0 100644
--- a/arch/powerpc/kernel/eeh_event.c
+++ b/arch/powerpc/kernel/eeh_event.c
@@ -36,7 +36,7 @@
 
 static DEFINE_SPINLOCK(eeh_eventlist_lock);
 static struct semaphore eeh_eventlist_sem;
-LIST_HEAD(eeh_eventlist);
+static LIST_HEAD(eeh_eventlist);
 
 /**
  * eeh_event_handler - Dispatch EEH events.
diff --git a/arch/powerpc/kernel/ibmebus.c b/arch/powerpc/kernel/ibmebus.c
index ac86c53e2542..a89f4f7a66bd 100644
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -408,7 +408,7 @@ static ssize_t modalias_show(struct device *dev,
 	return len+1;
 }
 
-struct device_attribute ibmebus_bus_device_attrs[] = {
+static struct device_attribute ibmebus_bus_device_attrs[] = {
 	__ATTR_RO(devspec),
 	__ATTR_RO(name),
 	__ATTR_RO(modalias),
diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index b2eb4686bd8f..35138225af6e 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -37,7 +37,7 @@ static DEFINE_PER_CPU(int, mce_queue_count);
 static DEFINE_PER_CPU(struct machine_check_event[MAX_MC_EVT], mce_event_queue);
 
 static void machine_check_process_queued_event(struct irq_work *work);
-struct irq_work mce_event_process_work = {
+static struct irq_work mce_event_process_work = {
         .func = machine_check_process_queued_event,
 };
 
diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
index 5a2c049c1c61..c07f4b665b6b 100644
--- a/arch/powerpc/kernel/rtasd.c
+++ b/arch/powerpc/kernel/rtasd.c
@@ -442,7 +442,7 @@ static void do_event_scan(void)
 }
 
 static void rtas_event_scan(struct work_struct *w);
-DECLARE_DELAYED_WORK(event_scan_work, rtas_event_scan);
+static DECLARE_DELAYED_WORK(event_scan_work, rtas_event_scan);
 
 /*
  * Delay should be at least one second since some machines have problems if
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 5f8dcdaa2820..8d7358f3a273 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -87,7 +87,7 @@ struct vio_cmo_dev_entry {
  * @curr: bytes currently allocated
  * @high: high water mark for IO data usage
  */
-struct vio_cmo {
+static struct vio_cmo {
 	spinlock_t lock;
 	struct delayed_work balance_q;
 	struct list_head device_list;
@@ -615,7 +615,7 @@ static u64 vio_dma_get_required_mask(struct device *dev)
         return dma_iommu_ops.get_required_mask(dev);
 }
 
-struct dma_map_ops vio_dma_mapping_ops = {
+static struct dma_map_ops vio_dma_mapping_ops = {
 	.alloc             = vio_dma_iommu_alloc_coherent,
 	.free              = vio_dma_iommu_free_coherent,
 	.mmap		   = dma_direct_mmap_coherent,
-- 
2.6.4
