Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGjgp5xXZzDqFH
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 May 2017 22:01:26 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id c2so5323520pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 May 2017 05:01:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 1/2] powerpc/64s: Fix FIXUP_ENDIAN non-maskable interrupt
 reentrancy
Date: Mon,  1 May 2017 22:01:09 +1000
Message-Id: <20170501120110.21888-2-npiggin@gmail.com>
In-Reply-To: <20170501120110.21888-1-npiggin@gmail.com>
References: <20170501120110.21888-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

FIXUP_ENDIAN uses SRR[01] with MSR_RI=1, which gets corrupted if there
is an interleaving system reset or machine check interrupt.

Set MSR_RI=0 before setting SRRs. The rfid will restore MSR.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/boot/ppc_asm.h        | 12 +++++++-----
 arch/powerpc/include/asm/ppc_asm.h | 11 +++++++----
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/boot/ppc_asm.h b/arch/powerpc/boot/ppc_asm.h
index b03373d8b386..68e388ee94fe 100644
--- a/arch/powerpc/boot/ppc_asm.h
+++ b/arch/powerpc/boot/ppc_asm.h
@@ -67,13 +67,15 @@
 #define MSR_LE		0x0000000000000001
 
 #define FIXUP_ENDIAN						   \
-	tdi   0, 0, 0x48; /* Reverse endian of b . + 8		*/ \
-	b     $+36;	  /* Skip trampoline if endian is good	*/ \
-	.long 0x05009f42; /* bcl 20,31,$+4			*/ \
-	.long 0xa602487d; /* mflr r10				*/ \
-	.long 0x1c004a39; /* addi r10,r10,28			*/ \
+	tdi   0,0,0x48;	  /* Reverse endian of b . + 8		*/ \
+	b     $+44;	  /* Skip trampoline if endian is good	*/ \
 	.long 0xa600607d; /* mfmsr r11				*/ \
 	.long 0x01006b69; /* xori r11,r11,1			*/ \
+	.long 0x00004039; /* li r10,0				*/ \
+	.long 0x6401417d; /* mtmsrd r10,1			*/ \
+	.long 0x05009f42; /* bcl 20,31,$+4			*/ \
+	.long 0xa602487d; /* mflr r10				*/ \
+	.long 0x14004a39; /* addi r10,r10,20			*/ \
 	.long 0xa6035a7d; /* mtsrr0 r10				*/ \
 	.long 0xa6037b7d; /* mtsrr1 r11				*/ \
 	.long 0x2400004c  /* rfid				*/
diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
index 359c44341761..6baeeb9acd0d 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -770,15 +770,18 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #else
 #define FIXUP_ENDIAN						   \
 	tdi   0,0,0x48;	  /* Reverse endian of b . + 8		*/ \
-	b     $+36;	  /* Skip trampoline if endian is good	*/ \
-	.long 0x05009f42; /* bcl 20,31,$+4			*/ \
-	.long 0xa602487d; /* mflr r10				*/ \
-	.long 0x1c004a39; /* addi r10,r10,28			*/ \
+	b     $+44;	  /* Skip trampoline if endian is good	*/ \
 	.long 0xa600607d; /* mfmsr r11				*/ \
 	.long 0x01006b69; /* xori r11,r11,1			*/ \
+	.long 0x00004039; /* li r10,0				*/ \
+	.long 0x6401417d; /* mtmsrd r10,1			*/ \
+	.long 0x05009f42; /* bcl 20,31,$+4			*/ \
+	.long 0xa602487d; /* mflr r10				*/ \
+	.long 0x14004a39; /* addi r10,r10,20			*/ \
 	.long 0xa6035a7d; /* mtsrr0 r10				*/ \
 	.long 0xa6037b7d; /* mtsrr1 r11				*/ \
 	.long 0x2400004c  /* rfid				*/
+
 #endif /* !CONFIG_PPC_BOOK3E */
 
 #endif /*  __ASSEMBLY__ */
-- 
2.11.0
