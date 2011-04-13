Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <34e3e03a96888bc8c20013aa65712123ccf94649.1302676893.git.michael@ellerman.id.au>
Subject: [PATCH 1/2] powerpc: Allow building the zImage wrapper as a
	relocatable ET_DYN
Date: Wed, 13 Apr 2011 16:38:55 +1000 (EST)
From: michael@ozlabs.org (Michael Ellerman)
Cc: Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds code, linker script and makefile support to allow
building the zImage wrapper around the kernel as a position independent
executable.  This results in an ET_DYN instead of an ET_EXEC ELF output
file, which can be loaded at any location by the firmware and will
process its own relocations to work correctly at the loaded address.

This is of interest particularly since the standard ePAPR image format
must be an ET_DYN (although this patch alone is not sufficient to
produce a fully ePAPR compliant boot image).

Note for now we don't enable building with -pie for anything.

Signed-off-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/boot/crt0.S            |  116 ++++++++++++++++++++++-------------
 arch/powerpc/boot/wrapper           |    9 ++-
 arch/powerpc/boot/zImage.coff.lds.S |    6 +-
 arch/powerpc/boot/zImage.lds.S      |   57 +++++++++++------
 4 files changed, 118 insertions(+), 70 deletions(-)

diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
index f1c4dfc..0f7428a 100644
--- a/arch/powerpc/boot/crt0.S
+++ b/arch/powerpc/boot/crt0.S
@@ -6,16 +6,28 @@
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
  *
- * NOTE: this code runs in 32 bit mode and is packaged as ELF32.
+ * NOTE: this code runs in 32 bit mode, is position-independent,
+ * and is packaged as ELF32.
  */
 
 #include "ppc_asm.h"
 
 	.text
-	/* a procedure descriptor used when booting this as a COFF file */
+	/* A procedure descriptor used when booting this as a COFF file.
+	 * When making COFF, this comes first in the link and we're
+	 * linked at 0x500000.
+	 */
 	.globl	_zimage_start_opd
 _zimage_start_opd:
-	.long	_zimage_start, 0, 0, 0
+	.long	0x500000, 0, 0, 0
+
+p_start:	.long	_start
+p_etext:	.long	_etext
+p_bss_start:	.long	__bss_start
+p_end:		.long	_end
+
+	.weak	_platform_stack_top
+p_pstack:	.long	_platform_stack_top
 
 	.weak	_zimage_start
 	.globl	_zimage_start
@@ -24,37 +36,65 @@ _zimage_start:
 _zimage_start_lib:
 	/* Work out the offset between the address we were linked at
 	   and the address where we're running. */
-	bl	1f
-1:	mflr	r0
-	lis	r9,1b@ha
-	addi	r9,r9,1b@l
-	subf.	r0,r9,r0
-	beq	3f		/* if running at same address as linked */
+	bl	.+4
+p_base:	mflr	r10		/* r10 now points to runtime addr of p_base */
+	/* grab the link address of the dynamic section in r11 */
+	addis	r11,r10,(_GLOBAL_OFFSET_TABLE_-p_base)@ha
+	lwz	r11,(_GLOBAL_OFFSET_TABLE_-p_base)@l(r11)
+	cmpwi	r11,0
+	beq	3f		/* if not linked -pie */
+	/* get the runtime address of the dynamic section in r12 */
+	.weak	__dynamic_start
+	addis	r12,r10,(__dynamic_start-p_base)@ha
+	addi	r12,r12,(__dynamic_start-p_base)@l
+	subf	r11,r11,r12	/* runtime - linktime offset */
+
+	/* The dynamic section contains a series of tagged entries.
+	 * We need the RELA and RELACOUNT entries. */
+RELA = 7
+RELACOUNT = 0x6ffffff9
+	li	r9,0
+	li	r0,0
+9:	lwz	r8,0(r12)	/* get tag */
+	cmpwi	r8,0
+	beq	10f		/* end of list */
+	cmpwi	r8,RELA
+	bne	11f
+	lwz	r9,4(r12)	/* get RELA pointer in r9 */
+	b	12f
+11:	addis	r8,r8,(-RELACOUNT)@ha
+	cmpwi	r8,RELACOUNT@l
+	bne	12f
+	lwz	r0,4(r12)	/* get RELACOUNT value in r0 */
+12:	addi	r12,r12,8
+	b	9b
 
