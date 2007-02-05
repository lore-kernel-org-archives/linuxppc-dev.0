Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E0F30DE782
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 06:10:09 +1100 (EST)
Message-Id: <20070205185835.337746000@sipsolutions.net>
References: <20070205183026.989209000@sipsolutions.net>
Date: Mon, 05 Feb 2007 19:30:28 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/10] dont copy pages that arent RAM
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org,
	Torrance <torrance123@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Pages that aren't RAM obviously cannot be saved during suspend-to-disk
so skip them.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
Pavel Machek requested this be put into -mm for some more
testing although he says it seems fine.

--- mb-wireless.orig/kernel/power/snapshot.c	2007-02-05 14:24:06.894526864 +0100
+++ mb-wireless/kernel/power/snapshot.c	2007-02-05 14:24:36.544526864 +0100
@@ -686,6 +686,8 @@ static struct page *saveable_page(unsign
 
 	if (PageReserved(page) && pfn_is_nosave(pfn))
 		return NULL;
+	if (!page_is_ram(pfn))
+		return NULL;
 
 	return page;
 }

--
