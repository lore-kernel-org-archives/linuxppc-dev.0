Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, hegdevasant@linux.vnet.ibm.com,
 stewart@linux.vnet.ibm.com
Subject: [PATCH 5/6] powerpc/powernv: Create OPAL sglist helper functions and
 fix endian issues
Date: Tue, 22 Apr 2014 15:01:26 +1000
Message-Id: <1398142887-24109-5-git-send-email-anton@samba.org>
In-Reply-To: <1398142887-24109-1-git-send-email-anton@samba.org>
References: <1398142887-24109-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have two copies of code that creates an OPAL sg list. Consolidate
these into a common set of helpers and fix the endian issues.

The flash interface embedded a version number in the num_entries
field, whereas the dump interface did did not. Since versioning
wasn't added to the flash interface and it is impossible to add
this in a backwards compatible way, just remove it.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/opal.h             |  14 ++--
 arch/powerpc/platforms/powernv/opal-dump.c  |  81 +--------------------
 arch/powerpc/platforms/powernv/opal-flash.c | 106 +---------------------------
 arch/powerpc/platforms/powernv/opal.c       |  63 +++++++++++++++++
 4 files changed, 76 insertions(+), 188 deletions(-)

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 1a752ac..afb0fed 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -41,14 +41,14 @@ struct opal_takeover_args {
  * size except the last one in the list to be as well.
  */
 struct opal_sg_entry {
-	void    *data;
-	long    length;
+	__be64 data;
+	__be64 length;
 };
 
-/* sg list */
+/* SG list */
 struct opal_sg_list {
-	unsigned long num_entries;
-	struct opal_sg_list *next;
+	__be64 length;
+	__be64 next;
 	struct opal_sg_entry entry[];
 };
 
@@ -929,6 +929,10 @@ extern int opal_resync_timebase(void);
 
 extern void opal_lpc_init(void);
 
+struct opal_sg_list *opal_vmalloc_to_sg_list(void *vmalloc_addr,
+					     unsigned long vmalloc_size);
+void opal_free_sg_list(struct opal_sg_list *sg);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __OPAL_H */
diff --git a/arch/powerpc/platforms/powernv/opal-dump.c b/arch/powerpc/platforms/powernv/opal-dump.c
index b9827b0..f0b4724 100644
--- a/arch/powerpc/platforms/powernv/opal-dump.c
+++ b/arch/powerpc/platforms/powernv/opal-dump.c
@@ -209,80 +209,6 @@ static struct kobj_type dump_ktype = {
 	.default_attrs = dump_default_attrs,
 };
 
-static void free_dump_sg_list(struct opal_sg_list *list)
-{
-	struct opal_sg_list *sg1;
-	while (list) {
-		sg1 = list->next;
-		kfree(list);
-		list = sg1;
-	}
-	list = NULL;
-}
-
-static struct opal_sg_list *dump_data_to_sglist(struct dump_obj *dump)
-{
-	struct opal_sg_list *sg1, *list = NULL;
-	void *addr;
-	int64_t size;
-
-	addr = dump->buffer;
-	size = dump->size;
-
-	sg1 = kzalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!sg1)
-		goto nomem;
-
-	list = sg1;
-	sg1->num_entries = 0;
-	while (size > 0) {
-		/* Translate virtual address to physical address */
-		sg1->entry[sg1->num_entries].data =
-			(void *)(vmalloc_to_pfn(addr) << PAGE_SHIFT);
-
-		if (size > PAGE_SIZE)
-			sg1->entry[sg1->num_entries].length = PAGE_SIZE;
-		else
-			sg1->entry[sg1->num_entries].length = size;
-
-		sg1->num_entries++;
-		if (sg1->num_entries >= SG_ENTRIES_PER_NODE) {
-			sg1->next = kzalloc(PAGE_SIZE, GFP_KERNEL);
-			if (!sg1->next)
-				goto nomem;
-
-			sg1 = sg1->next;
-			sg1->num_entries = 0;
-		}
-		addr += PAGE_SIZE;
-		size -= PAGE_SIZE;
-	}
-	return list;
-
-nomem:
-	pr_err("%s : Failed to allocate memory\n", __func__);
-	free_dump_sg_list(list);
-	return NULL;
-}
-
-static void sglist_to_phy_addr(struct opal_sg_list *list)
-{
-	struct opal_sg_list *sg, *next;
-
-	for (sg = list; sg; sg = next) {
-		next = sg->next;
-		/* Don't translate NULL pointer for last entry */
-		if (sg->next)
-			sg->next = (struct opal_sg_list *)__pa(sg->next);
-		else
-			sg->next = NULL;
-
-		/* Convert num_entries to length */
-		sg->num_entries =
-			sg->num_entries * sizeof(struct opal_sg_entry) + 16;
-	}
-}
-
 static int64_t dump_read_info(uint32_t *id, uint32_t *size, uint32_t *type)
 {
 	int rc;
@@ -314,15 +240,12 @@ static int64_t dump_read_data(struct dump_obj *dump)
 	}
 
 	/* Generate SG list */
