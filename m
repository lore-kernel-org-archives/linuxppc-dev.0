Return-Path: <oohall@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfvY73PX0zDw3P
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Dec 2016 13:35:07 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id 3so8043106pgd.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 18:35:07 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org,
	Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH] powerpc/time: clear LPCR.LD when unneeded
Date: Fri, 16 Dec 2016 13:34:54 +1100
Message-Id: <1481855694-17230-1-git-send-email-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the kernel will enable LD mode at boot when required. However,
when using kexec the second kernel may not want to have the LD enabled.
This patch ensures the second kernel will explicitly clear the LD flag
when not required by the current kernel.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/kernel/time.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index be9751f1cb2a..816700e8a475 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -925,18 +925,16 @@ static void register_decrementer_clockevent(int cpu)
 
 static void enable_large_decrementer(void)
 {
-	if (!cpu_has_feature(CPU_FTR_ARCH_300))
-		return;
-
-	if (decrementer_max <= DECREMENTER_DEFAULT_MAX)
-		return;
-
 	/*
 	 * If we're running as the hypervisor we need to enable the LD manually
 	 * otherwise firmware should have done it for us.
 	 */
-	if (cpu_has_feature(CPU_FTR_HVMODE))
+	if (decrementer_max > DECREMENTER_DEFAULT_MAX
+	    && cpu_has_feature(CPU_FTR_HVMODE)
+	    && cpu_has_feature(CPU_FTR_ARCH_300))
 		mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) | LPCR_LD);
+	else
+		mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) & ~LPCR_LD);
 }
 
 static void __init set_decrementer_max(void)
-- 
2.7.4
