Return-Path: <nfont@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B9909B70E2
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 04:37:42 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o79Ib5UC026421
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Aug 2010 14:37:05 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o79Ibcoh2093174
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Aug 2010 14:37:39 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o79Ibcfa015402
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Aug 2010 14:37:38 -0400
Message-ID: <4C604AF0.6080900@austin.ibm.com>
Date: Mon, 09 Aug 2010 13:37:36 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 3/8] v5 Add section count to memory_block
References: <4C60407C.2080608@austin.ibm.com>
In-Reply-To: <4C60407C.2080608@austin.ibm.com>
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

Add a section count property to the memory_block struct to track the number
of memory sections that have been added/removed from a memory block. This
alolws us to know when the lasat memory section of a memory block has been
removed so we can remove the memory block.

Signed-off-by: Nathan Fontenot <nfont@asutin.ibm.com>

---
 drivers/base/memory.c  |   18 +++++++++++-------
 include/linux/memory.h |    2 ++
 2 files changed, 13 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/base/memory.c
===================================================================
--- linux-2.6.orig/drivers/base/memory.c	2010-08-09 07:44:31.000000000 -0500
+++ linux-2.6/drivers/base/memory.c	2010-08-09 07:49:04.000000000 -0500
@@ -487,6 +487,7 @@ static int add_memory_block(int nid, str
 
 	mem->start_phys_index = __section_nr(section);
 	mem->state = state;
+	atomic_inc(&mem->section_count);
 	mutex_init(&mem->state_mutex);
 	start_pfn = section_nr_to_pfn(mem->start_phys_index);
 	mem->phys_device = arch_get_memory_phys_device(start_pfn);
@@ -516,13 +517,16 @@ int remove_memory_block(unsigned long no
 	struct memory_block *mem;
 
 	mem = find_memory_block(section);
-	unregister_mem_sect_under_nodes(mem);
-	mem_remove_simple_file(mem, phys_index);
-	mem_remove_simple_file(mem, end_phys_index);
-	mem_remove_simple_file(mem, state);
-	mem_remove_simple_file(mem, phys_device);
-	mem_remove_simple_file(mem, removable);
-	unregister_memory(mem, section);
+
+	if (atomic_dec_and_test(&mem->section_count)) {
+		unregister_mem_sect_under_nodes(mem);
+		mem_remove_simple_file(mem, phys_index);
+		mem_remove_simple_file(mem, end_phys_index);
+		mem_remove_simple_file(mem, state);
+		mem_remove_simple_file(mem, phys_device);
+		mem_remove_simple_file(mem, removable);
+		unregister_memory(mem, section);
+	}
 
 	return 0;
 }
Index: linux-2.6/include/linux/memory.h
===================================================================
--- linux-2.6.orig/include/linux/memory.h	2010-08-09 07:44:31.000000000 -0500
+++ linux-2.6/include/linux/memory.h	2010-08-09 07:49:04.000000000 -0500
@@ -19,11 +19,13 @@
 #include <linux/node.h>
 #include <linux/compiler.h>
 #include <linux/mutex.h>
+#include <asm/atomic.h>
 
 struct memory_block {
 	unsigned long start_phys_index;
 	unsigned long end_phys_index;
 	unsigned long state;
+	atomic_t section_count;
 	/*
 	 * This serializes all state change requests.  It isn't
 	 * held during creation because the control files are
