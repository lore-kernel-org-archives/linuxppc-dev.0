Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F19F02C00DB
 for <linuxppc-dev@ozlabs.org>; Tue, 31 Dec 2013 01:31:28 +1100 (EST)
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net
 [192.168.8.180])
 by mail-out.m-online.net (Postfix) with ESMTP id 3dtLfw1PbDz3hjDL
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Dec 2013 15:31:19 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
 by mail.m-online.net (Postfix) with ESMTP id 3dtLfv3cWvzbbfY
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Dec 2013 15:31:19 +0100 (CET)
Received: from mail.mnet-online.de ([192.168.8.180])
 by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new,
 port 10024) with ESMTP id xWLYCIny8DqV for <linuxppc-dev@ozlabs.org>;
 Mon, 30 Dec 2013 15:31:17 +0100 (CET)
Received: from igel.home (ppp-88-217-56-171.dynamic.mnet-online.de
 [88.217.56.171]) by mail.mnet-online.de (Postfix) with ESMTPA
 for <linuxppc-dev@ozlabs.org>; Mon, 30 Dec 2013 15:31:17 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: add vr save/restore functions
Date: Mon, 30 Dec 2013 15:31:17 +0100
Message-ID: <87eh4uif62.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

GCC 4.8 now generates out-of-line vr save/restore functions when
optimizing for size.  They are needed for the raid6 altivec support.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/powerpc/lib/crtsavres.S | 186 +++++++++++++++++++++++++++++++++++++++++++
 scripts/mod/modpost.c        |   8 +-
 2 files changed, 192 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/crtsavres.S b/arch/powerpc/lib/crtsavres.S
index b2c68ce..a5b30c7 100644
--- a/arch/powerpc/lib/crtsavres.S
+++ b/arch/powerpc/lib/crtsavres.S
@@ -231,6 +231,87 @@ _GLOBAL(_rest32gpr_31_x)
 	mr	1,11
 	blr
 
+#ifdef CONFIG_ALTIVEC
+/* Called with r0 pointing just beyond the end of the vector save area.  */
+
+_GLOBAL(_savevr_20)
+	li	r11,-192
+	stvx	vr20,r11,r0
+_GLOBAL(_savevr_21)
+	li	r11,-176
+	stvx	vr21,r11,r0
+_GLOBAL(_savevr_22)
+	li	r11,-160
+	stvx	vr22,r11,r0
+_GLOBAL(_savevr_23)
+	li	r11,-144
+	stvx	vr23,r11,r0
+_GLOBAL(_savevr_24)
+	li	r11,-128
+	stvx	vr24,r11,r0
+_GLOBAL(_savevr_25)
+	li	r11,-112
+	stvx	vr25,r11,r0
+_GLOBAL(_savevr_26)
+	li	r11,-96
+	stvx	vr26,r11,r0
+_GLOBAL(_savevr_27)
+	li	r11,-80
+	stvx	vr27,r11,r0
+_GLOBAL(_savevr_28)
+	li	r11,-64
+	stvx	vr28,r11,r0
+_GLOBAL(_savevr_29)
+	li	r11,-48
+	stvx	vr29,r11,r0
+_GLOBAL(_savevr_30)
+	li	r11,-32
+	stvx	vr30,r11,r0
+_GLOBAL(_savevr_31)
+	li	r11,-16
+	stvx	vr31,r11,r0
+	blr
+
+_GLOBAL(_restvr_20)
+	li	r11,-192
+	lvx	vr20,r11,r0
+_GLOBAL(_restvr_21)
+	li	r11,-176
+	lvx	vr21,r11,r0
+_GLOBAL(_restvr_22)
+	li	r11,-160
+	lvx	vr22,r11,r0
+_GLOBAL(_restvr_23)
+	li	r11,-144
+	lvx	vr23,r11,r0
+_GLOBAL(_restvr_24)
+	li	r11,-128
+	lvx	vr24,r11,r0
+_GLOBAL(_restvr_25)
+	li	r11,-112
+	lvx	vr25,r11,r0
+_GLOBAL(_restvr_26)
+	li	r11,-96
+	lvx	vr26,r11,r0
+_GLOBAL(_restvr_27)
+	li	r11,-80
+	lvx	vr27,r11,r0
+_GLOBAL(_restvr_28)
+	li	r11,-64
+	lvx	vr28,r11,r0
+_GLOBAL(_restvr_29)
+	li	r11,-48
+	lvx	vr29,r11,r0
+_GLOBAL(_restvr_30)
+	li	r11,-32
+	lvx	vr30,r11,r0
+_GLOBAL(_restvr_31)
+	li	r11,-16
+	lvx	vr31,r11,r0
+	blr
+
+#endif /* CONFIG_ALTIVEC */
+
 #else /* CONFIG_PPC64 */
 
 	.section ".text.save.restore","ax",@progbits
