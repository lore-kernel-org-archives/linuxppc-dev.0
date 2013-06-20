Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D15D62C054D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 20:14:39 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 20 Jun 2013 04:14:07 -0600
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 75D196E8044
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 06:14:00 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5KADY02297096
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 06:13:34 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5KADXvT015811
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 07:13:34 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/5] powernv/opal: Notifier for OPAL events
Date: Thu, 20 Jun 2013 18:13:22 +0800
Message-Id: <1371723206-26190-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1371723206-26190-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1371723206-26190-1-git-send-email-shangw@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/powernv/opal.c |   69 ++++++++++++++++++++++++++++++++-
 2 files changed, 73 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 2880797..029fe85 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -644,6 +644,11 @@ extern void hvc_opal_init_early(void);
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
 				   int depth, void *data);
 
+extern int opal_notifier_register(struct notifier_block *nb);
+extern void opal_notifier_enable(void);
+extern void opal_notifier_disable(void);
+extern void opal_notifier_update_evt(uint64_t evt_mask, uint64_t evt_val);
+
 extern int opal_get_chars(uint32_t vtermno, char *buf, int count);
 extern int opal_put_chars(uint32_t vtermno, const char *buf, int total_len);
 
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 628c564..106301f 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/interrupt.h>
+#include <linux/notifier.h>
 #include <linux/slab.h>
 #include <asm/opal.h>
 #include <asm/firmware.h>
@@ -31,6 +32,10 @@ static DEFINE_SPINLOCK(opal_write_lock);
 extern u64 opal_mc_secondary_handler[];
 static unsigned int *opal_irqs;
 static unsigned int opal_irq_count;
+static ATOMIC_NOTIFIER_HEAD(opal_notifier_head);
+static DEFINE_SPINLOCK(opal_notifier_lock);
+static uint64_t last_notified_mask = 0x0ul;
+static atomic_t opal_notifier_hold = ATOMIC_INIT(0);
 
 int __init early_init_dt_scan_opal(unsigned long node,
 				   const char *uname, int depth, void *data)
@@ -95,6 +100,68 @@ static int __init opal_register_exception_handlers(void)
 
 early_initcall(opal_register_exception_handlers);
 
+int opal_notifier_register(struct notifier_block *nb)
+{
+	if (!nb) {
+		pr_warning("%s: Invalid argument (%p)\n",
+			   __func__, nb);
+		return -EINVAL;
+	}
+
+	atomic_notifier_chain_register(&opal_notifier_head, nb);
+	return 0;
+}
+
+static void opal_do_notifier(uint64_t events)
+{
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
+	/*
+	 * We feed with the event bits and changed bits for
+	 * enough information to the callback.
+	 */
+	atomic_notifier_call_chain(&opal_notifier_head,
+				   events, (void *)changed_mask);
+}
+
+void opal_notifier_update_evt(uint64_t evt_mask,
+			      uint64_t evt_val)
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
@@ -297,7 +364,7 @@ static irqreturn_t opal_interrupt(int irq, void *data)
 
 	opal_handle_interrupt(virq_to_hw(irq), &events);
 
-	/* XXX TODO: Do something with the events */
+	opal_do_notifier(events);
 
 	return IRQ_HANDLED;
 }
-- 
1.7.5.4
