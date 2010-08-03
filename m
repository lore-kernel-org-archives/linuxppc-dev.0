Return-Path: <nfont@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B4E2B1007E4
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 23:41:54 +1000 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o73Da5wB027268
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Aug 2010 09:36:05 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o73DfpSd105178
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Aug 2010 09:41:51 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o73DfnA0021320
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Aug 2010 10:41:51 -0300
Message-ID: <4C581C99.8090201@austin.ibm.com>
Date: Tue, 03 Aug 2010 08:41:45 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 6/9] v4 Update the find_memory_block declaration
References: <4C581A6D.9030908@austin.ibm.com>
In-Reply-To: <4C581A6D.9030908@austin.ibm.com>
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

Update the find_memory_block declaration to to take a struct mem_section *
so that it matches the definition.

Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
---
 include/linux/memory.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/include/linux/memory.h
===================================================================
--- linux-2.6.orig/include/linux/memory.h	2010-08-02 13:58:41.000000000 -0500
+++ linux-2.6/include/linux/memory.h	2010-08-02 14:01:15.000000000 -0500
@@ -116,7 +116,7 @@ extern int memory_dev_init(void);
 extern int remove_memory_block(unsigned long, struct mem_section *, int);
 extern int memory_notify(unsigned long val, void *v);
 extern int memory_isolate_notify(unsigned long val, void *v);
-extern struct memory_block *find_memory_block(unsigned long);
+extern struct memory_block *find_memory_block(struct mem_section *);
 extern int memory_is_hidden(struct mem_section *);
 #define CONFIG_MEM_BLOCK_SIZE	(PAGES_PER_SECTION<<PAGE_SHIFT)
 enum mem_add_context { BOOT, HOTPLUG };
