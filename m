Return-Path: <dgibson@ozlabs.org>
Date: Mon, 17 Mar 2008 17:03:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Cleanup \nnn and \xNN string escape handling
Message-ID: <20080317060347.GG10988@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Several small cleanups to the handling of octal and hex string
escapes:
	- Use strncmp() instead dof what were essentially open-coded
          versions of the same, with short fixed lengths.
	- The call path to get_oct_char() means an empty escape is not
          possible.  So replace the error message in this case with an
          assert.
	- Use die() instead of a non-fatal error message if
          get_hex_char() is given an empty escape.  Change error
          message to close match gcc's in the same circumstance.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 data.c |   19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

Index: dtc/data.c
===================================================================
--- dtc.orig/data.c	2008-03-17 16:37:04.000000000 +1100
+++ dtc/data.c	2008-03-17 16:37:04.000000000 +1100
@@ -75,16 +75,11 @@ static char get_oct_char(const char *s, 
 	long val;
 
 	x[3] = '\0';
-	x[0] = s[(*i)];
-	if (x[0]) {
-		x[1] = s[(*i)+1];
-		if (x[1])
-			x[2] = s[(*i)+2];
-	}
+	strncpy(x, s + *i, 3);
 
 	val = strtol(x, &endx, 8);
-	if ((endx - x) == 0)
-		fprintf(stderr, "Empty \\nnn escape\n");
+
+	assert(endx > x);
 
 	(*i) += endx - x;
 	return val;
@@ -97,13 +92,11 @@ static char get_hex_char(const char *s, 
 	long val;
 
 	x[2] = '\0';
-	x[0] = s[(*i)];
-	if (x[0])
-		x[1] = s[(*i)+1];
+	strncpy(x, s + *i, 2);
 
 	val = strtol(x, &endx, 16);
-	if ((endx - x) == 0)
-		fprintf(stderr, "Empty \\x escape\n");
+	if (!(endx  > x))
+		die("\\x used with no following hex digits\n");
 
 	(*i) += endx - x;
 	return val;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