@@ -356,6 +437,111 @@ _restgpr0_31:
 	mtlr	r0
 	blr
 
+#ifdef CONFIG_ALTIVEC
+/* Called with r0 pointing just beyond the end of the vector save area.  */
+
+.globl	_savevr_20
+_savevr_20:
+	li	r12,-192
+	stvx	vr20,r12,r0
+.globl	_savevr_21
+_savevr_21:
+	li	r12,-176
+	stvx	vr21,r12,r0
+.globl	_savevr_22
+_savevr_22:
+	li	r12,-160
+	stvx	vr22,r12,r0
+.globl	_savevr_23
+_savevr_23:
+	li	r12,-144
+	stvx	vr23,r12,r0
+.globl	_savevr_24
+_savevr_24:
+	li	r12,-128
+	stvx	vr24,r12,r0
+.globl	_savevr_25
+_savevr_25:
+	li	r12,-112
+	stvx	vr25,r12,r0
+.globl	_savevr_26
+_savevr_26:
+	li	r12,-96
+	stvx	vr26,r12,r0
+.globl	_savevr_27
+_savevr_27:
+	li	r12,-80
+	stvx	vr27,r12,r0
+.globl	_savevr_28
+_savevr_28:
+	li	r12,-64
+	stvx	vr28,r12,r0
+.globl	_savevr_29
+_savevr_29:
+	li	r12,-48
+	stvx	vr29,r12,r0
+.globl	_savevr_30
+_savevr_30:
+	li	r12,-32
+	stvx	vr30,r12,r0
+.globl	_savevr_31
+_savevr_31:
+	li	r12,-16
+	stvx	vr31,r12,r0
+	blr
+
+.globl	_restvr_20
+_restvr_20:
+	li	r12,-192
+	lvx	vr20,r12,r0
+.globl	_restvr_21
+_restvr_21:
+	li	r12,-176
+	lvx	vr21,r12,r0
+.globl	_restvr_22
+_restvr_22:
+	li	r12,-160
+	lvx	vr22,r12,r0
+.globl	_restvr_23
+_restvr_23:
+	li	r12,-144
+	lvx	vr23,r12,r0
+.globl	_restvr_24
+_restvr_24:
+	li	r12,-128
+	lvx	vr24,r12,r0
+.globl	_restvr_25
+_restvr_25:
+	li	r12,-112
+	lvx	vr25,r12,r0
+.globl	_restvr_26
+_restvr_26:
+	li	r12,-96
+	lvx	vr26,r12,r0
+.globl	_restvr_27
+_restvr_27:
+	li	r12,-80
+	lvx	vr27,r12,r0
+.globl	_restvr_28
+_restvr_28:
+	li	r12,-64
+	lvx	vr28,r12,r0
+.globl	_restvr_29
+_restvr_29:
+	li	r12,-48
+	lvx	vr29,r12,r0
+.globl	_restvr_30
+_restvr_30:
+	li	r12,-32
+	lvx	vr30,r12,r0
+.globl	_restvr_31
+_restvr_31:
+	li	r12,-16
+	lvx	vr31,r12,r0
+	blr
+
+#endif /* CONFIG_ALTIVEC */
+
 #endif /* CONFIG_PPC64 */
 
 #endif
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 1785576..4061098 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -584,12 +584,16 @@ static int ignore_undef_symbol(struct elf_info *info, const char *symname)
 		if (strncmp(symname, "_restgpr_", sizeof("_restgpr_") - 1) == 0 ||
 		    strncmp(symname, "_savegpr_", sizeof("_savegpr_") - 1) == 0 ||
 		    strncmp(symname, "_rest32gpr_", sizeof("_rest32gpr_") - 1) == 0 ||
-		    strncmp(symname, "_save32gpr_", sizeof("_save32gpr_") - 1) == 0)
+		    strncmp(symname, "_save32gpr_", sizeof("_save32gpr_") - 1) == 0 ||
+		    strncmp(symname, "_restvr_", sizeof("_restvr_") - 1) == 0 ||
+		    strncmp(symname, "_savevr_", sizeof("_savevr_") - 1) == 0)
 			return 1;
 	if (info->hdr->e_machine == EM_PPC64)
 		/* Special register function linked on all modules during final link of .ko */
 		if (strncmp(symname, "_restgpr0_", sizeof("_restgpr0_") - 1) == 0 ||
-		    strncmp(symname, "_savegpr0_", sizeof("_savegpr0_") - 1) == 0)
+		    strncmp(symname, "_savegpr0_", sizeof("_savegpr0_") - 1) == 0 ||
+		    strncmp(symname, "_restvr_", sizeof("_restvr_") - 1) == 0 ||
+		    strncmp(symname, "_savevr_", sizeof("_savevr_") - 1) == 0)
 			return 1;
 	/* Do not ignore this symbol */
 	return 0;
-- 
1.8.5.2

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
