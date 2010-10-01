Return-Path: <nfont@austin.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 783E9B70E8
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Oct 2010 04:28:47 +1000 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o91I97qo025717
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 14:09:07 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o91ISgdo1413360
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 14:28:42 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o91ISf8o018714
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 14:28:42 -0400
Message-ID: <4CA62857.4030803@austin.ibm.com>
Date: Fri, 01 Oct 2010 13:28:39 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/9] v3 Move find_memory_block routine
References: <4CA62700.7010809@austin.ibm.com>
In-Reply-To: <4CA62700.7010809@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Greg KH <greg@kroah.com>, steiner@sgi.com, Robin Holt <holt@sgi.com>,
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
--- linux-next.orig/drivers/base/memory.c	2010-09-29 14:56:26.000000000 -0500
+++ linux-next/drivers/base/memory.c	2010-09-30 14:09:36.000000000 -0500
@@ -435,6 +435,37 @@
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
@@ -468,37 +499,6 @@
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
