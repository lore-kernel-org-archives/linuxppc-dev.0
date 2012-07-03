Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 025F62C011B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 16:06:21 +1000 (EST)
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 463A23EE0C1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 15:06:20 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 270E845DE58
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 15:06:20 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 0FC5145DE5E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 15:06:20 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 022991DB8048
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 15:06:20 +0900 (JST)
Received: from g01jpexchyt05.g01.fujitsu.local
 (g01jpexchyt05.g01.fujitsu.local [10.128.194.44])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id AC6801DB8051
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 15:06:19 +0900 (JST)
Message-ID: <4FF28BCE.7000904@jp.fujitsu.com>
Date: Tue, 3 Jul 2012 15:06:06 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-acpi@vger.kernel.org>
Subject: [RFC PATCH v2 13/13] memory-hotplug : remove sysfs file of node
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

The patch adds node_set_offline() and unregister_one_node() to remove_memory()
for removing sysfs file of node.

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
 mm/memory_hotplug.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-3.5-rc4/mm/memory_hotplug.c
===================================================================
--- linux-3.5-rc4.orig/mm/memory_hotplug.c	2012-07-03 14:22:21.012982694 +0900
+++ linux-3.5-rc4/mm/memory_hotplug.c	2012-07-03 14:22:25.405925554 +0900
@@ -702,6 +702,11 @@ int remove_memory(int nid, u64 start, u6
 	/* remove memmap entry */
 	firmware_map_remove(start, start + size - 1, "System RAM");

+	if (!node_present_pages(nid)) {
+		node_set_offline(nid);
+		unregister_one_node(nid);
+	}
+
 	__remove_pages(start >> PAGE_SHIFT, size >> PAGE_SHIFT);
 	unlock_memory_hotplug();
 	return 0;
