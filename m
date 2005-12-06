Return-Path: <rsushko@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 5CF7C68863
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Dec 2005 23:49:55 +1100 (EST)
From: "Ruslan V. Sushko" <rsushko@ru.mvista.com>
To: rollandd@cisco.com
Content-Type: multipart/mixed; boundary="=-dxVbsD7eQoB6bkkxM+I7"
Date: Tue, 06 Dec 2005 15:49:51 +0300
Message-Id: <1133873391.16347.42.camel@mephisto.spb.rtsoft.ru>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH 2/5] ppc32: verbose error checking for Yucca PCIE
	initialization
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-dxVbsD7eQoB6bkkxM+I7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> > +
>  > +	attempts = 10;
>  >  	switch (port) {
>  >  	case 0:
>  > -		if (!(SDR_READ(PESDR0_RCSSTS) & (1 << 16)))
>  > -			printk(KERN_WARNING "PCIE0: VC0 not active\n");
>  > +		while(!(SDR_READ(PESDR0_RCSSTS) & (1 << 16))) {
>  > +			if (!(attempts--)) {
>  > +				printk(KERN_WARNING "PCIE0: VC0 not active\n");
>  > +				return -1;
>  > +			}
>  > +			mdelay(1000);
>  > +		}
>  >  		SDR_WRITE(PESDR0_RCSSET, SDR_READ(PESDR0_RCSSET) | 1 << 20);
> 
> what lead you to add 10 tries here?  Did this fix an issue you saw
> with a device?

I haven't saw any error but this is potential issue because this flag
asserts only then PCI Express port initialization is completed. I guess
the initialization sequences assumes time using. Therefore the error may
appears in future revision of the boards if Core clock will grow up.
Nevertheless I do not know the time which is necessary for completeness,
so I add this just to be safe.

Signed-off-by: Ruslan V. Sushko <rsushko@ru.mvista.com>

--=-dxVbsD7eQoB6bkkxM+I7
Content-Disposition: attachment; filename=yucca_pcie_err_chk.patch
Content-Type: text/x-patch; name=yucca_pcie_err_chk.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit



This patch adds verbose error checking for Yucca PCIE initialization

---
commit 18b959b9ab80f8cb2fa1eff0a68cca3b5aa2f642
tree 632d445c219c2a3ff1d56023485efe23e7fd196d
parent 27304e1086e96f8110626096a75cf4783a5512bb
author Ruslan V. Sushko <rsushko@ru.mvista.com> Tue, 06 Dec 2005 12:56:36 +0300
committer Ruslan V. Sushko <rsushko@ru.mvista.com> Tue, 06 Dec 2005 12:56:36 +0300

 arch/ppc/syslib/ppc440spe_pcie.c |   74 +++++++++++++++++++++++++-------------
 1 files changed, 49 insertions(+), 25 deletions(-)

diff --git a/arch/ppc/syslib/ppc440spe_pcie.c b/arch/ppc/syslib/ppc440spe_pcie.c
--- a/arch/ppc/syslib/ppc440spe_pcie.c
+++ b/arch/ppc/syslib/ppc440spe_pcie.c
@@ -91,9 +91,10 @@ enum {
 	LNKW_X8			= 0x8
 };
 
-static void check_error(void)
+static int check_error(void)
 {
 	u32 valPE0, valPE1, valPE2;
+	int err = 0;
 
 	/* SDR0_PEGPLLLCT1 reset */
 	if (!(valPE0 = SDR_READ(PESDR0_PLLLCT1) & 0x01000000)) {
@@ -109,6 +110,7 @@ static void check_error(void)
 	     !(valPE1 & 0x01000000) ||
 	     !(valPE2 & 0x01000000)) {
 		printk(KERN_INFO "PCIE:  SDR0_PExRCSSET rstgu error\n");
+		err = -1;
 	}
 
 	/* SDR0_PExRCSSET rstdl */
@@ -116,6 +118,7 @@ static void check_error(void)
 	     !(valPE1 & 0x00010000) ||
 	     !(valPE2 & 0x00010000)) {
 		printk(KERN_INFO "PCIE:  SDR0_PExRCSSET rstdl error\n");
+		err = -1;
 	}
 
 	/* SDR0_PExRCSSET rstpyn */
@@ -123,6 +126,7 @@ static void check_error(void)
 	     (valPE1 & 0x00001000) ||
 	     (valPE2 & 0x00001000)) {
 		printk(KERN_INFO "PCIE:  SDR0_PExRCSSET rstpyn error\n");
+		err = -1;
 	}
 
 	/* SDR0_PExRCSSET hldplb */
@@ -130,6 +134,7 @@ static void check_error(void)
 	     (valPE1 & 0x10000000) ||
 	     (valPE2 & 0x10000000)) {
 		printk(KERN_INFO "PCIE:  SDR0_PExRCSSET hldplb error\n");
+		err = -1;
 	}
 
 	/* SDR0_PExRCSSET rdy */
@@ -137,6 +142,7 @@ static void check_error(void)
 	     (valPE1 & 0x00100000) ||
 	     (valPE2 & 0x00100000)) {
 		printk(KERN_INFO "PCIE:  SDR0_PExRCSSET rdy error\n");
+		err = -1;
 	}
 
 	/* SDR0_PExRCSSET shutdown */
