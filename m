Return-Path: <michel@daenzer.net>
Received: from mail.gna.ch (darkcity.gna.ch [195.226.6.51])
	by ozlabs.org (Postfix) with ESMTP id BD7D9B7BFF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  6 Dec 2009 23:16:13 +1100 (EST)
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: David Airlie <airlied@linux.ie>
Subject: [PATCH 1/2] agp/uninorth: Also handle user memory types in
	u3_remove_memory().
Date: Sun,  6 Dec 2009 13:15:55 +0100
Message-Id: <1260101756-22645-2-git-send-email-michel@daenzer.net>
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

Also short-circuit empty updates.

Signed-off-by: Michel Dänzer <daenzer@vmware.com>
---
 drivers/char/agp/uninorth-agp.c |   29 ++++++++++++++++++++++-------
 1 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
index 703959e..4e05021 100644
--- a/drivers/char/agp/uninorth-agp.c
+++ b/drivers/char/agp/uninorth-agp.c
@@ -151,9 +151,6 @@ static int uninorth_insert_memory(struct agp_memory *mem, off_t pg_start,
 	void *temp;
 	int mask_type;
 
-	temp = agp_bridge->current_size;
-	num_entries = A_SIZE_32(temp)->num_entries;
-
 	if (type != mem->type)
 		return -EINVAL;
 
@@ -163,6 +160,12 @@ static int uninorth_insert_memory(struct agp_memory *mem, off_t pg_start,
 		return -EINVAL;
 	}
 
+	if (mem->page_count == 0)
+		return 0;
+
+	temp = agp_bridge->current_size;
+	num_entries = A_SIZE_32(temp)->num_entries;
+
 	if ((pg_start + mem->page_count) > num_entries)
 		return -EINVAL;
 
@@ -194,9 +197,6 @@ static int u3_insert_memory(struct agp_memory *mem, off_t pg_start, int type)
 	u32 *gp;
 	int mask_type;
 
-	temp = agp_bridge->current_size;
-	num_entries = A_SIZE_32(temp)->num_entries;
-
 	if (type != mem->type)
 		return -EINVAL;
 
@@ -206,6 +206,12 @@ static int u3_insert_memory(struct agp_memory *mem, off_t pg_start, int type)
 		return -EINVAL;
 	}
 
+	if (mem->page_count == 0)
+		return 0;
+
+	temp = agp_bridge->current_size;
+	num_entries = A_SIZE_32(temp)->num_entries;
+
 	if ((pg_start + mem->page_count) > num_entries)
 		return -EINVAL;
 
@@ -234,10 +240,19 @@ int u3_remove_memory(struct agp_memory *mem, off_t pg_start, int type)
 {
 	size_t i;
 	u32 *gp;
+	int mask_type;
+
+	if (type != mem->type)
+		return -EINVAL;
 
-	if (type != 0 || mem->type != 0)
+	mask_type = agp_bridge->driver->agp_type_to_mask_type(agp_bridge, type);
+	if (mask_type != 0) {
 		/* We know nothing of memory types */
 		return -EINVAL;
+	}
+
+	if (mem->page_count == 0)
+		return 0;
 
 	gp = (u32 *) &agp_bridge->gatt_table[pg_start];
 	for (i = 0; i < mem->page_count; ++i)
-- 
1.6.5.3
