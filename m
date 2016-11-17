Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKcdS3Z1wzDvvd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 10:23:56 +1100 (AEDT)
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tKcdR5GCxz9t1F
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2016 10:23:55 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id p66so18759345pga.2
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2016 15:23:55 -0800 (PST)
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH] powerpc/xmon: Add support for dump in reverse
Message-ID: <51a96060-527a-f9ca-ced8-d261fc526d2a@gmail.com>
Date: Fri, 18 Nov 2016 10:23:48 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This patch adds support for dumping bytes in the reverse order of
what they are read in, effectively doing an endian swap on double words.

This makes it easy to debug on a little endian system

The output of "d" on a little endian system is

0:mon> d c000000000e8bd10
c000000000e8bd10 70bde800000000c0 8428002400000000  |p........(.$....|

and with "dR"

0:mon> dR c000000000e8bd10
c000000000e8bd10 c000000000e8bd70 0000000024002884  |p........(.$....|

The patch adds "dR" only for CONFIG_PPC64. A new function digithex
is introduced which helps convert a digit to char in hex. There are
other command line tools to do byte endian swap, but I find this
useful for debugging.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/xmon/xmon.c | 58 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 7605455..0f4750c 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -120,7 +120,7 @@ static void byterev(unsigned char *, int);
 static void memex(void);
 static int bsesc(void);
 static void dump(void);
-static void prdump(unsigned long, long);
+static void prdump(unsigned long, long, int);
 static int ppc_inst_dump(unsigned long, long, int);
 static void dump_log_buf(void);
 
@@ -144,6 +144,7 @@ int skipbl(void);
 int scanhex(unsigned long *valp);
 static void scannl(void);
 static int hexdigit(int);
+static int digithex(int);
 void getstring(char *, int);
 static void flush_input(void);
 static int inchar(void);
@@ -220,6 +221,7 @@ Commands:\n\
 #endif
 #ifdef CONFIG_PPC64
   "\
+  dR	dump bytes in reverse (double words) \n\
   dp[#]	dump paca for current cpu, or cpu #\n\
   dpa	dump paca for all possible cpus\n"
 #endif
@@ -2371,43 +2373,76 @@ dump(void)
 		xmon_rawdump(adrs, ndump);
 		adrs += ndump;
 		last_cmd = "dr\n";
+#ifdef CONFIG_PPC64
+	} else if (c == 'R') {
+		scanhex(&ndump);
+		if (ndump == 0)
+			ndump = 64;
+		else if (ndump > MAX_DUMP)
+			ndump = MAX_DUMP;
+		prdump(adrs, ndump, 1);
+		adrs += ndump;
+		last_cmd = "dR\n";
+#endif
 	} else {
 		scanhex(&ndump);
 		if (ndump == 0)
 			ndump = 64;
 		else if (ndump > MAX_DUMP)
 			ndump = MAX_DUMP;
-		prdump(adrs, ndump);
+		prdump(adrs, ndump, 0);
 		adrs += ndump;
 		last_cmd = "d\n";
 	}
 }
 
 static void
-prdump(unsigned long adrs, long ndump)
+prdump(unsigned long adrs, long ndump, int reverse)
 {
 	long n, m, c, r, nr;
 	unsigned char temp[16];
+	unsigned char buf[17];
+	int idx;
 
 	for (n = ndump; n > 0;) {
 		printf(REG, adrs);
 		putchar(' ');
 		r = n < 16? n: 16;
 		nr = mread(adrs, temp, r);
+
+		if (reverse) {
+			idx = 14;
+			buf[16] = '\0';
+		}
 		adrs += nr;
 		for (m = 0; m < r; ++m) {
-			if ((m & (sizeof(long) - 1)) == 0 && m > 0)
+			if ((m & (sizeof(long) - 1)) == 0 && m > 0) {
+				if (reverse) {
+					printf("%s", buf);
+					idx = 14;
+				}
 				putchar(' ');
-			if (m < nr)
-				printf("%.2x", temp[m]);
-			else
+			}
+
+			if (m < nr) {
+				if (reverse) {
+					buf[idx + 1] = digithex(temp[m] % 16);
+					buf[idx] = digithex(temp[m] / 16);
+					idx -= 2;
+				} else
+					printf("%.2x", temp[m]);
+			} else
 				printf("%s", fault_chars[fault_type]);
 		}
+
+		if (reverse)
+			printf("%s", buf);
 		for (; m < 16; ++m) {
 			if ((m & (sizeof(long) - 1)) == 0)
 				putchar(' ');
 			printf("  ");
 		}
+
 		printf("  |");
 		for (m = 0; m < r; ++m) {
 			if (m < nr) {
@@ -2893,6 +2928,15 @@ static int hexdigit(int c)
 	return EOF;
 }
 
+static int digithex(int c)
+{
+	if (c >= 0 && c <= 9)
+		return c + '0';
+	if (c >= 0xa && c <= 0xf)
+		return c + ('a' - 10);
+	return EOF;
+}
+
 void
 getstring(char *s, int size)
 {
-- 
2.5.5
