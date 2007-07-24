Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A3822DDE98
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Jul 2007 09:27:36 +1000 (EST)
Date: Wed, 25 Jul 2007 09:27:35 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] iSeries: fix section mismatch warnings
Message-Id: <20070725092735.0a5a1c52.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

WARNING: vmlinux.o(.text+0x8124): Section mismatch: reference to .init.text:.iSeries_early_setup (between '.__start_initialization_iSeries' and '.__mmu_off')
WARNING: vmlinux.o(.text+0x8128): Section mismatch: reference to .init.text:.early_setup (between '.__start_initialization_iSeries' and '.__mmu_off')

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/head_64.S |    7 ++++---
 include/asm-powerpc/ppc_asm.h |   12 ++++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 8cdd48e..1448af9 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -809,8 +809,9 @@ system_reset_iSeries:
 	mtmsrd	r24			/* RI on */
 	lhz	r24,PACAPACAINDEX(r13)	/* Get processor # */
 	cmpwi	0,r24,0			/* Are we processor 0? */
-	beq	.__start_initialization_iSeries	/* Start up the first processor */
-	mfspr	r4,SPRN_CTRLF
+	bne	1f
+	b	.__start_initialization_iSeries	/* Start up the first processor */
+1:	mfspr	r4,SPRN_CTRLF
 	li	r5,CTRL_RUNLATCH	/* Turn off the run light */
 	andc	r4,r4,r5
 	mtspr	SPRN_CTRLT,r4
@@ -1611,7 +1612,7 @@ _GLOBAL(generic_secondary_smp_init)
 #endif
 
 #ifdef CONFIG_PPC_ISERIES
-_STATIC(__start_initialization_iSeries)
+_INIT_STATIC(__start_initialization_iSeries)
 	/* Clear out the BSS */
 	LOAD_REG_IMMEDIATE(r11,__bss_stop)
 	LOAD_REG_IMMEDIATE(r8,__bss_start)
diff --git a/include/asm-powerpc/ppc_asm.h b/include/asm-powerpc/ppc_asm.h
index fa083d8..6532572 100644
--- a/include/asm-powerpc/ppc_asm.h
+++ b/include/asm-powerpc/ppc_asm.h
@@ -181,6 +181,18 @@ name: \
 	.type GLUE(.,name),@function; \
 GLUE(.,name):
 
+#define _INIT_STATIC(name) \
+	.section ".text.init.refok"; \
+	.align 2 ; \
+	.section ".opd","aw"; \
+name: \
+	.quad GLUE(.,name); \
+	.quad .TOC.@tocbase; \
+	.quad 0; \
+	.previous; \
+	.type GLUE(.,name),@function; \
+GLUE(.,name):
+
 #else /* 32-bit */
 
 #define _GLOBAL(n)	\
-- 
1.5.2.4
