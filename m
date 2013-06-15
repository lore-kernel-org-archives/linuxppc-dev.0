Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C268E2C013D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 19:03:42 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sat, 15 Jun 2013 05:03:39 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id E23EB38C801A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 05:03:36 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5F93bpJ296648
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 05:03:37 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5F93Z10026436
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2013 06:03:37 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 23/27] powernv/opal: Notifier for OPAL events
Date: Sat, 15 Jun 2013 17:03:14 +0800
Message-Id: <1371286998-2842-24-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371286998-2842-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371286998-2842-1-git-send-email-shangw@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/opal.h       |    4 ++
 arch/powerpc/platforms/powernv/opal.c |   74 ++++++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 2880797..c5803c0 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -644,6 +644,10 @@ extern void hvc_opal_init_early(void);
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
 				   int depth, void *data);
 
+extern int opal_notifier_register(uint64_t mask, void (*cb)(uint64_t));
+extern void opal_notifier_disable(void);
+extern void opal_notifier_enable(void);
+
 extern int opal_get_chars(uint32_t vtermno, char *buf, int count);
 extern int opal_put_chars(uint32_t vtermno, const char *buf, int total_len);
 
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 628c564..9e4c9e9 100644
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
@@ -95,6 +105,68 @@ static int __init opal_register_exception_handlers(void)
 
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
+	uint64_t changed_mask;
+
+	if (atomic_read(&opal_notifier_hold))
+		return;
+
+	changed_mask = last_notified_mask ^ events;
+	last_notified_mask = events;
+
+	list_for_each_entry(p, &opal_notifier, list) {
+		if (changed_mask & p->mask)
+			p->cb(events);
+	}
+}
+
+void opal_notifier_disable(void)
+{
+	atomic_set(&opal_notifier_hold, 1);
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
 int opal_get_chars(uint32_t vtermno, char *buf, int count)
 {
 	s64 len, rc;
@@ -297,7 +369,7 @@ static irqreturn_t opal_interrupt(int irq, void *data)
 
 	opal_handle_interrupt(virq_to_hw(irq), &events);
 
-	/* XXX TODO: Do something with the events */
+	opal_do_notifier(events);
 
 	return IRQ_HANDLED;
 }
-- 
1.7.5.4
