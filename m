Return-Path: <toshi.kani@hp.com>
Received: from g5t0009.atlanta.hp.com (g5t0009.atlanta.hp.com [15.192.0.46])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 491332C062D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2013 11:05:59 +1100 (EST)
From: Toshi Kani <toshi.kani@hp.com>
To: rjw@sisk.pl, lenb@kernel.org, gregkh@linuxfoundation.org,
 akpm@linux-foundation.org
Subject: [RFC PATCH v2 05/12] mm: Add memory hotplug handlers
Date: Thu, 10 Jan 2013 16:40:23 -0700
Message-Id: <1357861230-29549-6-git-send-email-toshi.kani@hp.com>
In-Reply-To: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
References: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
Cc: linux-s390@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>,
 jiang.liu@huawei.com, wency@cn.fujitsu.com, linux-mm@kvack.org,
 yinghai@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, srivatsa.bhat@linux.vnet.ibm.com,
 guohanjun@huawei.com, bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Added memory hotplug handlers.  mm_add_execute() onlines requested
memory ranges for hot-add & online operations, and mm_del_execute()
offlines them for hot-delete & offline operations.  They are also
used for rollback as well.

mm_del_validate() fails a hot-delete request if a requested memory
range is non-movable when del_movable_only is set.

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
---
 mm/memory_hotplug.c |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index d04ed87..ed3d829 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -29,6 +29,8 @@
 #include <linux/suspend.h>
 #include <linux/mm_inline.h>
 #include <linux/firmware-map.h>
+#include <linux/module.h>
+#include <linux/sys_hotplug.h>
 
 #include <asm/tlbflush.h>
 
@@ -45,6 +47,13 @@ static void generic_online_page(struct page *page);
 
 static online_page_callback_t online_page_callback = generic_online_page;
 
+static int mm_add_execute(struct shp_request *req, int rollback);
+static int mm_del_execute(struct shp_request *req, int rollback);
+
+static int del_movable_only = 0;
+module_param(del_movable_only, int, 0644);
+MODULE_PARM_DESC(del_movable_only, "Restrict hot-remove to movable memory only");
+
 DEFINE_MUTEX(mem_hotplug_mutex);
 
 void lock_memory_hotplug(void)
@@ -1431,3 +1440,95 @@ int remove_memory(u64 start, u64 size)
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 EXPORT_SYMBOL_GPL(remove_memory);
+
+static int mm_add_execute(struct shp_request *req, int rollback)
+{
+	struct shp_device *shp_dev;
+	struct shp_memory *shp_mem;
+	int ret;
+
+	if (rollback)
+		return mm_del_execute(req, 0);
+
+	list_for_each_entry(shp_dev, &req->dev_list, list) {
+		if (shp_dev->class != SHP_CLS_MEMORY)
+			continue;
+
+		shp_mem = &shp_dev->info.mem;
+
+		ret = add_memory(shp_mem->node,
+				shp_mem->start_addr, shp_mem->length);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int mm_del_validate(struct shp_request *req, int rollback)
+{
+	struct shp_device *shp_dev;
+	struct shp_memory *shp_mem;
+	unsigned long start_pfn, nr_pages;
+
+	if (rollback || !del_movable_only)
+		return 0;
+
+	list_for_each_entry(shp_dev, &req->dev_list, list) {
+		if (shp_dev->class != SHP_CLS_MEMORY)
+			continue;
+
+		shp_mem = &shp_dev->info.mem;
+		start_pfn = shp_mem->start_addr >> PAGE_SHIFT;
+		nr_pages = PAGE_ALIGN(shp_mem->length) >> PAGE_SHIFT;
+
+		/*
+		 * Check if this memory range is removable.  This check is
+		 * enabled when del_movable_only is set.
+		 */
+		if (is_mem_section_removable(start_pfn, nr_pages)) {
+			pr_info("Memory [%#010llx-%#010llx] not removable\n",
+				shp_mem->start_addr,
+				shp_mem->start_addr + shp_mem->length-1);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int mm_del_execute(struct shp_request *req, int rollback)
+{
+	struct shp_device *shp_dev;
+	struct shp_memory *shp_mem;
+	int ret;
+
+	if (rollback)
+		return mm_add_execute(req, 0);
+
+	list_for_each_entry(shp_dev, &req->dev_list, list) {
+		if (shp_dev->class != SHP_CLS_MEMORY)
+			continue;
+
+		shp_mem = &shp_dev->info.mem;
+
+		ret = remove_memory(shp_mem->start_addr, shp_mem->length);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int __init mm_shp_init(void)
+{
+	shp_register_handler(SHP_ADD_EXECUTE, mm_add_execute,
+				SHP_MEM_ADD_EXECUTE_ORDER);
+	shp_register_handler(SHP_DEL_VALIDATE, mm_del_validate,
+				SHP_MEM_DEL_VALIDATE_ORDER);
+	shp_register_handler(SHP_DEL_EXECUTE, mm_del_execute,
+				SHP_MEM_DEL_EXECUTE_ORDER);
+
+	return 0;
+}
+module_init(mm_shp_init);
