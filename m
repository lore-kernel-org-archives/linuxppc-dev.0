Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 17716DDED0
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 10:43:48 +1100 (EST)
Date: Thu, 3 Jan 2008 17:43:29 -0600
From: Scott Wood <scottwood@freescale.com>
To: jdl@jdl.com
Subject: [PATCH 1/3] Add yyerrorf() for formatted error messages.
Message-ID: <20080103234329.GA8441@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
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

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 dtc-parser.y |   16 +++++++++++++---
 srcpos.h     |    1 +
 treesource.c |    1 -
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/dtc-parser.y b/dtc-parser.y
index 002ea7f..ddb7f27 100644
--- a/dtc-parser.y
+++ b/dtc-parser.y
@@ -307,15 +307,25 @@ label:
 
 %%
 
-void yyerror (char const *s)
+void yyerrorf(char const *s, ...)
 {
 	const char *fname = srcpos_filename_for_num(yylloc.filenum);
+	va_list va;
+	va_start(va, s);
 
 	if (strcmp(fname, "-") == 0)
 		fname = "stdin";
 
-	fprintf(stderr, "%s:%d %s\n",
-		fname, yylloc.first_line, s);
+	fprintf(stderr, "%s:%d ", fname, yylloc.first_line);
+	vfprintf(stderr, s, va);
+	fprintf(stderr, "\n");
+
+	va_end(va);
+}
+
+void yyerror (char const *s)
+{
+	yyerrorf("%s", s);
 }
 
 unsigned long long eval_literal(const char *s, int base, int bits)
diff --git a/srcpos.h b/srcpos.h
index ce7ab5b..e59c788 100644
--- a/srcpos.h
+++ b/srcpos.h
@@ -63,6 +63,7 @@ typedef struct YYLTYPE {
 
 
 extern void yyerror(char const *);
+extern void yyerrorf(char const *, ...) __attribute__((format(printf, 1, 2)));
 
 extern int srcpos_filenum;
 
diff --git a/treesource.c b/treesource.c
index a6a7767..e7d580f 100644
--- a/treesource.c
+++ b/treesource.c
@@ -23,7 +23,6 @@
 
 extern FILE *yyin;
 extern int yyparse(void);
-extern void yyerror(char const *);
 
 struct boot_info *the_boot_info;
 
-- 
1.5.3
