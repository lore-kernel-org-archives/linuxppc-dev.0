Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7A1AA2C00F6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 16:05:30 +1000 (EST)
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id C054E3EE0C0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 15:05:28 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id A8F1045DE56
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 15:05:28 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 9369145DE52
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 15:05:28 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8800A1DB803E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 15:05:28 +0900 (JST)
Received: from g01jpexchyt05.g01.fujitsu.local
 (g01jpexchyt05.g01.fujitsu.local [10.128.194.44])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 3D7571DB8038
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 15:05:28 +0900 (JST)
Message-ID: <4FF28B9B.5010409@jp.fujitsu.com>
Date: Tue, 3 Jul 2012 15:05:15 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-acpi@vger.kernel.org>
Subject: [RFC PATCH v2 12/13] memory-hotplug : add node_device_release
References: <4FF287C3.4030901@jp.fujitsu.com>
In-Reply-To: <4FF287C3.4030901@jp.fujitsu.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Cc: len.brown@intel.com, paulus@samba.org, minchan.kim@gmail.com,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, cl@linux.com,
 akpm@linux-foundation.org, liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When calling unregister_node(), the function shows following message at
device_release().

Device 'node2' does not have a release() function, it is broken and must be
fixed.

So the patch implements node_device_release()

CC: David Rientjes <rientjes@google.com>
CC: Jiang Liu <liuj97@gmail.com>
CC: Len Brown <len.brown@intel.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Christoph Lameter <cl@linux.com>
Cc: Minchan Kim <minchan.kim@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

---
 drivers/base/node.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-3.5-rc4/drivers/base/node.c
===================================================================
--- linux-3.5-rc4.orig/drivers/base/node.c	2012-07-03 14:21:44.882432167 +0900
+++ linux-3.5-rc4/drivers/base/node.c	2012-07-03 14:22:23.296951921 +0900
@@ -252,6 +252,12 @@ static inline void hugetlb_register_node
 static inline void hugetlb_unregister_node(struct node *node) {}
 #endif

+static void node_device_release(struct device *dev)
+{
+	struct node *node_dev = to_node(dev);
+
+	memset(node_dev, 0, sizeof(struct node));
+}

 /*
  * register_node - Setup a sysfs device for a node.
@@ -265,6 +271,7 @@ int register_node(struct node *node, int

 	node->dev.id = num;
 	node->dev.bus = &node_subsys;
+	node->dev.release = node_device_release;
 	error = device_register(&node->dev);

 	if (!error){
