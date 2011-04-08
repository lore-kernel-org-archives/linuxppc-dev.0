Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2B5E9B6F7D
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Apr 2011 22:18:27 +1000 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p38BqsBS002260
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2011 07:52:54 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 66B926E8036
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Apr 2011 08:18:01 -0400 (EDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p38CI07f478680
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2011 08:18:01 -0400
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p38CI0DT008582
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Apr 2011 06:18:00 -0600
Date: Fri, 8 Apr 2011 08:18:22 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: Fix xmon ml/mz commands to work with 64-bit values
Message-ID: <20110408121822.GG2754@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ml and and mz commands in xmon currently only work on 32-bit values.
This leads to odd issues when trying to use them on a ppc64 machine.  If
one specified 64-bit addresses to mz, it would loop on the same output
indefinitely.  The ml command would fail to find any 64-bit values in a
memory range, even though one could clearly see them present with the d
command.

This adds a small function that mimics GETWORD, but works for 64-bit
values.  The data types involved in these commands are also changed to
'unsigned long' instead of just 'unsigned'.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 arch/powerpc/xmon/xmon.c |   47 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

Index: linux-2.6/arch/powerpc/xmon/xmon.c
===================================================================
--- linux-2.6.orig/arch/powerpc/xmon/xmon.c
+++ linux-2.6/arch/powerpc/xmon/xmon.c
@@ -2257,14 +2257,40 @@ memdiffs(unsigned char *p1, unsigned cha
 		printf("Total of %d differences\n", prt);
 }
 
-static unsigned mend;
-static unsigned mask;
+static unsigned long mend;
+static unsigned long mask;
+
+/* This is mimics GETWORD but works for 64-bit values. */
+static inline unsigned long xmon_getval(unsigned char *val)
+{
+	unsigned long word1 = 0, word2 = 0;
+	unsigned long size = sizeof(unsigned long);
+	int i;
+	int bits = 24;
+
+	for (i = 0; i < 4; i++) {
+		word1 += val[i] << bits;
+		bits -= 8;
+	}
+	if (size > 4) {
+		bits = 24;
+		for (i = 4; i < 8; i++) {
+			word2 += val[i] << bits;
+			bits -= 8;
+		}
+		word1 = word1 << 32;
+		word2 = word2 & 0x00000000ffffffff;
+		word1 = word1 | word2;
+	}
+	return word1;
+}
 
 static void
 memlocate(void)
 {
-	unsigned a, n;
-	unsigned char val[4];
+	unsigned long a, n;
+	unsigned char val[sizeof(unsigned long)];
+	int size = sizeof(unsigned long);
 
 	last_cmd = "ml";
 	scanhex((void *)&mdest);
@@ -2280,10 +2306,10 @@ memlocate(void)
 		}
 	}
 	n = 0;
-	for (a = mdest; a < mend; a += 4) {
-		if (mread(a, val, 4) == 4
-			&& ((GETWORD(val) ^ mval) & mask) == 0) {
-			printf("%.16x:  %.16x\n", a, GETWORD(val));
+	for (a = mdest; a < mend; a += size) {
+		if (mread(a, val, size) == size
+			&& ((xmon_getval(val) ^ mval) & mask) == 0) {
+			printf("%.16lx:  %.16lx\n", a, xmon_getval(val));
 			if (++n >= 10)
 				break;
 		}
@@ -2297,7 +2323,7 @@ static void
 memzcan(void)
 {
 	unsigned char v;
-	unsigned a;
+	unsigned long a;
 	int ok, ook;
 
 	scanhex(&mdest);
