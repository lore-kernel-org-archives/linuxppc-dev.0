Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 384E41A198A
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2015 06:09:32 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Tiejun Chen <tiejun.chen@intel.com>, <kexec@lists.infradead.org>, "Tiejun
 Chen" <tiejun.chen@windriver.com>, Scott Wood <scottwood@freescale.com>
Subject: [RFC PATCH 09/17] powerpc/booke64: Fix args to copy_and_flush
Date: Sat, 18 Jul 2015 15:08:46 -0500
Message-ID: <1437250134-307-10-git-send-email-scottwood@freescale.com>
In-Reply-To: <1437250134-307-1-git-send-email-scottwood@freescale.com>
References: <1437250134-307-1-git-send-email-scottwood@freescale.com>
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

From: Tiejun Chen <tiejun.chen@windriver.com>

Convert r4/r5, not r6, to a virtual address when calling
copy_and_flush.  Otherwise, r3 is already virtual, and copy_to_flush
tries to access r3+r6, PAGE_OFFSET gets added twice.

This isn't normally seen because on book3e we normally enter with
the kernel at zero and thus skip copy_to_flush -- but it will be
needed for kexec support.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
[scottwood: split patch and rewrote changelog]
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/head_64.S | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 8b2bf0d..a1e85ca 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -474,15 +474,15 @@ __after_prom_start:
  */
 	li	r3,0			/* target addr */
 #ifdef CONFIG_PPC_BOOK3E
-	tovirt(r3,r3)			/* on booke, we already run at PAGE_OFFSET */
+	tovirt(r3,r3)		/* on booke, we already run at PAGE_OFFSET */
 #endif
 	mr.	r4,r26			/* In some cases the loader may  */
+#if defined(CONFIG_PPC_BOOK3E)
+	tovirt(r4,r4)
+#endif
 	beq	9f			/* have already put us at zero */
 	li	r6,0x100		/* Start offset, the first 0x100 */
 					/* bytes were copied earlier.	 */
-#ifdef CONFIG_PPC_BOOK3E
-	tovirt(r6,r6)			/* on booke, we already run at PAGE_OFFSET */
-#endif
 
 #ifdef CONFIG_RELOCATABLE
 /*
@@ -514,6 +514,9 @@ __after_prom_start:
 p_end:	.llong	_end - _stext
 
 4:	/* Now copy the rest of the kernel up to _end */
+#if defined(CONFIG_PPC_BOOK3E)
+	tovirt(r26,r26)
+#endif
 	addis	r5,r26,(p_end - _stext)@ha
 	ld	r5,(p_end - _stext)@l(r5)	/* get _end */
 5:	bl	copy_and_flush		/* copy the rest */
-- 
2.1.4
