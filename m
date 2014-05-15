Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0139.outbound.protection.outlook.com [207.46.163.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 475471400D8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 May 2014 02:36:02 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc: Fix unused variable warning for epapr_has_idle
Date: Thu, 15 May 2014 11:35:35 -0500
Message-ID: <1400171735-20238-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This warning can be seen in allyesconfig, and was introduced by commit
f9eb581c63b2acce827570e105205c0789360650 "powerpc: fix build of
epapr_paravirt on 64-bit book3s".

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Sorry about the churn on this -- I did try to build allyesconfig, but I
forgot that CONFIG_PPC_DISABLE_WERROR would be enabled, plus the build
failed on the "attempt to move .org backwards" issue.
---
 arch/powerpc/kernel/epapr_paravirt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/epapr_paravirt.c b/arch/powerpc/kernel/epapr_paravirt.c
index eab2f2a..c47fed0 100644
--- a/arch/powerpc/kernel/epapr_paravirt.c
+++ b/arch/powerpc/kernel/epapr_paravirt.c
@@ -30,7 +30,7 @@ extern u32 epapr_ev_idle_start[];
 #endif
 
 bool epapr_paravirt_enabled;
-static bool epapr_has_idle;
+static bool __maybe_unused epapr_has_idle;
 
 static int __init early_init_dt_scan_epapr(unsigned long node,
 					   const char *uname,
-- 
1.9.1
