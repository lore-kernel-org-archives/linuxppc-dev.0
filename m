Return-Path: <dgibson@ozlabs.org>
Date: Wed, 7 Feb 2007 16:37:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [dtc] Allow multipart property values
Message-ID: <20070207053750.GG23870@localhost.localdomain>
References: <20070207032343.GD23870@localhost.localdomain>
	<41B393C3-9A8F-46EC-9B47-FCF8E0733994@kernel.crashing.org>
	<20070207044616.GF23870@localhost.localdomain>
	<BDAF32A9-05AE-4AFA-922B-22752C3B0845@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BDAF32A9-05AE-4AFA-922B-22752C3B0845@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 06, 2007 at 10:50:09PM -0600, Kumar Gala wrote:
> 
> On Feb 6, 2007, at 10:46 PM, David Gibson wrote:
> 
> > On Tue, Feb 06, 2007 at 10:37:25PM -0600, Kumar Gala wrote:
> >>
> >> On Feb 6, 2007, at 9:23 PM, David Gibson wrote:
> >>
> >>> At present each property definition in a dts file must give as the
> >>> value either a string ("abc..."), a bytestring ([12abcd...]) or a  
> >>> cell
> >>> list (<1 2 3 ...>).  This patch allows a property value to be  
> >>> given as
> >>> several of these, comma-separated.  The final property value is just
> >>> the components appended together.  So a property could have a  
> >>> list of
> >>> cells followed by a string, or a bytestring followed by some cells.
> >>> Cells are always aligned, so if cells are given following a  
> >>> string or
> >>> bytestring which is not a multiple of 4 bytes long, zero bytes are
> >>> inserted to align the following cells.
> >>>
> >>> The primary motivation for this feature, however, is to allow  
> >>> defining
> >>> a property as a list of several strings.  This is what's needed for
> >>> defining OF 'compatible' properties, and is less ugly and fiddly  
> >>> than
> >>> using embedded \0s in the strings.
> >>>
> >>> Signed-off-by: David Gibson <dwg@au1.ibm.com>
> >>
> >> Mind adding examples to the testsuite?
> >
> > What testsuite...?
> 
> Well there was a tests/ dir  and test.dts :)

There's nothing in tests/ though - I always meant to make a testsuite,
but I never got around to it.  Current plan is to implement a
testsuite by merging libfdt into the dtc tree.

Here's a revised patch which adds an example usage to test.dts

[dtc] Allow multipart property values

At present each property definition in a dts file must give as the
value either a string ("abc..."), a bytestring ([12abcd...]) or a cell
list (<1 2 3 ...>).  This patch allows a property value to be given as
several of these, comma-separated.  The final property value is just
the components appended together.  So a property could have a list of
cells followed by a string, or a bytestring followed by some cells.
Cells are always aligned, so if cells are given following a string or
bytestring which is not a multiple of 4 bytes long, zero bytes are
inserted to align the following cells.

The primary motivation for this feature, however, is to allow defining
a property as a list of several strings.  This is what's needed for
defining OF 'compatible' properties, and is less ugly and fiddly than
using embedded \0s in the strings.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: dtc/data.c
===================================================================
--- dtc.orig/data.c	2007-02-07 14:17:00.000000000 +1100
+++ dtc/data.c	2007-02-07 14:24:34.000000000 +1100
@@ -197,6 +197,33 @@ struct data data_append_data(struct data
 	return d;
 }
 
