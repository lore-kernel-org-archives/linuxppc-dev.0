Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BBEDDDDED7
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 00:02:00 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 60C278814
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jul 2007 19:01:59 +0500 (SAMST)
Date: Thu, 26 Jul 2007 18:01:39 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] mpc832x_rdb.c: prevent using uninitialized variable
Message-ID: <20070726140139.GA5709@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If CONFIG_PCI undefined, np will be used uninitialized, thereby
find_node_by_name(np, "par_io") will fail.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index c5463c7..b16dce2 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -79,14 +79,14 @@ device_initcall(mpc83xx_spi_devices_init);
 static void __init mpc832x_rdb_setup_arch(void)
 {
 #if defined(CONFIG_PCI) || defined(CONFIG_QUICC_ENGINE)
-	struct device_node *np;
+	struct device_node *np = NULL;
 #endif
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc832x_rdb_setup_arch()", 0);
 
 #ifdef CONFIG_PCI
-	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
+	for (; (np = of_find_node_by_type(np, "pci")) != NULL;)
 		mpc83xx_add_bridge(np);
 
 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
-- 
1.5.0.6
