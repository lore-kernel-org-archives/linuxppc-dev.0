Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yL6v24LVyzDqXj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 18:08:30 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id b85so16415108pfj.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Oct 2017 00:08:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/3] powerpc/book3s: use label for FIXUP_ENDIAN macro branch
Date: Mon, 23 Oct 2017 17:08:13 +1000
Message-Id: <20171023070815.19803-2-npiggin@gmail.com>
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/ppc_asm.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 36f3e41c9fbe..d6b56aebe602 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -776,7 +776,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #else
 #define FIXUP_ENDIAN						   \
 	tdi   0,0,0x48;	  /* Reverse endian of b . + 8		*/ \
-	b     $+44;	  /* Skip trampoline if endian is good	*/ \
+	b     191f;	  /* Skip trampoline if endian is good	*/ \
 	.long 0xa600607d; /* mfmsr r11				*/ \
 	.long 0x01006b69; /* xori r11,r11,1			*/ \
 	.long 0x00004039; /* li r10,0				*/ \
@@ -786,7 +786,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 	.long 0x14004a39; /* addi r10,r10,20			*/ \
 	.long 0xa6035a7d; /* mtsrr0 r10				*/ \
 	.long 0xa6037b7d; /* mtsrr1 r11				*/ \
-	.long 0x2400004c  /* rfid				*/
+	.long 0x2400004c; /* rfid				*/ \
+191:
 
 #endif /* !CONFIG_PPC_BOOK3E */
 
-- 
2.13.3
