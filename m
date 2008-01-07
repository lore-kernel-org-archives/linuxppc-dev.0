Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 89BA3DDEE6
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 07:27:53 +1100 (EST)
Date: Mon, 7 Jan 2008 14:27:36 -0600
From: Scott Wood <scottwood@freescale.com>
To: jdl@jdl.com
Subject: [DTC PATCH 1/2] Convert malloc() uses to xmalloc().
Message-ID: <20080107202736.GA17782@ld0162-tx32.am.freescale.net>
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
 dtc-lexer.l |    6 +-----
 srcpos.c    |   12 +++---------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/dtc-lexer.l b/dtc-lexer.l
index bfb996e..f2836a8 100644
--- a/dtc-lexer.l
+++ b/dtc-lexer.l
@@ -273,11 +273,7 @@ int push_input_file(const char *filename)
 		exit(1);
 	}
 
-	incl_file = malloc(sizeof(struct incl_file));
-	if (!incl_file) {
-		yyerror("Can not allocate include file space.");
-		return 0;
-	}
+	incl_file = xmalloc(sizeof(struct incl_file));
 
 	/*
 	 * Save current context.
diff --git a/srcpos.c b/srcpos.c
index 7a0c47e..7d0f0a7 100644
--- a/srcpos.c
+++ b/srcpos.c
@@ -33,9 +33,7 @@ static int dtc_open_one(struct dtc_file *file,
 	char *fullname;
 
 	if (search) {
-		fullname = malloc(strlen(search) + strlen(fname) + 2);
-		if (!fullname)
-			die("Out of memory\n");
+		fullname = xmalloc(strlen(search) + strlen(fname) + 2);
 
 		strcpy(fullname, search);
 		strcat(fullname, "/");
@@ -63,15 +61,11 @@ struct dtc_file *dtc_open_file(const char *fname,
 	struct dtc_file *file;
 	const char *slash;
 
-	file = malloc(sizeof(struct dtc_file));
-	if (!file)
-		die("Out of memory\n");
+	file = xmalloc(sizeof(struct dtc_file));
 
 	slash = strrchr(fname, '/');
 	if (slash) {
-		char *dir = malloc(slash - fname + 1);
-		if (!dir)
-			die("Out of memory\n");
+		char *dir = xmalloc(slash - fname + 1);
 
 		memcpy(dir, fname, slash - fname);
 		dir[slash - fname] = 0;
-- 
1.5.3
