Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BBA651A0182
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 20:56:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Remove unused vgacon_remap_base & fix build break
Date: Mon, 27 Oct 2014 20:56:14 +1100
Message-Id: <1414403774-18652-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The build is broken with CONFIG_PPC32=y, CONFIG_FB_VGA16=y and
CONFIG_VGA_CONSOLE=n.

The problem is that vgacon_remap_base is not defined. It's used in:

    #define VGA_MAP_MEM(x,s) (x + vgacon_remap_base)

Which is used in the vga16fb.c code.

Digging down it seems vgacon_remap_base is never initialised. It used to
be, back in arch/ppc (pplus.c and prep_setup.c), but none of that code
ever made it to arch/powerpc.

So given it's been unused for >6 years, remove it.

Whether vga16fb.c works on 32-bit is another question, but this patch
shouldn't affect it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/vga.h | 4 +---
 arch/powerpc/kernel/setup_32.c | 5 -----
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/vga.h b/arch/powerpc/include/asm/vga.h
index a2eac409c1ec..e5f8dd366212 100644
--- a/arch/powerpc/include/asm/vga.h
+++ b/arch/powerpc/include/asm/vga.h
@@ -38,12 +38,10 @@ static inline u16 scr_readw(volatile const u16 *addr)
 
 #endif /* !CONFIG_VGA_CONSOLE && !CONFIG_MDA_CONSOLE */
 
-extern unsigned long vgacon_remap_base;
-
 #ifdef __powerpc64__
 #define VGA_MAP_MEM(x,s) ((unsigned long) ioremap((x), s))
 #else
-#define VGA_MAP_MEM(x,s) (x + vgacon_remap_base)
+#define VGA_MAP_MEM(x,s) (x)
 #endif
 
 #define vga_readb(x) (*(x))
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 07831ed0d9ef..e46b56657c53 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -53,11 +53,6 @@ unsigned long ISA_DMA_THRESHOLD;
 unsigned int DMA_MODE_READ;
 unsigned int DMA_MODE_WRITE;
 
-#ifdef CONFIG_VGA_CONSOLE
-unsigned long vgacon_remap_base;
-EXPORT_SYMBOL(vgacon_remap_base);
-#endif
-
 /*
  * These are used in binfmt_elf.c to put aux entries on the stack
  * for each elf executable being started.
-- 
1.9.1
