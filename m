Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 26053DE007
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 11:08:04 +1000 (EST)
Message-ID: <470AD44C.5080305@am.sony.com>
Date: Mon, 08 Oct 2007 18:07:24 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch v2] PS3: Add os-area database routines
References: <20071006213542.311447584@am.sony.com>
	<20071006213542.954029915@am.sony.com>
In-Reply-To: <20071006213542.954029915@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Subject: PS3: Add os-area database routines

Add support for a simple tagged database in the PS3 flash rom
os-area.  The database allows the flash rom os-area to be shared
between a bootloader and installed operating systems.   The
application ps3-flash-util or the library libps3-utils from the
ps3-utils package can be used for userspace database operations.

The latest ps3-utils package is available here:

  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-utils.git


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---

v2: Address Geert's comments:
  o Replace numeric initializers with symbols, calculations and
    BUILD_BUG_ON() checks.
  o Add a KERN_WARNING message when flash driver is not available.
  o Remove the unused (and incorrect) routine db_get_video_mode().

 arch/powerpc/platforms/ps3/os-area.c |  445 +++++++++++++++++++++++++++++++++--
 1 file changed, 431 insertions(+), 14 deletions(-)

--- a/arch/powerpc/platforms/ps3/os-area.c
+++ b/arch/powerpc/platforms/ps3/os-area.c
@@ -21,6 +21,8 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 #include <linux/workqueue.h>
+#include <linux/fs.h>
+#include <linux/syscalls.h>
 
 #include <asm/lmb.h>
 
