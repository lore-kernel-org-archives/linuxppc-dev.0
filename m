Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D86BE1A1013
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 20:27:18 +1000 (AEST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E0AD7140DC0
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Jul 2015 20:27:17 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 6 Jul 2015 15:57:15 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 01B54E004C
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Jul 2015 16:00:57 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t66AQTD530343230
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Jul 2015 15:57:08 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t66APpmb027757
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Jul 2015 15:55:51 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org
Subject: [PATCH 2/2] powerpc/signal: Add helper function to fetch quad word
 aligned pointer
Date: Mon,  6 Jul 2015 15:55:34 +0530
Message-Id: <1436178334-15496-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1436178334-15496-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1436178334-15496-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds one helper function 'vmx_reserve_addr' which computes
quad word aligned pointer for vmx_reserve array element in sigcontext
structure making the code more readable.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/signal_64.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index c7c24d2..e8762f5 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -73,6 +73,12 @@ static const char fmt32[] = KERN_INFO \
 static const char fmt64[] = KERN_INFO \
 	"%s[%d]: bad frame in %s: %016lx nip %016lx lr %016lx\n";
 
+static elf_vrreg_t __user *vmx_reserve_addr(struct sigcontext __user *sc)
+{
+		return (elf_vrreg_t __user *)
+			(((unsigned long)sc->vmx_reserve + 15) & ~0xful);
+}
+
 /*
  * Set up the sigcontext for the signal frame.
  */
@@ -90,7 +96,7 @@ static long setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs,
 	 * v_regs pointer or not
 	 */
 #ifdef CONFIG_ALTIVEC
-	elf_vrreg_t __user *v_regs = (elf_vrreg_t __user *)(((unsigned long)sc->vmx_reserve + 15) & ~0xful);
+	elf_vrreg_t __user *v_regs = vmx_reserve_addr(sc);
 #endif
 	unsigned long msr = regs->msr;
 	long err = 0;
@@ -181,10 +187,8 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 	 * v_regs pointer or not.
 	 */
 #ifdef CONFIG_ALTIVEC
-	elf_vrreg_t __user *v_regs = (elf_vrreg_t __user *)
-		(((unsigned long)sc->vmx_reserve + 15) & ~0xful);
-	elf_vrreg_t __user *tm_v_regs = (elf_vrreg_t __user *)
-		(((unsigned long)tm_sc->vmx_reserve + 15) & ~0xful);
+	elf_vrreg_t __user *v_regs = vmx_reserve_addr(sc);
+	elf_vrreg_t __user *tm_v_regs = vmx_reserve_addr(tm_sc);
 #endif
 	unsigned long msr = regs->msr;
 	long err = 0;
-- 
2.1.0
