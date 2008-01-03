Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 24306DDED0
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 10:43:49 +1100 (EST)
Date: Thu, 3 Jan 2008 17:43:33 -0600
From: Scott Wood <scottwood@freescale.com>
To: jdl@jdl.com
Subject: [PATCH 3/3] Return a non-zero exit code if an error occurs during dts
	parsing.
Message-ID: <20080103234333.GC8441@ld0162-tx32.am.freescale.net>
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

Previously, only failure to parse caused the reading of the tree to fail;
semantic errors that called yyerror() but not YYERROR only emitted a message,
without signalling make to stop the build.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 dtc-parser.y |    2 ++
 dtc.c        |    2 +-
 dtc.h        |    1 +
 livetree.c   |    1 +
 treesource.c |    3 +++
 5 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/dtc-parser.y b/dtc-parser.y
index 8ed58e8..da7f6f5 100644
--- a/dtc-parser.y
+++ b/dtc-parser.y
@@ -28,6 +28,7 @@ int yylex(void);
 unsigned long long eval_literal(const char *s, int base, int bits);
 
 extern struct boot_info *the_boot_info;
+extern int treesource_error;
 
 %}
 
@@ -320,6 +321,7 @@ void yyerrorf(char const *s, ...)
 	vfprintf(stderr, s, va);
 	fprintf(stderr, "\n");
 
+	treesource_error = 1;
 	va_end(va);
 }
 
diff --git a/dtc.c b/dtc.c
index fb716f3..c1814c1 100644
--- a/dtc.c
+++ b/dtc.c
@@ -205,7 +205,7 @@ int main(int argc, char *argv[])
 	if (inf && inf->file != stdin)
 		fclose(inf->file);
 
-	if (! bi || ! bi->dt)
+	if (! bi || ! bi->dt || bi->error)
 		die("Couldn't read input tree\n");
 
 	process_checks(force, bi);
diff --git a/dtc.h b/dtc.h
index 9b89689..cba9d28 100644
--- a/dtc.h
+++ b/dtc.h
@@ -233,6 +233,7 @@ struct reserve_info *add_reserve_entry(struct reserve_info *list,
 struct boot_info {
 	struct reserve_info *reservelist;
 	struct node *dt;		/* the device tree */
+	int error;
 };
 
 struct boot_info *build_boot_info(struct reserve_info *reservelist,
diff --git a/livetree.c b/livetree.c
index 6ba0846..7610e78 100644
--- a/livetree.c
+++ b/livetree.c
@@ -172,6 +172,7 @@ struct boot_info *build_boot_info(struct reserve_info *reservelist,
 	bi = xmalloc(sizeof(*bi));
 	bi->reservelist = reservelist;
 	bi->dt = tree;
+	bi->error = 0;
 
 	return bi;
 }
diff --git a/treesource.c b/treesource.c
index e7d580f..980bda7 100644
--- a/treesource.c
+++ b/treesource.c
@@ -25,10 +25,12 @@ extern FILE *yyin;
 extern int yyparse(void);
 
 struct boot_info *the_boot_info;
+int treesource_error;
 
 struct boot_info *dt_from_source(const char *fname)
 {
 	the_boot_info = NULL;
+	treesource_error = 0;
 
 	push_input_file(fname);
 
@@ -37,6 +39,7 @@ struct boot_info *dt_from_source(const char *fname)
 
 	fill_fullpaths(the_boot_info->dt, "");
 
+	the_boot_info->error = treesource_error;
 	return the_boot_info;
 }
 
-- 
1.5.3
