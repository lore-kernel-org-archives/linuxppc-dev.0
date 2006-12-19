Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 75D3CDDDF2
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 16:43:14 +1100 (EST)
Subject: [PATCH] powerpc: Fix build of cell zImage.initrd
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Tue, 19 Dec 2006 16:42:58 +1100
Message-Id: <1166506978.19254.63.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patch adding support for zImage.ps3 didn't add a zImage.initrd.ps3
target causing builds of zImage.initrd to fail when ps3 is included in
the .config. The current method of generating ps3 images doesn't support
initrd's yet, so we create a dummy target that only displays a warning
message instead.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This should go into 2.6.20

Index: linux-cell/arch/powerpc/boot/Makefile
===================================================================
--- linux-cell.orig/arch/powerpc/boot/Makefile	2006-12-19 16:37:39.000000000 +1100
+++ linux-cell/arch/powerpc/boot/Makefile	2006-12-19 16:39:49.000000000 +1100
@@ -152,6 +152,9 @@ $(obj)/zImage.initrd.miboot: vmlinux $(w
 $(obj)/zImage.ps3: vmlinux
 	$(STRIP) -s -R .comment $< -o $@
 
+$(obj)/zImage.initrd.ps3: vmlinux
+	@echo "  WARNING zImage.initrd.ps3 not supported (yet)"
+
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call cmd,wrap,uboot)
 
