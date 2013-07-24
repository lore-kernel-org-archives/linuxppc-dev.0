Return-Path: <nfont@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9B4B82C0096
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 04:41:24 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Thu, 25 Jul 2013 00:03:15 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 451361258053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 00:10:41 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6OIgCM537421206
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 00:12:12 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6OIfF72010434
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2013 04:41:15 +1000
Message-ID: <51F01FC7.5040403@linux.vnet.ibm.com>
Date: Wed, 24 Jul 2013 13:41:11 -0500
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/8] Add notifiers for memory hot add/remove
References: <51F01E06.6090800@linux.vnet.ibm.com>
In-Reply-To: <51F01E06.6090800@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 isimatu.yasuaki@jp.fujitsu.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to allow architectures or other subsystems to do any needed
work prior to hot adding or hot removing memory the memory notifier
chain should be updated to provide notifications of these events.

This patch adds the notifications for memory hot add and hot remove.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
--
 Documentation/memory-hotplug.txt |   26 +++++++++++++++++++++++---
 include/linux/memory.h           |    6 ++++++
 mm/memory_hotplug.c              |   25 ++++++++++++++++++++++---
 3 files changed, 51 insertions(+), 6 deletions(-)

Index: linux/include/linux/memory.h
===================================================================
--- linux.orig/include/linux/memory.h
+++ linux/include/linux/memory.h
@@ -50,6 +50,12 @@ int arch_get_memory_phys_device(unsigned
 #define	MEM_GOING_ONLINE	(1<<3)
 #define	MEM_CANCEL_ONLINE	(1<<4)
 #define	MEM_CANCEL_OFFLINE	(1<<5)
+#define MEM_BEING_HOT_REMOVED	(1<<6)
+#define MEM_HOT_REMOVED		(1<<7)
+#define MEM_CANCEL_HOT_REMOVE	(1<<8)
+#define MEM_BEING_HOT_ADDED	(1<<9)
+#define MEM_HOT_ADDED		(1<<10)
+#define MEM_CANCEL_HOT_ADD	(1<<11)

 struct memory_notify {
 	unsigned long start_pfn;
Index: linux/mm/memory_hotplug.c
===================================================================
--- linux.orig/mm/memory_hotplug.c
+++ linux/mm/memory_hotplug.c
@@ -1073,17 +1073,25 @@ out:
 int __ref add_memory(int nid, u64 start, u64 size)
 {
 	pg_data_t *pgdat = NULL;
-	bool new_pgdat;
+	bool new_pgdat = false;
 	bool new_node;
-	struct resource *res;
+	struct resource *res = NULL;
+	struct memory_notify arg;
 	int ret;

 	lock_memory_hotplug();

+	arg.start_pfn = start >> PAGE_SHIFT;
+	arg.nr_pages = size / PAGE_SIZE;
+	ret = memory_notify(MEM_BEING_HOT_ADDED, &arg);
+	ret = notifier_to_errno(ret);
+	if (ret)
+		goto error;
+
 	res = register_memory_resource(start, size);
 	ret = -EEXIST;
 	if (!res)
-		goto out;
+		goto error;

 	{	/* Stupid hack to suppress address-never-null warning */
 		void *p = NODE_DATA(nid);
@@ -1119,9 +1127,12 @@ int __ref add_memory(int nid, u64 start,
 	/* create new memmap entry */
 	firmware_map_add_hotplug(start, start + size, "System RAM");

+	memory_notify(MEM_HOT_ADDED, &arg);
 	goto out;

 error:
+	memory_notify(MEM_CANCEL_HOT_ADD, &arg);
+
 	/* rollback pgdat allocation and others */
 	if (new_pgdat)
 		rollback_node_hotadd(nid, pgdat);
@@ -1784,10 +1795,15 @@ EXPORT_SYMBOL(try_offline_node);

 void __ref remove_memory(int nid, u64 start, u64 size)
 {
+	struct memory_notify arg;
 	int ret;

 	lock_memory_hotplug();

+	arg.start_pfn = start >> PAGE_SHIFT;
+	arg.nr_pages = size / PAGE_SIZE;
+	memory_notify(MEM_BEING_HOT_REMOVED, &arg);
+
 	/*
 	 * All memory blocks must be offlined before removing memory.  Check
 	 * whether all memory blocks in question are offline and trigger a BUG()
@@ -1796,6 +1812,7 @@ void __ref remove_memory(int nid, u64 st
 	ret = walk_memory_range(PFN_DOWN(start), PFN_UP(start + size - 1), NULL,
 				is_memblock_offlined_cb);
 	if (ret) {
+		memory_notify(MEM_CANCEL_HOT_REMOVE, &arg);
 		unlock_memory_hotplug();
 		BUG();
 	}
@@ -1807,6 +1824,8 @@ void __ref remove_memory(int nid, u64 st

 	try_offline_node(nid);

+	memory_notify(MEM_HOT_REMOVED, &arg);
+
 	unlock_memory_hotplug();
 }
 EXPORT_SYMBOL_GPL(remove_memory);
Index: linux/Documentation/memory-hotplug.txt
===================================================================
--- linux.orig/Documentation/memory-hotplug.txt
+++ linux/Documentation/memory-hotplug.txt
@@ -371,7 +371,9 @@ Need more implementation yet....
 --------------------------------
 8. Memory hotplug event notifier
 --------------------------------
-Memory hotplug has event notifier. There are 6 types of notification.
+Memory hotplug has event notifier. There are 12 types of notification, the
+first six relate to memory hotplug and the second six relate to memory hot
+add/remove.

 MEMORY_GOING_ONLINE
   Generated before new memory becomes available in order to be able to
@@ -398,6 +400,24 @@ MEMORY_CANCEL_OFFLINE
 MEMORY_OFFLINE
   Generated after offlining memory is complete.

+MEMORY_BEING_HOT_REMOVED
+  Generated prior to the process of hot removing memory.
+
+MEMORY_CANCEL_HOT_REMOVE
+  Generated if MEMORY_BEING_HOT_REMOVED fails.
+
+MEMORY_HOT_REMOVED
+  Generated when memory has been successfully hot removed.
+
+MEMORY_BEING_HOT_ADDED
+  Generated prior to the process of hot adding memory.
+
+MEMORY_HOT_ADD_CANCEL
+  Generated if MEMORY_BEING_HOT_ADDED fails.
+
+MEMORY_HOT_ADDED
+  Generated when memory has successfully been hot added.
+
 A callback routine can be registered by
   hotplug_memory_notifier(callback_func, priority)

@@ -412,8 +432,8 @@ struct memory_notify {
        int status_change_nid;
 }

-start_pfn is start_pfn of online/offline memory.
-nr_pages is # of pages of online/offline memory.
+start_pfn is start_pfn of online/offline/add/remove memory.
+nr_pages is # of pages of online/offline/add/remove memory.
 status_change_nid_normal is set node id when N_NORMAL_MEMORY of nodemask
 is (will be) set/clear, if this is -1, then nodemask status is not changed.
 status_change_nid_high is set node id when N_HIGH_MEMORY of nodemask