-	list = dump_data_to_sglist(dump);
+	list = opal_vmalloc_to_sg_list(dump->buffer, dump->size);
 	if (!list) {
 		rc = -ENOMEM;
 		goto out;
 	}
 
-	/* Translate sg list addr to real address */
-	sglist_to_phy_addr(list);
-
 	/* First entry address */
 	addr = __pa(list);
 
@@ -341,7 +264,7 @@ static int64_t dump_read_data(struct dump_obj *dump)
 			__func__, dump->id);
 
 	/* Free SG list */
-	free_dump_sg_list(list);
+	opal_free_sg_list(list);
 
 out:
 	return rc;
diff --git a/arch/powerpc/platforms/powernv/opal-flash.c b/arch/powerpc/platforms/powernv/opal-flash.c
index 714ef97..0ae9e5f 100644
--- a/arch/powerpc/platforms/powernv/opal-flash.c
+++ b/arch/powerpc/platforms/powernv/opal-flash.c
@@ -79,9 +79,6 @@
 /* XXX: Assume candidate image size is <= 1GB */
 #define MAX_IMAGE_SIZE	0x40000000
 
-/* Flash sg list version */
-#define SG_LIST_VERSION (1UL)
-
 /* Image status */
 enum {
 	IMAGE_INVALID,
@@ -268,93 +265,11 @@ static ssize_t manage_store(struct kobject *kobj,
 }
 
 /*
- * Free sg list
- */
-static void free_sg_list(struct opal_sg_list *list)
-{
-	struct opal_sg_list *sg1;
-	while (list) {
-		sg1 = list->next;
-		kfree(list);
-		list = sg1;
-	}
-	list = NULL;
-}
-
-/*
- * Build candidate image scatter gather list
- *
- * list format:
- *   -----------------------------------
- *  |  VER (8) | Entry length in bytes  |
- *   -----------------------------------
- *  |  Pointer to next entry            |
- *   -----------------------------------
- *  |  Address of memory area 1         |
- *   -----------------------------------
- *  |  Length of memory area 1          |
- *   -----------------------------------
- *  |   .........                       |
- *   -----------------------------------
- *  |   .........                       |
- *   -----------------------------------
- *  |  Address of memory area N         |
- *   -----------------------------------
- *  |  Length of memory area N          |
- *   -----------------------------------
- */
-static struct opal_sg_list *image_data_to_sglist(void)
-{
-	struct opal_sg_list *sg1, *list = NULL;
-	void *addr;
-	int size;
-
-	addr = image_data.data;
-	size = image_data.size;
-
-	sg1 = kzalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!sg1)
-		return NULL;
-
-	list = sg1;
-	sg1->num_entries = 0;
-	while (size > 0) {
-		/* Translate virtual address to physical address */
-		sg1->entry[sg1->num_entries].data =
-			(void *)(vmalloc_to_pfn(addr) << PAGE_SHIFT);
-
-		if (size > PAGE_SIZE)
-			sg1->entry[sg1->num_entries].length = PAGE_SIZE;
-		else
-			sg1->entry[sg1->num_entries].length = size;
-
-		sg1->num_entries++;
-		if (sg1->num_entries >= SG_ENTRIES_PER_NODE) {
-			sg1->next = kzalloc(PAGE_SIZE, GFP_KERNEL);
-			if (!sg1->next) {
-				pr_err("%s : Failed to allocate memory\n",
-				       __func__);
-				goto nomem;
-			}
-
-			sg1 = sg1->next;
-			sg1->num_entries = 0;
-		}
-		addr += PAGE_SIZE;
-		size -= PAGE_SIZE;
-	}
-	return list;
-nomem:
-	free_sg_list(list);
-	return NULL;
-}
-
-/*
  * OPAL update flash
  */
 static int opal_flash_update(int op)
 {
-	struct opal_sg_list *sg, *list, *next;
+	struct opal_sg_list *list;
 	unsigned long addr;
 	int64_t rc = OPAL_PARAMETER;
 
@@ -364,30 +279,13 @@ static int opal_flash_update(int op)
 		goto flash;
 	}
 
