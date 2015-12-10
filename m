Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D71061A05EF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Dec 2015 09:34:42 +1100 (AEDT)
Message-ID: <1449786882.29188.32.camel@neuling.org>
Subject: [PATCH v3 2/2] powerpc: Copy only required pieces of the
 mm_context_t to the paca
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, anton@samba.org, Cyril Bur <cyrilbur@gmail.com>
Date: Fri, 11 Dec 2015 09:34:42 +1100
In-Reply-To: <1449741623.7156.3.camel@ellerman.id.au>
References: <1446008047-2393-1-git-send-email-mikey@neuling.org>
 <1446008047-2393-2-git-send-email-mikey@neuling.org>
 <1449719211.29188.5.camel@neuling.org>
 <1449741623.7156.3.camel@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we copy the whole mm_context_t to the paca but only access a
few bits of it.  This is wasteful of space paca and also takes quite
some time in the hot path of context switching.

This patch pulls in only the required bits from the mm_context_t to
the paca and on context switch, copies only those.

Benchmarking this (On top of Anton's recent MSR context switching
changes [1]) using processes and yield shows an improvement of almost
3% on POWER8:

  http://ozlabs.org/~anton/junkcode/context_switch2.c
  ./context_switch2 --test=3Dyield --process 0 0

1. https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-October/135700.html

Signed-off-by: Michael Neuling <mikey@neuling.org>
--
v3:
  Fix line wrapping (WTF sorry!?!)
v2:
  Added missing include which broke allmodconfig (noticed by anton)


diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/pac=
a.h
index 1cc6e08..06cdaee 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -16,6 +16,7 @@
=20
 #ifdef CONFIG_PPC64
=20
+#include <linux/string.h>
 #include <asm/types.h>
 #include <asm/lppaca.h>
 #include <asm/mmu.h>
@@ -132,7 +133,13 @@ struct paca_struct {
 #endif /* CONFIG_PPC_BOOK3E */
=20
 #ifdef CONFIG_PPC_BOOK3S
-	mm_context_t context;
+	mm_context_id_t context_id;
+#ifdef CONFIG_PPC_MM_SLICES
+	u64 context_low_slices_psize;
+	unsigned char context_high_slices_psize[SLICE_ARRAY_SIZE];
+#else
+	u16 context_sllp;
+#endif
 #endif
=20
 	/*
@@ -199,7 +206,14 @@ struct paca_struct {
 #ifdef CONFIG_PPC_BOOK3S
 static inline void copy_mm_to_paca(mm_context_t *context)
 {
-	get_paca()->context =3D *context;
+	get_paca()->context_id =3D context->id;
+#ifdef CONFIG_PPC_MM_SLICES
+	get_paca()->context_low_slices_psize =3D context->low_slices_psize;
+	memcpy(&get_paca()->context_high_slices_psize,
+	       &context->high_slices_psize, SLICE_ARRAY_SIZE);
+#else
+	get_paca()->context_sllp =3D context->sllp;
+#endif
 }
 #else
 static inline void copy_mm_to_paca(mm_context_t *context){}
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-of=
fsets.c
index 9db7be2..d5903a9 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -186,12 +186,12 @@ int main(void)
 	DEFINE(PACASOFTIRQEN, offsetof(struct paca_struct, soft_enabled));
 	DEFINE(PACAIRQHAPPENED, offsetof(struct paca_struct, irq_happened));
 #ifdef CONFIG_PPC_BOOK3S
-	DEFINE(PACACONTEXTID, offsetof(struct paca_struct, context.id));
+	DEFINE(PACACONTEXTID, offsetof(struct paca_struct, context_id));
 #ifdef CONFIG_PPC_MM_SLICES
 	DEFINE(PACALOWSLICESPSIZE, offsetof(struct paca_struct,
-					    context.low_slices_psize));
+					    context_low_slices_psize));
 	DEFINE(PACAHIGHSLICEPSIZE, offsetof(struct paca_struct,
-					    context.high_slices_psize));
+					    context_high_slices_psize));
 	DEFINE(MMUPSIZEDEFSIZE, sizeof(struct mmu_psize_def));
 #endif /* CONFIG_PPC_MM_SLICES */
 #endif
@@ -224,7 +224,7 @@ int main(void)
 #ifdef CONFIG_PPC_MM_SLICES
 	DEFINE(MMUPSIZESLLP, offsetof(struct mmu_psize_def, sllp));
 #else
-	DEFINE(PACACONTEXTSLLP, offsetof(struct paca_struct, context.sllp));
+	DEFINE(PACACONTEXTSLLP, offsetof(struct paca_struct, context_sllp));
 #endif /* CONFIG_PPC_MM_SLICES */
 	DEFINE(PACA_EXGEN, offsetof(struct paca_struct, exgen));
 	DEFINE(PACA_EXMC, offsetof(struct paca_struct, exmc));
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_6=
4.c
index 0aa526e..ae98d58 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -877,11 +877,11 @@ static unsigned int get_paca_psize(unsigned long addr=
)
 	unsigned long index, mask_index;
=20
 	if (addr < SLICE_LOW_TOP) {
-		lpsizes =3D get_paca()->context.low_slices_psize;
+		lpsizes =3D get_paca()->context_low_slices_psize;
 		index =3D GET_LOW_SLICE_INDEX(addr);
 		return (lpsizes >> (index * 4)) & 0xF;
 	}
-	hpsizes =3D get_paca()->context.high_slices_psize;
+	hpsizes =3D get_paca()->context_high_slices_psize;
 	index =3D GET_HIGH_SLICE_INDEX(addr);
 	mask_index =3D index & 0x1;
 	return (hpsizes[index >> 1] >> (mask_index * 4)) & 0xF;
