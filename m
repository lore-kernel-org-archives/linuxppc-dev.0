Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMkwy4PZMzDvh9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 21:14:42 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] powerpc/boot: Fix rebuild when changing kernel endian
Date: Mon, 21 Nov 2016 21:14:35 +1100
Message-Id: <1479723275-11736-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1479723275-11736-1-git-send-email-mpe@ellerman.id.au>
References: <1479723275-11736-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ka3.ozlabs.ibm.com>

Now that we don't set ARCH incorrectly when calling the boot Makefile,
we can use the generic cpp_lds_S rule for converting our zImage.lds.S
into zImage.lds.

The main advantage of using the generic rule is that it correctly uses
if_changed, which means we correctly regenerate the linker script when
switching endian. Fixing that means we are finally able to build one
endian and then rebuild the other endian without requiring to clean
between builds.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/boot/Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 7f3faa6255a8..1d41d5a9d05e 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -171,10 +171,6 @@ $(addprefix $(obj)/,$(libfdt) $(libfdtheader)): $(obj)/%: $(srctree)/scripts/dtc
 $(obj)/empty.c:
 	$(Q)touch $@
 
-$(obj)/zImage.lds: $(obj)/%: $(srctree)/$(src)/%.S
-	$(CROSS32CC) $(cpp_flags) -E -Wp,-MD,$(depfile) -P -Upowerpc \
-		-D__ASSEMBLY__ -DLINKER_SCRIPT -o $@ $<
-
 $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds : $(obj)/%: $(srctree)/$(src)/%.S
 	$(Q)cp $< $@
 
-- 
2.7.4