-	list = image_data_to_sglist();
+	list = opal_vmalloc_to_sg_list(image_data.data, image_data.size);
 	if (!list)
 		goto invalid_img;
 
 	/* First entry address */
 	addr = __pa(list);
 
-	/* Translate sg list address to absolute */
-	for (sg = list; sg; sg = next) {
-		next = sg->next;
-		/* Don't translate NULL pointer for last entry */
-		if (sg->next)
-			sg->next = (struct opal_sg_list *)__pa(sg->next);
-		else
-			sg->next = NULL;
-
-		/*
-		 * Convert num_entries to version/length format
-		 * to satisfy OPAL.
-		 */
-		sg->num_entries = (SG_LIST_VERSION << 56) |
-			(sg->num_entries * sizeof(struct opal_sg_entry) + 16);
-	}
-
 	pr_alert("FLASH: Image is %u bytes\n", image_data.size);
 	pr_alert("FLASH: Image update requested\n");
 	pr_alert("FLASH: Image will be updated during system reboot\n");
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 17cfc70..360ad80c 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -638,3 +638,66 @@ void opal_shutdown(void)
 
 /* Export this so that test modules can use it */
 EXPORT_SYMBOL_GPL(opal_invalid_call);
+
+/* Convert a region of vmalloc memory to an opal sg list */
+struct opal_sg_list *opal_vmalloc_to_sg_list(void *vmalloc_addr,
+					     unsigned long vmalloc_size)
+{
+	struct opal_sg_list *sg, *first = NULL;
+	unsigned long i = 0;
+
+	sg = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!sg)
+		goto nomem;
+
+	first = sg;
+
+	while (vmalloc_size > 0) {
+		uint64_t data = vmalloc_to_pfn(vmalloc_addr) << PAGE_SHIFT;
+		uint64_t length = min(vmalloc_size, PAGE_SIZE);
+
+		sg->entry[i].data = cpu_to_be64(data);
+		sg->entry[i].length = cpu_to_be64(length);
+		i++;
+
+		if (i >= SG_ENTRIES_PER_NODE) {
+			struct opal_sg_list *next;
+
+			next = kzalloc(PAGE_SIZE, GFP_KERNEL);
+			if (!next)
+				goto nomem;
+
+			sg->length = cpu_to_be64(
+					i * sizeof(struct opal_sg_entry) + 16);
+			i = 0;
+			sg->next = cpu_to_be64(__pa(next));
+			sg = next;
+		}
+
+		vmalloc_addr += length;
+		vmalloc_size -= length;
+	}
+
+	sg->length = cpu_to_be64(i * sizeof(struct opal_sg_entry) + 16);
+
+	return first;
+
+nomem:
+	pr_err("%s : Failed to allocate memory\n", __func__);
+	opal_free_sg_list(first);
+	return NULL;
+}
+
+void opal_free_sg_list(struct opal_sg_list *sg)
+{
+	while (sg) {
+		uint64_t next = be64_to_cpu(sg->next);
+
+		kfree(sg);
+
+		if (next)
+			sg = __va(next);
+		else
+			sg = NULL;
+	}
+}
-- 
1.8.3.2