@@ -144,7 +150,9 @@ static void check_error(void)
 	     (valPE1 & 0x00000100) ||
 	     (valPE2 & 0x00000100)) {
 		printk(KERN_INFO "PCIE:  SDR0_PExRCSSET shutdown error\n");
+		err = -1;
 	}
+	return err;
 }
 
 /*
@@ -155,17 +163,20 @@ int ppc440spe_init_pcie(void)
 	/* Set PLL clock receiver to LVPECL */
 	SDR_WRITE(PESDR0_PLLLCT1, SDR_READ(PESDR0_PLLLCT1) | 1 << 28);
 
-	check_error();
+	if (check_error())
+		return -1;
 
-	printk(KERN_INFO "PCIE initialization OK\n");
-
-	if (!(SDR_READ(PESDR0_PLLLCT2) & 0x10000))
-		printk(KERN_INFO "PESDR_PLLCT2 resistance calibration failed (0x%08x)\n",
+	if (!(SDR_READ(PESDR0_PLLLCT2) & 0x10000)) {
+		printk(KERN_INFO "PCIE: PESDR_PLLCT2 resistance calibration "
+				"failed (0x%08x)\n",
 		       SDR_READ(PESDR0_PLLLCT2));
+		return -1;
+	}
 
 	/* De-assert reset of PCIe PLL, wait for lock */
 	SDR_WRITE(PESDR0_PLLLCT1, SDR_READ(PESDR0_PLLLCT1) & ~(1 << 24));
 	udelay(3);
+	printk(KERN_INFO "PCIE initialization OK\n");
 
 	return 0;
 }
@@ -174,14 +185,13 @@ int ppc440spe_init_pcie_rootport(int por
 {
 	static int core_init;
 	void __iomem *utl_base;
+	int attempts;
 	u32 val = 0;
-	int i;
 
 	if (!core_init) {
+		if(ppc440spe_init_pcie())
+			return -1;
 		++core_init;
-		i = ppc440spe_init_pcie();
-		if (i)
-			return i;
 	}
 
 	/*
@@ -252,15 +262,10 @@ int ppc440spe_init_pcie_rootport(int por
 	case 2: val = SDR_READ(PESDR2_RCSSTS); break;
 	}
 
-	if (!(val & (1 << 20)))
-		printk(KERN_INFO "PCIE%d: PGRST inactive\n", port);
-	else
-		printk(KERN_WARNING "PGRST for PCIE%d failed %08x\n", port, val);
-
-	switch (port) {
-	case 0: printk(KERN_INFO "PCIE0: LOOP %08x\n", SDR_READ(PESDR0_LOOP)); break;
-	case 1: printk(KERN_INFO "PCIE1: LOOP %08x\n", SDR_READ(PESDR1_LOOP)); break;
-	case 2: printk(KERN_INFO "PCIE2: LOOP %08x\n", SDR_READ(PESDR2_LOOP)); break;
+	if (val & (1 << 20)) {
+		printk(KERN_WARNING "PGRST for PCIE%d failed %08x\n",
+				port, val);
+		return -1;
 	}
 
 	/*
@@ -333,20 +338,39 @@ int ppc440spe_init_pcie_rootport(int por
 	/*
 	 * Check for VC0 active and assert RDY.
 	 */
+
+	attempts = 10;
 	switch (port) {
 	case 0:
-		if (!(SDR_READ(PESDR0_RCSSTS) & (1 << 16)))
-			printk(KERN_WARNING "PCIE0: VC0 not active\n");
+		while(!(SDR_READ(PESDR0_RCSSTS) & (1 << 16))) {
+			if (!(attempts--)) {
+				printk(KERN_WARNING "PCIE0: VC0 not active\n");
+				return -1;
+			}
+			mdelay(1000);
+		}
 		SDR_WRITE(PESDR0_RCSSET, SDR_READ(PESDR0_RCSSET) | 1 << 20);
 		break;
 	case 1:
-		if (!(SDR_READ(PESDR1_RCSSTS) & (1 << 16)))
-			printk(KERN_WARNING "PCIE0: VC0 not active\n");
+		while(!(SDR_READ(PESDR1_RCSSTS) & (1 << 16))) {
+			if (!(attempts--)) {
+				printk(KERN_WARNING "PCIE1: VC0 not active\n");
+				return -1;
+			}
+			mdelay(1000);
+		}
+
 		SDR_WRITE(PESDR1_RCSSET, SDR_READ(PESDR1_RCSSET) | 1 << 20);
 		break;
 	case 2:
-		if (!(SDR_READ(PESDR2_RCSSTS) & (1 << 16)))
-			printk(KERN_WARNING "PCIE0: VC0 not active\n");
+		while(!(SDR_READ(PESDR2_RCSSTS) & (1 << 16))) {
+			if (!(attempts--)) {
+				printk(KERN_WARNING "PCIE2: VC0 not active\n");
+				return -1;
+			}
+			mdelay(1000);
+		}
+
 		SDR_WRITE(PESDR2_RCSSET, SDR_READ(PESDR2_RCSSET) | 1 << 20);
 		break;
 	}




--=-dxVbsD7eQoB6bkkxM+I7--