@@ -39,7 +41,7 @@ enum os_area_ldr_format {
  * struct os_area_header - os area header segment.
  * @magic_num: Always 'cell_ext_os_area'.
  * @hdr_version: Header format version number.
- * @os_area_offset: Starting segment number of os image area.
+ * @db_area_offset: Starting segment number of other os database area.
  * @ldr_area_offset: Starting segment number of bootloader image area.
  * @ldr_format: HEADER_LDR_FORMAT flag.
  * @ldr_size: Size of bootloader image in bytes.
@@ -53,7 +55,7 @@ enum os_area_ldr_format {
 struct os_area_header {
 	u8 magic_num[16];
 	u32 hdr_version;
-	u32 os_area_offset;
+	u32 db_area_offset;
 	u32 ldr_area_offset;
 	u32 _reserved_1;
 	u32 ldr_format;
@@ -112,10 +114,95 @@ struct os_area_params {
 	u8 _reserved_5[8];
 };
 
+enum {
+	OS_AREA_DB_MAGIC_NUM = 0x2d64622dU,
+};
+
+/**
+ * struct os_area_db - Shared flash memory database.
+ * @magic_num: Always '-db-' = 0x2d64622d.
+ * @version: os_area_db format version number.
+ * @index_64: byte offset of the database id index for 64 bit variables.
+ * @count_64: number of usable 64 bit index entries
+ * @index_32: byte offset of the database id index for 32 bit variables.
+ * @count_32: number of usable 32 bit index entries
+ * @index_16: byte offset of the database id index for 16 bit variables.
+ * @count_16: number of usable 16 bit index entries
+ *
+ * Flash rom storage for exclusive use by guests running in the other os lpar.
+ * The current system configuration allocates 1K (two segments) for other os
+ * use.
+ */
+
+struct os_area_db {
+	u32 magic_num;
+	u16 version;
+	u16 _reserved_1;
+	u16 index_64;
+	u16 count_64;
+	u16 index_32;
+	u16 count_32;
+	u16 index_16;
+	u16 count_16;
+	u32 _reserved_2;
+	u8 _db_data[1000];
+};
+
+/**
+ * enum os_area_db_owner - Data owners.
+ */
+
+enum os_area_db_owner {
+	OS_AREA_DB_OWNER_ANY = -1,
+	OS_AREA_DB_OWNER_NONE = 0,
+	OS_AREA_DB_OWNER_PROTOTYPE = 1,
+	OS_AREA_DB_OWNER_LINUX = 2,
+	OS_AREA_DB_OWNER_PETITBOOT = 3,
+	OS_AREA_DB_OWNER_MAX = 32,
+};
+
+enum os_area_db_key {
+	OS_AREA_DB_KEY_ANY = -1,
+	OS_AREA_DB_KEY_NONE = 0,
+	OS_AREA_DB_KEY_RTC_DIFF = 1,
+	OS_AREA_DB_KEY_VIDEO_MODE = 2,
+	OS_AREA_DB_KEY_MAX = 8,
+};
+
+struct os_area_db_id {
+	int owner;
+	int key;
+};
+
+static const struct os_area_db_id os_area_db_id_empty = {
+	.owner = OS_AREA_DB_OWNER_NONE,
+	.key = OS_AREA_DB_KEY_NONE
+};
+
+static const struct os_area_db_id os_area_db_id_any = {
+	.owner = OS_AREA_DB_OWNER_ANY,
+	.key = OS_AREA_DB_KEY_ANY
+};
+
+static const struct os_area_db_id os_area_db_id_rtc_diff = {
+	.owner = OS_AREA_DB_OWNER_LINUX,
+	.key = OS_AREA_DB_KEY_RTC_DIFF
+};
+
+static const struct os_area_db_id os_area_db_id_video_mode = {
+	.owner = OS_AREA_DB_OWNER_LINUX,
+	.key = OS_AREA_DB_KEY_VIDEO_MODE
+};
+
 #define SECONDS_FROM_1970_TO_2000 946684800LL
 
 /**
  * struct saved_params - Static working copies of data from the PS3 'os area'.
+ *
+ * The order of preference we use for the rtc_diff source:
+ *  1) The database value.
+ *  2) The game os value.
+ *  3) The number of seconds from 1970 to 2000.
  */
 
 struct saved_params {
@@ -182,17 +269,17 @@ static void __init os_area_get_property(
 static void _dump_header(const struct os_area_header *h, const char *func,
 	int line)
 {
-	pr_debug("%s:%d: h.magic_num:         '%s'\n", func, line,
+	pr_debug("%s:%d: h.magic_num:       '%s'\n", func, line,
 		h->magic_num);
-	pr_debug("%s:%d: h.hdr_version:       %u\n", func, line,
+	pr_debug("%s:%d: h.hdr_version:     %u\n", func, line,
 		h->hdr_version);
-	pr_debug("%s:%d: h.os_area_offset:   %u\n", func, line,
-		h->os_area_offset);
+	pr_debug("%s:%d: h.db_area_offset:  %u\n", func, line,
+		h->db_area_offset);
 	pr_debug("%s:%d: h.ldr_area_offset: %u\n", func, line,
 		h->ldr_area_offset);
-	pr_debug("%s:%d: h.ldr_format:        %u\n", func, line,
+	pr_debug("%s:%d: h.ldr_format:      %u\n", func, line,
 		h->ldr_format);
-	pr_debug("%s:%d: h.ldr_size:          %xh\n", func, line,
+	pr_debug("%s:%d: h.ldr_size:        %xh\n", func, line,
 		h->ldr_size);
 }
 
@@ -222,7 +309,7 @@ static void _dump_params(const struct os
 		p->dns_secondary[2], p->dns_secondary[3]);
 }
 
-static int __init verify_header(const struct os_area_header *header)
+static int verify_header(const struct os_area_header *header)
 {
 	if (memcmp(header->magic_num, "cell_ext_os_area", 16)) {
 		pr_debug("%s:%d magic_num failed\n", __func__, __LINE__);
@@ -234,7 +321,7 @@ static int __init verify_header(const st
 		return -1;
 	}
 
-	if (header->os_area_offset > header->ldr_area_offset) {
+	if (header->db_area_offset > header->ldr_area_offset) {
 		pr_debug("%s:%d offsets failed\n", __func__, __LINE__);
 		return -1;
 	}
@@ -242,6 +329,319 @@ static int __init verify_header(const st
 	return 0;
 }
 
+static int db_verify(const struct os_area_db *db)
+{
+	if (db->magic_num != OS_AREA_DB_MAGIC_NUM) {
+		pr_debug("%s:%d magic_num failed\n", __func__, __LINE__);
+		return -1;
+	}
+
+	if (db->version != 1) {
+		pr_debug("%s:%d version failed\n", __func__, __LINE__);
+		return -1;
+	}
+
+	return 0;
+}
+
+struct db_index {
+       uint8_t owner:5;
+       uint8_t key:3;
+};
+
+struct db_iterator {
+	const struct os_area_db *db;
+	struct os_area_db_id match_id;
+	struct db_index *idx;
+	struct db_index *last_idx;
+	union {
+		uint64_t *value_64;
+		uint32_t *value_32;
+		uint16_t *value_16;
+	};
+};
+
+static unsigned int db_align_up(unsigned int val, unsigned int size)
+{
+	return (val + (size - 1)) & (~(size - 1));
+}
+
+/**
+ * db_for_each_64 - Iterator for 64 bit entries.
+ *
+ * A NULL value for id can be used to match all entries.
+ * OS_AREA_DB_OWNER_ANY and OS_AREA_DB_KEY_ANY can be used to match all.
+ */
+
+static int db_for_each_64(const struct os_area_db *db,
+	const struct os_area_db_id *match_id, struct db_iterator *i)
+{
+next:
+	if (!i->db) {
+		i->db = db;
+		i->match_id = match_id ? *match_id : os_area_db_id_any;
+		i->idx = (void *)db + db->index_64;
+		i->last_idx = i->idx + db->count_64;
+		i->value_64 = (void *)db + db->index_64
+			+ db_align_up(db->count_64, 8);
+	} else {
+		i->idx++;
+		i->value_64++;
+	}
+
+	if (i->idx >= i->last_idx) {
+		pr_debug("%s:%d: reached end\n", __func__, __LINE__);
+		return 0;
+	}
+
+	if (i->match_id.owner != OS_AREA_DB_OWNER_ANY
+		&& i->match_id.owner != (int)i->idx->owner)
+		goto next;
+	if (i->match_id.key != OS_AREA_DB_KEY_ANY
+		&& i->match_id.key != (int)i->idx->key)
+		goto next;
+
+	return 1;
+}
+
+static int db_delete_64(struct os_area_db *db, const struct os_area_db_id *id)
+{
+	struct db_iterator i;
+
+	for (i.db = NULL; db_for_each_64(db, id, &i); ) {
+
+		pr_debug("%s:%d: got (%d:%d) %llxh\n", __func__, __LINE__,
+			i.idx->owner, i.idx->key,
+			(unsigned long long)*i.value_64);
+
+		i.idx->owner = 0;
+		i.idx->key = 0;
+		*i.value_64 = 0;
+	}
+	return 0;
+}
+
+static int db_set_64(struct os_area_db *db, const struct os_area_db_id *id,
+	uint64_t value)
+{
+	struct db_iterator i;
+
+	pr_debug("%s:%d: (%d:%d) <= %llxh\n", __func__, __LINE__,
+		id->owner, id->key, (unsigned long long)value);
+
+	if (!id->owner || id->owner == OS_AREA_DB_OWNER_ANY
+		|| id->key == OS_AREA_DB_KEY_ANY) {
+		pr_debug("%s:%d: bad id: (%d:%d)\n", __func__,
+			__LINE__, id->owner, id->key);
+		return -1;
+	}
+
+	db_delete_64(db, id);
+
+	i.db = NULL;
+	if (db_for_each_64(db, &os_area_db_id_empty, &i)) {
+
+		pr_debug("%s:%d: got (%d:%d) %llxh\n", __func__, __LINE__,
+			i.idx->owner, i.idx->key,
+			(unsigned long long)*i.value_64);
+
+		i.idx->owner = id->owner;
+		i.idx->key = id->key;
+		*i.value_64 = value;
+
+		pr_debug("%s:%d: set (%d:%d) <= %llxh\n", __func__, __LINE__,
+			i.idx->owner, i.idx->key,
+			(unsigned long long)*i.value_64);
+		return 0;
+	}
+	pr_debug("%s:%d: database full.\n",
+		__func__, __LINE__);
+	return -1;
+}
+
+static int db_get_64(const struct os_area_db *db,
+	const struct os_area_db_id *id, uint64_t *value)
+{
+	struct db_iterator i;
+
+	i.db = NULL;
+	if (db_for_each_64(db, id, &i)) {
+		*value = *i.value_64;
+		pr_debug("%s:%d: found %lld\n", __func__, __LINE__,
+				(long long int)*i.value_64);
+		return 0;
+	}
+	pr_debug("%s:%d: not found\n", __func__, __LINE__);
+	return -1;
+}
+
+static int db_get_rtc_diff(const struct os_area_db *db, int64_t *rtc_diff)
+{
+	return db_get_64(db, &os_area_db_id_rtc_diff, (uint64_t*)rtc_diff);
+}
+
+#define dump_db(a) _dump_db(a, __func__, __LINE__)
+static void _dump_db(const struct os_area_db *db, const char *func,
+	int line)
+{
+	pr_debug("%s:%d: db.magic_num:      '%s'\n", func, line,
+		(const char*)&db->magic_num);
+	pr_debug("%s:%d: db.version:         %u\n", func, line,
+		db->version);
+	pr_debug("%s:%d: db.index_64:        %u\n", func, line,
+		db->index_64);
+	pr_debug("%s:%d: db.count_64:        %u\n", func, line,
+		db->count_64);
+	pr_debug("%s:%d: db.index_32:        %u\n", func, line,
+		db->index_32);
+	pr_debug("%s:%d: db.count_32:        %u\n", func, line,
+		db->count_32);
+	pr_debug("%s:%d: db.index_16:        %u\n", func, line,
+		db->index_16);
+	pr_debug("%s:%d: db.count_16:        %u\n", func, line,
+		db->count_16);
+}
+
+static void os_area_db_init(struct os_area_db *db)
+{
+	enum {
+		HEADER_SIZE = offsetof(struct os_area_db, _db_data),
+		INDEX_64_COUNT = 64,
+		VALUES_64_COUNT = 57,
+		INDEX_32_COUNT = 64,
+		VALUES_32_COUNT = 57,
+		INDEX_16_COUNT = 64,
+		VALUES_16_COUNT = 57,
+	};
+
+	memset(db, 0, sizeof(struct os_area_db));
+
+	db->magic_num = OS_AREA_DB_MAGIC_NUM;
+	db->version = 1;
+	db->index_64 = HEADER_SIZE;
+	db->count_64 = VALUES_64_COUNT;
+	db->index_32 = HEADER_SIZE
+			+ INDEX_64_COUNT * sizeof(struct db_index)
+			+ VALUES_64_COUNT * sizeof(u64);
+	db->count_32 = VALUES_32_COUNT;
+	db->index_16 = HEADER_SIZE
+			+ INDEX_64_COUNT * sizeof(struct db_index)
+			+ VALUES_64_COUNT * sizeof(u64)
+			+ INDEX_32_COUNT * sizeof(struct db_index)
+			+ VALUES_32_COUNT * sizeof(u32);
+	db->count_16 = VALUES_16_COUNT;
+
+	/* Rules to check db layout. */
+
+	BUILD_BUG_ON(sizeof(struct db_index) != 1);
+	BUILD_BUG_ON(sizeof(struct os_area_db) != 2 * OS_AREA_SEGMENT_SIZE);
+	BUILD_BUG_ON(INDEX_64_COUNT & 0x7);
+	BUILD_BUG_ON(VALUES_64_COUNT > INDEX_64_COUNT);
+	BUILD_BUG_ON(INDEX_32_COUNT & 0x7);
+	BUILD_BUG_ON(VALUES_32_COUNT > INDEX_32_COUNT);
+	BUILD_BUG_ON(INDEX_16_COUNT & 0x7);
+	BUILD_BUG_ON(VALUES_16_COUNT > INDEX_16_COUNT);
+	BUILD_BUG_ON(HEADER_SIZE
+			+ INDEX_64_COUNT * sizeof(struct db_index)
+			+ VALUES_64_COUNT * sizeof(u64)
+			+ INDEX_32_COUNT * sizeof(struct db_index)
+			+ VALUES_32_COUNT * sizeof(u32)
+			+ INDEX_16_COUNT * sizeof(struct db_index)
+			+ VALUES_16_COUNT * sizeof(u16)
+			> sizeof(struct os_area_db));
+}
+
+/**
+ * update_flash_db - Helper for os_area_queue_work_handler.
+ *
+ */
+
+static void update_flash_db(void)
+{
+	int result;
+	int file;
+	off_t offset;
+	ssize_t count;
+	static const unsigned int buf_len = 8 * OS_AREA_SEGMENT_SIZE;
+	const struct os_area_header *header;
+	struct os_area_db* db;
+
+	/* Read in header and db from flash. */
+
+	file = sys_open("/dev/ps3flash", O_RDWR, 0);
+
+	if (file < 0) {
+		pr_debug("%s:%d sys_open failed\n", __func__, __LINE__);
+		goto fail_open;
+	}
+
+	header = kmalloc(buf_len, GFP_KERNEL);
+
+	if (!header) {
+		pr_debug("%s:%d kmalloc failed\n", __func__, __LINE__);
+		goto fail_malloc;
+	}
+
+	offset = sys_lseek(file, 0, SEEK_SET);
+
+	if (offset != 0) {
+		pr_debug("%s:%d sys_lseek failed\n", __func__, __LINE__);
+		goto fail_header_seek;
+	}
+
+	count = sys_read(file, (char __user *)header, buf_len);
+
+	result = count < OS_AREA_SEGMENT_SIZE || verify_header(header)
+		|| count < header->db_area_offset * OS_AREA_SEGMENT_SIZE;
+
+	if (result) {
+		pr_debug("%s:%d verify_header failed\n", __func__, __LINE__);
+		dump_header(header);
+		goto fail_header;
+	}
+
+	/* Now got a good db offset and some maybe good db data. */
+
+	db = (void*)header + header->db_area_offset * OS_AREA_SEGMENT_SIZE;
+
+	result = db_verify(db);
+
+	if (result) {
+		printk(KERN_NOTICE "%s:%d: Verify of flash database failed, "
+			"formatting.\n", __func__, __LINE__);
+		dump_db(db);
+		os_area_db_init(db);
+	}
+
+	/* Now got good db data. */
+
+	db_set_64(db, &os_area_db_id_rtc_diff, saved_params.rtc_diff);
+
+	offset = sys_lseek(file, header->db_area_offset * OS_AREA_SEGMENT_SIZE,
+		SEEK_SET);
+
+	if (offset != header->db_area_offset * OS_AREA_SEGMENT_SIZE) {
+		pr_debug("%s:%d sys_lseek failed\n", __func__, __LINE__);
+		goto fail_db_seek;
+	}
+
+	count = sys_write(file, (const char __user *)db,
+		sizeof(struct os_area_db));
+
+	if (count < sizeof(struct os_area_db)) {
+		pr_debug("%s:%d sys_write failed\n", __func__, __LINE__);
+	}
+
+fail_db_seek:
+fail_header:
+fail_header_seek:
+	kfree(header);
+fail_malloc:
+	sys_close(file);
+fail_open:
+	return;
+}
+
 /**
  * os_area_queue_work_handler - Asynchronous write handler.
  *
@@ -264,6 +664,12 @@ static void os_area_queue_work_handler(s
 		pr_debug("%s:%d of_find_node_by_path failed\n",
 			__func__, __LINE__);
 
+#if defined(CONFIG_PS3_FLASH) || defined(CONFIG_PS3_FLASH_MODULE)
+	update_flash_db();
+#else
+	printk(KERN_WARNING "%s:%d: No flash rom driver configured.\n",
+		__func__, __LINE__);
+#endif
 	pr_debug(" <- %s:%d\n", __func__, __LINE__);
 }
 
@@ -278,11 +684,15 @@ static void os_area_queue_work(void)
 /**
  * ps3_os_area_save_params - Copy data from os area mirror to @saved_params.
  *
- * For the convenience of the guest, the HV makes a copy of the os area in
+ * For the convenience of the guest the HV makes a copy of the os area in
  * flash to a high address in the boot memory region and then puts that RAM
- * address and the byte count into the repository for retreval by the guest.
+ * address and the byte count into the repository for retrieval by the guest.
  * We copy the data we want into a static variable and allow the memory setup
  * by the HV to be claimed by the lmb manager.
+ *
+ * The os area mirror will not be available to a second stage kernel, and
+ * the header verify will fail.  In this case, the saved_params values will
+ * be set from flash memory or the passed in device tree in ps3_os_area_init().
  */
 
 void __init ps3_os_area_save_params(void)
@@ -292,6 +702,7 @@ void __init ps3_os_area_save_params(void
 	unsigned int size;
 	struct os_area_header *header;
 	struct os_area_params *params;
+	struct os_area_db *db;
 
 	pr_debug(" -> %s:%d\n", __func__, __LINE__);
 
@@ -311,16 +722,22 @@ void __init ps3_os_area_save_params(void
 
 	if (result) {
 		/* Second stage kernels exit here. */
-
 		pr_debug("%s:%d verify_header failed\n", __func__, __LINE__);
 		dump_header(header);
 		return;
 	}
 
+	db = (struct os_area_db *)__va(lpar_addr
+		+ header->db_area_offset * OS_AREA_SEGMENT_SIZE);
+
 	dump_header(header);
 	dump_params(params);
+	dump_db(db);
 
-	saved_params.rtc_diff = params->rtc_diff;
+	result = db_verify(db) || db_get_rtc_diff(db, &saved_params.rtc_diff);
+	if (result)
+		saved_params.rtc_diff = params->rtc_diff ? params->rtc_diff
+			: SECONDS_FROM_1970_TO_2000;
 	saved_params.av_multi_out = params->av_multi_out;
 	saved_params.valid = 1;
 
