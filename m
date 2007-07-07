Return-Path: <miltonm@sullivan.realtime.net>
Date: Sat, 7 Jul 2007 01:18:48 -0500 (CDT)
Subject: [PATCH 03/11] dtc: complain about unparsed digits in cell lists
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: Jon Loeliger <jdl@jdl.com>
Message-Id: <dtc-5-03.miltonm@bga.com>
In-Reply-To: <dtc-5-00.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Check that strtoul() parsed the complete string.

As with the number overflow case, write a non-fatal error
message to stdout.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
I saw the FIXME and knew how to fix it.  

I think the severity should be higher, but opted for the
detailed error message compared to the fixed string of
yyerror() and its immediate termination of parsing.

Index: dtc/dtc-parser.y
===================================================================
--- dtc.orig/dtc-parser.y	2007-06-14 22:59:04.000000000 -0500
+++ dtc/dtc-parser.y	2007-06-14 23:01:32.000000000 -0500
@@ -192,19 +192,27 @@ void yyerror (char const *s)
  * Convert a string representation of a numeric cell
  * in the given base into a cell.
  *
- * FIXME: The string "abc123", base 10, should be flagged
- *        as an error due to the leading "a", but isn't yet.
+ * FIXME: should these specification errors be fatal instead?
  */
 
 cell_t cell_from_string(char *s, unsigned int base)
 {
 	cell_t c;
+	char *e;
+
+	c = strtoul(s, &e, base);
+	if (*e) {
+		fprintf(stderr,
+			"Line %d: Invalid cell value '%s' : "
+			"%c is not a base %d digit; %d assumed\n",
+			yylloc.first_line, s, *e, base, c);
+	}
 
-	c = strtoul(s, NULL, base);
 	if (errno == EINVAL || errno == ERANGE) {
 		fprintf(stderr,
 			"Line %d: Invalid cell value '%s'; %d assumed\n",
 			yylloc.first_line, s, c);
+		errno = 0;
 	}
 
 	return c;
