Return-Path: <bunk@kernel.org>
Received: from smtp4.pp.htv.fi (smtp4.pp.htv.fi [213.243.153.38])
	by ozlabs.org (Postfix) with ESMTP id E2190DE1EC
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 04:20:07 +1000 (EST)
Date: Thu, 17 Jul 2008 21:19:49 +0300
From: Adrian Bunk <bunk@kernel.org>
To: David Gibson <david@gibson.dropbear.id.au>,
	Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org
Subject: [2.6 patch] powerpc/boot/dtc-src/dtc-lexer.l: add %option noinput
Message-ID: <20080717181949.GC18326@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

gcc 4.3 correctly determines that input() is unused and gives the 
following warning:

<--  snip  -->

...
  HOSTCC  arch/powerpc/boot/dtc-src/dtc-lexer.lex.o
dtc-lexer.lex.c:1436: warning: ‘input’ defined but not used
...

<--  snip  -->

Fix it by adding %option noinput to 
arch/powerpc/boot/dtc-src/dtc-lexer.l and 
regeneration of arch/powerpc/boot/dtc-src/dtc-lexer.lex.c_shipped.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 arch/powerpc/boot/dtc-src/dtc-lexer.l             |    2 
 arch/powerpc/boot/dtc-src/dtc-lexer.lex.c_shipped |  127 +++++++++-----
 2 files changed, 84 insertions(+), 45 deletions(-)

551cd080360b31cf9b8bb387916f3852e4fb6156 
diff --git a/arch/powerpc/boot/dtc-src/dtc-lexer.l b/arch/powerpc/boot/dtc-src/dtc-lexer.l
index c811b22..1f76fea 100644
--- a/arch/powerpc/boot/dtc-src/dtc-lexer.l
+++ b/arch/powerpc/boot/dtc-src/dtc-lexer.l
@@ -18,7 +18,7 @@
  *                                                                   USA
  */
 
-%option noyywrap nounput yylineno
+%option noyywrap nounput yylineno noinput
 
 %x INCLUDE
 %x BYTESTRING
diff --git a/arch/powerpc/boot/dtc-src/dtc-lexer.lex.c_shipped b/arch/powerpc/boot/dtc-src/dtc-lexer.lex.c_shipped
index d0f7424..fa309bc 100644
--- a/arch/powerpc/boot/dtc-src/dtc-lexer.lex.c_shipped
+++ b/arch/powerpc/boot/dtc-src/dtc-lexer.lex.c_shipped
@@ -1,6 +1,6 @@
-#line 2 "dtc-lexer.lex.c"
+#line 2 "arch/powerpc/boot/dtc-src/dtc-lexer.lex.c"
 
-#line 4 "dtc-lexer.lex.c"
+#line 4 "arch/powerpc/boot/dtc-src/dtc-lexer.lex.c"
 
 #define  YY_INT_ALIGNED short int
 
@@ -9,7 +9,7 @@
 #define FLEX_SCANNER
 #define YY_FLEX_MAJOR_VERSION 2
 #define YY_FLEX_MINOR_VERSION 5
-#define YY_FLEX_SUBMINOR_VERSION 33
+#define YY_FLEX_SUBMINOR_VERSION 35
 #if YY_FLEX_SUBMINOR_VERSION > 0
 #define FLEX_BETA
 #endif
@@ -31,7 +31,7 @@
 
 /* C99 systems have <inttypes.h>. Non-C99 systems may or may not. */
 
-#if __STDC_VERSION__ >= 199901L
+#if defined (__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
 
 /* C99 says to define __STDC_LIMIT_MACROS before including stdint.h,
  * if you want the limit (max/min) macros for int types. 
@@ -54,7 +54,6 @@ typedef int flex_int32_t;
 typedef unsigned char flex_uint8_t; 
 typedef unsigned short int flex_uint16_t;
 typedef unsigned int flex_uint32_t;
-#endif /* ! C99 */
 
 /* Limits of integral types. */
 #ifndef INT8_MIN
