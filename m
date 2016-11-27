Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tRFV76mGnzDvnQ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Nov 2016 14:22:07 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id 3so9381540pgd.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Nov 2016 19:22:07 -0800 (PST)
Date: Sun, 27 Nov 2016 14:21:55 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/boot: regenerate zImage linker script when
 options change
Message-ID: <20161127142155.4fef128b@roar.ozlabs.ibm.com>
In-Reply-To: <20161126040000.25052-1-npiggin@gmail.com>
References: <20161126040000.25052-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Changes since v1:
- Using cmd_cpp_lds_S command name was causing it to actually use the
  generic kbuild linker script command, which among other things did
  not undefine powerpc, causing the linker script to break for 32-bit.
  Use a new name.

 arch/powerpc/boot/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 0442516..06c19a7 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -175,9 +175,12 @@ $(addprefix $(obj)/,$(libfdt) $(libfdtheader)): $(obj)/%: $(srctree)/scripts/dtc
 $(obj)/empty.c:
 	$(Q)touch $@
 
-$(obj)/zImage.lds: $(obj)/%: $(srctree)/$(src)/%.S
-	$(CROSS32CC) $(cpp_flags) -E -Wp,-MD,$(depfile) -P -Upowerpc \
-		-D__ASSEMBLY__ -DLINKER_SCRIPT -o $@ $<
+quiet_cmd_zImage_lds_S = LDS     $@
+	cmd_zImage_lds_S = $(CROSS32CC) $(cpp_flags) -E -Wp,-MD,$(depfile) -P \
+			-Upowerpc -D__ASSEMBLY__ -DLINKER_SCRIPT -o $@ $<
+
+$(obj)/zImage.lds: $(obj)/%: $(srctree)/$(src)/%.S FORCE
+	$(call if_changed_dep,zImage_lds_S)
 
 $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds : $(obj)/%: $(srctree)/$(src)/%.S
 	$(Q)cp $< $@
-- 
2.10.2
