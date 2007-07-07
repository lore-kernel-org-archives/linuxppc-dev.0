Return-Path: <miltonm@sullivan.realtime.net>
Date: Sat, 7 Jul 2007 01:18:49 -0500 (CDT)
Subject: [PATCH 04/11] dtc: implement labels on memory reserve slots
Sender: <miltonm@realtime.net>
From: Milton Miller <miltonm@bga.com>
To: Jon Loeliger <jdl@jdl.com>
Message-Id: <dtc-5-04.miltonm@bga.com>
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

Allow a label to be placed on a memory reserve entry.
Change the parser to recogonise and store them.  Emit
them when writing assembly output.

Signed-off-by: Milton Miller <miltonm@bga.com>
--- 
The infrastructure for storing the label was already present, so
the changes are small.

Index: dtc/dtc-parser.y
===================================================================
--- dtc.orig/dtc-parser.y	2007-06-14 22:59:05.000000000 -0500
+++ dtc/dtc-parser.y	2007-06-14 22:59:07.000000000 -0500
@@ -92,11 +92,11 @@ memreserves:	memreserve memreserves {
 		}
 	;
 
-memreserve:	DT_MEMRESERVE DT_ADDR DT_ADDR ';' {
-			$$ = build_reserve_entry($2, $3, NULL);
+memreserve:	label DT_MEMRESERVE DT_ADDR DT_ADDR ';' {
+			$$ = build_reserve_entry($3, $4, $1);
 		}
-	|	DT_MEMRESERVE DT_ADDR '-' DT_ADDR ';' {
-			$$ = build_reserve_entry($2, $4 - $2 + 1, NULL);
+	|	label DT_MEMRESERVE DT_ADDR '-' DT_ADDR ';' {
+			$$ = build_reserve_entry($3, $5 - $3 + 1, $1);
 		}
 	;
 
Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c	2007-06-14 22:59:00.000000000 -0500
+++ dtc/flattree.c	2007-06-14 22:59:07.000000000 -0500
@@ -497,6 +497,10 @@ void dt_to_asm(FILE *f, struct boot_info
 	 * as it appears .quad isn't available in some assemblers.
 	 */
 	for (re = bi->reservelist; re; re = re->next) {
+		if (re->label) {
+			fprintf(f, "\t.globl\t%s\n", re->label);
+			fprintf(f, "%s:\n", re->label);
+		}
 		fprintf(f, "\t.long\t0x%08x\n\t.long\t0x%08x\n",
 			(unsigned int)(re->re.address >> 32),
 			(unsigned int)(re->re.address & 0xffffffff));
