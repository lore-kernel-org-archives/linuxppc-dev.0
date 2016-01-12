Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 837151A0D83
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 23:14:40 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Anton Blanchard <anton@samba.org>, amodra@gmail.com,
 ulrich.weigand@de.ibm.com, rostedt@goodmis.org
Subject: [PATCH 2/2] powerpc/module: Handle R_PPC64_ENTRY relocations
Date: Tue, 12 Jan 2016 23:14:23 +1100
Message-Id: <1452600863-6294-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1452600863-6294-1-git-send-email-mpe@ellerman.id.au>
References: <1452600863-6294-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ulrich Weigand <ulrich.weigand@de.ibm.com>

GCC 6 will include changes to generated code with -mcmodel=large,
which is used to build kernel modules on powerpc64le.  This was
necessary because the large model is supposed to allow arbitrary
sizes and locations of the code and data sections, but the ELFv2
global entry point prolog still made the unconditional assumption
that the TOC associated with any particular function can be found
within 2 GB of the function entry point:

func:
	addis r2,r12,(.TOC.-func)@ha
	addi  r2,r2,(.TOC.-func)@l
	.localentry func, .-func

To remove this assumption, GCC will now generate instead this global
entry point prolog sequence when using -mcmodel=large:

	.quad .TOC.-func
func:
	.reloc ., R_PPC64_ENTRY
	ld    r2, -8(r12)
	add   r2, r2, r12
	.localentry func, .-func

The new .reloc triggers an optimization in the linker that will
replace this new prolog with the original code (see above) if the
linker determines that the distance between .TOC. and func is in
range after all.

Since this new relocation is now present in module object files,
the kernel module loader is required to handle them too.  This
patch adds support for the new relocation and implements the
same optimization done by the GNU linker.

Cc: stable@vger.kernel.org
Signed-off-by: Ulrich Weigand <ulrich.weigand@de.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/uapi/asm/elf.h |  2 ++
 arch/powerpc/kernel/module_64.c     | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/elf.h b/arch/powerpc/include/uapi/asm/elf.h
index 59dad113897b..c2d21d11c2d2 100644
--- a/arch/powerpc/include/uapi/asm/elf.h
+++ b/arch/powerpc/include/uapi/asm/elf.h
@@ -295,6 +295,8 @@ do {									\
 #define R_PPC64_TLSLD		108
 #define R_PPC64_TOCSAVE		109
 
+#define R_PPC64_ENTRY		118
+
 #define R_PPC64_REL16		249
 #define R_PPC64_REL16_LO	250
 #define R_PPC64_REL16_HI	251
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 68384514506b..59663af9315f 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -635,6 +635,33 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 			 */
 			break;
 
+		case R_PPC64_ENTRY:
+			/*
+			 * Optimize ELFv2 large code model entry point if
+			 * the TOC is within 2GB range of current location.
+			 */
+			value = my_r2(sechdrs, me) - (unsigned long)location;
+			if (value + 0x80008000 > 0xffffffff)
+				break;
+			/*
+			 * Check for the large code model prolog sequence:
+		         *	ld r2, ...(r12)
+			 *	add r2, r2, r12
+			 */
+			if ((((uint32_t *)location)[0] & ~0xfffc)
+			    != 0xe84c0000)
+				break;
+			if (((uint32_t *)location)[1] != 0x7c426214)
+				break;
+			/*
+			 * If found, replace it with:
+			 *	addis r2, r12, (.TOC.-func)@ha
+			 *	addi r2, r12, (.TOC.-func)@l
+			 */
+			((uint32_t *)location)[0] = 0x3c4c0000 + PPC_HA(value);
+			((uint32_t *)location)[1] = 0x38420000 + PPC_LO(value);
+			break;
+
 		case R_PPC64_REL16_HA:
 			/* Subtract location pointer */
 			value -= (unsigned long)location;
-- 
2.5.0
