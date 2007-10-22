Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9336ADDE33
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 08:02:00 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1Ik5LQ-0000Ef-UF
	for linuxppc-dev@ozlabs.org; Mon, 22 Oct 2007 17:01:57 -0500
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] DTC: Rewrite the propdata and propdataprefix rules.
Date: Mon, 22 Oct 2007 17:01:56 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Ik5LQ-0000Ef-UF@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


After staring at these two rules for a bit, and not quite
groking them, I rewrote them into something I think is a
bit clearer.  With any luck, it's the same language still.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---

You be the judge too!

 dtc-parser.y |   31 ++++++++++++++-----------------
 1 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/dtc-parser.y b/dtc-parser.y
index 61ed250..f0b0178 100644
--- a/dtc-parser.y
+++ b/dtc-parser.y
@@ -59,7 +59,6 @@ extern struct boot_info *the_boot_info;
 %token <str> DT_REF
 
 %type <data> propdata
-%type <data> propdataprefix
 %type <re> memreserve
 %type <re> memreserves
 %type <cbase> opt_cell_base
@@ -143,37 +142,35 @@ propdef:
 	;
 
 propdata:
-	  propdataprefix DT_STRING
+	  DT_STRING
 		{
-			$$ = data_merge($1, $2);
+			$$ = data_merge(empty_data, $1);
 		}
-	| propdataprefix '<' celllist '>'
+	| '<' celllist '>'
 		{
-			$$ = data_merge(data_append_align($1,
-							  sizeof(cell_t)), $3);
+			$$ = data_merge(data_append_align(empty_data,
+							  sizeof(cell_t)), $2);
 		}
-	| propdataprefix '[' bytestring ']'
+	| '[' bytestring ']'
 		{
-			$$ = data_merge($1, $3);
+			$$ = data_merge(empty_data, $2);
 		}
 	| propdata DT_LABEL
 		{
 			$$ = data_add_label($1, $2);
 		}
-	;
-
-propdataprefix:
-	  /* empty */
+	| propdata ',' DT_STRING
 		{
-			$$ = empty_data;
+			$$ = data_merge($1, $3);
 		}
-	| propdata ','
+	| propdata ',' '<' celllist '>'
 		{
-			$$ = $1;
+			$$ = data_merge(data_append_align($1,
+							  sizeof(cell_t)), $4);
 		}
-	| propdataprefix DT_LABEL
+	| propdata ',' '[' bytestring ']'
 		{
-			$$ = data_add_label($1, $2);
+			$$ = data_merge($1, $4);
 		}
 	;
 
-- 
1.5.3.1.139.g9346b
