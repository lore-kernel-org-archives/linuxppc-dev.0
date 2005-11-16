Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3C5C368734
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2005 03:38:38 +1100 (EST)
Date: Wed, 16 Nov 2005 17:38:32 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Message-ID: <20051116163832.GA17120@suse.de>
References: <20051022213206.GB6097@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20051022213206.GB6097@suse.de>
Subject: Re: [PATCH] pmu_register_sleep_notifier needs ADB_PMU
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sat, Oct 22, Olaf Hering wrote:

> 
> a simple patch for a pegsos user:
> https://bugzilla.novell.com/show_bug.cgi?id=119606

Still not fully fixed:


drivers/video/aty/radeon_pm.c: In function `radeonfb_pm_init':
drivers/video/aty/radeon_pm.c:2769: warning: implicit declaration of function `pmac_call_feature'
drivers/video/aty/radeon_pm.c:2769: error: `PMAC_FTR_DEVICE_CAN_WAKE' undeclared (first use in this function)
drivers/video/aty/radeon_pm.c:2769: error: (Each undeclared identifier is reported only once
drivers/video/aty/radeon_pm.c:2769: error: for each function it appears in.)
drivers/video/aty/radeon_pm.c:2770: warning: implicit declaration of function `pmac_set_early_video_resume'

 drivers/video/aty/radeon_pm.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6.15-rc1-olh/drivers/video/aty/radeon_pm.c
===================================================================
--- linux-2.6.15-rc1-olh.orig/drivers/video/aty/radeon_pm.c
+++ linux-2.6.15-rc1-olh/drivers/video/aty/radeon_pm.c
@@ -1321,7 +1321,7 @@ static void radeon_pm_full_reset_sdram(s
 	mdelay( 15);
 }
 
-#ifdef CONFIG_PPC_OF
+#ifdef CONFIG_PPC_PMAC
 
 static void radeon_pm_reset_pad_ctlr_strength(struct radeonfb_info *rinfo)
 {
@@ -2401,7 +2401,7 @@ static void radeon_reinitialize_QW(struc
 }
 #endif /* 0 */
 
-#endif /* CONFIG_PPC_OF */
+#endif /* CONFIG_PPC_PMAC */
 
 static void radeon_set_suspend(struct radeonfb_info *rinfo, int suspend)
 {
@@ -2700,7 +2700,7 @@ int radeonfb_pci_resume(struct pci_dev *
 	return rc;
 }
 
-#ifdef CONFIG_PPC_OF
+#ifdef CONFIG_PPC_PMAC
 static void radeonfb_early_resume(void *data)
 {
         struct radeonfb_info *rinfo = data;
@@ -2734,7 +2734,7 @@ void radeonfb_pm_init(struct radeonfb_in
 	 * BIOS does tho. Right now, all this PM stuff is pmac-only for that
 	 * reason. --BenH
 	 */
-#if defined(CONFIG_PM) && defined(CONFIG_PPC_OF)
+#if defined(CONFIG_PM) && defined(CONFIG_PPC_PMAC)
 	if (_machine == _MACH_Pmac && rinfo->of_node) {
 		if (rinfo->is_mobility && rinfo->pm_reg &&
 		    rinfo->family <= CHIP_FAMILY_RV250)
@@ -2778,12 +2778,12 @@ void radeonfb_pm_init(struct radeonfb_in
 		OUTREG(TV_DAC_CNTL, INREG(TV_DAC_CNTL) | 0x07000000);
 #endif
 	}
-#endif /* defined(CONFIG_PM) && defined(CONFIG_PPC_OF) */
+#endif /* defined(CONFIG_PM) && defined(CONFIG_PPC_PMAC) */
 }
 
 void radeonfb_pm_exit(struct radeonfb_info *rinfo)
 {
-#if defined(CONFIG_PM) && defined(CONFIG_PPC_OF)
+#if defined(CONFIG_PM) && defined(CONFIG_PPC_PMAC)
 	if (rinfo->pm_mode != radeon_pm_none)
 		pmac_set_early_video_resume(NULL, NULL);
 #endif

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
