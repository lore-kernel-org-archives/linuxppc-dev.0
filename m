Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C04A5DDFDF
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 00:01:01 +1100 (EST)
Message-Id: <20070207124614.109461000@sipsolutions.net>
References: <20070207124536.963531000@sipsolutions.net>
Date: Wed, 07 Feb 2007 13:45:45 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/12] powerpc: remove bogus comment about page_is_ram
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

arch/powerpc/mm/mem.c states that page_is_ram is called by the code that
implements /dev/mem which isn't true. Remove the comment.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Paul Mackerras <paulus@samba.org>

---
Please apply to the powerpc tree.

--- linux-2.6-git.orig/arch/powerpc/mm/mem.c	2007-02-07 02:55:30.496884289 +0100
+++ linux-2.6-git/arch/powerpc/mm/mem.c	2007-02-07 02:55:34.636884289 +0100
@@ -61,10 +61,6 @@ unsigned long memory_limit;
 extern void hash_preload(struct mm_struct *mm, unsigned long ea,
 			 unsigned long access, unsigned long trap);
 
-/*
- * This is called by /dev/mem to know if a given address has to
- * be mapped non-cacheable or not
- */
 int page_is_ram(unsigned long pfn)
 {
 	unsigned long paddr = (pfn << PAGE_SHIFT);

--
