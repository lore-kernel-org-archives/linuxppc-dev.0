Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 45B2CDDF63
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 19:56:25 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l9A9uIug026923
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 02:56:19 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9A9uFR7029638
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 04:56:17 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 2/9] ipic: add new interrupts introduced by new chip
Date: Wed, 10 Oct 2007 18:06:37 +0800
Message-Id: <1192010804-20071-2-git-send-email-leoli@freescale.com>
In-Reply-To: <1192010804-20071-1-git-send-email-leoli@freescale.com>
References: <1192010804-20071-1-git-send-email-leoli@freescale.com>
Cc: Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These interrupts are introduced by the latest Freescale SoC such as
MPC837x.  The patch also adds comment to interrupts.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/ipic.c |  224 ++++++++++++++++++++++++++++++++++----------
 arch/powerpc/sysdev/ipic.h |    7 +-
 include/asm-powerpc/ipic.h |   12 ++-
 3 files changed, 186 insertions(+), 57 deletions(-)

diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index 473c415..ea4f695 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -33,7 +33,31 @@ static struct ipic * primary_ipic;
 static DEFINE_SPINLOCK(ipic_lock);
 
 static struct ipic_info ipic_info[] = {
-	[9] = {
+	[1] = {	/* PEX1 CNT */
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_C,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 16,
+		.prio_mask = 0,
+	},
+	[2] = {	/* PEX2 CNT */
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_C,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 17,
+		.prio_mask = 1,
+	},
+	[4] = {	/* MSIR1 */
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_C,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 19,
+		.prio_mask = 3,
+	},
+	[9] = {	/* UART1 */
 		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_D,
@@ -41,7 +65,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 24,
 		.prio_mask = 0,
 	},
-	[10] = {
+	[10] = { /* UART2 */
 		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_D,
@@ -49,7 +73,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 25,
 		.prio_mask = 1,
 	},
-	[11] = {
+	[11] = { /* SEC */
 		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_D,
@@ -57,7 +81,23 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 26,
 		.prio_mask = 2,
 	},
-	[14] = {
+	[12] = { /* eTSEC1 1588 */
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_D,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 27,
+		.prio_mask = 3,
+	},
+	[13] = { /* eTSEC2 1588 */
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_D,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 28,
+		.prio_mask = 4,
+	},
+	[14] = { /* I2C1 */
 		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_D,
@@ -65,7 +105,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 29,
 		.prio_mask = 5,
 	},
-	[15] = {
+	[15] = { /* I2C2 */
 		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_D,
@@ -73,7 +113,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 30,
 		.prio_mask = 6,
 	},
-	[16] = {
+	[16] = { /* SPI */
 		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_D,
@@ -81,7 +121,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 31,
 		.prio_mask = 7,
 	},
-	[17] = {
+	[17] = { /* IRQ1 */
 		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_A,
@@ -89,7 +129,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 1,
 		.prio_mask = 5,
 	},
-	[18] = {
+	[18] = { /* IRQ2 */
 		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_A,
@@ -97,7 +137,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 2,
 		.prio_mask = 6,
 	},
-	[19] = {
+	[19] = { /* IRQ3 */
 		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_A,
@@ -105,7 +145,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 3,
 		.prio_mask = 7,
 	},
-	[20] = {
+	[20] = { /* IRQ4 */
 		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_B,
@@ -113,7 +153,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 4,
 		.prio_mask = 4,
 	},
-	[21] = {
+	[21] = { /* IRQ5 */
 		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_B,
@@ -121,7 +161,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 5,
 		.prio_mask = 5,
 	},
-	[22] = {
+	[22] = { /* IRQ 6 */
 		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_B,
@@ -129,7 +169,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 6,
 		.prio_mask = 6,
 	},
-	[23] = {
+	[23] = { /* IRQ7 */
 		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_B,
@@ -137,7 +177,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 7,
 		.prio_mask = 7,
 	},
-	[32] = {
+	[32] = { /* TSEC1 Tx/QE High */
 		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_A,
@@ -145,7 +185,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 0,
 		.prio_mask = 0,
 	},
-	[33] = {
+	[33] = { /* TSEC1 Rx/QE Low */
 		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_A,
@@ -153,7 +193,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 1,
 		.prio_mask = 1,
 	},
-	[34] = {
+	[34] = { /* TSEC1 Err */
 		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_A,
@@ -161,7 +201,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 2,
 		.prio_mask = 2,
 	},
-	[35] = {
+	[35] = { /* TSEC2 Tx */
 		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_A,
@@ -169,7 +209,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 3,
 		.prio_mask = 3,
 	},
-	[36] = {
+	[36] = { /* TSEC2 Rx */
 		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_A,
@@ -177,7 +217,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 4,
 		.prio_mask = 4,
 	},
-	[37] = {
+	[37] = { /* TSEC2 Err */
 		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_A,
@@ -185,7 +225,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 5,
 		.prio_mask = 5,
 	},
-	[38] = {
+	[38] = { /* USB DR */
 		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_A,
@@ -193,7 +233,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 6,
 		.prio_mask = 6,
 	},
-	[39] = {
+	[39] = { /* USB MPH */
 		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_A,
@@ -201,7 +241,47 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 7,
 		.prio_mask = 7,
 	},
-	[48] = {
+	[42] = { /* eSDHC */
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_B,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 10,
+		.prio_mask = 2,
+	},
+	[44] = { /* SATA1 */
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_B,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 12,
+		.prio_mask = 4,
+	},
+	[45] = { /* SATA2 */
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_B,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 13,
+		.prio_mask = 5,
+	},
+	[46] = { /* SATA3 */
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_B,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 14,
+		.prio_mask = 6,
+	},
+	[47] = { /* SATA4 */
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_B,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 15,
+		.prio_mask = 7,
+	},
+	[48] = { /* IRQ0 */
 		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_A,
@@ -209,7 +289,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 0,
 		.prio_mask = 4,
 	},
-	[64] = {
+	[64] = { /* RTC SEC */
 		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_A,
@@ -217,7 +297,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 0,
 		.prio_mask = 0,
 	},
-	[65] = {
+	[65] = { /* PIT */
 		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_A,
@@ -225,7 +305,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 1,
 		.prio_mask = 1,
 	},
-	[66] = {
+	[66] = { /* PCI */
 		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_A,
@@ -233,7 +313,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 2,
 		.prio_mask = 2,
 	},
-	[67] = {
+	[67] = { /* MSIR0 */
 		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_A,
@@ -241,7 +321,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 3,
 		.prio_mask = 3,
 	},
-	[68] = {
+	[68] = { /* RTC ALR */
 		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_B,
@@ -249,7 +329,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 4,
 		.prio_mask = 0,
 	},
-	[69] = {
+	[69] = { /* MU */
 		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_B,
@@ -257,7 +337,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 5,
 		.prio_mask = 1,
 	},
-	[70] = {
+	[70] = { /* SBA */
 		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_B,
@@ -265,7 +345,7 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 6,
 		.prio_mask = 2,
 	},
-	[71] = {
+	[71] = { /* DMA */
 		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_B,
@@ -273,91 +353,133 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 7,
 		.prio_mask = 3,
 	},
-	[72] = {
+	[72] = { /* GTM4 */
 		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 8,
 	},
-	[73] = {
+	[73] = { /* GTM8 */
 		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 9,
 	},
-	[74] = {
+	[74] = { /* GPIO1/QE Ports */
 		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 10,
 	},
-	[75] = {
+	[75] = { /* GPIO2/SDDR */
 		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 11,
 	},
-	[76] = {
+	[76] = { /* DDR */
 		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 12,
 	},
-	[77] = {
+	[77] = { /* LBC */
 		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 13,
 	},
-	[78] = {
+	[78] = { /* GTM2 */
 		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 14,
 	},
-	[79] = {
+	[79] = { /* GTM6 */
 		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 15,
 	},
-	[80] = {
+	[80] = { /* PMC */
 		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 16,
 	},
-	[84] = {
+	[81] = { /* MSIR2 */
+		.pend	= IPIC_SIPNR_L,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 17,
+	},
+	[82] = { /* MSIR3 */
+		.pend	= IPIC_SIPNR_L,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 18,
+	},
+	[84] = { /* GTM3 */
 		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 20,
 	},
-	[85] = {
+	[85] = { /* GTM7 */
 		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 21,
 	},
-	[90] = {
+	[86] = { /* MSIR4 */
+		.pend	= IPIC_SIPNR_L,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 22,
+	},
+	[87] = { /* MSIR5 */
+		.pend	= IPIC_SIPNR_L,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 23,
+	},
+	[88] = { /* MSIR6 */
+		.pend	= IPIC_SIPNR_L,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 24,
+	},
+	[89] = { /* MSIR7 */
+		.pend	= IPIC_SIPNR_L,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 25,
+	},
+	[90] = { /* GTM1 */
 		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 26,
 	},
-	[91] = {
+	[91] = { /* GTM5 */
 		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
@@ -596,6 +718,10 @@ struct ipic * __init ipic_init(struct device_node *node, unsigned int flags)
 	 * configure SICFR accordingly */
 	if (flags & IPIC_SPREADMODE_GRP_A)
 		temp |= SICFR_IPSA;
+	if (flags & IPIC_SPREADMODE_GRP_B)
+		temp |= SICFR_IPSB;
+	if (flags & IPIC_SPREADMODE_GRP_C)
+		temp |= SICFR_IPSC;
 	if (flags & IPIC_SPREADMODE_GRP_D)
 		temp |= SICFR_IPSD;
 	if (flags & IPIC_SPREADMODE_MIX_A)
@@ -603,7 +729,7 @@ struct ipic * __init ipic_init(struct device_node *node, unsigned int flags)
 	if (flags & IPIC_SPREADMODE_MIX_B)
 		temp |= SICFR_MPSB;
 
-	ipic_write(ipic->regs, IPIC_SICNR, temp);
+	ipic_write(ipic->regs, IPIC_SICFR, temp);
 
 	/* handle MCP route */
 	temp = 0;
@@ -675,10 +801,12 @@ void ipic_set_highest_priority(unsigned int virq)
 
 void ipic_set_default_priority(void)
 {
-	ipic_write(primary_ipic->regs, IPIC_SIPRR_A, IPIC_SIPRR_A_DEFAULT);
-	ipic_write(primary_ipic->regs, IPIC_SIPRR_D, IPIC_SIPRR_D_DEFAULT);
-	ipic_write(primary_ipic->regs, IPIC_SMPRR_A, IPIC_SMPRR_A_DEFAULT);
-	ipic_write(primary_ipic->regs, IPIC_SMPRR_B, IPIC_SMPRR_B_DEFAULT);
+	ipic_write(primary_ipic->regs, IPIC_SIPRR_A, IPIC_PRIORITY_DEFAULT);
+	ipic_write(primary_ipic->regs, IPIC_SIPRR_B, IPIC_PRIORITY_DEFAULT);
+	ipic_write(primary_ipic->regs, IPIC_SIPRR_C, IPIC_PRIORITY_DEFAULT);
+	ipic_write(primary_ipic->regs, IPIC_SIPRR_D, IPIC_PRIORITY_DEFAULT);
+	ipic_write(primary_ipic->regs, IPIC_SMPRR_A, IPIC_PRIORITY_DEFAULT);
+	ipic_write(primary_ipic->regs, IPIC_SMPRR_B, IPIC_PRIORITY_DEFAULT);
 }
 
 void ipic_enable_mcp(enum ipic_mcp_irq mcp_irq)
diff --git a/arch/powerpc/sysdev/ipic.h b/arch/powerpc/sysdev/ipic.h
index c28e589..cd74302 100644
--- a/arch/powerpc/sysdev/ipic.h
+++ b/arch/powerpc/sysdev/ipic.h
@@ -23,13 +23,12 @@
 #define IPIC_IRQ_EXT7 23
 
 /* Default Priority Registers */
-#define IPIC_SIPRR_A_DEFAULT 0x05309770
-#define IPIC_SIPRR_D_DEFAULT 0x05309770
-#define IPIC_SMPRR_A_DEFAULT 0x05309770
-#define IPIC_SMPRR_B_DEFAULT 0x05309770
+#define IPIC_PRIORITY_DEFAULT 0x05309770
 
 /* System Global Interrupt Configuration Register */
 #define	SICFR_IPSA	0x00010000
+#define	SICFR_IPSB	0x00020000
+#define	SICFR_IPSC	0x00040000
 #define	SICFR_IPSD	0x00080000
 #define	SICFR_MPSA	0x00200000
 #define	SICFR_MPSB	0x00400000
diff --git a/include/asm-powerpc/ipic.h b/include/asm-powerpc/ipic.h
index edec79d..8ff08be 100644
--- a/include/asm-powerpc/ipic.h
+++ b/include/asm-powerpc/ipic.h
@@ -20,11 +20,13 @@
 
 /* Flags when we init the IPIC */
 #define IPIC_SPREADMODE_GRP_A	0x00000001
-#define IPIC_SPREADMODE_GRP_D	0x00000002
-#define IPIC_SPREADMODE_MIX_A	0x00000004
-#define IPIC_SPREADMODE_MIX_B	0x00000008
-#define IPIC_DISABLE_MCP_OUT	0x00000010
-#define IPIC_IRQ0_MCP		0x00000020
+#define IPIC_SPREADMODE_GRP_B	0x00000002
+#define IPIC_SPREADMODE_GRP_C	0x00000004
+#define IPIC_SPREADMODE_GRP_D	0x00000008
+#define IPIC_SPREADMODE_MIX_A	0x00000010
+#define IPIC_SPREADMODE_MIX_B	0x00000020
+#define IPIC_DISABLE_MCP_OUT	0x00000040
+#define IPIC_IRQ0_MCP		0x00000080
 
 /* IPIC registers offsets */
 #define IPIC_SICFR	0x00	/* System Global Interrupt Configuration Register */
-- 
1.5.3.2.104.g41ef
