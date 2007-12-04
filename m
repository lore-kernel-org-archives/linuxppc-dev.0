Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CD95CDDDE6
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 21:51:56 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	lB4ApoGY001508
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 03:51:50 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lB4ApnGq002385
	for <linuxppc-dev@ozlabs.org>; Tue, 4 Dec 2007 04:51:49 -0600 (CST)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] ipic: ack only for edge interrupts
Date: Tue,  4 Dec 2007 19:01:40 +0800
Message-Id: <1196766100-7411-1-git-send-email-leoli@freescale.com>
Cc: Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Only external interrupts in edge detect mode support ack operation.
Therefore, in most cases ack is not needed.  The patch makes ipic
ack only when it's needed.  This could boost over all system performance.

Signed-off-by: Li Yang <leoli@freescale.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
Update to use different irq_chip for level and edge interrupts as Ben
suggested.
Supercedes [PATCH] ipic: change ack operation that register is accessed
only when needed

 arch/powerpc/sysdev/ipic.c |  113 +++++++++++++++++---------------------------
 arch/powerpc/sysdev/ipic.h |    6 +--
 2 files changed, 45 insertions(+), 74 deletions(-)

diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index 7168b03..7274750 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -30,11 +30,11 @@
 #include "ipic.h"
 
 static struct ipic * primary_ipic;
+static struct irq_chip ipic_level_irq_chip, ipic_edge_irq_chip;
 static DEFINE_SPINLOCK(ipic_lock);
 
 static struct ipic_info ipic_info[] = {
 	[1] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_C,
 		.force	= IPIC_SIFCR_H,
@@ -42,7 +42,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 0,
 	},
 	[2] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_C,
 		.force	= IPIC_SIFCR_H,
@@ -50,7 +49,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 1,
 	},
 	[4] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_C,
 		.force	= IPIC_SIFCR_H,
@@ -58,7 +56,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 3,
 	},
 	[9] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_D,
 		.force	= IPIC_SIFCR_H,
@@ -66,7 +63,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 0,
 	},
 	[10] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_D,
 		.force	= IPIC_SIFCR_H,
@@ -74,7 +70,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 1,
 	},
 	[11] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_D,
 		.force	= IPIC_SIFCR_H,
@@ -82,7 +77,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 2,
 	},
 	[12] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_D,
 		.force	= IPIC_SIFCR_H,
@@ -90,7 +84,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 3,
 	},
 	[13] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_D,
 		.force	= IPIC_SIFCR_H,
@@ -98,7 +91,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 4,
 	},
 	[14] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_D,
 		.force	= IPIC_SIFCR_H,
@@ -106,7 +98,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 5,
 	},
 	[15] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_D,
 		.force	= IPIC_SIFCR_H,
@@ -114,7 +105,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 6,
 	},
 	[16] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_D,
 		.force	= IPIC_SIFCR_H,
@@ -122,7 +112,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 7,
 	},
 	[17] = {
-		.pend	= IPIC_SEPNR,
+		.ack	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SEFCR,
@@ -130,7 +120,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 5,
 	},
 	[18] = {
-		.pend	= IPIC_SEPNR,
+		.ack	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SEFCR,
@@ -138,7 +128,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 6,
 	},
 	[19] = {
-		.pend	= IPIC_SEPNR,
+		.ack	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SEFCR,
@@ -146,7 +136,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 7,
 	},
 	[20] = {
-		.pend	= IPIC_SEPNR,
+		.ack	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SEFCR,
@@ -154,7 +144,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 4,
 	},
 	[21] = {
-		.pend	= IPIC_SEPNR,
+		.ack	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SEFCR,
@@ -162,7 +152,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 5,
 	},
 	[22] = {
-		.pend	= IPIC_SEPNR,
+		.ack	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SEFCR,
@@ -170,7 +160,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 6,
 	},
 	[23] = {
-		.pend	= IPIC_SEPNR,
+		.ack	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SEFCR,
@@ -178,7 +168,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 7,
 	},
 	[32] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_A,
 		.force	= IPIC_SIFCR_H,
@@ -186,7 +175,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 0,
 	},
 	[33] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_A,
 		.force	= IPIC_SIFCR_H,
@@ -194,7 +182,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 1,
 	},
 	[34] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_A,
 		.force	= IPIC_SIFCR_H,