-	/* The .got2 section contains a list of addresses, so add
-	   the address offset onto each entry. */
-	lis	r9,__got2_start@ha
-	addi	r9,r9,__got2_start@l
-	lis	r8,__got2_end@ha
-	addi	r8,r8,__got2_end@l
-	subf.	r8,r9,r8
+	/* The relocation section contains a list of relocations.
+	 * We now do the R_PPC_RELATIVE ones, which point to words
+	 * which need to be initialized with addend + offset.
+	 * The R_PPC_RELATIVE ones come first and there are RELACOUNT
+	 * of them. */
+10:	/* skip relocation if we don't have both */
+	cmpwi	r0,0
 	beq	3f
-	srwi.	r8,r8,2
-	mtctr	r8
-	add	r9,r0,r9
-2:	lwz	r8,0(r9)
-	add	r8,r8,r0
-	stw	r8,0(r9)
-	addi	r9,r9,4
+	cmpwi	r9,0
+	beq	3f
+
+	add	r9,r9,r11	/* Relocate RELA pointer */
+	mtctr	r0
+2:	lbz	r0,4+3(r9)	/* ELF32_R_INFO(reloc->r_info) */
+	cmpwi	r0,22		/* R_PPC_RELATIVE */
+	bne	3f
+	lwz	r12,0(r9)	/* reloc->r_offset */
+	lwz	r0,8(r9)	/* reloc->r_addend */
+	add	r0,r0,r11
+	stwx	r0,r11,r12
+	addi	r9,r9,12
 	bdnz	2b
 
 	/* Do a cache flush for our text, in case the loader didn't */
-3:	lis	r9,_start@ha
-	addi	r9,r9,_start@l
-	add	r9,r0,r9
-	lis	r8,_etext@ha
-	addi	r8,r8,_etext@l
-	add	r8,r0,r8
+3:	lwz	r9,p_start-p_base(r10)	/* note: these are relocated now */
+	lwz	r8,p_etext-p_base(r10)
 4:	dcbf	r0,r9
 	icbi	r0,r9
 	addi	r9,r9,0x20
@@ -64,27 +104,19 @@ _zimage_start_lib:
 	isync
 
 	/* Clear the BSS */
-	lis	r9,__bss_start@ha
-	addi	r9,r9,__bss_start@l
-	add	r9,r0,r9
-	lis	r8,_end@ha
-	addi	r8,r8,_end@l
-	add	r8,r0,r8
-	li	r10,0
-5:	stw	r10,0(r9)
+	lwz	r9,p_bss_start-p_base(r10)
+	lwz	r8,p_end-p_base(r10)
+	li	r0,0
+5:	stw	r0,0(r9)
 	addi	r9,r9,4
 	cmplw	cr0,r9,r8
 	blt	5b
 
 	/* Possibly set up a custom stack */
-.weak	_platform_stack_top
-	lis	r8,_platform_stack_top@ha
-	addi	r8,r8,_platform_stack_top@l
+	lwz	r8,p_pstack-p_base(r10)
 	cmpwi	r8,0
 	beq	6f
-	add	r8,r0,r8
 	lwz	r1,0(r8)
-	add	r1,r0,r1
 	li	r0,0
 	stwu	r0,-16(r1)	/* establish a stack frame */
 6:
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index cb97e75..fef5278 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -39,6 +39,7 @@ dts=
 cacheit=
 binary=
 gzip=.gz
+pie=
 
 # cross-compilation prefix
 CROSS=
@@ -157,9 +158,10 @@ pmac|chrp)
     platformo=$object/of.o
     ;;
 coff)
-    platformo=$object/of.o
+    platformo="$object/crt0.o $object/of.o"
     lds=$object/zImage.coff.lds
     link_address='0x500000'
+    pie=
     ;;
 miboot|uboot)
     # miboot and U-boot want just the bare bits, not an ELF binary
@@ -208,6 +210,7 @@ ps3)
     ksection=.kernel:vmlinux.bin
     isection=.kernel:initrd
     link_address=''
