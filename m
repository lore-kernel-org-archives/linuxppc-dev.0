Return-Path: <wency@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 21CF02C046C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2012 17:45:02 +1000 (EST)
From: wency@cn.fujitsu.com
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-ia64@vger.kernel.org, cmetcalf@tilera.com
Subject: [RFC PATCH V6 18/19] memory-hotplug: add node_device_release
Date: Fri, 3 Aug 2012 15:49:20 +0800
Message-Id: <1343980161-14254-19-git-send-email-wency@cn.fujitsu.com>
In-Reply-To: <1343980161-14254-1-git-send-email-wency@cn.fujitsu.com>
References: <1343980161-14254-1-git-send-email-wency@cn.fujitsu.com>
Cc: len.brown@intel.com, Wen Congyang <wency@cn.fujitsu.com>,
 isimatu.yasuaki@jp.fujitsu.com, paulus@samba.org, minchan.kim@gmail.com,
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

From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

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
Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
---
 drivers/base/node.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index af1a177..9bc2f57 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -252,6 +252,13 @@ static inline void hugetlb_register_node(struct node *node) {}
 static inline void hugetlb_unregister_node(struct node *node) {}
 #endif
 
+static void node_device_release(struct device *dev)
+{
+	struct node *node_dev = to_node(dev);
+
+	flush_work(&node_dev->node_work);
+	memset(node_dev, 0, sizeof(struct node));
+}
 
 /*
  * register_node - Setup a sysfs device for a node.
@@ -265,6 +272,7 @@ int register_node(struct node *node, int num, struct node *parent)
 
 	node->dev.id = num;
 	node->dev.bus = &node_subsys;
+	node->dev.release = node_device_release;
 	error = device_register(&node->dev);
 
 	if (!error){
-- 
1.7.1