@@ -85,6 +84,8 @@ typedef unsigned int flex_uint32_t;
 #define UINT32_MAX             (4294967295U)
 #endif
 
+#endif /* ! C99 */
+
 #endif /* ! FLEXINT_H */
 
 #ifdef __cplusplus
@@ -94,11 +95,12 @@ typedef unsigned int flex_uint32_t;
 
 #else	/* ! __cplusplus */
 
-#if __STDC__
+/* C99 requires __STDC__ to be defined as 1. */
+#if defined (__STDC__)
 
 #define YY_USE_CONST
 
-#endif	/* __STDC__ */
+#endif	/* defined (__STDC__) */
 #endif	/* ! __cplusplus */
 
 #ifdef YY_USE_CONST
@@ -191,14 +193,9 @@ extern FILE *yyin, *yyout;
 
 #define unput(c) yyunput( c, (yytext_ptr)  )
 
-/* The following is because we cannot portably get our hands on size_t
- * (without autoconf's help, which isn't available because we want
- * flex-generated scanners to compile on their own).
- */
-
 #ifndef YY_TYPEDEF_YY_SIZE_T
 #define YY_TYPEDEF_YY_SIZE_T
-typedef unsigned int yy_size_t;
+typedef size_t yy_size_t;
 #endif
 
 #ifndef YY_STRUCT_YY_BUFFER_STATE
@@ -349,7 +346,7 @@ void yyfree (void *  );
 
 /* Begin user sect3 */
 
-#define yywrap() 1
+#define yywrap(n) 1
 #define YY_SKIP_YYWRAP
 
 typedef unsigned char YY_CHAR;
@@ -576,7 +573,7 @@ int yy_flex_debug = 0;
 #define YY_MORE_ADJ 0
 #define YY_RESTORE_YY_MORE_OFFSET
 char *yytext;
-#line 1 "dtc-lexer.l"
+#line 1 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 /*
  * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2005.
  *
@@ -596,11 +593,12 @@ char *yytext;
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
  *                                                                   USA
  */
+#define YY_NO_INPUT 1
 
 
 
 
-#line 33 "dtc-lexer.l"
+#line 33 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 #include "dtc.h"
 #include "srcpos.h"
 #include "dtc-parser.tab.h"
@@ -623,7 +621,7 @@ static int dts_version; /* = 0 */
 				DPRINT("<V1>\n"); \
 				BEGIN(V1); \
 			}
-#line 627 "dtc-lexer.lex.c"
+#line 625 "arch/powerpc/boot/dtc-src/dtc-lexer.lex.c"
 
 #define INITIAL 0
 #define INCLUDE 1
@@ -645,6 +643,35 @@ static int dts_version; /* = 0 */
 
 static int yy_init_globals (void );
 
+/* Accessor methods to globals.
+   These are made visible to non-reentrant scanners for convenience. */
+
+int yylex_destroy (void );
+
+int yyget_debug (void );
+
+void yyset_debug (int debug_flag  );
+
+YY_EXTRA_TYPE yyget_extra (void );
+
+void yyset_extra (YY_EXTRA_TYPE user_defined  );
+
+FILE *yyget_in (void );
+
+void yyset_in  (FILE * in_str  );
+
+FILE *yyget_out (void );
+
+void yyset_out  (FILE * out_str  );
+
+int yyget_leng (void );
+
+char *yyget_text (void );
+
+int yyget_lineno (void );
+
+void yyset_lineno (int line_number  );
+
 /* Macros after this point can all be overridden by user definitions in
  * section 1.
  */
@@ -685,7 +712,7 @@ static int input (void );
 /* This used to be an fputs(), but since the string might contain NUL's,
  * we now use fwrite().
  */
-#define ECHO (void) fwrite( yytext, yyleng, 1, yyout )
+#define ECHO fwrite( yytext, yyleng, 1, yyout )
 #endif
 
 /* Gets input and stuffs it into "buf".  number of characters read, or YY_NULL,
@@ -778,9 +805,9 @@ YY_DECL
 	register char *yy_cp, *yy_bp;
 	register int yy_act;
     
-#line 57 "dtc-lexer.l"
+#line 57 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 
-#line 784 "dtc-lexer.lex.c"
+#line 811 "arch/powerpc/boot/dtc-src/dtc-lexer.lex.c"
 
 	if ( !(yy_init) )
 		{
@@ -875,12 +902,12 @@ do_action:	/* This label is used only to access EOF actions. */
 
 case 1:
 YY_RULE_SETUP
