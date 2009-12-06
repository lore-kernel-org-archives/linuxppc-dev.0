Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id C08BFB7C0C
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  6 Dec 2009 23:16:13 +1100 (EST)
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: David Airlie <airlied@linux.ie>
Subject: [PATCH 2/2] agp/uninorth: Unify U3 and pre-U3 insert_memory and
	remove_memory hooks.
Date: Sun,  6 Dec 2009 13:15:56 +0100
Message-Id: <1260101756-22645-3-git-send-email-michel@daenzer.net>
In-Reply-To: <1260101756-22645-1-git-send-email-michel@daenzer.net>
References: <1260101756-22645-1-git-send-email-michel@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michel Dänzer <daenzer@vmware.com>

Signed-off-by: Michel Dänzer <daenzer@vmware.com>
---
 drivers/char/agp/uninorth-agp.c |   64 +++++++--------------------------------
 1 files changed, 11 insertions(+), 53 deletions(-)

diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
index 4e05021..d89da4a 100644
--- a/drivers/char/agp/uninorth-agp.c
+++ b/drivers/char/agp/uninorth-agp.c
@@ -144,53 +144,7 @@ static int uninorth_configure(void)
 	return 0;
 }
 
-static int uninorth_insert_memory(struct agp_memory *mem, off_t pg_start,
-				int type)
-{
-	int i, j, num_entries;
-	void *temp;
-	int mask_type;
-
-	if (type != mem->type)
-		return -EINVAL;
-
-	mask_type = agp_bridge->driver->agp_type_to_mask_type(agp_bridge, type);
-	if (mask_type != 0) {
-		/* We know nothing of memory types */
-		return -EINVAL;
-	}
-
-	if (mem->page_count == 0)
-		return 0;
-
-	temp = agp_bridge->current_size;
-	num_entries = A_SIZE_32(temp)->num_entries;
-
-	if ((pg_start + mem->page_count) > num_entries)
-		return -EINVAL;
-
-	j = pg_start;
-
-	while (j < (pg_start + mem->page_count)) {
-		if (agp_bridge->gatt_table[j])
-			return -EBUSY;
-		j++;
-	}
-
-	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
-		agp_bridge->gatt_table[j] =
-			cpu_to_le32((page_to_phys(mem->pages[i]) & 0xFFFFF000UL) | 0x1UL);
-		flush_dcache_range((unsigned long)__va(page_to_phys(mem->pages[i])),
-				   (unsigned long)__va(page_to_phys(mem->pages[i]))+0x1000);
-	}
-	(void)in_le32((volatile u32*)&agp_bridge->gatt_table[pg_start]);
-	mb();
-
-	uninorth_tlbflush(mem);
-	return 0;
-}
-
-static int u3_insert_memory(struct agp_memory *mem, off_t pg_start, int type)
+static int uninorth_insert_memory(struct agp_memory *mem, off_t pg_start, int type)
 {
 	int i, num_entries;
 	void *temp;
@@ -219,14 +173,18 @@ static int u3_insert_memory(struct agp_memory *mem, off_t pg_start, int type)
 	for (i = 0; i < mem->page_count; ++i) {
 		if (gp[i]) {
 			dev_info(&agp_bridge->dev->dev,
-				 "u3_insert_memory: entry 0x%x occupied (%x)\n",
+				 "uninorth_insert_memory: entry 0x%x occupied (%x)\n",
 				 i, gp[i]);
 			return -EBUSY;
 		}
 	}
 
 	for (i = 0; i < mem->page_count; i++) {
-		gp[i] = (page_to_phys(mem->pages[i]) >> PAGE_SHIFT) | 0x80000000UL;
+		if (is_u3)
+			gp[i] = (page_to_phys(mem->pages[i]) >> PAGE_SHIFT) | 0x80000000UL;
+		else
+			gp[i] =	cpu_to_le32((page_to_phys(mem->pages[i]) & 0xFFFFF000UL) |
+					    0x1UL);
 		flush_dcache_range((unsigned long)__va(page_to_phys(mem->pages[i])),
 				   (unsigned long)__va(page_to_phys(mem->pages[i]))+0x1000);
 	}
@@ -236,7 +194,7 @@ static int u3_insert_memory(struct agp_memory *mem, off_t pg_start, int type)
 	return 0;
 }
 
-int u3_remove_memory(struct agp_memory *mem, off_t pg_start, int type)
+int uninorth_remove_memory(struct agp_memory *mem, off_t pg_start, int type)
 {
 	size_t i;
 	u32 *gp;
@@ -551,7 +509,7 @@ const struct agp_bridge_driver uninorth_agp_driver = {
 	.create_gatt_table	= uninorth_create_gatt_table,
 	.free_gatt_table	= uninorth_free_gatt_table,
 	.insert_memory		= uninorth_insert_memory,
-	.remove_memory		= agp_generic_remove_memory,
+	.remove_memory		= uninorth_remove_memory,
 	.alloc_by_type		= agp_generic_alloc_by_type,
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
@@ -577,8 +535,8 @@ const struct agp_bridge_driver u3_agp_driver = {
 	.agp_enable		= uninorth_agp_enable,
 	.create_gatt_table	= uninorth_create_gatt_table,
 	.free_gatt_table	= uninorth_free_gatt_table,
-	.insert_memory		= u3_insert_memory,
-	.remove_memory		= u3_remove_memory,
+	.insert_memory		= uninorth_insert_memory,
+	.remove_memory		= uninorth_remove_memory,
 	.alloc_by_type		= agp_generic_alloc_by_type,
 	.free_by_type		= agp_generic_free_by_type,
 	.agp_alloc_page		= agp_generic_alloc_page,
-- 
1.6.5.3
