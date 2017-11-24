Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjntd3RmDzDrbB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 18:31:21 +1100 (AEDT)
Message-Id: <8703033cf68861aba6424b8c13694e9823f50f98.1511506950.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 1/2] powerpc/lib/code-patching: refactor patch_instruction()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri, 24 Nov 2017 08:31:07 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

patch_instruction() uses almost the same sequence as
__patch_instruction()

This patch refactor it so that patch_instruction() uses
__patch_instruction() instead of duplicating code.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/lib/code-patching.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index d469224c4ada..80954c910b66 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -23,19 +23,26 @@
 #include <asm/code-patching.h>
 #include <asm/setup.h>
 
-static int __patch_instruction(unsigned int *addr, unsigned int instr)
+static int __patch_instruction(unsigned int *exec_addr, unsigned int instr,
+			       unsigned int *patch_addr)
 {
 	int err;
 
-	__put_user_size(instr, addr, 4, err);
+	__put_user_size(instr, patch_addr, 4, err);
 	if (err)
 		return err;
 
-	asm ("dcbst 0, %0; sync; icbi 0,%0; sync; isync" :: "r" (addr));
+	asm ("dcbst 0, %0; sync; icbi 0,%1; sync; isync" :: "r" (patch_addr),
+							    "r" (exec_addr));
 
 	return 0;
 }
 
+static int raw_patch_instruction(unsigned int *addr, unsigned int instr)
+{
+	return __patch_instruction(addr, instr, addr);
+}
+
 #ifdef CONFIG_STRICT_KERNEL_RWX
 static DEFINE_PER_CPU(struct vm_struct *, text_poke_area);
 
@@ -138,7 +145,7 @@ static inline int unmap_patch_area(unsigned long addr)
 int patch_instruction(unsigned int *addr, unsigned int instr)
 {
 	int err;
-	unsigned int *dest = NULL;
+	unsigned int *patch_addr = NULL;
 	unsigned long flags;
 	unsigned long text_poke_addr;
 	unsigned long kaddr = (unsigned long)addr;
@@ -149,7 +156,7 @@ int patch_instruction(unsigned int *addr, unsigned int instr)
 	 * to allow patching. We just do the plain old patching
 	 */
 	if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
-		return __patch_instruction(addr, instr);
+		return raw_patch_instruction(addr, instr);
 
 	local_irq_save(flags);
 
@@ -159,17 +166,10 @@ int patch_instruction(unsigned int *addr, unsigned int instr)
 		goto out;
 	}
 
-	dest = (unsigned int *)(text_poke_addr) +
+	patch_addr = (unsigned int *)(text_poke_addr) +
 			((kaddr & ~PAGE_MASK) / sizeof(unsigned int));
 
-	/*
-	 * We use __put_user_size so that we can handle faults while
-	 * writing to dest and return err to handle faults gracefully
-	 */
-	__put_user_size(instr, dest, 4, err);
-	if (!err)
-		asm ("dcbst 0, %0; sync; icbi 0,%0; icbi 0,%1; sync; isync"
-			::"r" (dest), "r"(addr));
+	__patch_instruction(addr, instr, patch_addr);
 
 	err = unmap_patch_area(text_poke_addr);
 	if (err)
@@ -184,7 +184,7 @@ int patch_instruction(unsigned int *addr, unsigned int instr)
 
 int patch_instruction(unsigned int *addr, unsigned int instr)
 {
-	return __patch_instruction(addr, instr);
+	return raw_patch_instruction(addr, instr);
 }
 
 #endif /* CONFIG_STRICT_KERNEL_RWX */
-- 
2.13.3
