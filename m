Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C43EDDF31
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 03:42:37 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1Iivrk-000784-OB
	for linuxppc-dev@ozlabs.org; Fri, 19 Oct 2007 12:42:33 -0500
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4] DTC: Reformat grammar rules to not mix language syntax
	and yacc syntax.
Date: Fri, 19 Oct 2007 12:42:32 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Iivrk-000784-OB@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Use consistent indenting on all rule actions.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---

No functional changes!

 dtc-parser.y |  152 +++++++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 118 insertions(+), 34 deletions(-)

diff --git a/dtc-parser.y b/dtc-parser.y
index 54fd787..4698793 100644
--- a/dtc-parser.y
+++ b/dtc-parser.y
@@ -79,103 +79,187 @@ extern struct boot_info *the_boot_info;
 
 %%
 
-sourcefile:	memreserves devicetree {
+sourcefile:
+	  memreserves devicetree
+		{
 			the_boot_info = build_boot_info($1, $2);
 		}
 	;
 
-memreserves:	memreserve memreserves {
+memreserves:
+	  memreserve memreserves
+		{
 			$$ = chain_reserve_entry($1, $2);
 		}
-	|	/* empty */	{
+	| /* empty */
+		{
 			$$ = NULL;
 		}
 	;
 
-memreserve:	label DT_MEMRESERVE DT_ADDR DT_ADDR ';' {
+memreserve:
+	  label DT_MEMRESERVE DT_ADDR DT_ADDR ';'
+		{
 			$$ = build_reserve_entry($3, $4, $1);
 		}
-	|	label DT_MEMRESERVE DT_ADDR '-' DT_ADDR ';' {
+	| label DT_MEMRESERVE DT_ADDR '-' DT_ADDR ';'
+		{
 			$$ = build_reserve_entry($3, $5 - $3 + 1, $1);
 		}
 	;
 
-devicetree:	'/' nodedef {
+devicetree:
+	  '/' nodedef
+		{
 			$$ = name_node($2, "", NULL);
 		}
 	;
 
-nodedef:	'{' proplist subnodes '}' ';' {
+nodedef:
+	  '{' proplist subnodes '}' ';'
+		{
 			$$ = build_node($2, $3);
 		}
 	;
 
-proplist:	propdef proplist {
+proplist:
+	  propdef proplist
+		{
 			$$ = chain_property($1, $2);
 		}
-	|	/* empty */	{
+	| /* empty */
+		{
 			$$ = NULL;
 		}
 	;
 
-propdef:	label DT_PROPNAME '=' propdata ';' {
+propdef:
+	  label DT_PROPNAME '=' propdata ';'
+		{
 			$$ = build_property($2, $4, $1);
 		}
-	|	label DT_PROPNAME ';' {
+	| label DT_PROPNAME ';'
+		{
 			$$ = build_property($2, empty_data, $1);
 		}
 	;
 
-propdata:	propdataprefix DT_STRING { $$ = data_merge($1, $2); }
-	|	propdataprefix '<' celllist '>' {
-			$$ = data_merge(data_append_align($1, sizeof(cell_t)), $3);
+propdata:
+	  propdataprefix DT_STRING
+		{
+			$$ = data_merge($1, $2);
+		}
+	| propdataprefix '<' celllist '>'
+		{
+			$$ = data_merge(data_append_align($1,
+							  sizeof(cell_t)), $3);
+		}
+	| propdataprefix '[' bytestring ']'
+		{
+			$$ = data_merge($1, $3);
+		}
+	| propdata DT_LABEL
+		{
+			$$ = data_add_label($1, $2);
 		}
-	|	propdataprefix '[' bytestring ']' { $$ = data_merge($1, $3); }
-	|	propdata DT_LABEL { $$ = data_add_label($1, $2); }
 	;
 
-propdataprefix:	propdata ',' { $$ = $1; }
-	|	propdataprefix DT_LABEL { $$ = data_add_label($1, $2); }
-	|	/* empty */ { $$ = empty_data; }
+propdataprefix:
+	  propdata ','
+		{
+			$$ = $1;
+		}
+	| propdataprefix DT_LABEL
+		{
+			$$ = data_add_label($1, $2);
+		}
+	| /* empty */
+		{
+			$$ = empty_data;
+		}
 	;
 
 opt_cell_base:
 	  /* empty */
-		{ $$ = 16; }
+		{
+			$$ = 16;
+		}
 	| DT_BASE
 	;
 
-celllist:	celllist opt_cell_base DT_CELL {
+celllist:
+	  celllist opt_cell_base DT_CELL
+		{
 			$$ = data_append_cell($1,
 					      cell_from_string($3, $2));
 		}
-	|	celllist DT_REF	{
+	| celllist DT_REF
+		{
 			$$ = data_append_cell(data_add_fixup($1, $2), -1);
 		}
-	|	celllist DT_LABEL { $$ = data_add_label($1, $2); }
-	|	/* empty */ { $$ = empty_data; }
+	| celllist DT_LABEL
+		{
+			$$ = data_add_label($1, $2);
+		}
+	| /* empty */
+		{
+			$$ = empty_data;
+		}
 	;
 
-bytestring:	bytestring DT_BYTE { $$ = data_append_byte($1, $2); }
-	|	bytestring DT_LABEL { $$ = data_add_label($1, $2); }
-	|	/* empty */ { $$ = empty_data; }
+bytestring:
+	  bytestring DT_BYTE
+		{
+			$$ = data_append_byte($1, $2);
+		}
+	| bytestring DT_LABEL
+		{
+			$$ = data_add_label($1, $2);
+		}
+	| /* empty */
+		{
+			$$ = empty_data;
+		}
 	;
 
-subnodes:	subnode subnodes {
+subnodes:
+	  subnode subnodes
+		{
 			$$ = chain_node($1, $2);
 		}
-	|	/* empty */ { $$ = NULL; }
+	| /* empty */
+		{
+			$$ = NULL;
+		}
 	;
 
-subnode:	label nodename nodedef { $$ = name_node($3, $2, $1); }
+subnode:
+	  label nodename nodedef
+		{
+			$$ = name_node($3, $2, $1);
+		}
 	;
 
-nodename:	DT_NODENAME	{ $$ = $1; }
-	|	DT_PROPNAME	{ $$ = $1; }
+nodename:
+	  DT_NODENAME
+		{
+			$$ = $1;
+		}
+	| DT_PROPNAME
+		{
+			$$ = $1;
+		}
 	;
 
-label:		DT_LABEL	{ $$ = $1; }
-	|	/* empty */	{ $$ = NULL; }
+label:
+	  DT_LABEL
+		{
+			$$ = $1;
+		}
+	| /* empty */
+		{
+			$$ = NULL;
+		}
 	;
 
 %%
-- 
1.5.3.1.139.g9346b
