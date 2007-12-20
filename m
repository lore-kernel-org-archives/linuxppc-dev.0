Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F0AEADDE37
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 03:50:16 +1100 (EST)
Date: Thu, 20 Dec 2007 10:48:23 -0600
From: Scott Wood <scottwood@freescale.com>
To: jdl@jdl.com
Subject: [DTC PATCH 1/2] Add yyerrorf() for formatted error messages.
Message-ID: <20071220164823.GA32193@ld0162-tx32.am.freescale.net>
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

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 dtc-parser.y |   16 ++++++++++++++++
 srcpos.h     |    1 +
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/dtc-parser.y b/dtc-parser.y
index 002ea7f..4a0181d 100644
--- a/dtc-parser.y
+++ b/dtc-parser.y
@@ -318,6 +318,22 @@ void yyerror (char const *s)
 		fname, yylloc.first_line, s);
 }
 
+void yyerrorf(char const *s, ...)
+{
+	const char *fname = srcpos_filename_for_num(yylloc.filenum);
+	va_list va;
+	va_start(va, s);
+
+	if (strcmp(fname, "-") == 0)
+		fname = "stdin";
+
+	fprintf(stderr, "%s:%d ", fname, yylloc.first_line);
+	vfprintf(stderr, s, va);
+	fprintf(stderr, "\n");
+	
+	va_end(va);
+}
+
 unsigned long long eval_literal(const char *s, int base, int bits)
 {
 	unsigned long long val;
diff --git a/srcpos.h b/srcpos.h
index ce7ab5b..e59c788 100644
--- a/srcpos.h
+++ b/srcpos.h
@@ -63,6 +63,7 @@ typedef struct YYLTYPE {
 
 
 extern void yyerror(char const *);
+extern void yyerrorf(char const *, ...) __attribute__((format(printf, 1, 2)));
 
 extern int srcpos_filenum;
 
-- 
1.5.3
