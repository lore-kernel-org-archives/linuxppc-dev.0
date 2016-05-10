Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r3hjR4kcxzDq68
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 11:38:35 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id yl2so16767877pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 May 2016 18:38:35 -0700 (PDT)
Received: from circle.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id vg9sm43471733pab.35.2016.05.09.18.38.31
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 09 May 2016 18:38:32 -0700 (PDT)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V2] lib/test-hexdump: Changed to work on BE
Date: Tue, 10 May 2016 11:37:54 +1000
Message-Id: <1462844274-27887-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

test-hexdump.c doesn't work on BE because the test data is in LE format.
So add in data for BE.

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---

V2: Checking __BYTE_ORDER__. 

 lib/test_hexdump.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
index 3f415d8101f3..9de91a1b98bf 100644
--- a/lib/test_hexdump.c
+++ b/lib/test_hexdump.c
@@ -18,29 +18,48 @@ static const unsigned char data_b[] = {
 
 static const unsigned char data_a[] = ".2.{....p..$}.4...1.....L...C...";
 
-static const char * const test_data_1_le[] __initconst = {
+static const char * const test_data_1[] __initconst = {
 	"be", "32", "db", "7b", "0a", "18", "93", "b2",
 	"70", "ba", "c4", "24", "7d", "83", "34", "9b",
 	"a6", "9c", "31", "ad", "9c", "0f", "ac", "e9",
 	"4c", "d1", "19", "99", "43", "b1", "af", "0c",
 };
 
-static const char * const test_data_2_le[] __initconst = {
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+static const char * const test_data_2[] __initconst = {
 	"32be", "7bdb", "180a", "b293",
 	"ba70", "24c4", "837d", "9b34",
 	"9ca6", "ad31", "0f9c", "e9ac",
 	"d14c", "9919", "b143", "0caf",
 };
 
-static const char * const test_data_4_le[] __initconst = {
+static const char * const test_data_4[] __initconst = {
 	"7bdb32be", "b293180a", "24c4ba70", "9b34837d",
 	"ad319ca6", "e9ac0f9c", "9919d14c", "0cafb143",
 };
 
-static const char * const test_data_8_le[] __initconst = {
+static const char * const test_data_8[] __initconst = {
 	"b293180a7bdb32be", "9b34837d24c4ba70",
 	"e9ac0f9cad319ca6", "0cafb1439919d14c",
 };
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+static const char * const test_data_2[] __initconst = {
+	"be32", "db7b", "0a18", "93b2",
+	"70ba", "c424", "7d83", "349b",
+	"a69c", "31ad", "9c0f", "ace9",
+	"4cd1", "1999", "43b1", "af0c",
+};
+
+static const char * const test_data_4[] __initconst = {
+	"be32db7b", "0a1893b2", "70bac424", "7d83349b",
+	"a69c31ad", "9c0face9",	"4cd11999", "43b1af0c",
+};
+
+static const char * const test_data_8[] __initconst = {
+	"be32db7b0a1893b2", "70bac4247d83349b",
+	"a69c31ad9c0face9",	"4cd1199943b1af0c",
+};
+#endif
 
 #define FILL_CHAR	'#'
 
@@ -67,13 +86,13 @@ static void __init test_hexdump_prepare_test(size_t len, int rowsize,
 		gs = 1;
 
 	if (gs == 8)
-		result = test_data_8_le;
+		result = test_data_8;
 	else if (gs == 4)
-		result = test_data_4_le;
+		result = test_data_4;
 	else if (gs == 2)
-		result = test_data_2_le;
+		result = test_data_2;
 	else
-		result = test_data_1_le;
+		result = test_data_1;
 
 	/* hex dump */
 	p = test;
-- 
2.5.0
