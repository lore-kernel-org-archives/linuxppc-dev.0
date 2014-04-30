Return-Path: <stuart.yoder@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0244.outbound.protection.outlook.com [207.46.163.244])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AF4D71400A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 May 2014 06:20:29 +1000 (EST)
From: Stuart Yoder <stuart.yoder@freescale.com>
To: <benh@kernel.crashing.org>, <scottwood@freescale.com>
Subject: [PATCH][v2] powerpc: move epapr paravirt init of power_save to an
 initcall
Date: Wed, 30 Apr 2014 15:20:09 -0500
Message-ID: <1398889209-10350-1-git-send-email-stuart.yoder@freescale.com>
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

-v2: don't iterate over the entire DT, just look at
 the hypervisor node

 arch/powerpc/kernel/epapr_paravirt.c |   25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/epapr_paravirt.c b/arch/powerpc/kernel/epapr_paravirt.c
index 7898be9..a01df5e 100644
--- a/arch/powerpc/kernel/epapr_paravirt.c
+++ b/arch/powerpc/kernel/epapr_paravirt.c
@@ -53,11 +53,6 @@ static int __init early_init_dt_scan_epapr(unsigned long node,
 #endif
 	}
 
-#if !defined(CONFIG_64BIT) || defined(CONFIG_PPC_BOOK3E_64)
-	if (of_get_flat_dt_prop(node, "has-idle", NULL))
-		ppc_md.power_save = epapr_ev_idle;
-#endif
-
 	epapr_paravirt_enabled = true;
 
 	return 1;
@@ -70,3 +65,23 @@ int __init epapr_paravirt_early_init(void)
 	return 0;
 }
 
+static int __init epapr_idle_init(void)
+{
+	struct device_node *node;
+
+	if (!epapr_paravirt_enabled)
+		return 0;
+
+	node = of_find_node_by_path("/hypervisor");
+	if (!node)
+		return -ENODEV;
+
+#if !defined(CONFIG_64BIT) || defined(CONFIG_PPC_BOOK3E_64)
+	if (of_get_property(node, "has-idle", NULL))
+		ppc_md.power_save = epapr_ev_idle;
+#endif
+
+	return 0;
+}
+
+postcore_initcall(epapr_idle_init);
-- 
1.7.9.7
