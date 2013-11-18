Return-Path: <hegdevasant@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CBE592C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 22:09:33 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hegdevasant@linux.vnet.ibm.com>;
 Mon, 18 Nov 2013 16:39:26 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 8B4871258059
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 16:40:15 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAIB9JsP45744244
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 16:39:19 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAIB9MaJ026469
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 16:39:22 +0530
Received: from hegdevasant.in.ibm.com (hegdevasant.in.ibm.com [9.124.35.106]
 (may be forged))
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 rAIB9MjL026466
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2013 16:39:22 +0530
Subject: [PATCH] powerpc/powernv: Move SG list structure to header file
To: linuxppc-dev@lists.ozlabs.org
From: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
Date: Mon, 18 Nov 2013 16:39:22 +0530
Message-ID: <20131118110918.30576.19457.stgit@hegdevasant.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move SG list and entry structure to header file so that
it can be used in other places as well.

Signed-off-by: Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal.h             |   22 +++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-flash.c |   31 +++++----------------------
 2 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 033c06b..d1af862 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -33,6 +33,28 @@ struct opal_takeover_args {
 	u64	rd_loc;			/* r11 */
 };
 
+/*
+ * SG entry
+ *
+ * WARNING: The current implementation requires each entry
+ * to represent a block that is 4k aligned *and* each block
+ * size except the last one in the list to be as well.
+ */
+struct opal_sg_entry {
+	void    *data;
+	long    length;
+};
+
+/* sg list */
+struct opal_sg_list {
+	unsigned long num_entries;
+	struct opal_sg_list *next;
+	struct opal_sg_entry entry[];
+};
+
+/* We calculate number of sg entries based on PAGE_SIZE */
+#define SG_ENTRIES_PER_NODE ((PAGE_SIZE - 16) / sizeof(struct opal_sg_entry))
+
 extern long opal_query_takeover(u64 *hal_size, u64 *hal_align);
 
 extern long opal_do_takeover(struct opal_takeover_args *args);
diff --git a/arch/powerpc/platforms/powernv/opal-flash.c b/arch/powerpc/platforms/powernv/opal-flash.c
index 6ffa6b1..4aeae4f 100644
--- a/arch/powerpc/platforms/powernv/opal-flash.c
+++ b/arch/powerpc/platforms/powernv/opal-flash.c
@@ -103,27 +103,6 @@ struct image_header_t {
 	uint32_t	size;
 };
 
-/* Scatter/gather entry */
-struct opal_sg_entry {
-	void	*data;
-	long	length;
-};
-
-/* We calculate number of entries based on PAGE_SIZE */
-#define SG_ENTRIES_PER_NODE ((PAGE_SIZE - 16) / sizeof(struct opal_sg_entry))
-
-/*
- * This struct is very similar but not identical to that
- * needed by the opal flash update. All we need to do for
- * opal is rewrite num_entries into a version/length and
- * translate the pointers to absolute.
- */
-struct opal_sg_list {
-	unsigned long num_entries;
-	struct opal_sg_list *next;
-	struct opal_sg_entry entry[SG_ENTRIES_PER_NODE];
-};
-
 struct validate_flash_t {
 	int		status;		/* Return status */
 	void		*buf;		/* Candiate image buffer */
@@ -333,7 +312,7 @@ static struct opal_sg_list *image_data_to_sglist(void)
 	addr = image_data.data;
 	size = image_data.size;
 
-	sg1 = kzalloc((sizeof(struct opal_sg_list)), GFP_KERNEL);
+	sg1 = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!sg1)
 		return NULL;
 
@@ -351,8 +330,7 @@ static struct opal_sg_list *image_data_to_sglist(void)
 
 		sg1->num_entries++;
 		if (sg1->num_entries >= SG_ENTRIES_PER_NODE) {
-			sg1->next = kzalloc((sizeof(struct opal_sg_list)),
-					    GFP_KERNEL);
+			sg1->next = kzalloc(PAGE_SIZE, GFP_KERNEL);
 			if (!sg1->next) {
 				pr_err("%s : Failed to allocate memory\n",
 				       __func__);
@@ -402,7 +380,10 @@ static int opal_flash_update(int op)
 		else
 			sg->next = NULL;
 
-		/* Make num_entries into the version/length field */
+		/*
+		 * Convert num_entries to version/length format
+		 * to satisfy OPAL.
+		 */
 		sg->num_entries = (SG_LIST_VERSION << 56) |
 			(sg->num_entries * sizeof(struct opal_sg_entry) + 16);
 	}
