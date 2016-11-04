Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t95dv0JWMzDvXv
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 13:39:47 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/asm: Allow including ppc_asm.h in asm files
Date: Fri,  4 Nov 2016 13:39:43 +1100
Message-Id: <1478227183-10299-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There's no reason to #error if we include ppc_asm.h in asm files, the
ifdef already prevents any problems.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/ppc_asm.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index c73750b0d9fa..28ab87e5b739 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -10,9 +10,7 @@
 #include <asm/ppc-opcode.h>
 #include <asm/firmware.h>
 
-#ifndef __ASSEMBLY__
-#error __FILE__ should only be used in assembler files
-#else
+#ifdef __ASSEMBLY__
 
 #define SZL			(BITS_PER_LONG/8)
 
@@ -779,5 +777,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 	.long 0xa6037b7d; /* mtsrr1 r11				*/ \
 	.long 0x2400004c  /* rfid				*/
 #endif /* !CONFIG_PPC_BOOK3E */
+
 #endif /*  __ASSEMBLY__ */
+
 #endif /* _ASM_POWERPC_PPC_ASM_H */
-- 
2.7.4
