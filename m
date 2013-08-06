Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 60/63] powerpc: Add ability to build little endian kernels
Date: Wed,  7 Aug 2013 02:02:17 +1000
Message-Id: <1375804940-22050-61-git-send-email-anton@samba.org>
In-Reply-To: <1375804940-22050-1-git-send-email-anton@samba.org>
References: <1375804940-22050-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This patch allows the kbuild system to successfully compile a kernel for
the little endian PowerPC64 architecture.

To build such a kernel a supported platform must be used and
CONFIG_CPU_LITTLE_ENDIAN must be set. If cross compiling, CROSS_COMPILE
must point to a suitable toolchain (compiled for the powerpc64le-linux
and powerpcle-linux targets).

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/Makefile                   | 24 +++++++++++++++++++++---
 arch/powerpc/boot/Makefile              |  3 ++-
 arch/powerpc/kernel/vdso32/vdso32.lds.S |  4 ++++
 arch/powerpc/kernel/vdso64/vdso64.lds.S |  4 ++++
 arch/powerpc/platforms/Kconfig.cputype  | 11 +++++++++++
 5 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index c574a69..0ebad9c 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -65,11 +65,29 @@ endif
 
 UTS_MACHINE := $(OLDARCH)
 
+ifeq ($(CONFIG_CPU_LITTLE_ENDIAN),y)
+override CC	+= -mlittle-endian
+override AS	+= -mlittle-endian
+override LD	+= -EL
+override CROSS32CC += -mlittle-endian
+override CROSS32AS += -mlittle-endian
+LDEMULATION	:= lppc
+GNUTARGET	:= powerpcle
+MULTIPLEWORD	:= -mno-multiple
+else
+override CC	+= -mbig-endian
+override AS	+= -mbig-endian
+override LD	+= -EB
+LDEMULATION	:= ppc
+GNUTARGET	:= powerpc
+MULTIPLEWORD	:= -mmultiple
+endif
+
 ifeq ($(HAS_BIARCH),y)
 override AS	+= -a$(CONFIG_WORD_SIZE)
-override LD	+= -m elf$(CONFIG_WORD_SIZE)ppc
+override LD	+= -m elf$(CONFIG_WORD_SIZE)$(LDEMULATION)
 override CC	+= -m$(CONFIG_WORD_SIZE)
-override AR	:= GNUTARGET=elf$(CONFIG_WORD_SIZE)-powerpc $(AR)
+override AR	:= GNUTARGET=elf$(CONFIG_WORD_SIZE)-$(GNUTARGET) $(AR)
 endif
 
 LDFLAGS_vmlinux-y := -Bstatic
@@ -95,7 +113,7 @@ endif
 CFLAGS-$(CONFIG_PPC64)	:= -mtraceback=no -mcall-aixdesc
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mcmodel=medium,-mminimal-toc)
 CFLAGS-$(CONFIG_PPC64)	+= $(call cc-option,-mno-pointers-to-nested-functions)
-CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 -mmultiple
+CFLAGS-$(CONFIG_PPC32)	:= -ffixed-r2 $(MULTIPLEWORD)
 
 CFLAGS-$(CONFIG_GENERIC_CPU) += $(call cc-option,-mtune=power7,-mtune=power4)
 CFLAGS-$(CONFIG_CELL_CPU) += $(call cc-option,-mcpu=cell)
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 6a15c96..1e6baf0 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -22,7 +22,8 @@ all: $(obj)/zImage
 BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		 -fno-strict-aliasing -Os -msoft-float -pipe \
 		 -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
-		 -isystem $(shell $(CROSS32CC) -print-file-name=include)
+		 -isystem $(shell $(CROSS32CC) -print-file-name=include) \
+		 -mbig-endian
 BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
 
 ifdef CONFIG_DEBUG_INFO
diff --git a/arch/powerpc/kernel/vdso32/vdso32.lds.S b/arch/powerpc/kernel/vdso32/vdso32.lds.S
index f223409..e58ee10 100644
--- a/arch/powerpc/kernel/vdso32/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso32/vdso32.lds.S
@@ -4,7 +4,11 @@
  */
 #include <asm/vdso.h>
 
+#ifdef __LITTLE_ENDIAN__
+OUTPUT_FORMAT("elf32-powerpcle", "elf32-powerpcle", "elf32-powerpcle")
+#else
 OUTPUT_FORMAT("elf32-powerpc", "elf32-powerpc", "elf32-powerpc")
+#endif
 OUTPUT_ARCH(powerpc:common)
 ENTRY(_start)
 
diff --git a/arch/powerpc/kernel/vdso64/vdso64.lds.S b/arch/powerpc/kernel/vdso64/vdso64.lds.S
index e486381..64fb183 100644
--- a/arch/powerpc/kernel/vdso64/vdso64.lds.S
+++ b/arch/powerpc/kernel/vdso64/vdso64.lds.S
@@ -4,7 +4,11 @@
  */
 #include <asm/vdso.h>
 
+#ifdef __LITTLE_ENDIAN__
+OUTPUT_FORMAT("elf64-powerpcle", "elf64-powerpcle", "elf64-powerpcle")
+#else
 OUTPUT_FORMAT("elf64-powerpc", "elf64-powerpc", "elf64-powerpc")
+#endif
 OUTPUT_ARCH(powerpc:common64)
 ENTRY(_start)
 
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 47d9a03..89f91ed 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -389,3 +389,14 @@ config PPC_DOORBELL
 	default n
 
 endmenu
+
+config CPU_LITTLE_ENDIAN
+	bool "Build little endian kernel"
+	default n
+	help
+	  This option selects whether a big endian or little endian kernel will
+	  be built.
+
+	  Note that if cross compiling a little endian kernel,
+	  CROSS_COMPILE must point to a toolchain capable of targeting
+	  little endian powerpc.
-- 
1.8.1.2
