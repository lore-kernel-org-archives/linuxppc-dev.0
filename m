Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 467C42C039B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 15:21:51 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 19 Jun 2013 23:21:49 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
 [9.17.195.226])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 287F03E40026
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 23:21:27 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5K5Lj8g107784
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 23:21:45 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5K5Ljk6020745
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 23:21:45 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 27/31] powernv/opal: Notifier for OPAL events
Date: Thu, 20 Jun 2013 13:21:17 +0800
Message-Id: <1371705681-24632-28-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371705681-24632-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371705681-24632-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch implements a notifier to receive a notification on OPAL
event mask changes. The notifier is only called as a result of an OPAL
interrupt, which will happen upon reception of FSP messages or PCI errors.
Any event mask change detected as a result of opal_poll_events() will not
result in a notifier call.

[benh: changelog]
Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h       |    5 ++
 arch/powerpc/platforms/powernv/opal.c |   87 ++++++++++++++++++++++++++++++++-
 2 files changed, 91 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 2880797..bbaf801 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -644,6 +644,11 @@ extern void hvc_opal_init_early(void);
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
 				   int depth, void *data);
 
+extern int opal_notifier_register(uint64_t mask, void (*cb)(uint64_t));
+extern void opal_notifier_enable(void);
+extern void opal_notifier_disable(void);
+extern void opal_notifier_update_evt(uint64_t evt_mask, uint64_t evt_val);
+
 extern int opal_get_chars(uint32_t vtermno, char *buf, int count);
 extern int opal_put_chars(uint32_t vtermno, const char *buf, int total_len);
 
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 628c564..d87bd58 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -26,11 +26,21 @@ struct opal {
 	u64 entry;
 } opal;
 
+struct opal_cb {
+	struct list_head list;
+	uint64_t mask;
+	void (*cb)(uint64_t);
+};
+
 static struct device_node *opal_node;
 static DEFINE_SPINLOCK(opal_write_lock);
 extern u64 opal_mc_secondary_handler[];
 static unsigned int *opal_irqs;
 static unsigned int opal_irq_count;
+static LIST_HEAD(opal_notifier);
+static DEFINE_SPINLOCK(opal_notifier_lock);
+static uint64_t last_notified_mask = 0x0ul;
+static atomic_t opal_notifier_hold = ATOMIC_INIT(0);
 
 int __init early_init_dt_scan_opal(unsigned long node,
 				   const char *uname, int depth, void *data)
@@ -95,6 +105,81 @@ static int __init opal_register_exception_handlers(void)
 
 early_initcall(opal_register_exception_handlers);
 
+int opal_notifier_register(uint64_t mask, void (*cb)(uint64_t))
+{
+	unsigned long flags;
+	struct opal_cb *p;
+
+	if (!mask || !cb) {
+		pr_warning("%s: Invalid argument (%llx, %p)!\n",
+			__func__, mask, cb);
+		return -EINVAL;
+	}
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p) {
+		pr_warning("%s: Out of memory (%llx, %p)!\n",
+			__func__, mask, cb);
+		return -ENOMEM;
+	}
+	p->mask = mask;
+	p->cb   = cb;
+
+	spin_lock_irqsave(&opal_notifier_lock, flags);
+	list_add_tail(&p->list, &opal_notifier);
+	spin_unlock_irqrestore(&opal_notifier_lock, flags);
+
+	return 0;
+}
+
+static void opal_do_notifier(uint64_t events)
+{
+	struct opal_cb *p;
+	unsigned long flags;
+	uint64_t changed_mask;
+
+	if (atomic_read(&opal_notifier_hold))
+		return;
+
+	spin_lock_irqsave(&opal_notifier_lock, flags);
+	changed_mask = last_notified_mask ^ events;
+	last_notified_mask = events;
+	spin_unlock_irqrestore(&opal_notifier_lock, flags);
+
+	list_for_each_entry(p, &opal_notifier, list) {
+		if (changed_mask & p->mask)
+			p->cb(events);
+	}
+}
+
+void opal_notifier_update_evt(uint64_t evt_mask, uint64_t evt_val)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&opal_notifier_lock, flags);
+	last_notified_mask &= ~evt_mask;
+	last_notified_mask |= evt_val;
+	spin_unlock_irqrestore(&opal_notifier_lock, flags);
+}
+
+void opal_notifier_enable(void)
+{
+	int64_t rc;
+	uint64_t evt = 0;
+
+	atomic_set(&opal_notifier_hold, 0);
+
+	/* Process pending events */
+	rc = opal_poll_events(&evt);
+	if (rc == OPAL_SUCCESS && evt)
+		opal_do_notifier(evt);
+}
+
+void opal_notifier_disable(void)
+{
+	atomic_set(&opal_notifier_hold, 1);
+}
+
 int opal_get_chars(uint32_t vtermno, char *buf, int count)
 {
 	s64 len, rc;
@@ -297,7 +382,7 @@ static irqreturn_t opal_interrupt(int irq, void *data)
 
 	opal_handle_interrupt(virq_to_hw(irq), &events);
 
-	/* XXX TODO: Do something with the events */
+	opal_do_notifier(events);
 
 	return IRQ_HANDLED;
 }
-- 
1.7.5.4
