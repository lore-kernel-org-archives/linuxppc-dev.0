Return-Path: <paulus@ozlabs.org>
Date: Tue, 27 Aug 2013 16:07:49 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Work around gcc miscompilation of __pa() on 64-bit
Message-ID: <20130827060749.GA16462@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alan Modra <amodra@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 64-bit, __pa(&static_var) gets miscompiled by recent versions of
gcc as something like:

        addis 3,2,.LANCHOR1+4611686018427387904@toc@ha
        addi 3,3,.LANCHOR1+4611686018427387904@toc@l

This ends up effectively ignoring the offset, since its bottom 32 bits
are zero, and means that the result of __pa() still has 0xC in the top
nibble.  This happens with gcc 4.8.1, at least.

To work around this, for 64-bit we make __pa() use an AND operator,
and for symmetry, we make __va() use an OR operator.  Using an AND
operator rather than a subtraction ends up with slightly shorter code
since it can be done with a single clrldi instruction, whereas it
takes three instructions to form the constant (-PAGE_OFFSET) and add
it on.  (Note that MEMORY_START is always 0 on 64-bit.)

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/Kconfig            |  1 +
 arch/powerpc/include/asm/page.h | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index dbd9d3c..9cf59816d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -979,6 +979,7 @@ config RELOCATABLE
 	  must live at a different physical address than the primary
 	  kernel.
 
+# This value must have zeroes in the bottom 60 bits otherwise lots will break
 config PAGE_OFFSET
 	hex
 	default "0xc000000000000000"
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 988c812..b9f4262 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -211,9 +211,19 @@ extern long long virt_phys_offset;
 #define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) + VIRT_PHYS_OFFSET))
 #define __pa(x) ((unsigned long)(x) - VIRT_PHYS_OFFSET)
 #else
+#ifdef CONFIG_PPC64
+/*
+ * gcc miscompiles (unsigned long)(&static_var) - PAGE_OFFSET
+ * with -mcmodel=medium, so we use & and | instead of - and + on 64-bit.
+ */
+#define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) | PAGE_OFFSET))
+#define __pa(x) ((unsigned long)(x) & 0x0fffffffffffffffUL)
+
+#else /* 32-bit, non book E */
 #define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) + PAGE_OFFSET - MEMORY_START))
 #define __pa(x) ((unsigned long)(x) - PAGE_OFFSET + MEMORY_START)
 #endif
+#endif
 
 /*
  * Unfortunately the PLT is in the BSS in the PPC32 ELF ABI,
-- 
1.8.4.rc3
