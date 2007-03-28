Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F2BAADDF53
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2007 17:03:54 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l2S73lUP017660
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2007 00:03:47 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l2S73ktE020376
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2007 02:03:46 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] DTC: Add support for a C-like #include "file" mechanism.
Date: Wed, 28 Mar 2007 15:05:17 +0800
Message-ID: <989B956029373F45A0B8AF029708189058F38D@zch01exm26.fsl.freescale.net>
In-Reply-To: <1174681120.32390.82.camel@ld0161-tx32>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Loeliger Jon-LOELIGER" <jdl@freescale.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jon,

I got the following error while compiling new dtc.

cc -Wall -g   -c -o lex.yy.o lex.yy.c
In file included from dtc-lexer.l:37:
srcposstack.h: In function `push_input_file':
srcposstack.h:62: warning: implicit declaration of function `yyerror'
dtc-lexer.l: In function `yylex':
dtc-lexer.l:74: structure has no member named `filenum'
dtc-lexer.l:84: structure has no member named `filenum'
dtc-lexer.l:92: structure has no member named `filenum'
dtc-lexer.l:105: structure has no member named `filenum'
dtc-lexer.l:112: structure has no member named `filenum'
dtc-lexer.l:127: structure has no member named `filenum'
dtc-lexer.l:135: structure has no member named `filenum'
dtc-lexer.l:143: structure has no member named `filenum'
dtc-lexer.l:151: structure has no member named `filenum'
dtc-lexer.l:159: structure has no member named `filenum'
dtc-lexer.l:169: structure has no member named `filenum'
dtc-lexer.l:177: structure has no member named `filenum'
dtc-lexer.l:185: structure has no member named `filenum'
dtc-lexer.l:194: structure has no member named `filenum'
dtc-lexer.l:205: structure has no member named `filenum'
dtc-lexer.l:214: structure has no member named `filenum'
lex.yy.c:734: warning: label `find_rule' defined but not used
dtc-lexer.l: At top level:
lex.yy.c:1870: warning: `yy_flex_realloc' defined but not used
make: *** [lex.yy.o] Error 1

- Leo
> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org] On =
Behalf
Of Jon
> Loeliger
> Sent: Saturday, March 24, 2007 4:19 AM
> To: linuxppc-dev@ozlabs.org
> Subject: [PATCH] DTC: Add support for a C-like #include "file"
mechanism.
>=20
>=20
> Keeps track of open files in a stack, and assigns
> a filenum to source positions for each lexical token.
> Modified error reporting to show source file as well.
> No policy on file directory basis has been decided.
> Still handles stdin.
>=20
> Tested on all arch/powerpc/boot/dts DTS files
>=20
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> ---
>  Makefile      |    3 +-
>  dtc-lexer.l   |   39 ++++++++++++++++-
>  dtc-parser.y  |    9 +++-
>  dtc.c         |   19 +-------
>  dtc.h         |    2 +-
>  srcpos.c      |  105 +++++++++++++++++++++++++++++++++++++++++++
>  srcpos.h      |   71 +++++++++++++++++++++++++++++
>  srcposstack.h |  138
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  treesource.c  |    6 ++-
>  9 files changed, 369 insertions(+), 23 deletions(-)
>  create mode 100644 srcpos.c
>  create mode 100644 srcpos.h
>  create mode 100644 srcposstack.h
>=20
> diff --git a/Makefile b/Makefile
> index cdea9a2..280db78 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3,7 +3,8 @@ CFLAGS =3D -Wall -g
>=20
>  BISON =3D bison
>=20
> -DTC_OBJS =3D dtc.o livetree.o flattree.o data.o treesource.o fstree.o =
\
> +DTC_OBJS =3D dtc.o flattree.o fstree.o data.o livetree.o \
> +		srcpos.o treesource.o \
>  		dtc-parser.tab.o lex.yy.o
>=20
>  DEPFILES =3D $(DTC_OBJS:.o=3D.d)
> diff --git a/dtc-lexer.l b/dtc-lexer.l
> index 93f3268..45f66ef 100644
> --- a/dtc-lexer.l
> +++ b/dtc-lexer.l
> @@ -20,6 +20,7 @@
>=20
>  %option noyywrap nounput yylineno
>=20
> +%x INCLUDE
>  %x CELLDATA
>  %x BYTESTRING
>  %x MEMRESERVE
> @@ -32,8 +33,9 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
>=20
>  %{
>  #include "dtc.h"
> -
>  #include "dtc-parser.tab.h"
> +#include "srcposstack.h"
> +
>=20
>  /*#define LEXDEBUG	1*/
>=20
> @@ -49,7 +51,27 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
>=20
>  %%
>=20
> +#[ \t]*include		BEGIN(INCLUDE);
> +
> +<INCLUDE>[ \t]*		/* whitespace before file name */
> +<INCLUDE>\"[^"\n]*\"	{
> +			yytext[strlen(yytext) - 1] =3D 0;
> +			if (!push_input_file(yytext + 1)) {
> +				/* Some unrecoverable error.*/
> +				exit(1);
> +			}
> +			BEGIN(INITIAL);
> +		}
> +
> +
> +<<EOF>>		{
> +			if (!pop_input_file()) {
> +				yyterminate();
> +			}
> +		}
> +
>  \"[^"]*\"	{
> +			yylloc.filenum =3D srcpos_filenum;
>  			yylloc.first_line =3D yylineno;
>  			DPRINT("String: %s\n", yytext);
>  			yylval.data =3D data_copy_escape_string(yytext+1,
> @@ -59,6 +81,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
>  		}
>=20
>  "/memreserve/"	{
> +			yylloc.filenum =3D srcpos_filenum;
>  			yylloc.first_line =3D yylineno;
>  			DPRINT("Keyword: /memreserve/\n");
>  			BEGIN(MEMRESERVE);
> @@ -66,6 +89,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
>  		}
>=20
>  <MEMRESERVE>[0-9a-fA-F]+ {
> +			yylloc.filenum =3D srcpos_filenum;
>  			yylloc.first_line =3D yylineno;
>  			if (yyleng > 2*sizeof(yylval.addr)) {
>  				fprintf(stderr, "Address value %s too
large\n",
> @@ -78,12 +102,14 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
>  		}
>=20
>  <MEMRESERVE>";"	{
> +			yylloc.filenum =3D srcpos_filenum;
>  			yylloc.first_line =3D yylineno;
>  			DPRINT("/MEMRESERVE\n");
>  			BEGIN(INITIAL);
>  			return ';';
>  		}
>  <CELLDATA>[bodh]# {
> +			yylloc.filenum =3D srcpos_filenum;
>  			yylloc.first_line =3D yylineno;
>  			if (*yytext =3D=3D 'b')
>  				yylval.cbase =3D 2;
> @@ -98,6 +124,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
>  		}
>=20
>  <CELLDATA>[0-9a-fA-F]+	{
> +			yylloc.filenum =3D srcpos_filenum;
>  			yylloc.first_line =3D yylineno;
>  			yylval.str =3D strdup(yytext);
>  			DPRINT("Cell: '%s'\n", yylval.str);
> @@ -105,6 +132,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
>  		}
>=20
>  <CELLDATA>">"	{
> +			yylloc.filenum =3D srcpos_filenum;
>  			yylloc.first_line =3D yylineno;
>  			DPRINT("/CELLDATA\n");
>  			BEGIN(INITIAL);
> @@ -112,6 +140,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
>  		}
>=20
>  <CELLDATA>\&{REFCHAR}*	{
> +			yylloc.filenum =3D srcpos_filenum;
>  			yylloc.first_line =3D yylineno;
>  			DPRINT("Ref: %s\n", yytext+1);
>  			yylval.str =3D strdup(yytext+1);
> @@ -119,6 +148,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
>  		}
>=20
>  <BYTESTRING>[0-9a-fA-F]{2} {
> +			yylloc.filenum =3D srcpos_filenum;
>  			yylloc.first_line =3D yylineno;
>  			yylval.byte =3D strtol(yytext, NULL, 16);
>  			DPRINT("Byte: %02x\n", (int)yylval.byte);
> @@ -126,6 +156,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
>  		}
>=20
>  <BYTESTRING>"]"	{
> +			yylloc.filenum =3D srcpos_filenum;
>  			yylloc.first_line =3D yylineno;
>  			DPRINT("/BYTESTRING\n");
>  			BEGIN(INITIAL);
> @@ -135,6 +166,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
>  ,		{ /* Technically this is a valid property name,
>  		     but we'd rather use it as punctuation, so detect it
>  		     here in preference */
> +			yylloc.filenum =3D srcpos_filenum;
>  			yylloc.first_line =3D yylineno;
>  			DPRINT("Char (propname like): %c (\\x%02x)\n",
yytext[0],
>  				(unsigned)yytext[0]);
> @@ -142,6 +174,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
>  		}
>=20
>  {PROPCHAR}+	{
> +			yylloc.filenum =3D srcpos_filenum;
>  			yylloc.first_line =3D yylineno;
>  			DPRINT("PropName: %s\n", yytext);
>  			yylval.str =3D strdup(yytext);
> @@ -149,6 +182,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
>  		}
>=20
>  {PROPCHAR}+(@{UNITCHAR}+)? {
> +			yylloc.filenum =3D srcpos_filenum;
>  			yylloc.first_line =3D yylineno;
>  			DPRINT("NodeName: %s\n", yytext);
>  			yylval.str =3D strdup(yytext);
> @@ -157,6 +191,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
>=20
>=20
>  [a-zA-Z_][a-zA-Z0-9_]*:	{
> +			yylloc.filenum =3D srcpos_filenum;
>  			yylloc.first_line =3D yylineno;
>  			DPRINT("Label: %s\n", yytext);
>  			yylval.str =3D strdup(yytext);
> @@ -167,6 +202,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
>  <*>{WS}+	/* eat whitespace */
>=20
>  <*>"/*"([^*]|\*+[^*/])*\*+"/"	{
> +			yylloc.filenum =3D srcpos_filenum;
>  			yylloc.first_line =3D yylineno;
>  			DPRINT("Comment: %s\n", yytext);
>  			/* eat comments */
> @@ -175,6 +211,7 @@ REFCHAR		({PROPCHAR}|{UNITCHAR}|[/@])
>  <*>"//".*\n	/* eat line comments */
>=20
>  <*>.		{
> +			yylloc.filenum =3D srcpos_filenum;
>  			yylloc.first_line =3D yylineno;
>  			switch (yytext[0]) {
>  				case '<':
> diff --git a/dtc-parser.y b/dtc-parser.y
> index a8902fc..39d9dac 100644
> --- a/dtc-parser.y
> +++ b/dtc-parser.y
> @@ -23,6 +23,7 @@
>=20
>  %{
>  #include "dtc.h"
> +#include "srcpos.h"
>=20
>  int yylex(void);
>  void yyerror(char const *);
> @@ -178,7 +179,13 @@ label:		DT_LABEL	{ $$ =3D $1; }
>=20
>  void yyerror (char const *s)
>  {
> -	fprintf (stderr, "%s at line %d\n", s, yylloc.first_line);
> +	const char *fname =3D srcpos_filename_for_num(yylloc.filenum);
> +
> +	if (strcmp(fname, "-") =3D=3D 0)
> +		fname =3D "stdin";
> +
> +	fprintf(stderr, "%s:%d %s\n",
> +		fname, yylloc.first_line, s);
>  }
>=20
>=20
> diff --git a/dtc.c b/dtc.c
> index 051a68b..a009605 100644
> --- a/dtc.c
> +++ b/dtc.c
> @@ -19,6 +19,7 @@
>   */
>=20
>  #include "dtc.h"
> +#include "srcpos.h"
>=20
>  char *join_path(char *path, char *name)
>  {
> @@ -61,21 +62,6 @@ void fill_fullpaths(struct node *tree, char
*prefix)
>  		fill_fullpaths(child, tree->fullpath);
>  }
>=20
> -static FILE *dtc_open_file(char *fname)
> -{
> -	FILE *f;
> -
> -	if (streq(fname, "-"))
> -		f =3D stdin;
> -	else
> -		f =3D fopen(fname, "r");
> -
> -	if (! f)
> -		die("Couldn't open \"%s\": %s\n", fname,
strerror(errno));
> -
> -	return f;
> -}
> -
>  static void usage(void)
>  {
>  	fprintf(stderr, "Usage:\n");
> @@ -166,8 +152,7 @@ int main(int argc, char *argv[])
>  		inform, outform, arg);
>=20
>  	if (streq(inform, "dts")) {
> -		inf =3D dtc_open_file(arg);
> -		bi =3D dt_from_source(inf);
> +		bi =3D dt_from_source(arg);
>  	} else if (streq(inform, "fs")) {
>  		bi =3D dt_from_fs(arg);
>  	} else if(streq(inform, "dtb")) {
> diff --git a/dtc.h b/dtc.h
> index e3e2863..7ed3df2 100644
> --- a/dtc.h
> +++ b/dtc.h
> @@ -223,7 +223,7 @@ struct boot_info *dt_from_blob(FILE *f);
>  /* Tree source */
>=20
>  void dt_to_source(FILE *f, struct boot_info *bi);
> -struct boot_info *dt_from_source(FILE *f);
> +struct boot_info *dt_from_source(const char *f);
>=20
>  /* FS trees */
>=20
> diff --git a/srcpos.c b/srcpos.c
> new file mode 100644
> index 0000000..44eee5d
> --- /dev/null
> +++ b/srcpos.c
> @@ -0,0 +1,105 @@
> +/*
> + * Copyright 2007 Jon Loeliger, Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of the
> + * License, or (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
02111-1307
> + *
USA
> + */
> +
> +#include "dtc.h"
> +#include "srcpos.h"
> +
> +
> +/*
> + * Record the complete unique set of opened file names.
> + * Primarily used to cache source position file names.
> + */
> +#define MAX_N_FILE_NAMES	(100)
> +
> +const char *file_names[MAX_N_FILE_NAMES];
> +static int n_file_names =3D 0;
> +
> +/*
> + * Like yylineno, this is the current open file pos.
> + */
> +
> +int srcpos_filenum =3D -1;
> +
> +
> +
> +FILE *dtc_open_file(const char *fname)
> +{
> +	FILE *f;
> +
> +	if (lookup_file_name(fname, 1) < 0)
> +		die("Too many files opened\n");
> +
> +	if (streq(fname, "-"))
> +		f =3D stdin;
> +	else
> +		f =3D fopen(fname, "r");
> +
> +	if (! f)
> +		die("Couldn't open \"%s\": %s\n", fname,
strerror(errno));
> +
> +	return f;
> +}
> +
> +
> +
> +/*
> + * Locate and optionally add filename fname in the file_names[]
array.
> + *
> + * If the filename is currently not in the array and the boolean
> + * add_it is non-zero, an attempt to add the filename will be made.
> + *
> + * Returns;
> + *    Index [0..MAX_N_FILE_NAMES) where the filename is kept
> + *    -1 if the name can not be recorded
> + */
> +
> +int lookup_file_name(const char *fname, int add_it)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < n_file_names; i++) {
> +		if (strcmp(file_names[i], fname) =3D=3D 0)
> +			return i;
> +	}
> +
> +	if (add_it) {
> +		if (n_file_names < MAX_N_FILE_NAMES) {
> +			file_names[n_file_names] =3D strdup(fname);
> +			return n_file_names++;
> +		}
> +	}
> +
> +	return -1;
> +}
> +
> +
> +const char *srcpos_filename_for_num(int filenum)
> +{
> +	if (0 <=3D filenum && filenum < n_file_names) {
> +		return file_names[filenum];
> +	}
> +
> +	return 0;
> +}
> +
> +
> +const char *srcpos_get_filename(void)
> +{
> +	return srcpos_filename_for_num(srcpos_filenum);
> +}
> diff --git a/srcpos.h b/srcpos.h
> new file mode 100644
> index 0000000..7ad0bf5
> --- /dev/null
> +++ b/srcpos.h
> @@ -0,0 +1,71 @@
> +/*
> + * Copyright 2007 Jon Loeliger, Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of the
> + * License, or (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
02111-1307
> + *
USA
> + */
> +
> +/*
> + * Augment the standard YYLTYPE with a filenum index into an
> + * array of all opened filenames.
> + */
> +
> +#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
> +typedef struct YYLTYPE {
> +    int first_line;
> +    int first_column;
> +    int last_line;
> +    int last_column;
> +    int filenum;
> +} YYLTYPE;
> +
> +#define YYLTYPE_IS_DECLARED	1
> +#define YYLTYPE_IS_TRIVIAL	1
> +#endif
> +
> +
> +#define YYLLOC_DEFAULT(Current, Rhs, N)
\
> +    do
\
> +      if (YYID (N))
\
> +	{
\
> +	  (Current).first_line   =3D YYRHSLOC (Rhs, 1).first_line;
\
> +	  (Current).first_column =3D YYRHSLOC (Rhs, 1).first_column;
\
> +	  (Current).last_line    =3D YYRHSLOC (Rhs, N).last_line;
\
> +	  (Current).last_column  =3D YYRHSLOC (Rhs, N).last_column;
\
> +	  (Current).filenum      =3D YYRHSLOC (Rhs, N).filenum;
\
> +	}
\
> +      else
\
> +	{
\
> +	  (Current).first_line   =3D (Current).last_line   =3D
\
> +	    YYRHSLOC (Rhs, 0).last_line;
\
> +	  (Current).first_column =3D (Current).last_column =3D
\
> +	    YYRHSLOC (Rhs, 0).last_column;
\
> +	  (Current).filenum      =3D YYRHSLOC (Rhs, 0).filenum;
\
> +	}
\
> +    while (YYID (0))
> +
> +
> +
> +
> +extern int srcpos_filenum;
> +
> +extern int push_input_file(const char *filename);
> +extern int pop_input_file(void);
> +
> +extern FILE *dtc_open_file(const char *fname);
> +extern int lookup_file_name(const char *fname, int add_it);
> +extern const char *srcpos_filename_for_num(int filenum);
> +const char *srcpos_get_filename(void);
> +
> diff --git a/srcposstack.h b/srcposstack.h
> new file mode 100644
> index 0000000..b4a459b
> --- /dev/null
> +++ b/srcposstack.h
> @@ -0,0 +1,138 @@
> +/*
> + * Copyright 2007 Jon Loeliger, Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of the
> + * License, or (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + *  General Public License for more details.
> + *
> + *  You should have received a copy of the GNU General Public License
> + *  along with this program; if not, write to the Free Software
> + *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
02111-1307
> + *
USA
> + */
> +
> +#include "srcpos.h"
> +
> +
> +/*
> + * This code should only be included into the lexical analysis.
> + * It references global context symbols that are only present
> + * in the generated lex.yy,c file.
> + */
> +
> +#ifdef FLEX_SCANNER
> +
> +
> +/*
> + * Stack of nested include file contexts.
> + */
> +
> +struct incl_file {
> +	int filenum;
> +	FILE *file;
> +	YY_BUFFER_STATE yy_prev_buf;
> +	int yy_prev_lineno;
> +	struct incl_file *prev;
> +};
> +
> +struct incl_file *incl_file_stack;
> +
> +
> +/*
> + * Detect infinite include recursion.
> + */
> +#define MAX_INCLUDE_DEPTH	(100)
> +
> +static int incl_depth =3D 0;
> +
> +
> +
> +int push_input_file(const char *filename)
> +{
> +	FILE *f;
> +	struct incl_file *incl_file;
> +
> +	if (!filename) {
> +		yyerror("No include file name given.");
> +		return 0;
> +	}
> +
> +	if (incl_depth++ >=3D MAX_INCLUDE_DEPTH) {
> +		yyerror("Includes nested too deeply");
> +		return 0;
> +	}
> +
> +	f =3D dtc_open_file(filename);
> +
> +	incl_file =3D malloc(sizeof(struct incl_file));
> +	if (!incl_file) {
> +		yyerror("Can not allocate include file space.");
> +		return 0;
> +	}
> +
> +	/*
> +	 * Save current context.
> +	 */
> +	incl_file->yy_prev_buf =3D YY_CURRENT_BUFFER;
> +	incl_file->yy_prev_lineno =3D yylineno;
> +	incl_file->filenum =3D srcpos_filenum;
> +	incl_file->file =3D yyin;
> +	incl_file->prev =3D incl_file_stack;
> +
> +	incl_file_stack =3D incl_file;
> +
> +	/*
> +	 * Establish new context.
> +	 */
> +	srcpos_filenum =3D lookup_file_name(filename, 0);
> +	yylineno =3D 1;
> +	yyin =3D f;
> +	yy_switch_to_buffer(yy_create_buffer(yyin, YY_BUF_SIZE));
> +
> +	return 1;
> +}
> +
> +
> +int pop_input_file(void)
> +{
> +	struct incl_file *incl_file;
> +
> +	if (incl_file_stack =3D=3D 0)
> +		return 0;
> +
> +	fclose(yyin);
> +
> +	/*
> +	 * Pop.
> +	 */
> +	--incl_depth;
> +	incl_file =3D incl_file_stack;
> +	incl_file_stack =3D incl_file->prev;
> +
> +	/*
> +	 * Recover old context.
> +	 */
> +	yy_delete_buffer(YY_CURRENT_BUFFER);
> +	yy_switch_to_buffer(incl_file->yy_prev_buf);
> +	yylineno =3D incl_file->yy_prev_lineno;
> +	srcpos_filenum =3D incl_file->filenum;
> +	yyin =3D incl_file->file;
> +
> +	/*
> +	 * Free old state.
> +	 */
> +	free(incl_file);
> +
> +	if (YY_CURRENT_BUFFER =3D=3D 0)
> +		return 0;
> +
> +	return 1;
> +}
> +
> +#endif	/* FLEX_SCANNER */
> diff --git a/treesource.c b/treesource.c
> index e9bbaa5..c067b20 100644
> --- a/treesource.c
> +++ b/treesource.c
> @@ -19,6 +19,7 @@
>   */
>=20
>  #include "dtc.h"
> +#include "srcpos.h"
>=20
>  extern FILE *yyin;
>  extern int yyparse(void);
> @@ -26,11 +27,12 @@ extern void yyerror(char const *);
>=20
>  struct boot_info *the_boot_info;
>=20
> -struct boot_info *dt_from_source(FILE *f)
> +struct boot_info *dt_from_source(const char *fname)
>  {
>  	the_boot_info =3D NULL;
>=20
> -	yyin =3D f;
> +	push_input_file(fname);
> +
>  	if (yyparse() !=3D 0)
>  		return NULL;
>=20
> --
> 1.5.0.3
>=20
>=20
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
