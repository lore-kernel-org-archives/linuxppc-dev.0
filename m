Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMkww2rMfzDvh9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 21:14:40 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] powerpc: Stop passing ARCH=ppc64 to boot Makefile
Date: Mon, 21 Nov 2016 21:14:33 +1100
Message-Id: <1479723275-11736-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Back in 2005 when the ppc/ppc64 merge started, we used to build the
kernel code in arch/powerpc but use the boot code from arch/ppc or
arch/ppc64 depending on whether we were building for 32 or 64-bit.

Originally we called the boot Makefile passing ARCH=$(OLDARCH), where
OLDARCH was ppc or ppc64.

In commit 20f629549b30 ("powerpc: Make building the boot image work for
both 32-bit and 64-bit") (2005-10-11) we split the call for 32/64-bit
using an ifeq check, because the two Makefiles took different targets,
and explicitly passed ARCH=ppc64 for the 64-bit case and ARCH=ppc for
the 32-bit case.

Then in commit 94b212c29f68 ("powerpc: Move ppc64 boot wrapper code over
to arch/powerpc") (2005-11-16) we moved the boot code into arch/powerpc
and dropped the ppc case, but kept passing ARCH=ppc64 to
arch/powerpc/boot/Makefile.

Since then there have been several more boot targets added, all of which
have copied the ARCH=ppc64 setting, such that now we have four targets
using it.

Currently it seems that nothing actually uses the ARCH value, but that's
basically just luck, and in particular it prevents us from using the
generic cpp_lds_S rule. It's also clearly wrong, ARCH=ppc64 is dead,
buried and cremated.

Fix it by dropping the setting of ARCH completely, the correct value is
exported by the top level Makefile.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 617dece67924..c3f700ab5cef 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -275,16 +275,16 @@ zImage: relocs_check
 endif
 
 $(BOOT_TARGETS1): vmlinux
-	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
+	$(Q)$(MAKE) $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
 $(BOOT_TARGETS2): vmlinux
-	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
+	$(Q)$(MAKE) $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
 
 
 bootwrapper_install:
-	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
+	$(Q)$(MAKE) $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
 
 %.dtb: scripts
-	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
+	$(Q)$(MAKE) $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
 
 # Used to create 'merged defconfigs'
 # To use it $(call) it with the first argument as the base defconfig
-- 
2.7.4
