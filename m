Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjntX055KzDrZc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 18:31:15 +1100 (AEDT)
Message-Id: <d282fc60052bbe13c3ac19e3e9389603d0d46e44.1511506950.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 2/2] powerpc/lib/feature-fixups: use raw_patch_instruction()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 24 Nov 2017 08:31:09 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

feature fixups need to use patch_instruction() early in the boot,
even before the code is relocated to its final address, requiring
patch_instruction() to use PTRRELOC() in order to address data.

But feature fixups applies on code before it is set to read only,
even for modules. Therefore, feature fixups can use
raw_patch_instruction() instead.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/code-patching.h | 1 +
 arch/powerpc/lib/code-patching.c         | 4 ++--
 arch/powerpc/lib/feature-fixups.c        | 8 ++++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index abef812de7f8..1090024e8519 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -31,6 +31,7 @@ unsigned int create_cond_branch(const unsigned int *addr,
 				unsigned long target, int flags);
 int patch_branch(unsigned int *addr, unsigned long target, int flags);
 int patch_instruction(unsigned int *addr, unsigned int instr);
+int raw_patch_instruction(unsigned int *addr, unsigned int instr);
 
 int instr_is_relative_branch(unsigned int instr);
 int instr_is_branch_to_addr(const unsigned int *instr, unsigned long addr);
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 80954c910b66..b7c555df5cd6 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -38,7 +38,7 @@ static int __patch_instruction(unsigned int *exec_addr, unsigned int instr,
 	return 0;
 }
 
-static int raw_patch_instruction(unsigned int *addr, unsigned int instr)
+int raw_patch_instruction(unsigned int *addr, unsigned int instr)
 {
 	return __patch_instruction(addr, instr, addr);
 }
@@ -155,7 +155,7 @@ int patch_instruction(unsigned int *addr, unsigned int instr)
 	 * when text_poke_area is not ready, but we still need
 	 * to allow patching. We just do the plain old patching
 	 */
-	if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
+	if (!this_cpu_read(text_poke_area))
 		return raw_patch_instruction(addr, instr);
 
 	local_irq_save(flags);
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 41cf5ae273cf..0872d60ede10 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -62,7 +62,7 @@ static int patch_alt_instruction(unsigned int *src, unsigned int *dest,
 		}
 	}
 
-	patch_instruction(dest, instr);
+	raw_patch_instruction(dest, instr);
 
 	return 0;
 }
@@ -91,7 +91,7 @@ static int patch_feature_section(unsigned long value, struct fixup_entry *fcur)
 	}
 
 	for (; dest < end; dest++)
-		patch_instruction(dest, PPC_INST_NOP);
+		raw_patch_instruction(dest, PPC_INST_NOP);
 
 	return 0;
 }
@@ -129,7 +129,7 @@ void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 
 	for (; start < end; start++) {
 		dest = (void *)start + *start;
-		patch_instruction(dest, PPC_INST_LWSYNC);
+		raw_patch_instruction(dest, PPC_INST_LWSYNC);
 	}
 }
 
@@ -147,7 +147,7 @@ static void do_final_fixups(void)
 	length = (__end_interrupts - _stext) / sizeof(int);
 
 	while (length--) {
-		patch_instruction(dest, *src);
+		raw_patch_instruction(dest, *src);
 		src++;
 		dest++;
 	}
-- 
2.13.3
