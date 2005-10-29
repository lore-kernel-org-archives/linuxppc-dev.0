Return-Path: <akpm@osdl.org>
Message-Id: <200510290047.j9T0lKBd030105@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:49 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, olh@suse.de,
	linuxppc64-dev@ozlabs.org
Subject: [patch 34/43] ppc64 boot: proof that reloc works
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Olaf Hering <olh@suse.de>

To prove that the relocation works, move the crt0.o away from the beginning. 
Move linker options from command line into linker script.  rename entry point
because '_start' is referenced in printf output.

Signed-off-by: Olaf Hering <olh@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc64/boot/Makefile   |    4 ++--
 arch/ppc64/boot/crt0.S     |    4 ++--
 arch/ppc64/boot/zImage.lds |    3 +++
 3 files changed, 7 insertions(+), 4 deletions(-)

diff -puN arch/ppc64/boot/crt0.S~ppc64-boot-proof-that-reloc-works arch/ppc64/boot/crt0.S
--- devel/arch/ppc64/boot/crt0.S~ppc64-boot-proof-that-reloc-works	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/arch/ppc64/boot/crt0.S	2005-10-28 17:45:21.000000000 -0700
@@ -12,8 +12,8 @@
 #include "ppc_asm.h"
 
 	.text
-	.globl	_start
-_start:
+	.globl	_zimage_start
+_zimage_start:
 	bl	reloc_offset
 
 reloc_offset:
diff -puN arch/ppc64/boot/Makefile~ppc64-boot-proof-that-reloc-works arch/ppc64/boot/Makefile
--- devel/arch/ppc64/boot/Makefile~ppc64-boot-proof-that-reloc-works	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/arch/ppc64/boot/Makefile	2005-10-28 17:44:04.000000000 -0700
@@ -24,7 +24,7 @@
 HOSTCC		:= gcc
 BOOTCFLAGS	:= $(HOSTCFLAGS) -fno-builtin -nostdinc -isystem $(shell $(CROSS32CC) -print-file-name=include) -fPIC
 BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
-BOOTLFLAGS	:= -Ttext 0x00400000 -e _start -T $(srctree)/$(src)/zImage.lds
+BOOTLFLAGS	:= -T $(srctree)/$(src)/zImage.lds
 OBJCOPYFLAGS    := contents,alloc,load,readonly,data
 
 zlib       := infblock.c infcodes.c inffast.c inflate.c inftrees.c infutil.c
@@ -34,7 +34,7 @@ zliblinuxheader := zlib.h zconf.h zutil.
 $(addprefix $(obj)/,$(zlib) main.o): $(addprefix $(obj)/,$(zliblinuxheader)) $(addprefix $(obj)/,$(zlibheader))
 #$(addprefix $(obj)/,main.o): $(addprefix $(obj)/,zlib.h)
 
-src-boot := crt0.S string.S prom.c main.c div64.S
+src-boot := string.S prom.c main.c div64.S crt0.S
 src-boot += $(zlib)
 src-boot := $(addprefix $(obj)/, $(src-boot))
 obj-boot := $(addsuffix .o, $(basename $(src-boot)))
diff -puN arch/ppc64/boot/zImage.lds~ppc64-boot-proof-that-reloc-works arch/ppc64/boot/zImage.lds
--- devel/arch/ppc64/boot/zImage.lds~ppc64-boot-proof-that-reloc-works	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/arch/ppc64/boot/zImage.lds	2005-10-28 17:44:04.000000000 -0700
@@ -1,6 +1,9 @@
 OUTPUT_ARCH(powerpc:common)
+ENTRY(_zimage_start)
 SECTIONS
 {
+  . = (4*1024*1024);
+  _start = .;
   .text      :
   {
     *(.text)
_
