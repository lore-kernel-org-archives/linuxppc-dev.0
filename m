Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE282DDF33
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 00:00:50 +1100 (EST)
Message-Id: <20070207124614.830282000@sipsolutions.net>
References: <20070207124536.963531000@sipsolutions.net>
Date: Wed, 07 Feb 2007 13:45:46 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/12] powerpc: remove unneeded exports in mem.c
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/mm/mem.c exports page_is_ram and phys_mem_access_prot which
both are not used anywhere that could be modular.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Paul Mackerras <paulus@samba.org>

---
I don't see any possible way these could be used by external modules either,
especially since they are not portable across arches.

--- linux-2.6-git.orig/arch/powerpc/mm/mem.c	2007-02-07 02:55:34.636884289 +0100
+++ linux-2.6-git/arch/powerpc/mm/mem.c	2007-02-07 02:55:35.252884289 +0100
@@ -83,7 +83,6 @@ int page_is_ram(unsigned long pfn)
 	return 0;
 #endif
 }
-EXPORT_SYMBOL(page_is_ram);
 
 pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 			      unsigned long size, pgprot_t vma_prot)
@@ -96,7 +95,6 @@ pgprot_t phys_mem_access_prot(struct fil
 				    | _PAGE_GUARDED | _PAGE_NO_CACHE);
 	return vma_prot;
 }
-EXPORT_SYMBOL(phys_mem_access_prot);
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 

--
