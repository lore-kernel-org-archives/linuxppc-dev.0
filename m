Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0212.outbound.protection.outlook.com [207.46.163.212])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BC1B814007D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 May 2014 01:31:55 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc: fix build of epapr_paravirt on 64-bit book3s
Date: Mon, 12 May 2014 10:31:22 -0500
Message-ID: <1399908682-28825-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes an allyesconfig build break introduced by commit
7762b1ed7aaee223230793fcee80672e2e3aa7a8 "powerpc: move epapr paravirt
init of power_save to an initcall".

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Stuart Yoder <stuart.yoder@freescale.com>
---
 arch/powerpc/kernel/epapr_paravirt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/epapr_paravirt.c b/arch/powerpc/kernel/epapr_paravirt.c
index 8a7a62c..eab2f2a 100644
--- a/arch/powerpc/kernel/epapr_paravirt.c
+++ b/arch/powerpc/kernel/epapr_paravirt.c
@@ -73,8 +73,10 @@ int __init epapr_paravirt_early_init(void)
 
 static int __init epapr_idle_init(void)
 {
+#if !defined(CONFIG_64BIT) || defined(CONFIG_PPC_BOOK3E_64)
 	if (epapr_has_idle)
 		ppc_md.power_save = epapr_ev_idle;
+#endif
 
 	return 0;
 }
-- 
1.9.1
