Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19AEA1A1986
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2015 06:09:30 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Tiejun Chen <tiejun.chen@intel.com>, <kexec@lists.infradead.org>, "Tiejun
 Chen" <tiejun.chen@windriver.com>, Scott Wood <scottwood@freescale.com>
Subject: [RFC PATCH 08/17] powerpc/book3e-64: rename interrupt_end_book3e with
 __end_interrupts
Date: Sat, 18 Jul 2015 15:08:45 -0500
Message-ID: <1437250134-307-9-git-send-email-scottwood@freescale.com>
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

Rename 'interrupt_end_book3e' to '__end_interrupts' so that the symbol
can be used by both book3s and book3e.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
[scottwood: edit changelog]
Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kernel/exceptions-64e.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index f3bd5e7..9d4a006 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -542,8 +542,8 @@ interrupt_base_book3e:					/* fake trap */
 	EXCEPTION_STUB(0x320, ehpriv)
 	EXCEPTION_STUB(0x340, lrat_error)
 
-	.globl interrupt_end_book3e
-interrupt_end_book3e:
+	.globl __end_interrupts
+__end_interrupts:
 
 /* Critical Input Interrupt */
 	START_EXCEPTION(critical_input);
@@ -736,7 +736,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	beq+	1f
 
 	LOAD_REG_IMMEDIATE(r14,interrupt_base_book3e)
-	LOAD_REG_IMMEDIATE(r15,interrupt_end_book3e)
+	LOAD_REG_IMMEDIATE(r15,__end_interrupts)
 	cmpld	cr0,r10,r14
 	cmpld	cr1,r10,r15
 	blt+	cr0,1f
@@ -800,7 +800,7 @@ kernel_dbg_exc:
 	beq+	1f
 
 	LOAD_REG_IMMEDIATE(r14,interrupt_base_book3e)
-	LOAD_REG_IMMEDIATE(r15,interrupt_end_book3e)
+	LOAD_REG_IMMEDIATE(r15,__end_interrupts)
 	cmpld	cr0,r10,r14
 	cmpld	cr1,r10,r15
 	blt+	cr0,1f
-- 
2.1.4
