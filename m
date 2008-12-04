Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 9E55CDDE0A
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 04:34:54 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Cliff Wickman <cpw@sgi.com>, Mijo Safradin <safradin@de.ibm.com>,
	Christoph Lameter <clameter@sgi.com>,
	Lee Schermerhorn <lee.schermerhorn@hp.com>, linuxppc-dev@ozlabs.org
Subject: [PATCH] numactl: fix libnuma on big-endian 64-bit systems
Date: Thu, 4 Dec 2008 18:34:45 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200812041834.45931.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The read-mask function assumes that it is running in 32-bit mode,
by addressing the bitmask as a series of int values, instead of
longs. This is broken as can easily be reproduced by running numademo
on a bit-endian 64-bit system.

Changing the addressing to use 'long' values fixes the problem.

Reported-by: Mijo Safradin <safradin@de.ibm.com>

---

Note: the set_nodemask_size() function is broken as well, it seems
to always set the nodemask size to "17" with the s2nbits implementation.
The fallback path in there looks correct.

--- a/libnuma.c	2008-12-04 14:25:30.000000000 +0100
+++ b/libnuma.c	2008-11-20 13:40:29.000000000 +0100
@@ -392,9 +372,9 @@ read_mask(char *s, struct bitmask *bmp)
 {
 	char *end = s;
 	char *prevend;
-	unsigned long *start = bmp->maskp;
-	unsigned long *p = start;
-	unsigned long *q;
+	unsigned int *start = (unsigned int *)bmp->maskp;
+	unsigned int *p = start;
+	unsigned int *q;
 	unsigned int i;
 	unsigned int n = 0;
 
@@ -431,14 +411,14 @@
 	}
 
 	/* Poor mans fls() */
-	for(i = sizeof(long) * 8 - 1; i >= 0; i--)
+	for(i = 31; i >= 0; i--)
 		if (test_bit(i, start + n))
 			break;
 
 	/*
 	 * Return the last bit set
 	 */
-	return ((sizeof(unsigned long)*8) * n) + i;
+	return ((sizeof(unsigned int)*8) * n) + i;
 }
 
 /*
