Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4BCCDDED81
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:35:36 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6I1ZUdK019047
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:35:31 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1ZUSt001456
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:30 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I1AnSo007902
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:10:49 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 2A39CAEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:35:29 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1ZTs9015350
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:35:29 -0500
Date: Tue, 17 Jul 2007 20:35:29 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 23/61] Rename mpc82xx_ads_show_cpuinfo to m82xx_show_cpuinfo.
Message-ID: <20070718013528.GU15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Vendor and machine are removed; any such information should go in
ppc_md.name.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/82xx/mpc8272ads.c |    4 ++--
 arch/powerpc/platforms/82xx/mpc82xx.c    |    4 +---
 arch/powerpc/platforms/82xx/pq2ads.h     |    2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/mpc8272ads.c b/arch/powerpc/platforms/82xx/mpc8272ads.c
index da20832..1945522 100644
--- a/arch/powerpc/platforms/82xx/mpc8272ads.c
+++ b/arch/powerpc/platforms/82xx/mpc8272ads.c
@@ -629,11 +629,11 @@ static void m82xx_halt(void)
 
 define_machine(mpc82xx_ads)
 {
-	.name = "MPC82xx ADS",
+	.name = "Freescale MPC8272ADS",
 	.probe = mpc82xx_ads_probe,
 	.setup_arch =    mpc82xx_ads_setup_arch,
 	.init_IRQ =    mpc82xx_ads_pic_init,
-	.show_cpuinfo =    mpc82xx_ads_show_cpuinfo,
+	.show_cpuinfo =    m82xx_show_cpuinfo,
 	.get_irq =    cpm2_get_irq,
 	.calibrate_decr =    m82xx_calibrate_decr,
 	.restart = m82xx_restart,.halt = m82xx_halt,
diff --git a/arch/powerpc/platforms/82xx/mpc82xx.c b/arch/powerpc/platforms/82xx/mpc82xx.c
index cc9900d..a2a9c8d 100644
--- a/arch/powerpc/platforms/82xx/mpc82xx.c
+++ b/arch/powerpc/platforms/82xx/mpc82xx.c
@@ -88,7 +88,7 @@ void __init m82xx_calibrate_decr(void)
 				"(not found)\n");
 }
 
-void mpc82xx_ads_show_cpuinfo(struct seq_file *m)
+void m82xx_show_cpuinfo(struct seq_file *m)
 {
 	uint pvid, svid, phid1;
 	uint memsize = total_memory;
@@ -96,8 +96,6 @@ void mpc82xx_ads_show_cpuinfo(struct seq_file *m)
 	pvid = mfspr(SPRN_PVR);
 	svid = mfspr(SPRN_SVR);
 
-	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
-	seq_printf(m, "Machine\t\t: %s\n", CPUINFO_MACHINE);
 	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
 	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
 
diff --git a/arch/powerpc/platforms/82xx/pq2ads.h b/arch/powerpc/platforms/82xx/pq2ads.h
index 5b5cca6..4802292 100644
--- a/arch/powerpc/platforms/82xx/pq2ads.h
+++ b/arch/powerpc/platforms/82xx/pq2ads.h
@@ -59,7 +59,7 @@
 #define SIU_INT_SCC4		((uint)0x2b+CPM_IRQ_OFFSET)
 
 void m82xx_pci_init_irq(void);
-void mpc82xx_ads_show_cpuinfo(struct seq_file*);
+void m82xx_show_cpuinfo(struct seq_file *);
 void m82xx_calibrate_decr(void);
 
 #endif /* __MACH_ADS8260_DEFS */
-- 
1.5.0.3
