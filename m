Return-Path: <cpw@sgi.com>
Received: from relay.sgi.com (relay2.sgi.com [192.48.179.30])
	by ozlabs.org (Postfix) with ESMTP id C3DD5DDDEE
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Dec 2008 04:51:05 +1100 (EST)
To: arnd@arndb.de
Subject: [Re: PATCH] numactl: fix libnuma on big-endian 64-bit systems
Message-Id: <E1L8ejM-0003Ln-VN@eag09.americas.sgi.com>
From: Cliff Wickman <cpw@sgi.com>
Date: Fri, 05 Dec 2008 11:44:44 -0600
Cc: Lee.Schermerhorn@hp.com, safradin@de.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


linux-numa@vger.kernel.org

Arnd Bergmann and Mijo Safradin called my attention to problems with
libnuma's read_mask() on a big-endian 64-bit machine.

In testing that function I found it to be buggy on little-endian and 32-bit
systems as well.

I propose a function that looks like the below.  The patch is farther below.
(Arnd, I did not switch to longs, as that proved problematic.  The ascii hex
 strings being scanned are 32-bit values.)

I tested on a 64-bit MIPS system.  Could you test on your platform?

/*
 * Read a mask consisting of a sequence of hexadecimal longs separated by
 * commas. Order them correctly and return the number of the last bit
 * set.
 */
static int
read_mask(char *s, struct bitmask *bmp)
{
	char *end = s;
	unsigned int *start = (unsigned int *)bmp->maskp;
	unsigned int *p = start;
	unsigned int *q;
	unsigned int i;
	unsigned int n = 0;

	i = strtoul(s, &end, 16);

	/* Skip leading zeros */
	while (!i && *end++ == ',') {
		i = strtoul(end, &end, 16);
	}
	end++; /* past the , */

	if (!i)
		/* End of string. No mask */
		return -1;

	start[n++] = i;
	/* Read sequence of ints */
	do {
		i = strtoul(end, &end, 16);
		if (i)
			start[n++] = i;
	} while (*end++ == ',');
	n--;

	/*
	 * Invert sequence of ints if necessary since the first int
	 * is the highest and we put it first because we read it first.
	 */
	for (q = start + n, p = start; p < q; q--, p++) {
		unsigned int x = *q;

		*q = *p;
		*p = x;
	}

	/* Poor mans fls() */
	for(i = 31; i >= 0; i--)
		if (test_bit(i, start + n))
			break;

	/*
	 * Return the last bit set
	 */
	return ((sizeof(unsigned int)*8) * n) + i;
}



Signed-off-by: Cliff Wickman <cpw@sgi.com>
---
 libnuma.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: numactl-dev/libnuma.c
===================================================================
--- numactl-dev.orig/libnuma.c
+++ numactl-dev/libnuma.c
@@ -371,7 +371,6 @@ static int
 read_mask(char *s, struct bitmask *bmp)
 {
 	char *end = s;
-	char *prevend;
 	unsigned int *start = (unsigned int *)bmp->maskp;
 	unsigned int *p = start;
 	unsigned int *q;
@@ -380,22 +379,22 @@ read_mask(char *s, struct bitmask *bmp)
 
 	i = strtoul(s, &end, 16);
 
-	prevend = end;
 	/* Skip leading zeros */
 	while (!i && *end++ == ',') {
-		prevend = end;
 		i = strtoul(end, &end, 16);
 	}
-	end = prevend;
+	end++; /* past the , */
 
 	if (!i)
 		/* End of string. No mask */
 		return -1;
 
+	start[n++] = i;
 	/* Read sequence of ints */
 	do {
-		start[n++] = i;
 		i = strtoul(end, &end, 16);
+		if (i)
+			start[n++] = i;
 	} while (*end++ == ',');
 	n--;
 
