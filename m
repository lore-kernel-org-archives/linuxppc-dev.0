Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQfNX618czDvxR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Nov 2016 15:00:12 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id y68so3637212pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 20:00:12 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/boot: regenerate zImage linker script when options
 change
Date: Sat, 26 Nov 2016 15:00:00 +1100
Message-Id: <20161126040000.25052-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Changing config options (e.g., endianness) does not always seem to
regenerate zImage.lds properly. Adapt the standard kernel linker script
build command and use that.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/boot/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 0442516..cf60936 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -175,9 +175,12 @@ $(addprefix $(obj)/,$(libfdt) $(libfdtheader)): $(obj)/%: $(srctree)/scripts/dtc
 $(obj)/empty.c:
 	$(Q)touch $@
 
-$(obj)/zImage.lds: $(obj)/%: $(srctree)/$(src)/%.S
-	$(CROSS32CC) $(cpp_flags) -E -Wp,-MD,$(depfile) -P -Upowerpc \
-		-D__ASSEMBLY__ -DLINKER_SCRIPT -o $@ $<
+quiet_cmd_cpp_lds_S = LDS     $@
+	cmd_cpp_lds_S = $(CROSS32CC) $(cpp_flags) -E -Wp,-MD,$(depfile) -P \
+			-Upowerpc -D__ASSEMBLY__ -DLINKER_SCRIPT -o $@ $<
+
+$(obj)/zImage.lds: $(obj)/%: $(srctree)/$(src)/%.S FORCE
+	$(call if_changed_dep,cpp_lds_S)
 
 $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds : $(obj)/%: $(srctree)/$(src)/%.S
 	$(Q)cp $< $@
-- 
2.10.2
