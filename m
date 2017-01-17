Return-Path: <ard.biesheuvel@linaro.org>
Received: from mail-wm0-x232.google.com (mail-wm0-x232.google.com
 [IPv6:2a00:1450:400c:c09::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v30TP0tyPzDqQt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 06:26:33 +1100 (AEDT)
Received: by mail-wm0-x232.google.com with SMTP id c85so214376433wmi.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 11:26:32 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-kernel@vger.kernel.org,
	mpe@ellerman.id.au,
	jeyu@redhat.com
Cc: rusty@rustcorp.com.au, suzuki.poulose@arm.com, will.deacon@arm.com,
 akpm@linux-foundation.org, benh@kernel.crashing.org, paulus@samba.org,
 arnd@arndb.de, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
 linuxppc-dev@lists.ozlabs.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v4 2/3] powerpc/reloc64: add support for 32-bit CRC
 pseudo-symbols
Date: Tue, 17 Jan 2017 19:26:12 +0000
Message-Id: <1484681173-11644-3-git-send-email-ard.biesheuvel@linaro.org>
In-Reply-To: <1484681173-11644-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1484681173-11644-1-git-send-email-ard.biesheuvel@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In preparation of modifying the core modversions code to emit the CRCs
as 32-bit quantities, ensure that 64-bit PowerPC will be able to deal
with this when CONFIG_RELOCATABLE=y, in which case the CRCs will be
emitted into the final ELF binary as R_PPC64_ADDR32 relocations.

Since 32-bit relocations cannot be used to relocate memory addresses on
64-bit architectures, and since the CRC pseudo-symbol references are
emitted as anonymous relocations (i.e., against the NULL symbol in the
.dynsym section) with the final value recorded in the addend (*), we
can disregard any relocations where the symbol index != 0.

* Note that unsatisfied CRC pseudo-symbol references are emitted as
  R_PPC64_ADDR32 relocations against named symbols that are typed as
  weak undefined in the .dynsym symbol table. These can simply be
  ignored (as before), considering that zero CRCs are interpreted as
  missing, and the module code deals with that accordingly.

As it turns out, binutils for powerpc does not account for any relocations
beyond R_PPC64_RELATIVE ones in the RELACOUNT field of the .dynamic section,
which is unfortunate, since we need to do extra work to figure out the size
of the relocation array. So with a little help from the linker scripts,
grab an end pointer rather than a count, and iterate over the entire section.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/powerpc/kernel/reloc_64.S    | 60 ++++++++++++--------
 arch/powerpc/kernel/vmlinux.lds.S |  1 +
 arch/powerpc/relocs_check.sh      |  5 +-
 3 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/reloc_64.S b/arch/powerpc/kernel/reloc_64.S
index d88736fbece6..e50f5d778ea2 100644
--- a/arch/powerpc/kernel/reloc_64.S
+++ b/arch/powerpc/kernel/reloc_64.S
@@ -12,8 +12,8 @@
 #include <asm/ppc_asm.h>
 
 RELA = 7
-RELACOUNT = 0x6ffffff9
 R_PPC64_RELATIVE = 22
+R_PPC64_ADDR32 = 1
 
 /*
  * r3 = desired final address of kernel
@@ -29,29 +29,27 @@ _GLOBAL(relocate)
 	add	r9,r9,r12	/* r9 has runtime addr of .rela.dyn section */
 	ld	r10,(p_st - 0b)(r12)
 	add	r10,r10,r12	/* r10 has runtime addr of _stext */
+	ld	r8,(p_rela_end - 0b)(r12)
+	add	r8,r8,r12	/* r8 has addr of end of .rela.dyn section */
 
 	/*
-	 * Scan the dynamic section for the RELA and RELACOUNT entries.
+	 * Scan the dynamic section for the RELA entry.
+	 * NOTE: the RELACOUNT entry only covers R_PPC64_RELATIVE relocations,
+	 *       so we cannot use it here.
 	 */
 	li	r7,0
-	li	r8,0
 1:	ld	r6,0(r11)	/* get tag */
 	cmpdi	r6,0
-	beq	4f		/* end of list */
+	beq	3f		/* end of list */
 	cmpdi	r6,RELA
-	bne	2f
-	ld	r7,8(r11)	/* get RELA pointer in r7 */
-	b	3f
-2:	addis	r6,r6,(-RELACOUNT)@ha
-	cmpdi	r6,RELACOUNT@l
-	bne	3f
-	ld	r8,8(r11)	/* get RELACOUNT value in r8 */
-3:	addi	r11,r11,16
+	beq	2f
+	addi	r11,r11,16
 	b	1b
-4:	cmpdi	r7,0		/* check we have both RELA and RELACOUNT */
-	cmpdi	cr1,r8,0
-	beq	6f
-	beq	cr1,6f
+2:	ld	r7,8(r11)	/* get RELA pointer in r7 */
+3:	cmpdi	r7,0		/* check we have both RELA and a non-empty */
+	cmpd	cr1,r8,r9	/* .rela.dyn section			   */
+	beq	7f
+	beq	cr1,7f
 
 	/*
 	 * Work out linktime address of _stext and hence the
@@ -63,26 +61,40 @@ _GLOBAL(relocate)
 	subf	r7,r7,r9	/* cur_offset */
 	subf	r10,r7,r10
 	subf	r3,r10,r3	/* final_offset */
+	b	4f
 
 	/*
 	 * Run through the list of relocations and process the
-	 * R_PPC64_RELATIVE ones.
+	 * R_PPC64_RELATIVE and R_PPC64_ADDR32 ones.
 	 */
-	mtctr	r8
-5:	ld	r0,8(9)		/* ELF64_R_TYPE(reloc->r_info) */
+3:	addi	r9,r9,24
+4:	cmpd	r9,r8
+	beq	7f
+5:	ld	r0,8(9)		/* reloc->r_info (type *and* symbol index) */
+	ld	r6,0(r9)	/* reloc->r_offset */
 	cmpdi	r0,R_PPC64_RELATIVE
 	bne	6f
-	ld	r6,0(r9)	/* reloc->r_offset */
 	ld	r0,16(r9)	/* reloc->r_addend */
 	add	r0,r0,r3
 	stdx	r0,r7,r6
-	addi	r9,r9,24
-	bdnz	5b
+	b	3b
+
+	/*
+	 * CRCs of exported symbols are emitted as 32-bit relocations against
+	 * the NULL .dynsym entry, with the CRC value recorded in the addend.
+	 */
+6:	cmpdi	r0,R_PPC64_ADDR32
+	bne	3b
+	ld	r0,16(r9)	/* reloc->r_addend */
+	stwx	r0,r7,r6
+	b	3b
+
+7:	blr
 
-6:	blr
 
 .balign 8
 p_dyn:	.llong	__dynamic_start - 0b
 p_rela:	.llong	__rela_dyn_start - 0b
+p_rela_end:
+	.llong	__rela_dyn_end - 0b
 p_st:	.llong	_stext - 0b
-
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 7394b770ae1f..654728fc860d 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -241,6 +241,7 @@ SECTIONS
 	{
 		__rela_dyn_start = .;
 		*(.rela*)
+		__rela_dyn_end = .;
 	}
 #endif
 	/* .exit.data is discarded at runtime, not link time,
diff --git a/arch/powerpc/relocs_check.sh b/arch/powerpc/relocs_check.sh
index ec2d5c835170..f9636b4e4548 100755
--- a/arch/powerpc/relocs_check.sh
+++ b/arch/powerpc/relocs_check.sh
@@ -30,7 +30,7 @@ bad_relocs=$(
 	# On PPC64:
 	#	R_PPC64_RELATIVE, R_PPC64_NONE
 	#	R_PPC64_ADDR64 mach_<name>
-	#	R_PPC64_ADDR64 __crc_<name>
+	#	R_PPC64_ADDR32 __crc_<name>
 	# On PPC:
 	#	R_PPC_RELATIVE, R_PPC_ADDR16_HI,
 	#	R_PPC_ADDR16_HA,R_PPC_ADDR16_LO,
@@ -43,7 +43,8 @@ R_PPC_ADDR16_HA
 R_PPC_RELATIVE
 R_PPC_NONE' |
 	grep -E -v '\<R_PPC64_ADDR64[[:space:]]+mach_' |
-	grep -E -v '\<R_PPC64_ADDR64[[:space:]]+__crc_'
+	grep -E -v '\<R_PPC64_ADDR32[[:space:]]+__crc_' |
+	grep -E -v '\<R_PPC64_ADDR32[[:space:]]+\*ABS\*'
 )
 
 if [ -z "$bad_relocs" ]; then
-- 
2.7.4
