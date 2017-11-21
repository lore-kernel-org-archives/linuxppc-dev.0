Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yh7FZ1M01zDrZr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 01:26:56 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc: fix boot on BOOK3S_32 with
 CONFIG_STRICT_KERNEL_RWX
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20171121142647.5A79A6BB8F@po15668-vm-win7.idsi0.si.c-s.fr>
Date: Tue, 21 Nov 2017 15:26:47 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On powerpc32, patch_instruction() is called by apply_feature_fixups()
which is called from early_init()

There is the following note in front of early_init():
 * Note that the kernel may be running at an address which is different
 * from the address that it was linked at, so we must use RELOC/PTRRELOC
 * to access static data (including strings).  -- paulus

Therefore, slab_is_available() cannot be called yet, and
text_poke_area must be addressed with PTRRELOC()

Fixes: 37bc3e5fd764f ("powerpc/lib/code-patching: Use alternate map
for patch_instruction()")
Reported-by: Meelis Roos <mroos@linux.ee>
Cc: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: Added missing asm/setup.h

 arch/powerpc/lib/code-patching.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index c9de03e0c1f1..d469224c4ada 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -21,6 +21,7 @@
 #include <asm/tlbflush.h>
 #include <asm/page.h>
 #include <asm/code-patching.h>
+#include <asm/setup.h>
 
 static int __patch_instruction(unsigned int *addr, unsigned int instr)
 {
@@ -146,11 +147,8 @@ int patch_instruction(unsigned int *addr, unsigned int instr)
 	 * During early early boot patch_instruction is called
 	 * when text_poke_area is not ready, but we still need
 	 * to allow patching. We just do the plain old patching
-	 * We use slab_is_available and per cpu read * via this_cpu_read
-	 * of text_poke_area. Per-CPU areas might not be up early
-	 * this can create problems with just using this_cpu_read()
 	 */
-	if (!slab_is_available() || !this_cpu_read(text_poke_area))
+	if (!this_cpu_read(*PTRRELOC(&text_poke_area)))
 		return __patch_instruction(addr, instr);
 
 	local_irq_save(flags);
-- 
2.13.3
