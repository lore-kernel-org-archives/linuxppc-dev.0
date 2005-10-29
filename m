Return-Path: <akpm@osdl.org>
Message-Id: <200510290047.j9T0lJaf030102@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:48 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, olh@suse.de,
	linuxppc64-dev@ozlabs.org
Subject: [patch 33/43] ppc64 boot: make the zImage relocateable
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Olaf Hering <olh@suse.de>

Make the zImage relocateable.  So yaboot could just load and run any ELF
binary, without worrying about its load address.

Signed-off-by: Olaf Hering <olh@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc64/boot/Makefile   |    2 +-
 arch/ppc64/boot/crt0.S     |   29 +++++++++++++++++++++++++++++
 arch/ppc64/boot/zImage.lds |    4 +++-
 3 files changed, 33 insertions(+), 2 deletions(-)

diff -puN arch/ppc64/boot/crt0.S~ppc64-boot-make-the-zimage-relocateable arch/ppc64/boot/crt0.S
--- devel/arch/ppc64/boot/crt0.S~ppc64-boot-make-the-zimage-relocateable	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/arch/ppc64/boot/crt0.S	2005-10-28 17:45:21.000000000 -0700
@@ -14,9 +14,38 @@
 	.text
 	.globl	_start
 _start:
+	bl	reloc_offset
+
+reloc_offset:
+	mflr	r0
+	lis	r9,reloc_offset@ha
+	addi	r9,r9,reloc_offset@l
+	subf.	r0,r9,r0
+	beq	clear_caches
+
+reloc_got2:
+	lis	r9,__got2_start@ha
+	addi	r9,r9,__got2_start@l
+	lis	r8,__got2_end@ha
+	addi	r8,r8,__got2_end@l
+	subf.	r8,r9,r8
+	beq	clear_caches
+	srwi.	r8,r8,2
+	mtctr	r8
+	add	r9,r0,r9
+reloc_got2_loop:
+	lwz	r8,0(r9)
+	add	r8,r8,r0
+	stw	r8,0(r9)
+	addi	r9,r9,4
+	bdnz	reloc_got2_loop
+
+clear_caches:
 	lis	r9,_start@h
+	add	r9,r0,r9
 	lis	r8,_etext@ha
 	addi	r8,r8,_etext@l
+	add	r8,r0,r8
 1:	dcbf	r0,r9
 	icbi	r0,r9
 	addi	r9,r9,0x20
diff -puN arch/ppc64/boot/Makefile~ppc64-boot-make-the-zimage-relocateable arch/ppc64/boot/Makefile
--- devel/arch/ppc64/boot/Makefile~ppc64-boot-make-the-zimage-relocateable	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/arch/ppc64/boot/Makefile	2005-10-28 17:45:21.000000000 -0700
@@ -22,7 +22,7 @@
 
 
 HOSTCC		:= gcc
-BOOTCFLAGS	:= $(HOSTCFLAGS) -fno-builtin -nostdinc -isystem $(shell $(CROSS32CC) -print-file-name=include)
+BOOTCFLAGS	:= $(HOSTCFLAGS) -fno-builtin -nostdinc -isystem $(shell $(CROSS32CC) -print-file-name=include) -fPIC
 BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
 BOOTLFLAGS	:= -Ttext 0x00400000 -e _start -T $(srctree)/$(src)/zImage.lds
 OBJCOPYFLAGS    := contents,alloc,load,readonly,data
diff -puN arch/ppc64/boot/zImage.lds~ppc64-boot-make-the-zimage-relocateable arch/ppc64/boot/zImage.lds
--- devel/arch/ppc64/boot/zImage.lds~ppc64-boot-make-the-zimage-relocateable	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/arch/ppc64/boot/zImage.lds	2005-10-28 17:45:21.000000000 -0700
@@ -13,7 +13,9 @@ SECTIONS
     *(.rodata*)
     *(.data*)
     *(.sdata*)
-    *(.got*)
+    __got2_start = .;
+    *(.got2)
+    __got2_end = .;
   }
 
   . = ALIGN(4096);
_
