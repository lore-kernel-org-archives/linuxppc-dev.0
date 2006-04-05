Return-Path: <sfr@canb.auug.org.au>
From: sfr@canb.auug.org.au
To: paulus@samba.org
Subject: [PATCH 15/15] powerpc: remove include hack
Date: Wed, 05 Apr 2006 15:10:49 +1000
Message-Id: <11442138832112-git-send-email-sfr@canb.auug.org.au>
In-Reply-To: <11442138494042-git-send-email-sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
Reply-To: sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Stephen Rothwell <sfr@canb.auug.org.au>

This patch removes the Makefile hack that allows including files from
include/asm-ppc when doing a 32bit ARCH=powerpc build.  Build tested
for all three 32bit defconfigs and pseries_defconfig.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

---

 arch/powerpc/Makefile |   21 +++------------------
 1 files changed, 3 insertions(+), 18 deletions(-)

50d33a5568cebd00d7148e90a6b5b6865f029602
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 6ec84d3..f757532 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -36,7 +36,7 @@ export CROSS32CC CROSS32AS CROSS32LD CRO
 KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
 
 ifeq ($(CONFIG_PPC64),y)
-OLDARCH	:= ppc64
+UTS_MACHINE	:= ppc64
 SZ	:= 64
 
 new_nm := $(shell if $(NM) --help 2>&1 | grep -- '--synthetic' > /dev/null; then echo y; else echo n; fi)
@@ -46,12 +46,10 @@ NM		:= $(NM) --synthetic
 endif
 
 else
-OLDARCH	:= ppc
+UTS_MACHINE	:= ppc
 SZ	:= 32
 endif
 
-UTS_MACHINE := $(OLDARCH)
-
 ifeq ($(HAS_BIARCH),y)
 override AS	+= -a$(SZ)
 override LD	+= -m elf$(SZ)ppc
@@ -60,8 +58,7 @@ endif
 
 LDFLAGS_vmlinux	:= -Bstatic
 
-# The -Iarch/$(ARCH)/include is temporary while we are merging
-CPPFLAGS-$(CONFIG_PPC32) := -Iarch/$(ARCH) -Iarch/$(ARCH)/include
+CPPFLAGS-$(CONFIG_PPC32) := -Iarch/$(ARCH)
 AFLAGS-$(CONFIG_PPC32)	:= -Iarch/$(ARCH)
 CFLAGS-$(CONFIG_PPC64)	:= -mminimal-toc -mtraceback=none  -mcall-aixdesc
 CFLAGS-$(CONFIG_PPC32)	:= -Iarch/$(ARCH) -ffixed-r2 -mmultiple
@@ -69,9 +66,6 @@ CPPFLAGS	+= $(CPPFLAGS-y)
 AFLAGS		+= $(AFLAGS-y)
 CFLAGS		+= -msoft-float -pipe $(CFLAGS-y)
 CPP		= $(CC) -E $(CFLAGS)
-# Temporary hack until we have migrated to asm-powerpc
-LINUXINCLUDE-$(CONFIG_PPC32)	:= -Iarch/$(ARCH)/include
-LINUXINCLUDE    += $(LINUXINCLUDE-y)
 
 CHECKFLAGS	+= -m$(SZ) -D__powerpc__ -D__powerpc$(SZ)__
 
@@ -165,18 +159,9 @@ archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
 
 archmrproper:
-	$(Q)rm -rf arch/$(ARCH)/include
 
 archprepare: checkbin
 
-ifeq ($(CONFIG_PPC32),y)
-# Temporary hack until we have migrated to asm-powerpc
-include/asm: arch/$(ARCH)/include/asm
-arch/$(ARCH)/include/asm: FORCE
-	$(Q)if [ ! -d arch/$(ARCH)/include ]; then mkdir -p arch/$(ARCH)/include; fi
-	$(Q)ln -fsn $(srctree)/include/asm-$(OLDARCH) arch/$(ARCH)/include/asm
-endif
-
 # Use the file '.tmp_gas_check' for binutils tests, as gas won't output
 # to stdout and these checks are run even on install targets.
 TOUT	:= .tmp_gas_check
-- 
1.2.4
