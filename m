Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E0F2ADE1DF
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 05:29:27 +1000 (EST)
Message-Id: <200807301929.m6UJT3nb011915@imap1.linux-foundation.org>
Subject: [patch 1/2] ppc: use the common ascii hex helpers
To: benh@kernel.crashing.org
From: akpm@linux-foundation.org
Date: Wed, 30 Jul 2008 12:29:03 -0700
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	harvey.harrison@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Harvey Harrison <harvey.harrison@gmail.com>

[akpm@linux-foundation.org: exclude prom_init.c]
Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/kernel/btext.c |   34 ++++++++++++++++------------------
 powerpc/kernel/prom_init.c  |    0 
 2 files changed, 16 insertions(+), 18 deletions(-)

diff -puN arch/powerpc/kernel/btext.c~ppc-use-the-common-ascii-hex-helpers arch/powerpc/kernel/btext.c
--- a/arch/powerpc/kernel/btext.c~ppc-use-the-common-ascii-hex-helpers
+++ a/arch/powerpc/kernel/btext.c
@@ -442,28 +442,26 @@ void btext_drawtext(const char *c, unsig
 
 void btext_drawhex(unsigned long v)
 {
-	char *hex_table = "0123456789abcdef";
-
 	if (!boot_text_mapped)
 		return;
 #ifdef CONFIG_PPC64
-	btext_drawchar(hex_table[(v >> 60) & 0x0000000FUL]);
-	btext_drawchar(hex_table[(v >> 56) & 0x0000000FUL]);
-	btext_drawchar(hex_table[(v >> 52) & 0x0000000FUL]);
-	btext_drawchar(hex_table[(v >> 48) & 0x0000000FUL]);
-	btext_drawchar(hex_table[(v >> 44) & 0x0000000FUL]);
-	btext_drawchar(hex_table[(v >> 40) & 0x0000000FUL]);
-	btext_drawchar(hex_table[(v >> 36) & 0x0000000FUL]);
-	btext_drawchar(hex_table[(v >> 32) & 0x0000000FUL]);
+	btext_drawchar(hex_asc_hi(v >> 56));
+	btext_drawchar(hex_asc_lo(v >> 56));
+	btext_drawchar(hex_asc_hi(v >> 48));
+	btext_drawchar(hex_asc_lo(v >> 48));
+	btext_drawchar(hex_asc_hi(v >> 40));
+	btext_drawchar(hex_asc_lo(v >> 40));
+	btext_drawchar(hex_asc_hi(v >> 32));
+	btext_drawchar(hex_asc_lo(v >> 32));
 #endif
-	btext_drawchar(hex_table[(v >> 28) & 0x0000000FUL]);
-	btext_drawchar(hex_table[(v >> 24) & 0x0000000FUL]);
-	btext_drawchar(hex_table[(v >> 20) & 0x0000000FUL]);
-	btext_drawchar(hex_table[(v >> 16) & 0x0000000FUL]);
-	btext_drawchar(hex_table[(v >> 12) & 0x0000000FUL]);
-	btext_drawchar(hex_table[(v >>  8) & 0x0000000FUL]);
-	btext_drawchar(hex_table[(v >>  4) & 0x0000000FUL]);
-	btext_drawchar(hex_table[(v >>  0) & 0x0000000FUL]);
+	btext_drawchar(hex_asc_hi(v >> 24));
+	btext_drawchar(hex_asc_lo(v >> 24));
+	btext_drawchar(hex_asc_hi(v >> 16));
+	btext_drawchar(hex_asc_lo(v >> 16));
+	btext_drawchar(hex_asc_hi(v >> 8));
+	btext_drawchar(hex_asc_lo(v >> 8));
+	btext_drawchar(hex_asc_hi(v));
+	btext_drawchar(hex_asc_lo(v));
 	btext_drawchar(' ');
 }
 
diff -puN arch/powerpc/kernel/prom_init.c~ppc-use-the-common-ascii-hex-helpers arch/powerpc/kernel/prom_init.c
_
