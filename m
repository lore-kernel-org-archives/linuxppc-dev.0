Return-Path: <akpm@osdl.org>
Message-Id: <200510290047.j9T0lGUx030093@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:45 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, olh@suse.de,
	linuxppc64-dev@ozlabs.org
Subject: [patch 30/43] ppc64 boot: use memset to clear bss
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Olaf Hering <olh@suse.de>

Use memset to clear bss, instead of own version.

Signed-off-by: Olaf Hering <olh@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc64/boot/crt0.S |   19 -------------------
 arch/ppc64/boot/main.c |    3 +++
 2 files changed, 3 insertions(+), 19 deletions(-)

diff -puN arch/ppc64/boot/crt0.S~ppc64-boot-use-memset-to-clear-bss arch/ppc64/boot/crt0.S
--- devel/arch/ppc64/boot/crt0.S~ppc64-boot-use-memset-to-clear-bss	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/arch/ppc64/boot/crt0.S	2005-10-28 17:45:21.000000000 -0700
@@ -25,24 +25,5 @@ _start:
 	sync
 	isync
 
-	## Clear out the BSS as per ANSI C requirements
-
-	lis	r7,_end@ha
-	addi    r7,r7,_end@l		# r7 = &_end 
-	lis	r8,__bss_start@ha	# 
-	addi    r8,r8,__bss_start@l	# r8 = &_bss_start
-
-	## Determine how large an area, in number of words, to clear
-
-	subf	r7,r8,r7		# r7 = &_end - &_bss_start + 1 
-	addi	r7,r7,3			# r7 += 3 
-	srwi.	r7,r7,2			# r7 = size in words.
-	beq	3f			# If the size is zero, don't bother
-	addi	r8,r8,-4		# r8 -= 4 
-	mtctr	r7			# SPRN_CTR = number of words to clear
-	li	r0,0			# r0 = 0
-2:	stwu	r0,4(r8)		# Clear out a word
-	bdnz	2b			# Keep clearing until done
-3:
 	b	start
 
diff -puN arch/ppc64/boot/main.c~ppc64-boot-use-memset-to-clear-bss arch/ppc64/boot/main.c
--- devel/arch/ppc64/boot/main.c~ppc64-boot-use-memset-to-clear-bss	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/arch/ppc64/boot/main.c	2005-10-28 17:45:22.000000000 -0700
@@ -26,6 +26,7 @@ extern void flush_cache(void *, unsigned
 #define	ONE_MB		0x100000
 
 extern char _start[];
+extern char __bss_start[];
 extern char _end[];
 extern char _vmlinux_start[];
 extern char _vmlinux_end[];
@@ -138,6 +139,8 @@ void start(unsigned long a1, unsigned lo
 	Elf64_Ehdr *elf64;
 	Elf64_Phdr *elf64ph;
 
+	memset(__bss_start, 0, _end - __bss_start);
+
 	prom = (int (*)(void *)) promptr;
 	chosen_handle = finddevice("/chosen");
 	if (chosen_handle == (void *) -1)
_
