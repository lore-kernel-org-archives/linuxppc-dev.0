Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3273BDDF85
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 16:50:12 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m766o3e4000103
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 23:50:04 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m766nrIc000135
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Aug 2008 01:50:02 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH 6/6] powerpc: add 82xx platform level support to SEC engine
Date: Wed,  6 Aug 2008 15:04:45 +0800
Message-Id: <1218006285-27138-6-git-send-email-leoli@freescale.com>
In-Reply-To: <1218006285-27138-5-git-send-email-leoli@freescale.com>
References: <1218006285-27138-1-git-send-email-leoli@freescale.com>
	<1218006285-27138-2-git-send-email-leoli@freescale.com>
	<1218006285-27138-3-git-send-email-leoli@freescale.com>
	<1218006285-27138-4-git-send-email-leoli@freescale.com>
	<1218006285-27138-5-git-send-email-leoli@freescale.com>
Cc: Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Initialize base and size of SEC memory region and bus priority for SEC.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/include/asm/immap_cpm2.h     |    7 +++++--
 arch/powerpc/platforms/82xx/mpc8272_ads.c |    1 +
 arch/powerpc/platforms/82xx/pq2.c         |   19 +++++++++++++++++++
 arch/powerpc/platforms/82xx/pq2.h         |    1 +
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/immap_cpm2.h b/arch/powerpc/include/asm/immap_cpm2.h
index d4f069b..71de9d0 100644
--- a/arch/powerpc/include/asm/immap_cpm2.h
+++ b/arch/powerpc/include/asm/immap_cpm2.h
@@ -115,10 +115,13 @@ typedef struct	mem_ctlr {
 	u32	memc_immr;
 	u32	memc_pcibr0;
 	u32	memc_pcibr1;
-	u8	res10[16];
+	u32	secbr;
+	u8	res10[4];
+	u32	secmr;
+	u8	res11[4];
 	u32	memc_pcimsk0;
 	u32	memc_pcimsk1;
-	u8	res11[52];
+	u8	res12[52];
 } memctl_cpm2_t;
 
 /* System Integration Timers.
diff --git a/arch/powerpc/platforms/82xx/mpc8272_ads.c b/arch/powerpc/platforms/82xx/mpc8272_ads.c
index 69781e6..a98d97c 100644
--- a/arch/powerpc/platforms/82xx/mpc8272_ads.c
+++ b/arch/powerpc/platforms/82xx/mpc8272_ads.c
@@ -179,6 +179,7 @@ static void __init mpc8272_ads_setup_arch(void)
 
 	init_ioports();
 	pq2_init_pci();
+	pq2_init_sec();
 
 	if (ppc_md.progress)
 		ppc_md.progress("mpc8272_ads_setup_arch(), finish", 0);
diff --git a/arch/powerpc/platforms/82xx/pq2.c b/arch/powerpc/platforms/82xx/pq2.c
index 1b75902..bacb136 100644
--- a/arch/powerpc/platforms/82xx/pq2.c
+++ b/arch/powerpc/platforms/82xx/pq2.c
@@ -22,6 +22,8 @@
 #include <platforms/82xx/pq2.h>
 
 #define RMR_CSRE 0x00000001
+#define PQ2_SECMR_128K 0xfffe0000
+#define PQ2_ALRH_SEC 0x30126745
 
 void pq2_restart(char *cmd)
 {
@@ -35,6 +37,23 @@ void pq2_restart(char *cmd)
 	panic("Restart failed\n");
 }
 
+void __init pq2_init_sec(void)
+{
+	struct device_node *np = NULL;
+	struct resource res;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,talitos");
+	if (!np)
+		return;
+
+	of_address_to_resource(np, 0, &res);
+	printk(KERN_INFO "Setting SECBR and SECMR\n");
+	out_be32(&cpm2_immr->im_memctl.secbr, (u32)res.start);
+	out_be32(&cpm2_immr->im_memctl.secmr, PQ2_SECMR_128K);
+	out_be32(&cpm2_immr->im_siu_conf.siu_82xx.sc_ppc_alrh, PQ2_ALRH_SEC);
+	of_node_put(np);
+}
+
 #ifdef CONFIG_PCI
 static int pq2_pci_exclude_device(struct pci_controller *hose,
                                   u_char bus, u8 devfn)
diff --git a/arch/powerpc/platforms/82xx/pq2.h b/arch/powerpc/platforms/82xx/pq2.h
index a41f84a..98d3c3c 100644
--- a/arch/powerpc/platforms/82xx/pq2.h
+++ b/arch/powerpc/platforms/82xx/pq2.h
@@ -2,6 +2,7 @@
 #define _PQ2_H
 
 void pq2_restart(char *cmd);
+void pq2_init_sec(void);
 
 #ifdef CONFIG_PCI
 int pq2ads_pci_init_irq(void);
-- 
1.5.5.1.248.g4b17