-#line 58 "dtc-lexer.l"
+#line 58 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 BEGIN(INCLUDE);
 	YY_BREAK
 case 2:
 YY_RULE_SETUP
-#line 60 "dtc-lexer.l"
+#line 60 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 {
 			yytext[strlen(yytext) - 1] = 0;
 			if (!push_input_file(yytext + 1)) {
@@ -895,7 +922,7 @@ case YY_STATE_EOF(INCLUDE):
 case YY_STATE_EOF(BYTESTRING):
 case YY_STATE_EOF(PROPNODENAME):
 case YY_STATE_EOF(V1):
-#line 70 "dtc-lexer.l"
+#line 70 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 {
 			if (!pop_input_file()) {
 				yyterminate();
@@ -905,7 +932,7 @@ case YY_STATE_EOF(V1):
 case 3:
 /* rule 3 can match eol */
 YY_RULE_SETUP
-#line 76 "dtc-lexer.l"
+#line 76 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 {
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
@@ -918,7 +945,7 @@ YY_RULE_SETUP
 	YY_BREAK
 case 4:
 YY_RULE_SETUP
-#line 86 "dtc-lexer.l"
+#line 86 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 {
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
@@ -930,7 +957,7 @@ YY_RULE_SETUP
 	YY_BREAK
 case 5:
 YY_RULE_SETUP
-#line 95 "dtc-lexer.l"
+#line 95 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 {
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
@@ -941,7 +968,7 @@ YY_RULE_SETUP
 	YY_BREAK
 case 6:
 YY_RULE_SETUP
-#line 103 "dtc-lexer.l"
+#line 103 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 {
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
@@ -953,7 +980,7 @@ YY_RULE_SETUP
 	YY_BREAK
 case 7:
 YY_RULE_SETUP
-#line 112 "dtc-lexer.l"
+#line 112 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 {
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
@@ -971,7 +998,7 @@ YY_RULE_SETUP
 	YY_BREAK
 case 8:
 YY_RULE_SETUP
-#line 127 "dtc-lexer.l"
+#line 127 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 {
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
@@ -982,7 +1009,7 @@ YY_RULE_SETUP
 	YY_BREAK
 case 9:
 YY_RULE_SETUP
-#line 135 "dtc-lexer.l"
+#line 135 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 {
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
@@ -993,7 +1020,7 @@ YY_RULE_SETUP
 	YY_BREAK
 case 10:
 YY_RULE_SETUP
-#line 143 "dtc-lexer.l"
+#line 143 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 {	/* label reference */
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
@@ -1004,7 +1031,7 @@ YY_RULE_SETUP
 	YY_BREAK
 case 11:
 YY_RULE_SETUP
-#line 151 "dtc-lexer.l"
+#line 151 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 {	/* new-style path reference */
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
@@ -1016,7 +1043,7 @@ YY_RULE_SETUP
 	YY_BREAK
 case 12:
 YY_RULE_SETUP
-#line 160 "dtc-lexer.l"
+#line 160 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 {	/* old-style path reference */
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
@@ -1027,7 +1054,7 @@ YY_RULE_SETUP
 	YY_BREAK
 case 13:
 YY_RULE_SETUP
-#line 168 "dtc-lexer.l"
+#line 168 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 {
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
@@ -1038,7 +1065,7 @@ YY_RULE_SETUP
 	YY_BREAK
 case 14:
 YY_RULE_SETUP
-#line 176 "dtc-lexer.l"
+#line 176 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 {
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
@@ -1049,7 +1076,7 @@ YY_RULE_SETUP
 	YY_BREAK
 case 15:
 YY_RULE_SETUP
-#line 184 "dtc-lexer.l"
+#line 184 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 {
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
@@ -1062,13 +1089,13 @@ YY_RULE_SETUP
 case 16:
 /* rule 16 can match eol */
 YY_RULE_SETUP
-#line 194 "dtc-lexer.l"
+#line 194 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 /* eat whitespace */
 	YY_BREAK
 case 17:
 /* rule 17 can match eol */
 YY_RULE_SETUP
-#line 196 "dtc-lexer.l"
+#line 196 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 {
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
@@ -1079,12 +1106,12 @@ YY_RULE_SETUP
 case 18:
 /* rule 18 can match eol */
 YY_RULE_SETUP
-#line 203 "dtc-lexer.l"
+#line 203 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 /* eat line comments */
 	YY_BREAK
 case 19:
 YY_RULE_SETUP
-#line 205 "dtc-lexer.l"
+#line 205 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 {
 			yylloc.filenum = srcpos_filenum;
 			yylloc.first_line = yylineno;
@@ -1104,10 +1131,10 @@ YY_RULE_SETUP
 	YY_BREAK
 case 20:
 YY_RULE_SETUP
-#line 222 "dtc-lexer.l"
+#line 222 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 ECHO;
 	YY_BREAK
-#line 1111 "dtc-lexer.lex.c"
+#line 1138 "arch/powerpc/boot/dtc-src/dtc-lexer.lex.c"
 
 	case YY_END_OF_BUFFER:
 		{
@@ -1360,6 +1387,14 @@ static int yy_get_next_buffer (void)
 	else
 		ret_val = EOB_ACT_CONTINUE_SCAN;
 
+	if ((yy_size_t) ((yy_n_chars) + number_to_move) > YY_CURRENT_BUFFER_LVALUE->yy_buf_size) {
+		/* Extend the array by 50%, plus the number we really need. */
+		yy_size_t new_size = (yy_n_chars) + number_to_move + ((yy_n_chars) >> 1);
+		YY_CURRENT_BUFFER_LVALUE->yy_ch_buf = (char *) yyrealloc((void *) YY_CURRENT_BUFFER_LVALUE->yy_ch_buf,new_size  );
+		if ( ! YY_CURRENT_BUFFER_LVALUE->yy_ch_buf )
+			YY_FATAL_ERROR( "out of dynamic memory in yy_get_next_buffer()" );
+	}
+
 	(yy_n_chars) += number_to_move;
 	YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars)] = YY_END_OF_BUFFER_CHAR;
 	YY_CURRENT_BUFFER_LVALUE->yy_ch_buf[(yy_n_chars) + 1] = YY_END_OF_BUFFER_CHAR;
@@ -1743,7 +1778,9 @@ static void yyensure_buffer_stack (void)
 		(yy_buffer_stack) = (struct yy_buffer_state**)yyalloc
 								(num_to_alloc * sizeof(struct yy_buffer_state*)
 								);
-		
+		if ( ! (yy_buffer_stack) )
+			YY_FATAL_ERROR( "out of dynamic memory in yyensure_buffer_stack()" );
+								  
 		memset((yy_buffer_stack), 0, num_to_alloc * sizeof(struct yy_buffer_state*));
 				
 		(yy_buffer_stack_max) = num_to_alloc;
@@ -1761,6 +1798,8 @@ static void yyensure_buffer_stack (void)
 								((yy_buffer_stack),
 								num_to_alloc * sizeof(struct yy_buffer_state*)
 								);
+		if ( ! (yy_buffer_stack) )
+			YY_FATAL_ERROR( "out of dynamic memory in yyensure_buffer_stack()" );
 
 		/* zero only the new slots.*/
 		memset((yy_buffer_stack) + (yy_buffer_stack_max), 0, grow_size * sizeof(struct yy_buffer_state*));
@@ -2062,7 +2101,7 @@ void yyfree (void * ptr )
 
 #define YYTABLES_NAME "yytables"
 
-#line 222 "dtc-lexer.l"
+#line 222 "arch/powerpc/boot/dtc-src/dtc-lexer.l"
 
 
 
