Return-Path: <nfont@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 37EBAB70DC
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 05:23:55 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8RJIhfW022103
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Sep 2010 13:18:43 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8RJNq6K162810
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Sep 2010 13:23:52 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o8RJNo4W021784
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Sep 2010 13:23:51 -0600
Message-ID: <4CA0EF45.3000601@austin.ibm.com>
Date: Mon, 27 Sep 2010 14:23:49 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 3/8] v2 Add mutex for adding/removing memory blocks
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

Add a new mutex for use in adding and removing of memory blocks.  This
is needed to avoid any race conditions in which the same memory block could
be added and removed at the same time.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

---
 drivers/base/memory.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-next/drivers/base/memory.c
===================================================================
--- linux-next.orig/drivers/base/memory.c	2010-09-27 09:31:35.000000000 -0500
+++ linux-next/drivers/base/memory.c	2010-09-27 09:31:57.000000000 -0500
@@ -27,6 +27,8 @@
 #include <asm/atomic.h>
 #include <asm/uaccess.h>
 
+static DEFINE_MUTEX(mem_sysfs_mutex);
+
 #define MEMORY_CLASS_NAME	"memory"
 
 static struct sysdev_class memory_sysdev_class = {
@@ -476,6 +478,8 @@
 	if (!mem)
 		return -ENOMEM;
 
+	mutex_lock(&mem_sysfs_mutex);
+
 	mem->phys_index = __section_nr(section);
 	mem->state = state;
 	atomic_inc(&mem->section_count);
@@ -497,6 +501,7 @@
 			ret = register_mem_sect_under_node(mem, nid);
 	}
 
+	mutex_unlock(&mem_sysfs_mutex);
 	return ret;
 }
 
@@ -505,6 +510,7 @@
 {
 	struct memory_block *mem;
 
+	mutex_lock(&mem_sysfs_mutex);
 	mem = find_memory_block(section);
 
 	if (atomic_dec_and_test(&mem->section_count)) {
@@ -516,6 +522,7 @@
 		unregister_memory(mem, section);
 	}
 
+	mutex_unlock(&mem_sysfs_mutex);
 	return 0;
 }
