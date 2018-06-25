Return-Path: <kernelfans@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Dcz36m6TzF18f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2018 15:23:43 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id o18-v6so5569465pll.12
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jun 2018 22:23:43 -0700 (PDT)
From: Pingfan Liu <kernelfans@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Pingfan Liu <kernelfans@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Grygorii Strashko <grygorii.strashko@ti.com>,
 Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Dave Young <dyoung@redhat.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] drivers/base: introduce some help routines for reordering
 a group of dev
Date: Mon, 25 Jun 2018 13:23:05 +0800
Message-Id: <1529904187-18673-2-git-send-email-kernelfans@gmail.com>
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

This patch introduce some help routines used by next patch. It aims to
ease reviewing, while the next patch will concentrate on algorithm.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: linux-pci@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 drivers/base/core.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 36622b5..8113d2c 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -123,6 +123,44 @@ static int device_is_dependent(struct device *dev, void *target)
 	return ret;
 }
 
+struct pos_info {
+	struct device *pos;
+	struct device *tail;
+};
+
+/* caller takes the devices_kset->list_lock */
+static int descendants_reorder_after_pos(struct device *dev,
+	void *data)
+{
+	struct device *pos;
+	struct pos_info *p = data;
+
+	pos = p->pos;
+	pr_debug("devices_kset: Moving %s after %s\n",
+		 dev_name(dev), dev_name(pos));
+	device_for_each_child(dev, p, descendants_reorder_after_pos);
+	/* children at the tail */
+	list_move(&dev->kobj.entry, &pos->kobj.entry);
+	/* record the right boundary of the section */
+	if (p->tail == NULL)
+		p->tail = dev;
+	return 0;
+}
+
+/* iterate over an open section */
+#define list_opensect_for_each_reverse(cur, left, right)	\
+	for (cur = right->prev; cur == left; cur = cur->prev)
+
+static bool is_consumer(struct device *query, struct device *supplier)
+{
+	struct device_link *link;
+	/* todo, lock protection */
+	list_for_each_entry(link, &supplier->links.consumers, s_node)
+		if (link->consumer == query)
+			return true;
+	return false;
+}
+
 static int device_reorder_to_tail(struct device *dev, void *not_used)
 {
 	struct device_link *link;
-- 
2.7.4
