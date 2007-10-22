Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B694BDDE1B
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 07:59:49 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1Ik5JJ-0000Cp-KT
	for linuxppc-dev@ozlabs.org; Mon, 22 Oct 2007 16:59:46 -0500
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] DTC: Minor grammar rule shuffle.
Date: Mon, 22 Oct 2007 16:59:45 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Ik5JJ-0000Cp-KT@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I like to see the basis cases established early in
the rule sets, so place  "empty" reduction first.
Purely cosmetic.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 dtc-parser.y |   62 +++++++++++++++++++++++++++++-----------------------------
 1 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/dtc-parser.y b/dtc-parser.y
index 0d140e5..c213526 100644
--- a/dtc-parser.y
+++ b/dtc-parser.y
@@ -86,13 +86,13 @@ sourcefile:
 	;
 
 memreserves:
-	  memreserve memreserves
+	  /* empty */
 		{
-			$$ = chain_reserve_entry($1, $2);
+			$$ = NULL;
 		}
-	| /* empty */
+	| memreserve memreserves
 		{
-			$$ = NULL;
+			$$ = chain_reserve_entry($1, $2);
 		}
 	;
 
@@ -122,13 +122,13 @@ nodedef:
 	;
 
 proplist:
-	  proplist propdef
+	  /* empty */
 		{
-			$$ = chain_property($2, $1);
+			$$ = NULL;
 		}
-	| /* empty */
+	| proplist propdef
 		{
-			$$ = NULL;
+			$$ = chain_property($2, $1);
 		}
 	;
 
@@ -164,7 +164,11 @@ propdata:
 	;
 
 propdataprefix:
-	  propdata ','
+	  /* empty */
+		{
+			$$ = empty_data;
+		}
+	| propdata ','
 		{
 			$$ = $1;
 		}
@@ -172,10 +176,6 @@ propdataprefix:
 		{
 			$$ = data_add_label($1, $2);
 		}
-	| /* empty */
-		{
-			$$ = empty_data;
-		}
 	;
 
 opt_cell_base:
@@ -187,7 +187,11 @@ opt_cell_base:
 	;
 
 celllist:
-	  celllist opt_cell_base DT_CELL
+	  /* empty */
+		{
+			$$ = empty_data;
+		}
+	| celllist opt_cell_base DT_CELL
 		{
 			$$ = data_append_cell($1,
 					      cell_from_string($3, $2));
@@ -200,14 +204,14 @@ celllist:
 		{
 			$$ = data_add_label($1, $2);
 		}
-	| /* empty */
-		{
-			$$ = empty_data;
-		}
 	;
 
 bytestring:
-	  bytestring DT_BYTE
+	  /* empty */
+		{
+			$$ = empty_data;
+		}
+	| bytestring DT_BYTE
 		{
 			$$ = data_append_byte($1, $2);
 		}
@@ -215,20 +219,16 @@ bytestring:
 		{
 			$$ = data_add_label($1, $2);
 		}
-	| /* empty */
-		{
-			$$ = empty_data;
-		}
 	;
 
 subnodes:
-	  subnode subnodes
+	  /* empty */
 		{
-			$$ = chain_node($1, $2);
+			$$ = NULL;
 		}
-	| /* empty */
+	|  subnode subnodes
 		{
-			$$ = NULL;
+			$$ = chain_node($1, $2);
 		}
 	;
 
@@ -251,13 +251,13 @@ nodename:
 	;
 
 label:
-	  DT_LABEL
+	  /* empty */
 		{
-			$$ = $1;
+			$$ = NULL;
 		}
-	| /* empty */
+	| DT_LABEL
 		{
-			$$ = NULL;
+			$$ = $1;
 		}
 	;
 
-- 
1.5.3.1.139.g9346b
