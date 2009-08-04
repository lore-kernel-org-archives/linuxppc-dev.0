Return-Path: <michel@daenzer.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 01AC2B7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Aug 2009 07:51:14 +1000 (EST)
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id 0AC1CDDDA0
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Aug 2009 07:51:12 +1000 (EST)
From: =?utf-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: Dave Airlie <airlied@linux.ie>
Subject: [PATCH 2/3] agp/uninorth: Simplify cache flushing.
Date: Tue,  4 Aug 2009 23:51:04 +0200
Message-Id: <1249422665-24437-2-git-send-email-michel@daenzer.net>
In-Reply-To: <1249422665-24437-1-git-send-email-michel@daenzer.net>
References: <1249422665-24437-1-git-send-email-michel@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michel Dänzer <daenzer@vmware.com>

Map the GART table uncached, so we don't always need to flush the CPU caches
explicitly after updates.

Signed-off-by: Michel Dänzer <daenzer@vmware.com>
---
 drivers/char/agp/uninorth-agp.c |   33 +++++++++++++++++++++++++--------
 1 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
index eed2195..bc8b43a 100644
--- a/drivers/char/agp/uninorth-agp.c
+++ b/drivers/char/agp/uninorth-agp.c
@@ -7,6 +7,7 @@
 #include <linux/pagemap.h>
 #include <linux/agp_backend.h>
 #include <linux/delay.h>
+#include <linux/vmalloc.h>
 #include <asm/uninorth.h>
 #include <asm/pci-bridge.h>
 #include <asm/prom.h>
@@ -184,8 +185,6 @@ static int uninorth_insert_memory(struct agp_memory *mem, off_t pg_start,
 	}
 	(void)in_le32((volatile u32*)&agp_bridge->gatt_table[pg_start]);
 	mb();
-	flush_dcache_range((unsigned long)&agp_bridge->gatt_table[pg_start],
-		(unsigned long)&agp_bridge->gatt_table[pg_start + mem->page_count]);
 
 	uninorth_tlbflush(mem);
 	return 0;
@@ -232,7 +231,6 @@ static int u3_insert_memory(struct agp_memory *mem, off_t pg_start, int type)
 				   (unsigned long)__va(page_to_phys(mem->pages[i]))+0x1000);
 	}
 	mb();
-	flush_dcache_range((unsigned long)gp, (unsigned long) &gp[i]);
 	uninorth_tlbflush(mem);
 
 	return 0;
@@ -260,7 +258,6 @@ int u3_remove_memory(struct agp_memory *mem, off_t pg_start, int type)
 	for (i = 0; i < mem->page_count; ++i)
 		gp[i] = 0;
 	mb();
-	flush_dcache_range((unsigned long)gp, (unsigned long) &gp[i]);
 	uninorth_tlbflush(mem);
 
 	return 0;
@@ -413,6 +410,7 @@ static int uninorth_create_gatt_table(struct agp_bridge_data *bridge)
 	int i;
 	void *temp;
 	struct page *page;
+	struct page **pages;
 
 	/* We can't handle 2 level gatt's */
 	if (bridge->driver->size_type == LVL2_APER_SIZE)
@@ -441,21 +439,39 @@ static int uninorth_create_gatt_table(struct agp_bridge_data *bridge)
 	if (table == NULL)
 		return -ENOMEM;
 
+	pages = kmalloc((1 << page_order) * sizeof(struct page*), GFP_KERNEL);
+	if (pages == NULL)
+		goto enomem;
+
 	table_end = table + ((PAGE_SIZE * (1 << page_order)) - 1);
 
-	for (page = virt_to_page(table); page <= virt_to_page(table_end); page++)
+	for (page = virt_to_page(table), i = 0; page <= virt_to_page(table_end);
+	     page++, i++) {
 		SetPageReserved(page);
+		pages[i] = page;
+	}
 
 	bridge->gatt_table_real = (u32 *) table;
-	bridge->gatt_table = (u32 *)table;
+	/* Need to clear out any dirty data still sitting in caches */
+	flush_dcache_range((unsigned long)table,
+			   (unsigned long)(table_end + PAGE_SIZE));
+	bridge->gatt_table = vmap(pages, (1 << page_order), 0, PAGE_KERNEL_NCG);
+
+	if (bridge->gatt_table == NULL)
+		goto enomem;
+
 	bridge->gatt_bus_addr = virt_to_gart(table);
 
 	for (i = 0; i < num_entries; i++)
 		bridge->gatt_table[i] = 0;
 
-	flush_dcache_range((unsigned long)table, (unsigned long)table_end);
-
 	return 0;
+
+enomem:
+	kfree(pages);
+	if (table)
+		free_pages((unsigned long)table, page_order);
+	return -ENOMEM;
 }
 
 static int uninorth_free_gatt_table(struct agp_bridge_data *bridge)
@@ -473,6 +489,7 @@ static int uninorth_free_gatt_table(struct agp_bridge_data *bridge)
 	 * from the table.
 	 */
 
+	vunmap(bridge->gatt_table);
 	table = (char *) bridge->gatt_table_real;
 	table_end = table + ((PAGE_SIZE * (1 << page_order)) - 1);
 
-- 
1.6.3.3
