Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail8.fujitsu.co.jp (fgwmail8.fujitsu.co.jp [192.51.44.38])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9471DB6FBA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 15:51:50 +1000 (EST)
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 by fgwmail8.fujitsu.co.jp (Postfix) with ESMTP id 0F0011793B54
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 14:44:37 +0900 (JST)
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id E37A63EE0AE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 14:44:34 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id CD86045DD78
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 14:44:34 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id AD2D245DD74
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 14:44:34 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 9F702E18004
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 14:44:34 +0900 (JST)
Received: from g01jpexchkw07.g01.fujitsu.local
 (g01jpexchkw07.g01.fujitsu.local [10.0.194.46])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 5B5C21DB802C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 14:44:34 +0900 (JST)
Message-ID: <4FEA9DB1.7010303@jp.fujitsu.com>
Date: Wed, 27 Jun 2012 14:44:17 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-acpi@vger.kernel.org>
Subject: [RFC PATCH 2/12] memory-hogplug : check memory offline in
 offline_pages
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

When offline_pages() is called to offlined memory, the function fails since
all memory has been offlined. In this case, the function should succeed.
The patch adds the check function into offline_pages().

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
 drivers/base/memory.c  |   20 ++++++++++++++++++++
 include/linux/memory.h |    1 +
 mm/memory_hotplug.c    |    5 +++++
 3 files changed, 26 insertions(+)

Index: linux-3.5-rc4/drivers/base/memory.c
===================================================================
--- linux-3.5-rc4.orig/drivers/base/memory.c	2012-06-26 13:28:16.726211752 +0900
+++ linux-3.5-rc4/drivers/base/memory.c	2012-06-26 13:34:22.423639904 +0900
@@ -70,6 +70,26 @@ void unregister_memory_isolate_notifier(
 }
 EXPORT_SYMBOL(unregister_memory_isolate_notifier);

+bool memory_is_offline(unsigned long start_pfn, unsigned long end_pfn)
+{
+	struct memory_block *mem;
+	struct mem_section *section;
+	unsigned long pfn, section_nr;
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
+		section_nr = pfn_to_section_nr(pfn);
+		section = __nr_to_section(section_nr);
+		mem = find_memory_block(section);
+		if (!mem)
+			continue;
+		if (mem->state == MEM_OFFLINE)
+			continue;
+		return false;
+	}
+
+	return true;
+}
+
 /*
  * register_memory - Setup a sysfs device for a memory block
  */
Index: linux-3.5-rc4/include/linux/memory.h
===================================================================
--- linux-3.5-rc4.orig/include/linux/memory.h	2012-06-25 04:53:04.000000000 +0900
+++ linux-3.5-rc4/include/linux/memory.h	2012-06-26 13:34:22.424639891 +0900
@@ -120,6 +120,7 @@ extern int memory_isolate_notify(unsigne
 extern struct memory_block *find_memory_block_hinted(struct mem_section *,
 							struct memory_block *);
 extern struct memory_block *find_memory_block(struct mem_section *);
+extern bool memory_is_offline(unsigned long start_pfn, unsigned long end_pfn);
 #define CONFIG_MEM_BLOCK_SIZE	(PAGES_PER_SECTION<<PAGE_SHIFT)
 enum mem_add_context { BOOT, HOTPLUG };
 #endif /* CONFIG_MEMORY_HOTPLUG_SPARSE */
Index: linux-3.5-rc4/mm/memory_hotplug.c
===================================================================
--- linux-3.5-rc4.orig/mm/memory_hotplug.c	2012-06-26 13:28:16.743211538 +0900
+++ linux-3.5-rc4/mm/memory_hotplug.c	2012-06-26 13:48:38.264940468 +0900
@@ -887,6 +887,11 @@ static int __ref offline_pages(unsigned

 	lock_memory_hotplug();

+	if (memory_is_offline(start_pfn, end_pfn)) {
+		ret = 0;
+		goto out;
+	}
+
 	zone = page_zone(pfn_to_page(start_pfn));
 	node = zone_to_nid(zone);
 	nr_pages = end_pfn - start_pfn;
