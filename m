Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 02162DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 13:22:03 +1100 (EST)
Date: Thu, 20 Dec 2007 10:48:29 -0600
From: Scott Wood <scottwood@freescale.com>
To: jdl@jdl.com
Subject: [DTC PATCH 2/2] Add support for binary includes.
Message-ID: <20071220164829.GB32193@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, u-boot-users@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A property's data can be populated with a file's contents
as follows:

node {
	prop = /bin-include/ "path/to/data";
};

Search paths are not yet implemented; non-absolute lookups are relative to
the directory from which dtc was invoked.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 dtc-lexer.l  |    6 ++++++
 dtc-parser.y |   26 ++++++++++++++++++++++++++
 dtc.h        |    1 +
 3 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/dtc-lexer.l b/dtc-lexer.l
index c811b22..1f3e6d6 100644
--- a/dtc-lexer.l
+++ b/dtc-lexer.l
@@ -190,6 +190,12 @@ static int dts_version; /* = 0 */
 			return DT_PROPNODENAME;
 		}
 
+"/bin-include/"	{
+			yylloc.filenum = srcpos_filenum;
+			yylloc.first_line = yylineno;
+			DPRINT("Binary Include\n");
+			return DT_BININCLUDE;
+		}
 
 <*>[[:space:]]+	/* eat whitespace */
 
diff --git a/dtc-parser.y b/dtc-parser.y
index 4a0181d..c7ed715 100644
--- a/dtc-parser.y
+++ b/dtc-parser.y
@@ -21,6 +21,8 @@
 %locations
 
 %{
+#include <sys/stat.h>
+
 #include "dtc.h"
 #include "srcpos.h"
 
@@ -58,6 +60,7 @@ extern struct boot_info *the_boot_info;
 %token <data> DT_STRING
 %token <labelref> DT_LABEL
 %token <labelref> DT_REF
+%token DT_BININCLUDE
 
 %type <data> propdata
 %type <data> propdataprefix
@@ -196,6 +199,29 @@ propdata:
 		{
 			$$ = data_add_marker($1, REF_PATH, $2);
 		}
+	| propdataprefix DT_BININCLUDE DT_STRING
+		{
+			struct stat st;
+			FILE *f;
+			int fd;
+			
+			f = fopen($3.val, "rb");
+			if (!f) {
+				yyerrorf("Cannot open file \"%s\": %s",
+				         $3.val, strerror(errno));
+				YYERROR;
+			}
+
+			fd = fileno(f);
+			if (fstat(fd, &st) < 0) {
+				yyerrorf("Cannot stat file \"%s\": %s",
+				         $3.val, strerror(errno));
+				YYERROR;
+			}
+
+			$$ = data_merge($1, data_copy_file(f, st.st_size));
+			fclose(f);
+		}
 	| propdata DT_LABEL
 		{
 			$$ = data_add_marker($1, LABEL, $2);
diff --git a/dtc.h b/dtc.h
index 9b89689..87b5bb1 100644
--- a/dtc.h
+++ b/dtc.h
@@ -138,6 +138,7 @@ struct data data_grow_for(struct data d, int xlen);
 struct data data_copy_mem(const char *mem, int len);
 struct data data_copy_escape_string(const char *s, int len);
 struct data data_copy_file(FILE *f, size_t len);
+struct data data_bin_include(const char *filename);
 
 struct data data_append_data(struct data d, const void *p, int len);
 struct data data_insert_at_marker(struct data d, struct marker *m,
-- 
1.5.3
