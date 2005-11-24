Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A5FAB68826
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Nov 2005 08:38:24 +1100 (EST)
Date: Thu, 24 Nov 2005 13:38:21 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20051124213821.GA21929@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Rini <trini@kernel.crashing.org>, linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: fix treeboot image entrypoint
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Correctly specify treeboot based image entrypoint. Currently makefile 
uses $(ENTRYPOINT) which isn't defined anywhere. Each board port sets 
entrypoint-$(CONFIG_BOARD_NAME) instead.

Without this patch I cannot boot Ocotea (PPC440GX eval board) anymore. 
I was getting random "OS panic" errors from OpenBIOS for a while, but 
with current kernel I get them all the time (probably because image 
became bigger).

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
---

diff --git a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
index 82df88b..f3e9c53 100644
--- a/arch/ppc/boot/simple/Makefile
+++ b/arch/ppc/boot/simple/Makefile
@@ -262,11 +262,11 @@ $(images)/zImage.initrd-STRIPELF: $(obj)
 		skip=64 bs=1k
 
 $(images)/zImage-TREE: $(obj)/zvmlinux $(MKTREE)
-	$(MKTREE) $(obj)/zvmlinux $(images)/zImage.$(end-y) $(ENTRYPOINT)
+	$(MKTREE) $(obj)/zvmlinux $(images)/zImage.$(end-y) $(entrypoint-y)
 
 $(images)/zImage.initrd-TREE: $(obj)/zvmlinux.initrd $(MKTREE)
 	$(MKTREE) $(obj)/zvmlinux.initrd $(images)/zImage.initrd.$(end-y) \
-		$(ENTRYPOINT)
+		$(entrypoint-y)
 
 $(images)/zImage-PPLUS: $(obj)/zvmlinux $(MKPREP) $(MKBUGBOOT)
 	$(MKPREP) -pbp $(obj)/zvmlinux $(images)/zImage.$(end-y)
