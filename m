Return-Path: <kernelfans@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Dcz72j4MzF1Gt
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 15:23:47 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id b17-v6so5924703pfi.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jun 2018 22:23:47 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Pingfan Liu <kernelfans@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] drivers/base: reorder consumer and its children behind
 suppliers
Date: Mon, 25 Jun 2018 13:23:06 +0800
Message-Id: <1529904187-18673-3-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1529904187-18673-1-git-send-email-kernelfans@gmail.com>
References: <1529904187-18673-1-git-send-email-kernelfans@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

commit 52cdbdd49853 ("driver core: correct device's shutdown order")
introduces supplier<-consumer order in devices_kset. The commit tries
to cleverly maintain both parent<-child and supplier<-consumer order by
reordering a device when probing. This method makes things simple and
clean, but unfortunately, breaks parent<-child order in some case,
which is described in next patch in this series.
Here this patch tries to resolve supplier<-consumer by only reordering a
device when it has suppliers, and takes care of the following scenario:
    [consumer, children] [ ... potential ... ] supplier
                         ^                   ^
After moving the consumer and its children after the supplier, the
potentail section may contain consumers whose supplier is inside
children, and this poses the requirement to dry out all consumpers in
the section recursively.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 drivers/base/base.h |  1 +
 drivers/base/core.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index a75c302..37f86ca 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -135,6 +135,7 @@ extern void device_unblock_probing(void);
 
 /* /sys/devices directory */
 extern struct kset *devices_kset;
+extern int device_reorder_consumer(struct device *dev);
 extern void devices_kset_move_last(struct device *dev);
 
 #if defined(CONFIG_MODULES) && defined(CONFIG_SYSFS)
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 8113d2c..db30e86 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -161,6 +161,103 @@ static bool is_consumer(struct device *query, struct device *supplier)
 	return false;
 }
 
+/* recursively move the potential consumers in open section (left, right)
+ * after the barrier
+ */
+static int __device_reorder_consumer(struct device *consumer,
+	struct list_head *left, struct list_head *right,
+	struct pos_info *p)
+{
+	struct list_head *iter;
+	struct device *c_dev, *s_dev, *tail_dev;
+
+	descendants_reorder_after_pos(consumer, p);
+	tail_dev = p->tail;
+	/* (left, right) may contain consumers, hence checking if any moved
+	 * child serving as supplier. The reversing order help us to meet
+	 * the last supplier of a consumer.
+	 */
+	list_opensect_for_each_reverse(iter, left, right) {
+		struct list_head *l_iter, *moved_left, *moved_right;
+
+		moved_left = (&consumer->kobj.entry)->prev;
+		moved_right = tail_dev->kobj.entry.next;
+		/* the moved section may contain potential suppliers */
+		list_opensect_for_each_reverse(l_iter, moved_left,
+			moved_right) {
+			s_dev = list_entry(l_iter, struct device, kobj.entry);
+			c_dev = list_entry(iter, struct device, kobj.entry);
+			/* to fix: this poses extra effort for locking */
+			if (is_consumer(c_dev, s_dev)) {
+				p->tail = NULL;
+				/* to fix: lock issue */
+				p->pos =  s_dev;
+				/* reorder after the last supplier */
+				__device_reorder_consumer(c_dev,
+					l_iter, right, p);
+			}
+		}
+	}
+	return 0;
+}
+
+static int find_last_supplier(struct device *dev, struct device *supplier)
+{
+	struct device_link *link;
+
+	list_for_each_entry_reverse(link, &dev->links.suppliers, c_node) {
+		if (link->supplier == supplier)
+			return 1;
+	}
+	if (dev == supplier)
+		return -1;
+	return 0;
+}
+
+/* When reodering, take care of the range of (old_pos(dev), new_pos(dev)),
+ * there may be requirement to recursively move item.
+ */
+int device_reorder_consumer(struct device *dev)
+{
+	struct list_head *iter, *left, *right;
+	struct device *cur_dev;
+	struct pos_info info;
+	int ret, idx;
+
+	idx = device_links_read_lock();
+	if (list_empty(&dev->links.suppliers)) {
+		device_links_read_unlock(idx);
+		return 0;
+	}
+	spin_lock(&devices_kset->list_lock);
+	list_for_each_prev(iter, &devices_kset->list) {
+		cur_dev = list_entry(iter, struct device, kobj.entry);
+		ret = find_last_supplier(dev, cur_dev);
+		switch (ret) {
+		case -1:
+			goto unlock;
+		case 1:
+			break;
+		case 0:
+			continue;
+		}
+	}
+	BUG_ON(!ret);
+
+	/* record the affected open section */
+	left = dev->kobj.entry.prev;
+	right = iter;
+	info.pos = list_entry(iter, struct device, kobj.entry);
+	info.tail = NULL;
+	/* dry out the consumers in (left,right) */
+	__device_reorder_consumer(dev, left, right, &info);
+
+unlock:
+	spin_unlock(&devices_kset->list_lock);
+	device_links_read_unlock(idx);
+	return 0;
+}
+
 static int device_reorder_to_tail(struct device *dev, void *not_used)
 {
 	struct device_link *link;
-- 
2.7.4
