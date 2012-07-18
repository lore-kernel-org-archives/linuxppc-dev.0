Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F1BF02C0382
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2012 20:05:55 +1000 (EST)
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 498353EE0C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2012 19:05:54 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 2308945DEBB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2012 19:05:54 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id E9C1545DEAD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2012 19:05:53 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id DC1D71DB803B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2012 19:05:53 +0900 (JST)
Received: from g01jpexchyt01.g01.fujitsu.local
 (g01jpexchyt01.g01.fujitsu.local [10.128.194.40])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 8108A1DB803F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jul 2012 19:05:53 +0900 (JST)
Message-ID: <50068A6E.5050904@jp.fujitsu.com>
Date: Wed, 18 Jul 2012 19:05:34 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-acpi@vger.kernel.org>
Subject: [RFC PATCH v4 1/13] memory-hotplug : rename remove_memory to
 offline_memory
References: <50068974.1070409@jp.fujitsu.com>
In-Reply-To: <50068974.1070409@jp.fujitsu.com>
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

remove_memory() does not remove memory but just offlines memory. The patch
changes name of it to offline_memory().

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
 drivers/acpi/acpi_memhotplug.c |    2 +-
 drivers/base/memory.c          |    4 ++--
 include/linux/memory_hotplug.h |    2 +-
 mm/memory_hotplug.c            |    6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

Index: linux-3.5-rc4/drivers/acpi/acpi_memhotplug.c
===================================================================
--- linux-3.5-rc4.orig/drivers/acpi/acpi_memhotplug.c	2012-07-03 14:21:46.102416917 +0900
+++ linux-3.5-rc4/drivers/acpi/acpi_memhotplug.c	2012-07-03 14:21:49.458374960 +0900
@@ -318,7 +318,7 @@ static int acpi_memory_disable_device(st
 	 */
 	list_for_each_entry_safe(info, n, &mem_device->res_list, list) {
 		if (info->enabled) {
-			result = remove_memory(info->start_addr, info->length);
+			result = offline_memory(info->start_addr, info->length);
 			if (result)
 				return result;
 		}
Index: linux-3.5-rc4/drivers/base/memory.c
===================================================================
--- linux-3.5-rc4.orig/drivers/base/memory.c	2012-07-03 14:21:46.095417003 +0900
+++ linux-3.5-rc4/drivers/base/memory.c	2012-07-03 14:21:49.459374948 +0900
@@ -266,8 +266,8 @@ memory_block_action(unsigned long phys_i
 			break;
 		case MEM_OFFLINE:
 			start_paddr = page_to_pfn(first_page) << PAGE_SHIFT;
-			ret = remove_memory(start_paddr,
-					    nr_pages << PAGE_SHIFT);
+			ret = offline_memory(start_paddr,
+					     nr_pages << PAGE_SHIFT);
 			break;
 		default:
 			WARN(1, KERN_WARNING "%s(%ld, %ld) unknown action: "
Index: linux-3.5-rc4/mm/memory_hotplug.c
===================================================================
--- linux-3.5-rc4.orig/mm/memory_hotplug.c	2012-07-03 14:21:46.102416917 +0900
+++ linux-3.5-rc4/mm/memory_hotplug.c	2012-07-03 14:21:49.466374860 +0900
@@ -990,7 +990,7 @@ out:
 	return ret;
 }
 
-int remove_memory(u64 start, u64 size)
+int offline_memory(u64 start, u64 size)
 {
 	unsigned long start_pfn, end_pfn;
 
@@ -999,9 +999,9 @@ int remove_memory(u64 start, u64 size)
 	return offline_pages(start_pfn, end_pfn, 120 * HZ);
 }
 #else
-int remove_memory(u64 start, u64 size)
+int offline_memory(u64 start, u64 size)
 {
 	return -EINVAL;
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
-EXPORT_SYMBOL_GPL(remove_memory);
+EXPORT_SYMBOL_GPL(offline_memory);
Index: linux-3.5-rc4/include/linux/memory_hotplug.h
===================================================================
--- linux-3.5-rc4.orig/include/linux/memory_hotplug.h	2012-07-03 14:21:46.102416917 +0900
+++ linux-3.5-rc4/include/linux/memory_hotplug.h	2012-07-03 14:21:49.471374796 +0900
@@ -233,7 +233,7 @@ static inline int is_mem_section_removab
 extern int mem_online_node(int nid);
 extern int add_memory(int nid, u64 start, u64 size);
 extern int arch_add_memory(int nid, u64 start, u64 size);
-extern int remove_memory(u64 start, u64 size);
+extern int offline_memory(u64 start, u64 size);
 extern int sparse_add_one_section(struct zone *zone, unsigned long start_pfn,
 								int nr_pages);
 extern void sparse_remove_one_section(struct zone *zone, struct mem_section *ms);
