Return-Path: <nfont@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 43B5DB70E2
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 05:21:27 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8RJBrX3010020
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Sep 2010 13:11:53 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8RJLGRQ027256
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Sep 2010 13:21:16 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o8RJLELP009457
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Sep 2010 13:21:16 -0600
Message-ID: <4CA0EEA8.4050009@austin.ibm.com>
Date: Mon, 27 Sep 2010 14:21:12 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 1/8] v2 Move find_memory_block() routine
References: <4CA0EBEB.1030204@austin.ibm.com>
In-Reply-To: <4CA0EBEB.1030204@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg KH <greg@kroah.com>,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the find_memory_block() routine up to avoid needing a forward
declaration in subsequent patches.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

---
 drivers/base/memory.c |   62 +++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

Index: linux-next/drivers/base/memory.c
===================================================================
--- linux-next.orig/drivers/base/memory.c	2010-09-21 11:59:24.000000000 -0500
+++ linux-next/drivers/base/memory.c	2010-09-21 12:32:45.000000000 -0500
@@ -435,6 +435,37 @@ int __weak arch_get_memory_phys_device(u
 	return 0;
 }
 
+/*
+ * For now, we have a linear search to go find the appropriate
+ * memory_block corresponding to a particular phys_index. If
+ * this gets to be a real problem, we can always use a radix
+ * tree or something here.
+ *
+ * This could be made generic for all sysdev classes.
+ */
+struct memory_block *find_memory_block(struct mem_section *section)
+{
+	struct kobject *kobj;
+	struct sys_device *sysdev;
+	struct memory_block *mem;
+	char name[sizeof(MEMORY_CLASS_NAME) + 9 + 1];
+
+	/*
+	 * This only works because we know that section == sysdev->id
+	 * slightly redundant with sysdev_register()
+	 */
+	sprintf(&name[0], "%s%d", MEMORY_CLASS_NAME, __section_nr(section));
+
+	kobj = kset_find_obj(&memory_sysdev_class.kset, name);
+	if (!kobj)
+		return NULL;
+
+	sysdev = container_of(kobj, struct sys_device, kobj);
+	mem = container_of(sysdev, struct memory_block, sysdev);
+
+	return mem;
+}
+
 static int add_memory_block(int nid, struct mem_section *section,
 			unsigned long state, enum mem_add_context context)
 {
@@ -468,37 +499,6 @@ static int add_memory_block(int nid, str
 	return ret;
 }
 
-/*
- * For now, we have a linear search to go find the appropriate
- * memory_block corresponding to a particular phys_index. If
- * this gets to be a real problem, we can always use a radix
- * tree or something here.
- *
- * This could be made generic for all sysdev classes.
- */
-struct memory_block *find_memory_block(struct mem_section *section)
-{
-	struct kobject *kobj;
-	struct sys_device *sysdev;
-	struct memory_block *mem;
-	char name[sizeof(MEMORY_CLASS_NAME) + 9 + 1];
-
-	/*
-	 * This only works because we know that section == sysdev->id
-	 * slightly redundant with sysdev_register()
-	 */
-	sprintf(&name[0], "%s%d", MEMORY_CLASS_NAME, __section_nr(section));
-
-	kobj = kset_find_obj(&memory_sysdev_class.kset, name);
-	if (!kobj)
-		return NULL;
-
-	sysdev = container_of(kobj, struct sys_device, kobj);
-	mem = container_of(sysdev, struct memory_block, sysdev);
-
-	return mem;
-}
-
 int remove_memory_block(unsigned long node_id, struct mem_section *section,
 		int phys_device)
 {
