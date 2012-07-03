Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BFB242C00DA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 15:56:58 +1000 (EST)
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id E671F3EE0B6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 14:56:56 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id CA31745DE5C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 14:56:56 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id AEA1D45DE55
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 14:56:56 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9B4751DB805A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 14:56:56 +0900 (JST)
Received: from g01jpexchyt09.g01.fujitsu.local
 (g01jpexchyt09.g01.fujitsu.local [10.128.194.48])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 42EDD1DB8051
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2012 14:56:56 +0900 (JST)
Message-ID: <4FF28996.10702@jp.fujitsu.com>
Date: Tue, 3 Jul 2012 14:56:38 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-acpi@vger.kernel.org>
Subject: [RFC PATCH v2 4/13] memory-hotplug : remove /sys/firmware/memmap/X
 sysfs
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

When (hot)adding memory into system, /sys/firmware/memmap/X/{end, start, type}
sysfs files are created. But there is no code to remove these files. The patch
implements the function to remove them.

Note : The code does not free firmware_map_entry since there is no way to free
       memory which is allocated by bootmem.

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
 drivers/firmware/memmap.c    |   70 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/firmware-map.h |    6 +++
 mm/memory_hotplug.c          |    6 +++
 3 files changed, 81 insertions(+), 1 deletion(-)

Index: linux-3.5-rc4/mm/memory_hotplug.c
===================================================================
--- linux-3.5-rc4.orig/mm/memory_hotplug.c	2012-07-03 14:22:00.190240794 +0900
+++ linux-3.5-rc4/mm/memory_hotplug.c	2012-07-03 14:22:03.549198802 +0900
@@ -661,7 +661,11 @@ EXPORT_SYMBOL_GPL(add_memory);

 int remove_memory(int nid, u64 start, u64 size)
 {
-	return -EBUSY;
+	lock_memory_hotplug();
+	/* remove memmap entry */
+	firmware_map_remove(start, start + size - 1, "System RAM");
+	unlock_memory_hotplug();
+	return 0;

 }
 EXPORT_SYMBOL_GPL(remove_memory);
Index: linux-3.5-rc4/include/linux/firmware-map.h
===================================================================
--- linux-3.5-rc4.orig/include/linux/firmware-map.h	2012-07-03 14:21:45.766421116 +0900
+++ linux-3.5-rc4/include/linux/firmware-map.h	2012-07-03 14:22:03.550198789 +0900
@@ -25,6 +25,7 @@

 int firmware_map_add_early(u64 start, u64 end, const char *type);
 int firmware_map_add_hotplug(u64 start, u64 end, const char *type);
+int firmware_map_remove(u64 start, u64 end, const char *type);

 #else /* CONFIG_FIRMWARE_MEMMAP */

@@ -38,6 +39,11 @@ static inline int firmware_map_add_hotpl
 	return 0;
 }

+static inline int firmware_map_remove(u64 start, u64 end, const char *type)
+{
+	return 0;
+}
+
 #endif /* CONFIG_FIRMWARE_MEMMAP */

 #endif /* _LINUX_FIRMWARE_MAP_H */
Index: linux-3.5-rc4/drivers/firmware/memmap.c
===================================================================
--- linux-3.5-rc4.orig/drivers/firmware/memmap.c	2012-07-03 14:21:45.761421180 +0900
+++ linux-3.5-rc4/drivers/firmware/memmap.c	2012-07-03 14:22:03.569198549 +0900
@@ -79,7 +79,16 @@ static const struct sysfs_ops memmap_att
 	.show = memmap_attr_show,
 };

+static void release_firmware_map_entry(struct kobject *kobj)
+{
+	/*
+	 * FIXME : There is no idea.
+	 *         How to free the entry which allocated bootmem?
+	 */
+}
+
 static struct kobj_type memmap_ktype = {
+	.release	= release_firmware_map_entry,
 	.sysfs_ops	= &memmap_attr_ops,
 	.default_attrs	= def_attrs,
 };
@@ -123,6 +132,16 @@ static int firmware_map_add_entry(u64 st
 	return 0;
 }

+/**
+ * firmware_map_remove_entry() - Does the real work to remove a firmware
+ * memmap entry.
+ * @entry: removed entry.
+ **/
+static inline void firmware_map_remove_entry(struct firmware_map_entry *entry)
+{
+	list_del(&entry->list);
+}
+
 /*
  * Add memmap entry on sysfs
  */
@@ -144,6 +163,31 @@ static int add_sysfs_fw_map_entry(struct
 	return 0;
 }

+/*
+ * Remove memmap entry on sysfs
+ */
+static inline void remove_sysfs_fw_map_entry(struct firmware_map_entry *entry)
+{
+	kobject_put(&entry->kobj);
+}
+
+/*
+ * Search memmap entry
+ */
+
+struct firmware_map_entry * __meminit
+find_firmware_map_entry(u64 start, u64 end, const char *type)
+{
+	struct firmware_map_entry *entry;
+
+	list_for_each_entry(entry, &map_entries, list)
+		if ((entry->start == start) && (entry->end == end) &&
+		    (!strcmp(entry->type, type)))
+			return entry;
+
+	return NULL;
+}
+
 /**
  * firmware_map_add_hotplug() - Adds a firmware mapping entry when we do
  * memory hotplug.
@@ -196,6 +240,32 @@ int __init firmware_map_add_early(u64 st
 	return firmware_map_add_entry(start, end, type, entry);
 }

+/**
+ * firmware_map_remove() - remove a firmware mapping entry
+ * @start: Start of the memory range.
+ * @end:   End of the memory range (inclusive).
+ * @type:  Type of the memory range.
+ *
+ * removes a firmware mapping entry.
+ *
+ * Returns 0 on success, or -EINVAL if no entry.
+ **/
+int __meminit firmware_map_remove(u64 start, u64 end, const char *type)
+{
+	struct firmware_map_entry *entry;
+
+	entry = find_firmware_map_entry(start, end, type);
+	if (!entry)
+		return -EINVAL;
+
+	/* remove the memmap entry */
+	remove_sysfs_fw_map_entry(entry);
+
+	firmware_map_remove_entry(entry);
+
+	return 0;
+}
+
 /*
  * Sysfs functions -------------------------------------------------------------
  */
