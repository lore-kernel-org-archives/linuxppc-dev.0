Return-Path: <sfr@canb.auug.org.au>
Date: Sun, 11 Sep 2005 00:00:14 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@osdl.org>
Message-Id: <20050911000014.7dc55b6f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Move include3 to arch/$(ARCH)/include
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is less troublesome and makes more sense.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

 arch/ppc/Makefile   |   16 +++++++++-------
 arch/ppc64/Makefile |   13 +++++++------
 2 files changed, 16 insertions(+), 13 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

ed5a6c627c4bd12f2030318abb62e2c26e11113b
diff --git a/arch/ppc/Makefile b/arch/ppc/Makefile
--- a/arch/ppc/Makefile
+++ b/arch/ppc/Makefile
@@ -21,13 +21,14 @@ CC		:= $(CC) -m32
 endif
 
 LDFLAGS_vmlinux	:= -Ttext $(KERNELLOAD) -Bstatic
-CPPFLAGS	+= -Iarch/$(ARCH) -Iinclude3
+# The -Iarch/$(ARCH)/include is temporary while we are merging
+CPPFLAGS	+= -Iarch/$(ARCH) -Iarch/$(ARCH)/include
 AFLAGS		+= -Iarch/$(ARCH)
 CFLAGS		+= -Iarch/$(ARCH) -msoft-float -pipe \
 		-ffixed-r2 -mmultiple
 CPP		= $(CC) -E $(CFLAGS)
 # Temporary hack until we have migrated to asm-powerpc
-LINUXINCLUDE    += -Iinclude3
+LINUXINCLUDE    += -Iarch/$(ARCH)/include
 
 CHECKFLAGS	+= -D__powerpc__
 
@@ -103,15 +104,16 @@ endef
 
 archclean:
 	$(Q)$(MAKE) $(clean)=arch/ppc/boot
-	$(Q)rm -rf include3
+	# Temporary hack until we have migrated to asm-powerpc
+	$(Q)rm -rf arch/$(ARCH)/include
 
 prepare: checkbin
 
 # Temporary hack until we have migrated to asm-powerpc
-include/asm: include3/asm
-include3/asm:
-	$(Q)if [ ! -d include3 ]; then mkdir -p include3; fi
-	$(Q)ln -fsn $(srctree)/include/asm-powerpc include3/asm
+include/asm: arch/$(ARCH)/include/asm
+arch/$(ARCH)/include/asm:
+	$(Q)if [ ! -d arch/$(ARCH)/include ]; then mkdir -p arch/$(ARCH)/include; fi
+	$(Q)ln -fsn $(srctree)/include/asm-powerpc arch/$(ARCH)/include/asm
 
 # Use the file '.tmp_gas_check' for binutils tests, as gas won't output
 # to stdout and these checks are run even on install targets.
diff --git a/arch/ppc64/Makefile b/arch/ppc64/Makefile
--- a/arch/ppc64/Makefile
+++ b/arch/ppc64/Makefile
@@ -56,7 +56,7 @@ LDFLAGS_vmlinux	:= -Bstatic -e $(KERNELL
 CFLAGS		+= -msoft-float -pipe -mminimal-toc -mtraceback=none \
 		   -mcall-aixdesc
 # Temporary hack until we have migrated to asm-powerpc
-CPPFLAGS	+= -Iinclude3
+CPPFLAGS	+= -Iarch/$(ARCH)/include
 
 GCC_VERSION     := $(call cc-version)
 GCC_BROKEN_VEC	:= $(shell if [ $(GCC_VERSION) -lt 0400 ] ; then echo "y"; fi ;)
@@ -115,14 +115,15 @@ all: $(KBUILD_IMAGE)
 
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
-	$(Q)rm -rf include3
+	# Temporary hack until we have migrated to asm-powerpc
+	$(Q)rm -rf arch/$(ARCH)/include
 
 
 # Temporary hack until we have migrated to asm-powerpc
-include/asm: include3/asm
-include3/asm:
-	$(Q)if [ ! -d include3 ]; then mkdir -p include3; fi;
-	$(Q)ln -fsn $(srctree)/include/asm-powerpc include3/asm
+include/asm: arch/$(ARCH)/include/asm
+arch/$(ARCH)/include/asm:
+	$(Q)if [ ! -d arch/$(ARCH)/include ]; then mkdir -p arch/$(ARCH)/include; fi
+	$(Q)ln -fsn $(srctree)/include/asm-powerpc arch/$(ARCH)/include/asm
 
 define archhelp
   echo  '  zImage.vmode        - Compressed kernel image (arch/$(ARCH)/boot/zImage.vmode)'
