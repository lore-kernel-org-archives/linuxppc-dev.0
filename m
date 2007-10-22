Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EC17BDDE1C
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 07:13:59 +1000 (EST)
Received: from jdl (helo=jdl.com) by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>) id 1Ik4aw-0007ud-Lu
	for linuxppc-dev@ozlabs.org; Mon, 22 Oct 2007 16:13:55 -0500
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] DTC:  Remove the need for the GLR Parser.
Date: Mon, 22 Oct 2007 16:13:54 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1Ik4aw-0007ud-Lu@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Previously, there were a few shift/reduce and reduce/reduce
errors in the grammar that were being handled by the not-so-popular
GLR Parser technique.

Flip a right-recursive stack-abusing rule into a left-recursive
stack-friendly rule and clear up three messes in one shot: No more
conflicts, no need for the GLR parser, and friendlier stackness.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 Makefile     |    1 -
 dtc-parser.y |    5 ++---
 2 files changed, 2 insertions(+), 4 deletions(-)

Both "make check" and the "compare all old and new DTB kernel files"
tests are happy with this change.


diff --git a/Makefile b/Makefile
index d7d1af5..84f0efe 100644
--- a/Makefile
+++ b/Makefile
@@ -207,7 +207,6 @@ clean: libfdt_clean tests_clean
 
 %.tab.c %.tab.h %.output: %.y
 	@$(VECHO) BISON $@
-	@$(VECHO) ---- Expect 2 s/r and 2 r/r. ----
 	$(BISON) -d $<
 
 FORCE:
diff --git a/dtc-parser.y b/dtc-parser.y
index 4698793..0d140e5 100644
--- a/dtc-parser.y
+++ b/dtc-parser.y
@@ -18,7 +18,6 @@
  *                                                                   USA
  */
 
-%glr-parser
 %locations
 
 %{
@@ -123,9 +122,9 @@ nodedef:
 	;
 
 proplist:
-	  propdef proplist
+	  proplist propdef
 		{
-			$$ = chain_property($1, $2);
+			$$ = chain_property($2, $1);
 		}
 	| /* empty */
 		{
-- 
1.5.3.1.139.g9346b
