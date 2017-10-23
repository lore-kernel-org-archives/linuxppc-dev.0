Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yL6v44TmkzDqjC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 18:08:32 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id j3so11073293pga.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 00:08:32 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/3] powerpc/book3s: Add an HV variant of FIXUP_ENDIAN that is
 recoverable
Date: Mon, 23 Oct 2017 17:08:14 +1000
Message-Id: <20171023070815.19803-3-npiggin@gmail.com>
In-Reply-To: <20171023070815.19803-1-npiggin@gmail.com>
References: <20171023070815.19803-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add an HV variant of FIXUP_ENDIAN which uses HSRR[01] and does not
clear MSR[RI], which improves recoverability.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/ppc_asm.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index d6b56aebe602..ae94b3626b6c 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -774,6 +774,10 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #ifdef CONFIG_PPC_BOOK3E
 #define FIXUP_ENDIAN
 #else
+/*
+ * This version may be used in in HV or non-HV context.
+ * MSR[EE] must be disabled.
+ */
 #define FIXUP_ENDIAN						   \
 	tdi   0,0,0x48;	  /* Reverse endian of b . + 8		*/ \
 	b     191f;	  /* Skip trampoline if endian is good	*/ \
@@ -789,6 +793,24 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 	.long 0x2400004c; /* rfid				*/ \
 191:
 
+/*
+ * This version that may only be used with MSR[HV]=1
+ * - Does not clear MSR[RI], so more robust.
+ * - Slightly smaller and faster.
+ */
+#define FIXUP_ENDIAN_HV						   \
+	tdi   0,0,0x48;	  /* Reverse endian of b . + 8		*/ \
+	b     191f;	  /* Skip trampoline if endian is good	*/ \
+	.long 0xa600607d; /* mfmsr r11				*/ \
+	.long 0x01006b69; /* xori r11,r11,1			*/ \
+	.long 0x05009f42; /* bcl 20,31,$+4			*/ \
+	.long 0xa602487d; /* mflr r10				*/ \
+	.long 0x14004a39; /* addi r10,r10,20			*/ \
+	.long 0xa64b5a7d; /* mthsrr0 r10			*/ \
+	.long 0xa64b7b7d; /* mthsrr1 r11			*/ \
+	.long 0x2402004c; /* hrfid				*/ \
+191:
+
 #endif /* !CONFIG_PPC_BOOK3E */
 
 #endif /*  __ASSEMBLY__ */
-- 
2.13.3
