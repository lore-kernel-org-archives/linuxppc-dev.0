Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 1A889DE01C
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 08:25:21 +1000 (EST)
Received: from pd4mr4so.prod.shaw.ca
	(pd4mr4so-qfe3.prod.shaw.ca [10.0.141.215]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPM007BM6A0PND0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 08 Oct 2007 16:25:12 -0600 (MDT)
Received: from pn2ml8so.prod.shaw.ca ([10.0.121.152])
	by pd4mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPM002376A0KQ10@pd4mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 08 Oct 2007 16:25:12 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.133.150])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPM00KK169ZMM40@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 08 Oct 2007 16:25:12 -0600 (MDT)
Date: Mon, 08 Oct 2007 16:25:12 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 4/6] MPC52xx: Drop show_cpuinfo platform hooks from Lite5200
In-reply-to: <20071008222445.25840.6561.stgit@trillian.cg.shawcable.net>
To: galak@kernel.crashing.org, paulus@samba.org, arnd@arndb.de,
	linuxppc-dev@ozlabs.org
Message-id: <20071008222509.25840.77238.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071008222445.25840.6561.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

This hook doesn't really add any new information.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/52xx/lite5200.c |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index 48fc662..6469813 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -138,20 +138,6 @@ static void __init lite5200_setup_arch(void)
 #endif
 }
 
-static void lite5200_show_cpuinfo(struct seq_file *m)
-{
-	struct device_node* np = of_find_all_nodes(NULL);
-	const char *model = NULL;
-
-	if (np)
-		model = of_get_property(np, "model", NULL);
-
-	seq_printf(m, "vendor\t\t:	Freescale Semiconductor\n");
-	seq_printf(m, "machine\t\t:	%s\n", model ? model : "unknown");
-
-	of_node_put(np);
-}
-
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
@@ -175,6 +161,5 @@ define_machine(lite5200) {
 	.init		= mpc52xx_declare_of_platform_devices,
 	.init_IRQ 	= mpc52xx_init_irq,
 	.get_irq 	= mpc52xx_get_irq,
-	.show_cpuinfo	= lite5200_show_cpuinfo,
 	.calibrate_decr	= generic_calibrate_decr,
 };
