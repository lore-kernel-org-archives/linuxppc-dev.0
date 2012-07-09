Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 476142C02FC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 20:27:18 +1000 (EST)
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 8DF7D3EE0C0
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 19:27:16 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 6D7AA45DEB3
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 19:27:16 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 462DC45DEAD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 19:27:16 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 345EF1DB803E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 19:27:16 +0900 (JST)
Received: from g01jpexchyt10.g01.fujitsu.local
 (g01jpexchyt10.g01.fujitsu.local [10.128.194.49])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id D78A21DB803B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 19:27:15 +0900 (JST)
Message-ID: <4FFAB1F3.1020304@jp.fujitsu.com>
Date: Mon, 9 Jul 2012 19:26:59 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-acpi@vger.kernel.org>
Subject: [RFC PATCH v3 5/13] memory-hotplug : does not release memory region
 in PAGES_PER_SECTION chunks
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

Since applying a patch(de7f0cba96786c), release_mem_region() has been changed
as called in PAGES_PER_SECTION chunks because register_memory_resource() is
called in PAGES_PER_SECTION chunks by add_memory(). But it seems firmware
dependency. If CRS are written in the PAGES_PER_SECTION chunks in ACPI DSDT
Table, register_memory_resource() is called in PAGES_PER_SECTION chunks.
But if CRS are written in the DIMM unit in ACPI DSDT Table,
register_memory_resource() is called in DIMM unit. So release_mem_region()
should not be called in PAGES_PER_SECTION chunks. The patch fixes it.

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
 arch/powerpc/platforms/pseries/hotplug-memory.c |   13 +++++++++----
 mm/memory_hotplug.c                             |    4 ++--
 2 files changed, 11 insertions(+), 6 deletions(-)

Index: linux-3.5-rc4/mm/memory_hotplug.c
===================================================================
--- linux-3.5-rc4.orig/mm/memory_hotplug.c	2012-07-03 14:22:03.549198802 +0900
+++ linux-3.5-rc4/mm/memory_hotplug.c	2012-07-03 14:22:05.919169458 +0900
@@ -358,11 +358,11 @@ int __remove_pages(struct zone *zone, un
 	BUG_ON(phys_start_pfn & ~PAGE_SECTION_MASK);
 	BUG_ON(nr_pages % PAGES_PER_SECTION);

+	release_mem_region(phys_start_pfn << PAGE_SHIFT,  nr_pages * PAGE_SIZE);
+
 	sections_to_remove = nr_pages / PAGES_PER_SECTION;
 	for (i = 0; i < sections_to_remove; i++) {
 		unsigned long pfn = phys_start_pfn + i*PAGES_PER_SECTION;
-		release_mem_region(pfn << PAGE_SHIFT,
-				   PAGES_PER_SECTION << PAGE_SHIFT);
 		ret = __remove_section(zone, __pfn_to_section(pfn));
 		if (ret)
 			break;
Index: linux-3.5-rc4/arch/powerpc/platforms/pseries/hotplug-memory.c
===================================================================
--- linux-3.5-rc4.orig/arch/powerpc/platforms/pseries/hotplug-memory.c	2012-07-03 14:21:45.641422678
+0900
+++ linux-3.5-rc4/arch/powerpc/platforms/pseries/hotplug-memory.c	2012-07-03 14:22:05.920169437 +0900
@@ -77,7 +77,8 @@ static int pseries_remove_memblock(unsig
 {
 	unsigned long start, start_pfn;
 	struct zone *zone;
-	int ret;
+	int i, ret;
+	int sections_to_remove;

 	start_pfn = base >> PAGE_SHIFT;

@@ -97,9 +98,13 @@ static int pseries_remove_memblock(unsig
 	 * to sysfs "state" file and we can't remove sysfs entries
 	 * while writing to it. So we have to defer it to here.
 	 */
-	ret = __remove_pages(zone, start_pfn, memblock_size >> PAGE_SHIFT);
-	if (ret)
-		return ret;
+	sections_to_remove = (memblock_size >> PAGE_SHIFT) / PAGES_PER_SECTION;
+	for (i = 0; i < sections_to_remove; i++) {
+		unsigned long pfn = start_pfn + i * PAGES_PER_SECTION;
+		ret = __remove_pages(zone, start_pfn,  PAGES_PER_SECTION);
+		if (ret)
+			return ret;
+	}

 	/*
 	 * Update memory regions for memory remove
