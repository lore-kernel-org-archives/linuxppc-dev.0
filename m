Return-Path: <arnd@arndb.de>
Received: from mout-bounce.kundenserver.de (mout-bounce.kundenserver.de
	[212.227.17.2]) by ozlabs.org (Postfix) with ESMTP id 6D6F3DDE0F
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 07:52:07 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
Subject: [PATCH, v2] numactl: fix libnuma on big-endian 64-bit systems
Date: Thu, 4 Dec 2008 21:51:58 +0100
References: <200812041834.45931.arnd@arndb.de>
	<1228412816.6959.48.camel@lts-notebook>
	<200812042149.06163.arnd@arndb.de>
In-Reply-To: <200812042149.06163.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200812042151.58676.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Mijo Safradin <safradin@de.ibm.com>,
	Cliff Wickman <cpw@sgi.com>, Christoph Lameter <clameter@sgi.com>
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
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---
 libnuma.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/libnuma.c b/libnuma.c
index 4d26093..9a9fbbe 100755
--- a/libnuma.c
+++ b/libnuma.c
@@ -376,9 +376,9 @@ read_mask(char *s, struct bitmask *bmp)
 {
 	char *end = s;
 	char *prevend;
-	unsigned int *start = (unsigned int *)bmp->maskp;
-	unsigned int *p = start;
-	unsigned int *q;
+	unsigned long *start = bmp->maskp;
+	unsigned long *p = start;
+	unsigned long *q;
 	unsigned int i;
 	unsigned int n = 0;
 
@@ -415,14 +415,14 @@ read_mask(char *s, struct bitmask *bmp)
 	}
 
 	/* Poor mans fls() */
-	for(i = 31; i >= 0; i--)
+	for(i = sizeof(long) * 8 - 1; i >= 0; i--)
 		if (test_bit(i, start + n))
 			break;
 
 	/*
 	 * Return the last bit set
 	 */
-	return ((sizeof(unsigned int)*8) * n) + i;
+	return ((sizeof(unsigned long)*8) * n) + i;
 }
 
 /*