@@ -202,7 +189,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 2,
 	},
 	[35] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_A,
 		.force	= IPIC_SIFCR_H,
@@ -210,7 +196,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 3,
 	},
 	[36] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_A,
 		.force	= IPIC_SIFCR_H,
@@ -218,7 +203,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 4,
 	},
 	[37] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_A,
 		.force	= IPIC_SIFCR_H,
@@ -226,7 +210,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 5,
 	},
 	[38] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_A,
 		.force	= IPIC_SIFCR_H,
@@ -234,7 +217,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 6,
 	},
 	[39] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_A,
 		.force	= IPIC_SIFCR_H,
@@ -242,7 +224,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 7,
 	},
 	[42] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_B,
 		.force	= IPIC_SIFCR_H,
@@ -250,7 +231,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 2,
 	},
 	[44] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_B,
 		.force	= IPIC_SIFCR_H,
@@ -258,7 +238,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 4,
 	},
 	[45] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_B,
 		.force	= IPIC_SIFCR_H,
@@ -266,7 +245,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 5,
 	},
 	[46] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_B,
 		.force	= IPIC_SIFCR_H,
@@ -274,7 +252,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 6,
 	},
 	[47] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_B,
 		.force	= IPIC_SIFCR_H,
@@ -282,7 +259,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 7,
 	},
 	[48] = {
-		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SEFCR,
@@ -290,7 +266,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 4,
 	},
 	[64] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SIFCR_L,
@@ -298,7 +273,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 0,
 	},
 	[65] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SIFCR_L,
@@ -306,7 +280,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 1,
 	},
 	[66] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SIFCR_L,
@@ -314,7 +287,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 2,
 	},
 	[67] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SIFCR_L,
@@ -322,7 +294,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 3,
 	},
 	[68] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SIFCR_L,
@@ -330,7 +301,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 0,
 	},
 	[69] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SIFCR_L,
@@ -338,7 +308,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 1,
 	},
 	[70] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SIFCR_L,
@@ -346,7 +315,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 2,
 	},
 	[71] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SIFCR_L,
@@ -354,133 +322,114 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 3,
 	},
 	[72] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 8,
 	},
 	[73] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 9,
 	},
 	[74] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 10,
 	},
 	[75] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 11,
 	},
 	[76] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 12,
 	},
 	[77] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 13,
 	},
 	[78] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 14,
 	},
 	[79] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 15,
 	},
 	[80] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 16,
 	},
 	[81] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 17,
 	},
 	[82] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 18,
 	},
 	[84] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 20,
 	},
 	[85] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 21,
 	},
 	[86] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 22,
 	},
 	[87] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 23,
 	},
 	[88] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 24,
 	},
 	[89] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 25,
 	},
 	[90] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
 		.bit	= 26,
 	},
 	[91] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= 0,
 		.force	= IPIC_SIFCR_L,
@@ -534,6 +483,10 @@ static void ipic_mask_irq(unsigned int virq)
 	temp &= ~(1 << (31 - ipic_info[src].bit));
 	ipic_write(ipic->regs, ipic_info[src].mask, temp);
 
+	/* mb() can't guarantee that masking is finished.  But it does finish
+	 * for nearly all cases. */
+	mb();
+
 	spin_unlock_irqrestore(&ipic_lock, flags);
 }
 
@@ -546,9 +499,13 @@ static void ipic_ack_irq(unsigned int virq)
 
 	spin_lock_irqsave(&ipic_lock, flags);
 
-	temp = ipic_read(ipic->regs, ipic_info[src].pend);
+	temp = ipic_read(ipic->regs, ipic_info[src].ack);
 	temp |= (1 << (31 - ipic_info[src].bit));
-	ipic_write(ipic->regs, ipic_info[src].pend, temp);
+	ipic_write(ipic->regs, ipic_info[src].ack, temp);
+
+	/* mb() can't guarantee that ack is finished.  But it does finish
+	 * for nearly all cases. */
+	mb();
 
 	spin_unlock_irqrestore(&ipic_lock, flags);
 }
@@ -566,9 +523,13 @@ static void ipic_mask_irq_and_ack(unsigned int virq)
 	temp &= ~(1 << (31 - ipic_info[src].bit));
 	ipic_write(ipic->regs, ipic_info[src].mask, temp);
 
