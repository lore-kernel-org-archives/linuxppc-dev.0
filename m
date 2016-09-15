Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZKMB1RFQzDsW3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 10:40:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH] powerpc: Don't change the section in _GLOBAL()
Date: Thu, 15 Sep 2016 10:40:20 +1000
Message-Id: <1473900020-3281-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the _GLOBAL() macro unilaterally sets the assembler section to
".text" at the start of the macro. This is rude as the caller may be
using a different section.

So let the caller decide which section to emit the code into. On big
endian we do need to switch to the ".opd" section to emit the OPD, but
do that with pushsection/popsection, thereby leaving the original
section intact.

The only place I could find where this requires changes to the code is
in misc_32.S, where we need to switch back to ".text" after
flush_icache_range() which is in ".kprobes.text".

I verified that the order of all entries in System.map is unchanged
after this patch. The actual addresses shift around slightly so you
can't just diff the System.map.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---

If anyone can think of a better method to verify we are still emitting
everything in the same sections let me know.


 arch/powerpc/include/asm/ppc_asm.h | 8 ++------
 arch/powerpc/kernel/misc_32.S      | 3 +++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index d5d5b5e348f2..479287045166 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -201,14 +201,12 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 #ifdef PPC64_ELF_ABI_v2
 
 #define _GLOBAL(name) \
-	.section ".text"; \
 	.align 2 ; \
 	.type name,@function; \
 	.globl name; \
 name:
 
 #define _GLOBAL_TOC(name) \
-	.section ".text"; \
 	.align 2 ; \
 	.type name,@function; \
 	.globl name; \
@@ -232,16 +230,15 @@ name:
 #define GLUE(a,b) XGLUE(a,b)
 
 #define _GLOBAL(name) \
-	.section ".text"; \
 	.align 2 ; \
 	.globl name; \
 	.globl GLUE(.,name); \
-	.section ".opd","aw"; \
+	.pushsection ".opd","aw"; \
 name: \
 	.quad GLUE(.,name); \
 	.quad .TOC.@tocbase; \
 	.quad 0; \
-	.previous; \
+	.popsection; \
 	.type GLUE(.,name),@function; \
 GLUE(.,name):
 
@@ -272,7 +269,6 @@ GLUE(.,name):
 n:
 
 #define _GLOBAL(n)	\
-	.text;		\
 	.stabs __stringify(n:F-1),N_FUN,0,0,n;\
 	.globl n;	\
 n:
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index d9c912b6e632..64fb1138961f 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -358,6 +358,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 	sync				/* additional sync needed on g4 */
 	isync
 	blr
+
+.previous
+
 /*
  * Flush a particular page from the data cache to RAM.
  * Note: this is necessary because the instruction cache does *not*
-- 
2.7.4
