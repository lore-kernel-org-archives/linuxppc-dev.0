Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lhWT24J2zDq6t
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 16:37:08 +1000 (AEST)
Message-Id: <f3112437f62c2f48300535510918e8be1dceacfb.1533610877.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] lib/test_hexdump: fix failure on big endian cpu
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>
Date: Wed,  8 Aug 2018 06:37:03 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On a big endian cpu, test_hexdump fails as follows. The logs show
that bytes are expected in reversed order.

[...]
[   16.643648] test_hexdump: Len: 24 buflen: 130 strlen: 97
[   16.648681] test_hexdump: Result: 97 'be32db7b 0a1893b2 70bac424 7d83349b a69c31ad 9c0face9                    .2.{....p..$}.4...1.....'
[   16.660951] test_hexdump: Expect: 97 '7bdb32be b293180a 24c4ba70 9b34837d ad319ca6 e9ac0f9c                    .2.{....p..$}.4...1.....'
[   16.673129] test_hexdump: Len: 8 buflen: 130 strlen: 77
[   16.678113] test_hexdump: Result: 77 'be32db7b0a1893b2                                                     .2.{....'
[   16.688660] test_hexdump: Expect: 77 'b293180a7bdb32be                                                     .2.{....'
[   16.699170] test_hexdump: Len: 6 buflen: 131 strlen: 87
[   16.704238] test_hexdump: Result: 87 'be32 db7b 0a18                                                                   .2.{..'
[   16.715511] test_hexdump: Expect: 87 '32be 7bdb 180a                                                                   .2.{..'
[   16.726864] test_hexdump: Len: 24 buflen: 131 strlen: 97
[   16.731902] test_hexdump: Result: 97 'be32db7b 0a1893b2 70bac424 7d83349b a69c31ad 9c0face9                    .2.{....p..$}.4...1.....'
[   16.744175] test_hexdump: Expect: 97 '7bdb32be b293180a 24c4ba70 9b34837d ad319ca6 e9ac0f9c                    .2.{....p..$}.4...1.....'
[   16.756379] test_hexdump: Len: 32 buflen: 131 strlen: 101
[   16.761507] test_hexdump: Result: 101 'be32db7b0a1893b2 70bac4247d83349b a69c31ad9c0face9 4cd1199943b1af0c  .2.{....p..$}.4...1.....L...C...'
[   16.774212] test_hexdump: Expect: 101 'b293180a7bdb32be 9b34837d24c4ba70 e9ac0f9cad319ca6 0cafb1439919d14c  .2.{....p..$}.4...1.....L...C...'
[   16.786763] test_hexdump: failed 801 out of 1184 tests

This patch fixes it.

Fixes: 64d1d77a44697 ("hexdump: introduce test suite")
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 lib/test_hexdump.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
index 3f415d8101f3..626f580b4ff7 100644
--- a/lib/test_hexdump.c
+++ b/lib/test_hexdump.c
@@ -18,7 +18,7 @@ static const unsigned char data_b[] = {
 
 static const unsigned char data_a[] = ".2.{....p..$}.4...1.....L...C...";
 
-static const char * const test_data_1_le[] __initconst = {
+static const char * const test_data_1[] __initconst = {
 	"be", "32", "db", "7b", "0a", "18", "93", "b2",
 	"70", "ba", "c4", "24", "7d", "83", "34", "9b",
 	"a6", "9c", "31", "ad", "9c", "0f", "ac", "e9",
@@ -32,16 +32,33 @@ static const char * const test_data_2_le[] __initconst = {
 	"d14c", "9919", "b143", "0caf",
 };
 
+static const char * const test_data_2_be[] __initconst = {
+	"be32", "db7b", "0a18", "93b2",
+	"70ba", "c424", "7d83", "349b",
+	"a69c", "31ad", "9c0f", "ace9",
+	"4cd1", "1999", "43b1", "af0c",
+};
+
 static const char * const test_data_4_le[] __initconst = {
 	"7bdb32be", "b293180a", "24c4ba70", "9b34837d",
 	"ad319ca6", "e9ac0f9c", "9919d14c", "0cafb143",
 };
 
+static const char * const test_data_4_be[] __initconst = {
+	"be32db7b", "0a1893b2", "70bac424", "7d83349b",
+	"a69c31ad", "9c0face9", "4cd11999", "43b1af0c",
+};
+
 static const char * const test_data_8_le[] __initconst = {
 	"b293180a7bdb32be", "9b34837d24c4ba70",
 	"e9ac0f9cad319ca6", "0cafb1439919d14c",
 };
 
+static const char * const test_data_8_be[] __initconst = {
+	"be32db7b0a1893b2", "70bac4247d83349b",
+	"a69c31ad9c0face9", "4cd1199943b1af0c",
+};
+
 #define FILL_CHAR	'#'
 
 static unsigned total_tests __initdata;
@@ -56,6 +73,7 @@ static void __init test_hexdump_prepare_test(size_t len, int rowsize,
 	size_t l = len;
 	int gs = groupsize, rs = rowsize;
 	unsigned int i;
+	const bool is_be = IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
 
 	if (rs != 16 && rs != 32)
 		rs = 16;
@@ -67,13 +85,13 @@ static void __init test_hexdump_prepare_test(size_t len, int rowsize,
 		gs = 1;
 
 	if (gs == 8)
-		result = test_data_8_le;
+		result = is_be ? test_data_8_be : test_data_8_le;
 	else if (gs == 4)
-		result = test_data_4_le;
+		result = is_be ? test_data_4_be : test_data_4_le;
 	else if (gs == 2)
-		result = test_data_2_le;
+		result = is_be ? test_data_2_be : test_data_2_le;
 	else
-		result = test_data_1_le;
+		result = test_data_1;
 
 	/* hex dump */
 	p = test;
-- 
2.13.3
