Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail7-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 73401DDDE6
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Dec 2007 16:10:01 +1100 (EST)
Message-ID: <476DED97.8070709@am.sony.com>
Date: Sat, 22 Dec 2007 21:09:43 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [patch v3] PS3: Fix printing of os-area magic numbers
References: <473F6A28.5000309@am.sony.com>
In-Reply-To: <473F6A28.5000309@am.sony.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix a bug in the printing of the os-area magic numbers which assumed that
magic numbers were zero terminated strings.  The magic numbers are represented
in memory as integers.  If the os-area sections are not initialized correctly
they could contained random data that would be printed to the display.
Also unify the handling of header and db magic numbers and make both
of type array of u8.

CC: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
v2: o handle unprintable chars.

v3: o breakout string dump into helper dump_field()
    o unify handling of header and db magic numbers

 arch/powerpc/platforms/ps3/os-area.c |   40 ++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 10 deletions(-)

--- a/arch/powerpc/platforms/ps3/os-area.c
+++ b/arch/powerpc/platforms/ps3/os-area.c
@@ -23,6 +23,7 @@
 #include <linux/workqueue.h>
 #include <linux/fs.h>
 #include <linux/syscalls.h>
+#include <linux/ctype.h>
 
 #include <asm/lmb.h>
 
@@ -37,6 +38,8 @@ enum os_area_ldr_format {
 	HEADER_LDR_FORMAT_GZIP = 1,
 };
 
+#define OS_AREA_HEADER_MAGIC_NUM "cell_ext_os_area"
+
 /**
  * struct os_area_header - os area header segment.
  * @magic_num: Always 'cell_ext_os_area'.
@@ -114,13 +117,11 @@ struct os_area_params {
 	u8 _reserved_5[8];
 };
 
-enum {
-	OS_AREA_DB_MAGIC_NUM = 0x2d64622dU,
-};
+#define OS_AREA_DB_MAGIC_NUM "-db-"
 
 /**
  * struct os_area_db - Shared flash memory database.
- * @magic_num: Always '-db-' = 0x2d64622d.
+ * @magic_num: Always '-db-'.
  * @version: os_area_db format version number.
  * @index_64: byte offset of the database id index for 64 bit variables.
  * @count_64: number of usable 64 bit index entries
@@ -135,7 +136,7 @@ enum {
  */
 
 struct os_area_db {
-	u32 magic_num;
+	u8 magic_num[4];
 	u16 version;
 	u16 _reserved_1;
 	u16 index_64;
@@ -265,12 +266,26 @@ static void __init os_area_get_property(
 			prop->name);
 }
 
+static void dump_field(char *s, const u8 *f, unsigned int size)
+{
+#if defined(DEBUG)
+	unsigned int i;
+
+	for (i = 0; i < size; i++)
+		s[i] = isprint(f[i]) ? f[i] : '.';
+	s[i] = 0;
+#endif
+}
+
 #define dump_header(_a) _dump_header(_a, __func__, __LINE__)
 static void _dump_header(const struct os_area_header *h, const char *func,
 	int line)
 {
+	char str[sizeof(h->magic_num) + 1];
+
+	dump_field(str, h->magic_num, sizeof(h->magic_num));
 	pr_debug("%s:%d: h.magic_num:       '%s'\n", func, line,
-		h->magic_num);
+		str);
 	pr_debug("%s:%d: h.hdr_version:     %u\n", func, line,
 		h->hdr_version);
 	pr_debug("%s:%d: h.db_area_offset:  %u\n", func, line,
@@ -311,7 +326,8 @@ static void _dump_params(const struct os
 
 static int verify_header(const struct os_area_header *header)
 {
-	if (memcmp(header->magic_num, "cell_ext_os_area", 16)) {
+	if (memcmp(header->magic_num, OS_AREA_HEADER_MAGIC_NUM,
+		sizeof(header->magic_num))) {
 		pr_debug("%s:%d magic_num failed\n", __func__, __LINE__);
 		return -1;
 	}
@@ -331,7 +347,8 @@ static int verify_header(const struct os
 
 static int db_verify(const struct os_area_db *db)
 {
-	if (db->magic_num != OS_AREA_DB_MAGIC_NUM) {
+	if (memcmp(db->magic_num, OS_AREA_DB_MAGIC_NUM,
+		sizeof(db->magic_num))) {
 		pr_debug("%s:%d magic_num failed\n", __func__, __LINE__);
 		return -1;
 	}
@@ -484,8 +501,11 @@ static int db_get_rtc_diff(const struct 
 static void _dump_db(const struct os_area_db *db, const char *func,
 	int line)
 {
+	char str[sizeof(db->magic_num) + 1];
+
+	dump_field(str, db->magic_num, sizeof(db->magic_num));
 	pr_debug("%s:%d: db.magic_num:      '%s'\n", func, line,
-		(const char*)&db->magic_num);
+		str);
 	pr_debug("%s:%d: db.version:         %u\n", func, line,
 		db->version);
 	pr_debug("%s:%d: db.index_64:        %u\n", func, line,
@@ -516,7 +536,7 @@ static void os_area_db_init(struct os_ar
 
 	memset(db, 0, sizeof(struct os_area_db));
 
-	db->magic_num = OS_AREA_DB_MAGIC_NUM;
+	memcpy(db->magic_num, OS_AREA_DB_MAGIC_NUM, sizeof(db->magic_num));
 	db->version = 1;
 	db->index_64 = HEADER_SIZE;
 	db->count_64 = VALUES_64_COUNT;
