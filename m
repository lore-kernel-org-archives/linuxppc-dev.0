Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DC645DDDD6
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Nov 2007 09:26:54 +1100 (EST)
Message-ID: <473F6A28.5000309@am.sony.com>
Date: Sat, 17 Nov 2007 14:24:40 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [patch] PS3: Fix printing of os-area magic numbers
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

Fix a bug in the printing of the PS3 os-area magic numbers which assumed that
magic numbers were zero terminated strings.  The magic numbers are represented
in memory as integers.  If the os-area sections are not initialized correctly
they could contained random data that would be printed to the display.

CC: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---

Paul,

This fixes a very minor bug in linus' current tree.  Please consider
for 2.6.24.

-Geoff

 arch/powerpc/platforms/ps3/os-area.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/arch/powerpc/platforms/ps3/os-area.c
+++ b/arch/powerpc/platforms/ps3/os-area.c
@@ -269,8 +269,13 @@ static void __init os_area_get_property(
 static void _dump_header(const struct os_area_header *h, const char *func,
 	int line)
 {
+	u8 str[sizeof(h->magic_num) + 1];
+
+	memcpy(str, h->magic_num, sizeof(h->magic_num));
+	str[sizeof(h->magic_num)] = 0;
+
 	pr_debug("%s:%d: h.magic_num:       '%s'\n", func, line,
-		h->magic_num);
+		str);
 	pr_debug("%s:%d: h.hdr_version:     %u\n", func, line,
 		h->hdr_version);
 	pr_debug("%s:%d: h.db_area_offset:  %u\n", func, line,
@@ -484,8 +489,13 @@ static int db_get_rtc_diff(const struct 
 static void _dump_db(const struct os_area_db *db, const char *func,
 	int line)
 {
+	u8 str[sizeof(db->magic_num) + 1];
+
+	memcpy(str, &db->magic_num, sizeof(db->magic_num));
+	str[sizeof(db->magic_num)] = 0;
+
 	pr_debug("%s:%d: db.magic_num:      '%s'\n", func, line,
-		(const char*)&db->magic_num);
+		str);
 	pr_debug("%s:%d: db.version:         %u\n", func, line,
 		db->version);
 	pr_debug("%s:%d: db.index_64:        %u\n", func, line,