-	temp = ipic_read(ipic->regs, ipic_info[src].pend);
+	temp = ipic_read(ipic->regs, ipic_info[src].ack);
 	temp |= (1 << (31 - ipic_info[src].bit));
-	ipic_write(ipic->regs, ipic_info[src].pend, temp);
+	ipic_write(ipic->regs, ipic_info[src].ack, temp);
+
+	/* mb() can't guarantee that ack is finished.  But it does finish
+	 * for nearly all cases. */
+	mb();
 
 	spin_unlock_irqrestore(&ipic_lock, flags);
 }
@@ -590,14 +551,22 @@ static int ipic_set_irq_type(unsigned int virq, unsigned int flow_type)
 			flow_type);
 		return -EINVAL;
 	}
+	/* ipic supports only edge mode on external interrupts */
+	if ((flow_type & IRQ_TYPE_EDGE_FALLING) && !ipic_info[src].ack) {
+		printk(KERN_ERR "ipic: edge sense not supported on internal "
+				"interrupts\n");
+		return -EINVAL;
+	}
 
 	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
 	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
 	if (flow_type & IRQ_TYPE_LEVEL_LOW)  {
 		desc->status |= IRQ_LEVEL;
 		desc->handle_irq = handle_level_irq;
+		desc->chip = &ipic_level_irq_chip;
 	} else {
 		desc->handle_irq = handle_edge_irq;
+		desc->chip = &ipic_edge_irq_chip;
 	}
 
 	/* only EXT IRQ senses are programmable on ipic
@@ -622,7 +591,16 @@ static int ipic_set_irq_type(unsigned int virq, unsigned int flow_type)
 	return 0;
 }
 
-static struct irq_chip ipic_irq_chip = {
+/* level interrupts and edge interrupts have different ack operations */
+static struct irq_chip ipic_level_irq_chip = {
+	.typename	= " IPIC  ",
+	.unmask		= ipic_unmask_irq,
+	.mask		= ipic_mask_irq,
+	.mask_ack	= ipic_mask_irq,
+	.set_type	= ipic_set_irq_type,
+};
+
+static struct irq_chip ipic_edge_irq_chip = {
 	.typename	= " IPIC  ",
 	.unmask		= ipic_unmask_irq,
 	.mask		= ipic_mask_irq,
@@ -641,13 +619,9 @@ static int ipic_host_map(struct irq_host *h, unsigned int virq,
 			 irq_hw_number_t hw)
 {
 	struct ipic *ipic = h->host_data;
-	struct irq_chip *chip;
-
-	/* Default chip */
-	chip = &ipic->hc_irq;
 
 	set_irq_chip_data(virq, ipic);
-	set_irq_chip_and_handler(virq, chip, handle_level_irq);
+	set_irq_chip_and_handler(virq, &ipic_level_irq_chip, handle_level_irq);
 
 	/* Set default irq type */
 	set_irq_type(virq, IRQ_TYPE_NONE);
@@ -706,7 +680,6 @@ struct ipic * __init ipic_init(struct device_node *node, unsigned int flags)
 	ipic->regs = ioremap(res.start, res.end - res.start + 1);
 
 	ipic->irqhost->host_data = ipic;
-	ipic->hc_irq = ipic_irq_chip;
 
 	/* init hw */
 	ipic_write(ipic->regs, IPIC_SICNR, 0x0);
diff --git a/arch/powerpc/sysdev/ipic.h b/arch/powerpc/sysdev/ipic.h
index 1158b8f..9391c57 100644
--- a/arch/powerpc/sysdev/ipic.h
+++ b/arch/powerpc/sysdev/ipic.h
@@ -44,13 +44,11 @@ struct ipic {
 
 	/* The remapper for this IPIC */
 	struct irq_host		*irqhost;
-
-	/* The "linux" controller struct */
-	struct irq_chip		hc_irq;
 };
 
 struct ipic_info {
-	u8	pend;		/* pending register offset from base */
+	u8	ack;		/* pending register offset from base if the irq
+				   supports ack operation */
 	u8	mask;		/* mask register offset from base */
 	u8	prio;		/* priority register offset from base */
 	u8	force;		/* force register offset from base */
-- 
1.5.3.5.643.g40e25
