Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9DF57B6FB6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 15:54:49 +1000 (EST)
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id D7E6C3EE0C5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 14:54:47 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id BEA0D45DE4D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 14:54:47 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 9474645DE51
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 14:54:47 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 83867E18005
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 14:54:47 +0900 (JST)
Received: from g01jpexchkw06.g01.fujitsu.local
 (g01jpexchkw06.g01.fujitsu.local [10.0.194.45])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 341AB1DB803B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 14:54:47 +0900 (JST)
Message-ID: <4FEAA019.7070302@jp.fujitsu.com>
Date: Wed, 27 Jun 2012 14:54:33 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-acpi@vger.kernel.org>
Subject: [RFC PATCH 8/12] memory-hotplug : move register_page_bootmem_info_node
 and put_page_bootmem for sparse-vmemmap
References: <4FEA9C88.1070800@jp.fujitsu.com>
In-Reply-To: <4FEA9C88.1070800@jp.fujitsu.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Cc: len.brown@intel.com, wency@cn.fujitsu.com, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, cl@linux.com,
 akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For implementing register_page_bootmem_info_node of sparse-vmemmap,
register_page_bootmem_info_node and put_page_bootmem are moved to
memory_hotplug.c

CC: Len Brown <len.brown@intel.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Paul Mackerras <paulus@samba.org>
CC: Christoph Lameter <cl@linux.com>
Cc: Minchan Kim <minchan.kim@gmail.com>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
CC: Wen Congyan <wency@cn.fujitsu.com>
Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

---
 include/linux/memory_hotplug.h |    9 ---------
 mm/memory_hotplug.c            |    8 ++++++--
 2 files changed, 6 insertions(+), 11 deletions(-)

Index: linux-3.5-rc4/include/linux/memory_hotplug.h
===================================================================
--- linux-3.5-rc4.orig/include/linux/memory_hotplug.h	2012-06-26 13:56:34.372988299 +0900
+++ linux-3.5-rc4/include/linux/memory_hotplug.h	2012-06-26 14:05:16.603459518 +0900
@@ -160,17 +160,8 @@ static inline void arch_refresh_nodedata
 #endif /* CONFIG_NUMA */
 #endif /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */

-#ifdef CONFIG_SPARSEMEM_VMEMMAP
-static inline void register_page_bootmem_info_node(struct pglist_data *pgdat)
-{
-}
-static inline void put_page_bootmem(struct page *page)
-{
-}
-#else
 extern void register_page_bootmem_info_node(struct pglist_data *pgdat);
 extern void put_page_bootmem(struct page *page);
-#endif

 /*
  * Lock for memory hotplug guarantees 1) all callbacks for memory hotplug
Index: linux-3.5-rc4/mm/memory_hotplug.c
===================================================================
--- linux-3.5-rc4.orig/mm/memory_hotplug.c	2012-06-26 14:03:37.564697621 +0900
+++ linux-3.5-rc4/mm/memory_hotplug.c	2012-06-26 14:05:16.604459506 +0900
@@ -91,7 +91,6 @@ static void release_memory_resource(stru
 }

 #ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
-#ifndef CONFIG_SPARSEMEM_VMEMMAP
 static void get_page_bootmem(unsigned long info,  struct page *page,
 			     unsigned long type)
 {
@@ -127,6 +126,7 @@ void __ref put_page_bootmem(struct page

 }

+#ifndef CONFIG_SPARSEMEM_VMEMMAP
 static void register_page_bootmem_info_section(unsigned long start_pfn)
 {
 	unsigned long *usemap, mapsize, section_nr, i;
@@ -163,6 +163,11 @@ static void register_page_bootmem_info_s
 		get_page_bootmem(section_nr, page, MIX_SECTION_INFO);

 }
+#else
+static inline void register_page_bootmem_info_section(unsigned long start_pfn)
+{
+}
+#endif

 void register_page_bootmem_info_node(struct pglist_data *pgdat)
 {
@@ -198,7 +203,6 @@ void register_page_bootmem_info_node(str
 		register_page_bootmem_info_section(pfn);

 }
-#endif /* !CONFIG_SPARSEMEM_VMEMMAP */

 static void grow_zone_span(struct zone *zone, unsigned long start_pfn,
 			   unsigned long end_pfn)
