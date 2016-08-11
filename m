Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8yB41klCzDqwH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 16:03:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH 3/5] powerpc/boot: Use $(Q) to quiet build rules not @
Date: Thu, 11 Aug 2016 16:03:13 +1000
Message-Id: <1470895395-10007-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1470895395-10007-1-git-send-email-mpe@ellerman.id.au>
References: <1470895395-10007-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some of the rules in the boot Makefile use @ to hide the command, this
means "make V=1" doesn't show them, which is confusing.

So use the Kbuild standard $(Q) which means KBUILD_VERBOSE=1 or V=1 will
work as expected.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/boot/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 1a2a6e8dc40d..df0fd406aed1 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -150,14 +150,14 @@ $(addprefix $(obj)/,$(libfdt) $(libfdtheader)): $(obj)/%: $(srctree)/scripts/dtc
 	$(call cmd,copy_libfdt)
 
 $(obj)/empty.c:
-	@touch $@
+	$(Q)touch $@
 
 $(obj)/zImage.lds: $(obj)/%: $(srctree)/$(src)/%.S
 	$(CROSS32CC) $(cpp_flags) -E -Wp,-MD,$(depfile) -P -Upowerpc \
 		-D__ASSEMBLY__ -DLINKER_SCRIPT -o $@ $<
 
 $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds : $(obj)/%: $(srctree)/$(src)/%.S
-	@cp $< $@
+	$(Q)cp $< $@
 
 clean-files := $(zlib) $(zlibheader) $(zliblinuxheader) \
 		$(libfdt) $(libfdtheader) \
@@ -391,9 +391,9 @@ image-y := vmlinux.strip
 endif
 
 $(obj)/zImage:		$(addprefix $(obj)/, $(image-y))
-	@rm -f $@; ln $< $@
+	$(Q)rm -f $@; ln $< $@
 $(obj)/zImage.initrd:	$(addprefix $(obj)/, $(initrd-y))
-	@rm -f $@; ln $< $@
+	$(Q)rm -f $@; ln $< $@
 
 # Only install the vmlinux
 install: $(CONFIGURE) $(addprefix $(obj)/, $(image-y))
-- 
2.7.4
