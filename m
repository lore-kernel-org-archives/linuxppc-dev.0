Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 1CCEFDDD0D
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 13:00:26 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l2F20Nud011789
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 19:00:24 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l2F20MCm010445
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 21:00:23 -0500 (CDT)
Subject: [patch] kernel: Remove loops_per_jiffy code for 7448HPC2 platforms
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Message-Id: <1173915476.5191.1.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 15 Mar 2007 07:37:56 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove loops_per_jiffy code for 7448HPC2 platforms. They are not
necessary.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>

---
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
index 9922574..ad0514d 100644
--- a/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
+++ b/arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
@@ -73,22 +73,10 @@ int mpc7448_hpc2_exclude_device(u_char b
 
 static void __init mpc7448_hpc2_setup_arch(void)
 {
-	struct device_node *cpu;
 	struct device_node *np;
 	if (ppc_md.progress)
 		ppc_md.progress("mpc7448_hpc2_setup_arch():set_bridge", 0);
 
-	cpu = of_find_node_by_type(NULL, "cpu");
-	if (cpu != 0) {
-		const unsigned int *fp;
-
-		fp = get_property(cpu, "clock-frequency", NULL);
-		if (fp != 0)
-			loops_per_jiffy = *fp / HZ;
-		else
-			loops_per_jiffy = 50000000 / HZ;
-		of_node_put(cpu);
-	}
 	tsi108_csr_vir_base = get_vir_csrbase();
 
 	/* setup PCI host bridge */
-- 
1.4.0
