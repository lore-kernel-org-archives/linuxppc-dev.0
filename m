Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40R36c4lS8zF1xc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 23:36:08 +1000 (AEST)
Message-Id: <fe9959328efb520e6030476553ed23541c547639.1524055122.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 1/2] powerpc: fix vmlinux.lds to build with
 CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arch@vger.kernel.org
Date: Wed, 18 Apr 2018 15:36:03 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes vmlinux.lds script to build properly with
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION enabled

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/vmlinux.lds.S | 4 ++--
 include/asm-generic/vmlinux.lds.h | 6 +++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index c8af90ff49f0..afff03e9be39 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -98,7 +98,7 @@ SECTIONS
 		ALIGN_FUNCTION();
 #endif
 		/* careful! __ftr_alt_* sections need to be close to .text */
-		*(.text.hot .text .text.fixup .text.unlikely .fixup __ftr_alt_* .ref.text);
+		*(.text.hot TEXT_MAIN .text.fixup .text.unlikely .fixup __ftr_alt_* .ref.text);
 		SCHED_TEXT
 		CPUIDLE_TEXT
 		LOCK_TEXT
@@ -274,7 +274,7 @@ SECTIONS
 	.data : AT(ADDR(.data) - LOAD_OFFSET) {
 		DATA_DATA
 		*(.data.rel*)
-		*(.sdata)
+		*(SDATA_MAIN)
 		*(.sdata2)
 		*(.got.plt) *(.got)
 		*(.plt)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 278841c75b97..5549be081931 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -68,11 +68,15 @@
 #ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
 #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
 #define DATA_MAIN .data .data.[0-9a-zA-Z_]*
+#define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
 #define BSS_MAIN .bss .bss.[0-9a-zA-Z_]*
+#define SBSS_MAIN .sbss .sbss.[0-9a-zA-Z_]*
 #else
 #define TEXT_MAIN .text
 #define DATA_MAIN .data
+#define SDATA_MAIN .sdata
 #define BSS_MAIN .bss
+#define SBSS_MAIN .sbss
 #endif
 
 /*
@@ -629,7 +633,7 @@
 	. = ALIGN(sbss_align);						\
 	.sbss : AT(ADDR(.sbss) - LOAD_OFFSET) {				\
 		*(.dynsbss)						\
-		*(.sbss)						\
+		*(SBSS_MAIN)						\
 		*(.scommon)						\
 	}
 
-- 
2.13.3