+struct data data_merge(struct data d1, struct data d2)
+{
+	struct data d;
+	struct fixup **ff;
+	struct fixup *f, *f2;
+
+	d = data_append_data(d1, d2.val, d2.len);
+
+	/* Extract d2's fixups */
+	f2 = d2.refs;
+	d2.refs = NULL;
+
+	/* Tack them onto d's list of fixups */
+	ff = &d.refs;
+	while (*ff)
+		ff = &((*ff)->next);
+	*ff = f2;
+
+	/* And correct them for their new position */
+	for (f = f2; f; f = f->next)
+		f->offset += d1.len;
+
+	data_free(d2);
+
+	return d;
+}
+
 struct data data_append_cell(struct data d, cell_t word)
 {
 	cell_t beword = cpu_to_be32(word);
Index: dtc/dtc-parser.y
===================================================================
--- dtc.orig/dtc-parser.y	2007-02-07 14:17:00.000000000 +1100
+++ dtc/dtc-parser.y	2007-02-07 14:24:34.000000000 +1100
@@ -58,6 +58,7 @@ extern struct boot_info *the_boot_info;
 %token <str> DT_REF
 
 %type <data> propdata
+%type <data> propdataprefix
 %type <re> memreserve
 %type <re> memreserves
 %type <data> celllist
@@ -121,9 +122,15 @@ propdef:	label DT_PROPNAME '=' propdata 
 		}
 	;
 
-propdata:	DT_STRING { $$ = $1; }
-	|	'<' celllist '>' { $$ = $2; }
-	|	'[' bytestring ']' { $$ = $2; }
+propdata:	propdataprefix DT_STRING { $$ = data_merge($1, $2); }
+	|	propdataprefix '<' celllist '>' {
+			$$ = data_merge(data_append_align($1, sizeof(cell_t)), $3);
+		}
+	|	propdataprefix '[' bytestring ']' { $$ = data_merge($1, $3); }
+	;
+
+propdataprefix:	propdata ',' { $$ = $1; }
+	|	/* empty */ { $$ = empty_data; }
 	;
 
 celllist:	celllist DT_CELL { $$ = data_append_cell($1, $2); }
Index: dtc/dtc.h
===================================================================
--- dtc.orig/dtc.h	2007-02-07 14:17:00.000000000 +1100
+++ dtc/dtc.h	2007-02-07 14:24:34.000000000 +1100
@@ -119,6 +119,7 @@ struct data data_copy_escape_string(char
 struct data data_copy_file(FILE *f, size_t len);
 
 struct data data_append_data(struct data d, void *p, int len);
+struct data data_merge(struct data d1, struct data d2);
 struct data data_append_cell(struct data d, cell_t word);
 struct data data_append_re(struct data d, struct reserve_entry *re);
 struct data data_append_addr(struct data d, u64 addr);
Index: dtc/dtc-lexer.l
===================================================================
--- dtc.orig/dtc-lexer.l	2007-02-07 14:17:00.000000000 +1100
+++ dtc/dtc-lexer.l	2007-02-07 14:24:34.000000000 +1100
@@ -123,6 +123,15 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
 			return ']';
 		}
 
+,		{ /* Technically this is a valid property name,
+		     but we'd rather use it as punctuation, so detect it
+		     here in preference */
+			yylloc.first_line = yylineno;
+			DPRINT("Char (propname like): %c (\\x%02x)\n", yytext[0],
+				(unsigned)yytext[0]);
+			return yytext[0];
+		}
+
 {PROPCHAR}+	{
 			yylloc.first_line = yylineno;
 			DPRINT("PropName: %s\n", yytext);
Index: dtc/test.dts
===================================================================
--- dtc.orig/test.dts	2007-02-07 16:35:54.000000000 +1100
+++ dtc/test.dts	2007-02-07 16:37:21.000000000 +1100
@@ -4,7 +4,7 @@
 
 / {
 	model = "MyBoardName";
-	compatible = "MyBoardFamilyName";
+	compatible = "MyBoardName", "MyBoardFamilyName";
 	#address-cells = <2>;
 	#size-cells = <2>;
 
@@ -39,6 +39,7 @@
 		string = "\xff\0stuffstuff\t\t\t\n\n\n";
 		blob = [0a 0b 0c 0d de ea ad be ef];
 		ref = < &/memory@0 >;
+		mixed = "abc", [1234], <a b c>;
 	};
 
 	memory@0 {


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