+    pie=
     ;;
 ep88xc|ep405|ep8248e)
     platformo="$object/fixed-head.o $object/$platform.o"
@@ -310,9 +313,9 @@ fi
 
 if [ "$platform" != "miboot" ]; then
     if [ -n "$link_address" ] ; then
-        text_start="-Ttext $link_address --defsym _start=$link_address"
+        text_start="-Ttext $link_address"
     fi
-    ${CROSS}ld -m elf32ppc -T $lds $text_start -o "$ofile" \
+    ${CROSS}ld -m elf32ppc -T $lds $text_start $pie -o "$ofile" \
 	$platformo $tmp $object/wrapper.a
     rm $tmp
 fi
diff --git a/arch/powerpc/boot/zImage.coff.lds.S b/arch/powerpc/boot/zImage.coff.lds.S
index 856dc78..de4c9e3 100644
--- a/arch/powerpc/boot/zImage.coff.lds.S
+++ b/arch/powerpc/boot/zImage.coff.lds.S
@@ -3,13 +3,13 @@ ENTRY(_zimage_start_opd)
 EXTERN(_zimage_start_opd)
 SECTIONS
 {
-  _start = .;
   .text      :
   {
+    _start = .;
     *(.text)
     *(.fixup)
+    _etext = .;
   }
-  _etext = .;
   . = ALIGN(4096);
   .data    :
   {
@@ -17,9 +17,7 @@ SECTIONS
     *(.data*)
     *(__builtin_*)
     *(.sdata*)
-    __got2_start = .;
     *(.got2)
-    __got2_end = .;
 
     _dtb_start = .;
     *(.kernel:dtb)
diff --git a/arch/powerpc/boot/zImage.lds.S b/arch/powerpc/boot/zImage.lds.S
index 0962d62..2bd8731 100644
--- a/arch/powerpc/boot/zImage.lds.S
+++ b/arch/powerpc/boot/zImage.lds.S
@@ -3,49 +3,64 @@ ENTRY(_zimage_start)
 EXTERN(_zimage_start)
 SECTIONS
 {
-  _start = .;
   .text      :
   {
+    _start = .;
     *(.text)
     *(.fixup)
+    _etext = .;
   }
-  _etext = .;
   . = ALIGN(4096);
   .data    :
   {
     *(.rodata*)
     *(.data*)
     *(.sdata*)
-    __got2_start = .;
     *(.got2)
-    __got2_end = .;
   }
+  .dynsym : { *(.dynsym) }
+  .dynstr : { *(.dynstr) }
+  .dynamic :
+  {
+    __dynamic_start = .;
+    *(.dynamic)
+  }
+  .hash : { *(.hash) }
+  .interp : { *(.interp) }
+  .rela.dyn : { *(.rela*) }
 
   . = ALIGN(8);
-  _dtb_start = .;
-  .kernel:dtb : { *(.kernel:dtb) }
-  _dtb_end = .;
-
-  . = ALIGN(4096);
-  _vmlinux_start =  .;
-  .kernel:vmlinux.strip : { *(.kernel:vmlinux.strip) }
-  _vmlinux_end =  .;
+  .kernel:dtb :
+  {
+    _dtb_start = .;
+    *(.kernel:dtb)
+    _dtb_end = .;
+  }
 
   . = ALIGN(4096);
-  _initrd_start =  .;
-  .kernel:initrd : { *(.kernel:initrd) }
-  _initrd_end =  .;
+  .kernel:vmlinux.strip :
+  {
+    _vmlinux_start =  .;
+    *(.kernel:vmlinux.strip)
+    _vmlinux_end =  .;
+  }
 
   . = ALIGN(4096);
-  _edata  =  .;
+  .kernel:initrd :
+  {
+    _initrd_start =  .;
+    *(.kernel:initrd)
+    _initrd_end =  .;
+  }
 
   . = ALIGN(4096);
-  __bss_start = .;
   .bss       :
   {
-   *(.sbss)
-   *(.bss)
+    _edata  =  .;
+    __bss_start = .;
+    *(.sbss)
+    *(.bss)
+    *(COMMON)
+    _end = . ;
   }
-  . = ALIGN(4096);
-  _end = . ;
 }
-- 
1.7.1
