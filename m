Return-Path: <sam@ravnborg.org>
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by ozlabs.org (Postfix) with ESMTP id 4D323B6EED
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 16:47:51 +1000 (EST)
Date: Tue, 3 Aug 2010 08:47:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: fix build with make 3.82
Message-ID: <20100803064748.GA19193@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Marek <mmarek@suse.cz>, linuxppc-dev@ozlabs.org,
	Thomas Backlund <tmb@mandriva.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thomas Backlund reported that the powerpc build broke with make 3.82.
It failed with the following message:

    arch/powerpc/Makefile:183: *** mixed implicit and normal rules.  Stop.

The fix is to avoid mixing non-wildcard and wildcard targets.

Reported-by: Thomas Backlund <tmb@mandriva.org>
Tested-by: Thomas Backlund <tmb@mandriva.org>
Cc: Michal Marek <mmarek@suse.cz>
Cc: stable <stable@kernel.org>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

Hi Ben / Paul.

This fixes powerc build with latest make version.
The patch is on top of 2.6.35.
But it is more of a coincidence that we see a make release
right now and this issue is also present in older kernels.
So I have added a "Cc: stable <stable@kernel.org>" because
I consider this relevant for the stable kernel releases too.

@Michal - you got a copy as information only.
I fear we may see this bug for other parts of the kernel too.

	Sam


diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 77cfe7a..5d2f17d 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -163,9 +163,11 @@ drivers-$(CONFIG_OPROFILE)	+= arch/powerpc/oprofile/
 # Default to zImage, override when needed
 all: zImage
 
-BOOT_TARGETS = zImage zImage.initrd uImage zImage% dtbImage% treeImage.% cuImage.% simpleImage.%
+# With make 3.82 we cannot mix normal and wildcard targets
+BOOT_TARGETS1 := zImage zImage.initrd uImaged
+BOOT_TARGETS2 := zImage% dtbImage% treeImage.% cuImage.% simpleImage.%
 
-PHONY += $(BOOT_TARGETS)
+PHONY += $(BOOT_TARGETS1) $(BOOT_TARGETS2)
 
 boot := arch/$(ARCH)/boot
 
@@ -180,10 +182,16 @@ relocs_check: arch/powerpc/relocs_check.pl vmlinux
 zImage: relocs_check
 endif
 
-$(BOOT_TARGETS): vmlinux
+$(BOOT_TARGETS1): vmlinux
+	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
+$(BOOT_TARGETS2): vmlinux
+	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
+
+
+bootwrapper_install:
 	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
 
-bootwrapper_install %.dtb:
+%.dtb:
 	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
 
 define archhelp
