Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 44E85DE033
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jul 2007 04:25:15 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6RIPAjw013385
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 11:25:10 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l6RIP93P017098
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2007 13:25:09 -0500 (CDT)
Subject: [PATCH 5/5] embedded6xx: Remove unnecessary loops_per_jiffy
	initialization code.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1185560709.8055.178.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 27 Jul 2007 13:25:09 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/platforms/embedded6xx/holly.c     |   12 ------------
 arch/powerpc/platforms/embedded6xx/prpmc2800.c |    7 -------
 2 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/holly.c b/arch/powerpc/platforms/embedded6xx/holly.c
index 6292e36..7662091 100644
--- a/arch/powerpc/platforms/embedded6xx/holly.c
+++ b/arch/powerpc/platforms/embedded6xx/holly.c
@@ -113,23 +113,11 @@ static void holly_remap_bridge(void)
 
 static void __init holly_setup_arch(void)
 {
-	struct device_node *cpu;
 	struct device_node *np;
 
 	if (ppc_md.progress)
 		ppc_md.progress("holly_setup_arch():set_bridge", 0);
 
-	cpu = of_find_node_by_type(NULL, "cpu");
-	if (cpu) {
-		const unsigned int *fp;
-
-		fp = of_get_property(cpu, "clock-frequency", NULL);
-		if (fp)
-			loops_per_jiffy = *fp / HZ;
-		else
-			loops_per_jiffy = 50000000 / HZ;
-		of_node_put(cpu);
-	}
 	tsi108_csr_vir_base = get_vir_csrbase();
 
 	/* setup PCI host bridge */
diff --git a/arch/powerpc/platforms/embedded6xx/prpmc2800.c b/arch/powerpc/platforms/embedded6xx/prpmc2800.c
index 5342095..5467564 100644
--- a/arch/powerpc/platforms/embedded6xx/prpmc2800.c
+++ b/arch/powerpc/platforms/embedded6xx/prpmc2800.c
@@ -44,7 +44,6 @@ static void __init prpmc2800_setup_arch(void)
 	struct device_node *np;
 	phys_addr_t paddr;
 	const unsigned int *reg;
-	const unsigned int *prop;
 
 	/*
 	 * ioremap mpp and gpp registers in case they are later
@@ -62,12 +61,6 @@ static void __init prpmc2800_setup_arch(void)
 	of_node_put(np);
 	mv64x60_gpp_reg_base = ioremap(paddr, reg[1]);
 
-	np = of_find_node_by_type(NULL, "cpu");
-	prop = of_get_property(np, "clock-frequency", NULL);
-	if (prop)
-		loops_per_jiffy = *prop / HZ;
-	of_node_put(np);
-
 #ifdef CONFIG_PCI
 	mv64x60_pci_init();
 #endif
-- 
1.5.0.3
