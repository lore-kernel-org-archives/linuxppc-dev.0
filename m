Return-Path: <nfont@austin.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 254271007DD
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jul 2010 13:56:24 +1000 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6K3cPfv007109
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jul 2010 23:38:25 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6K3uMrn393638
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jul 2010 23:56:22 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6K3uLCW010457
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jul 2010 23:56:22 -0400
Message-ID: <4C451E60.8080702@austin.ibm.com>
Date: Mon, 19 Jul 2010 22:56:16 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 5/8] v3 Update the find_memory_block declaration
References: <4C451BF5.50304@austin.ibm.com>
In-Reply-To: <4C451BF5.50304@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: greg@kroah.com, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
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
--- linux-2.6.orig/include/linux/memory.h	2010-07-19 21:10:28.000000000 -0500
+++ linux-2.6/include/linux/memory.h	2010-07-19 21:12:46.000000000 -0500
@@ -116,7 +116,7 @@ extern int memory_dev_init(void);
 extern int remove_memory_block(unsigned long, struct mem_section *, int);
 extern int memory_notify(unsigned long val, void *v);
 extern int memory_isolate_notify(unsigned long val, void *v);
-extern struct memory_block *find_memory_block(unsigned long);
+extern struct memory_block *find_memory_block(struct mem_section *);
 extern int memory_is_hidden(struct mem_section *);
 #define CONFIG_MEM_BLOCK_SIZE	(PAGES_PER_SECTION<<PAGE_SHIFT)
 enum mem_add_context { BOOT, HOTPLUG };
