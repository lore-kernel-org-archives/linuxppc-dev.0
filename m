Return-Path: <stuart.yoder@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0142.outbound.protection.outlook.com [207.46.163.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 22F651400F6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 May 2014 09:23:23 +1000 (EST)
From: Stuart Yoder <stuart.yoder@freescale.com>
To: <benh@kernel.crashing.org>, <scottwood@freescale.com>
Subject: [PATCH][v3] powerpc: move epapr paravirt init of power_save to an
 initcall
Date: Wed, 30 Apr 2014 18:23:12 -0500
Message-ID: <1398900192-2646-1-git-send-email-stuart.yoder@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, agraf@suse.de,
 Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stuart Yoder <stuart.yoder@freescale.com>

some restructuring of epapr paravirt init resulted in
ppc_md.power_save being set, and then overwritten to
NULL during machine_init.  This patch splits the
initialization of ppc_md.power_save out into a postcore
init call.

Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---
-v3
   -changed approach slightly, set flag in the dt scanning
    code and just look at that flag in the initcall


 arch/powerpc/kernel/epapr_paravirt.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/epapr_paravirt.c b/arch/powerpc/kernel/epapr_paravirt.c
index 7898be9..6596cd7 100644
--- a/arch/powerpc/kernel/epapr_paravirt.c
+++ b/arch/powerpc/kernel/epapr_paravirt.c
@@ -30,6 +30,7 @@ extern u32 epapr_ev_idle_start[];
 #endif
 
 bool epapr_paravirt_enabled;
+bool epapr_has_idle;
 
 static int __init early_init_dt_scan_epapr(unsigned long node,
 					   const char *uname,
@@ -55,7 +56,7 @@ static int __init early_init_dt_scan_epapr(unsigned long node,
 
 #if !defined(CONFIG_64BIT) || defined(CONFIG_PPC_BOOK3E_64)
 	if (of_get_flat_dt_prop(node, "has-idle", NULL))
-		ppc_md.power_save = epapr_ev_idle;
+		epapr_has_idle = true;
 #endif
 
 	epapr_paravirt_enabled = true;
@@ -70,3 +71,12 @@ int __init epapr_paravirt_early_init(void)
 	return 0;
 }
 
+static int __init epapr_idle_init(void)
+{
+	if (epapr_has_idle)
+		ppc_md.power_save = epapr_ev_idle;
+
+	return 0;
+}
+
+postcore_initcall(epapr_idle_init);
-- 
1.7.9.7
