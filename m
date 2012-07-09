Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 09FBE2C0040
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 20:35:07 +1000 (EST)
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 2DF883EE0BC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 19:35:06 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id F002C45DEB4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 19:35:05 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id D3D5345DEAD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 19:35:05 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id C184F1DB8040
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 19:35:05 +0900 (JST)
Received: from g01jpexchyt01.g01.fujitsu.local
 (g01jpexchyt01.g01.fujitsu.local [10.128.194.40])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 6BE7F1DB803F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 19:35:05 +0900 (JST)
Message-ID: <4FFAB3C6.7020803@jp.fujitsu.com>
Date: Mon, 9 Jul 2012 19:34:46 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-acpi@vger.kernel.org>
Subject: [RFC PATCH v3 12/13] memory-hotplug : add node_device_release
References: <4FFAB0A2.8070304@jp.fujitsu.com>
In-Reply-To: <4FFAB0A2.8070304@jp.fujitsu.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Cc: len.brown@intel.com, wency@cn.fujitsu.com, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 cl@linux.com, akpm@linux-foundation.org, liuj97@gmail.com
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
CC: Wen Congyang <wency@cn.fujitsu.com>
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
