Return-Path: <paul.gortmaker@windriver.com>
Received: from yow-pgortmak-d1.corp.ad.wrs.com (unknown [128.224.252.2])
	by ozlabs.org (Postfix) with ESMTP id EC523DE099
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 08:45:59 +1000 (EST)
Date: Tue, 15 Apr 2008 18:46:30 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] 86xx: mark functions static, other minor cleanups
Message-ID: <20080415224628.GA21663@windriver.com>
References: <1207933186-20555-1-git-send-email-paul.gortmaker@windriver.com>
	<4804D39C.9000309@freescale.com> <4804D7C4.8060805@windriver.com>
	<4804D867.4070205@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4804D867.4070205@freescale.com>
Cc: linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message: Re: [PATCH] 86xx: mark functions static, other minor cleanups
on 15/04/2008 Timur Tabi wrote:

> Paul Gortmaker wrote:
> 
> > Valid point.  Is there a precedent here -- like a printk indicating
> > that the old ID matched, to let the user know?
> 
> Not really, but a pr_warning() would be nice.

Done.

I've also removed the sbc8641 content from this patch, and rolled it
into the resend of those board specific patches.  This is now just for
incorporating that same feedback into existing boards.

Thanks,
Paul.
---

 From aa2d1dd871c7eb440b3947cf8952d28249acf218 Mon Sep 17 00:00:00 2001
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Fri, 11 Apr 2008 12:51:04 -0400
Subject: [PATCH] 86xx: mark functions static, other minor cleanups

Cleanups as suggested by Stephen Rothwell and Dale Farnsworth, which
incudes marking a bunch of functions static and add a vendor prefix to
the compat node check for uniqueness.  We match on the old compat node
ID for one version and warn accordingly, so as to not plunge people
into silent boot death, as suggested by Timur Tabi.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts     |    2 +-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    4 ++--
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   14 ++++++++++----
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 79385bc..7f9b999 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -13,7 +13,7 @@
 
 / {
 	model = "MPC8641HPCN";
-	compatible = "mpc86xx";
+	compatible = "fsl,mpc8641hpcn";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index 0b07485..18b8ebe 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -52,7 +52,7 @@ static int __init mpc8610_declare_of_platform_devices(void)
 }
 machine_device_initcall(mpc86xx_hpcd, mpc8610_declare_of_platform_devices);
 
-void __init
+static void __init
 mpc86xx_hpcd_init_irq(void)
 {
 	struct mpic *mpic1;
@@ -200,7 +200,7 @@ static int __init mpc86xx_hpcd_probe(void)
 	return 0;
 }
 
-long __init
+static long __init
 mpc86xx_time_init(void)
 {
 	unsigned int temp;
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index cfbe8c5..9d32223 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -55,7 +55,7 @@ static void mpc86xx_8259_cascade(unsigned int irq, struct irq_desc *desc)
 }
 #endif	/* CONFIG_PCI */
 
-void __init
+static void __init
 mpc86xx_hpcn_init_irq(void)
 {
 	struct mpic *mpic1;
@@ -162,7 +162,7 @@ mpc86xx_hpcn_setup_arch(void)
 }
 
 
-void
+static void
 mpc86xx_hpcn_show_cpuinfo(struct seq_file *m)
 {
 	struct device_node *root;
@@ -190,13 +190,19 @@ static int __init mpc86xx_hpcn_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (of_flat_dt_is_compatible(root, "mpc86xx"))
+	/* Delete this in 2.6.27 */
+	if (of_flat_dt_is_compatible(root, "mpc86xx")) {
+		pr_warning("WARNING: your dts/dtb is old. You must update before the next kernel release\n");
+		return 1;
+	}
+
+	if (of_flat_dt_is_compatible(root, "fsl,mpc8641hpcn"))
 		return 1;	/* Looks good */
 
 	return 0;
 }
 
-long __init
+static long __init
 mpc86xx_time_init(void)
 {
 	unsigned int temp;
-- 
1.5.4.3
