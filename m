Return-Path: <nfont@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 54854B70E9
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Oct 2010 04:30:46 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o91IAWUh002096
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 14:10:32 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o91IUgZ01179756
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 14:30:42 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o91IUf8l029607
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 14:30:42 -0400
Message-ID: <4CA628D0.6030508@austin.ibm.com>
Date: Fri, 01 Oct 2010 13:30:40 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/9] v3 Add section count to memory_block struct
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

Add a section count property to the memory_block struct to track the number
of memory sections that have been added/removed from a memory block. This
allows us to know when the last memory section of a memory block has been
removed so we can remove the memory block.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>

---
 drivers/base/memory.c  |   17 +++++++++++------
 include/linux/memory.h |    2 ++
 2 files changed, 13 insertions(+), 6 deletions(-)

Index: linux-next/drivers/base/memory.c
===================================================================
--- linux-next.orig/drivers/base/memory.c	2010-09-30 14:12:41.000000000 -0500
+++ linux-next/drivers/base/memory.c	2010-09-30 14:13:50.000000000 -0500
@@ -482,6 +482,7 @@
 
 	mem->phys_index = __section_nr(section);
 	mem->state = state;
+	mem->section_count++;
 	mutex_init(&mem->state_mutex);
 	start_pfn = section_nr_to_pfn(mem->phys_index);
 	mem->phys_device = arch_get_memory_phys_device(start_pfn);
@@ -511,12 +512,16 @@
 
 	mutex_lock(&mem_sysfs_mutex);
 	mem = find_memory_block(section);
-	unregister_mem_sect_under_nodes(mem);
-	mem_remove_simple_file(mem, phys_index);
-	mem_remove_simple_file(mem, state);
-	mem_remove_simple_file(mem, phys_device);
-	mem_remove_simple_file(mem, removable);
-	unregister_memory(mem, section);
+
+	mem->section_count--;
+	if (mem->section_count == 0) {
+		unregister_mem_sect_under_nodes(mem);
+		mem_remove_simple_file(mem, phys_index);
+		mem_remove_simple_file(mem, state);
+		mem_remove_simple_file(mem, phys_device);
+		mem_remove_simple_file(mem, removable);
+		unregister_memory(mem, section);
+	}
 
 	mutex_unlock(&mem_sysfs_mutex);
 	return 0;
Index: linux-next/include/linux/memory.h
===================================================================
--- linux-next.orig/include/linux/memory.h	2010-09-29 14:56:29.000000000 -0500
+++ linux-next/include/linux/memory.h	2010-09-30 14:13:50.000000000 -0500
@@ -23,6 +23,8 @@
 struct memory_block {
 	unsigned long phys_index;
 	unsigned long state;
+	int section_count;
+
 	/*
 	 * This serializes all state change requests.  It isn't
 	 * held during creation because the control files are
