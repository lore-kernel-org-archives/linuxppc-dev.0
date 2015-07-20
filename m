Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406D51A09AE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 12:59:37 +1000 (AEST)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1082114027F
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Jul 2015 12:59:37 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 20 Jul 2015 12:59:36 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 8A13D2BB0051
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Jul 2015 12:59:34 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6K2xMC155443678
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Jul 2015 12:59:31 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6K2x11g021050
 for <linuxppc-dev@ozlabs.org>; Mon, 20 Jul 2015 12:59:01 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, mpe@ellerman.id.au
Subject: [PATCH V2] powerpc/signal: Add helper function to fetch quad word
 aligned pointer
Date: Mon, 20 Jul 2015 08:28:43 +0530
Message-Id: <1437361123-18615-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds one helper function 'sigcontext_vmx_regs' which computes
quad word aligned pointer for 'vmx_reserve' array element in sigcontext
structure making the code more readable.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
- Fixed some indentation problems
- Changed function name from 'vmx_reserve_addr' to 'sigcontext_vmx_regs'
- Added some documentation before the function

 arch/powerpc/kernel/signal_64.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index c7c24d2..bb9c939 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -74,6 +74,16 @@ static const char fmt64[] = KERN_INFO \
 	"%s[%d]: bad frame in %s: %016lx nip %016lx lr %016lx\n";
 
 /*
+ * This computes quad word aligned pointer for 'vmx_reserve' array element
+ * which is used primarily in assigning to the preceding pointer 'v_regs'
+ * in sigcontext structure.
+ */
+static elf_vrreg_t __user *sigcontext_vmx_regs(struct sigcontext __user *sc)
+{
+	return (elf_vrreg_t __user *) (((unsigned long)sc->vmx_reserve + 15) & ~0xful);
+}
+
+/*
  * Set up the sigcontext for the signal frame.
  */
 
@@ -90,7 +100,7 @@ static long setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs,
 	 * v_regs pointer or not
 	 */
 #ifdef CONFIG_ALTIVEC
-	elf_vrreg_t __user *v_regs = (elf_vrreg_t __user *)(((unsigned long)sc->vmx_reserve + 15) & ~0xful);
+	elf_vrreg_t __user *v_regs = sigcontext_vmx_regs(sc);
 #endif
 	unsigned long msr = regs->msr;
 	long err = 0;
@@ -181,10 +191,8 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 	 * v_regs pointer or not.
 	 */
 #ifdef CONFIG_ALTIVEC
-	elf_vrreg_t __user *v_regs = (elf_vrreg_t __user *)
-		(((unsigned long)sc->vmx_reserve + 15) & ~0xful);
-	elf_vrreg_t __user *tm_v_regs = (elf_vrreg_t __user *)
-		(((unsigned long)tm_sc->vmx_reserve + 15) & ~0xful);
+	elf_vrreg_t __user *v_regs = sigcontext_vmx_regs(sc);
+	elf_vrreg_t __user *tm_v_regs = sigcontext_vmx_regs(tm_sc);
 #endif
 	unsigned long msr = regs->msr;
 	long err = 0;
-- 
2.1.0
