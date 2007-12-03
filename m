Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 19671DDDF0
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Dec 2007 23:16:37 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	lB3CGU57016035
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 05:16:30 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id lB3CGSec000881
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 06:16:29 -0600 (CST)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] ipic: change ack operation that register is accessed only
	when needed
Date: Mon,  3 Dec 2007 20:26:19 +0800
Message-Id: <1196684780-28408-1-git-send-email-leoli@freescale.com>
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
---
Replaces patch:  [PATCH 7/9] ipic: clean up unsupported ack operations

 arch/powerpc/sysdev/ipic.c |  107 +++++++++++++++----------------------------
 arch/powerpc/sysdev/ipic.h |    3 +-
 2 files changed, 39 insertions(+), 71 deletions(-)

diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index 7168b03..388fa59 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -34,7 +34,6 @@ static DEFINE_SPINLOCK(ipic_lock);
 
 static struct ipic_info ipic_info[] = {
 	[1] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_C,
 		.force	= IPIC_SIFCR_H,
@@ -42,7 +41,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 0,
 	},
 	[2] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_C,
 		.force	= IPIC_SIFCR_H,
@@ -50,7 +48,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 1,
 	},
 	[4] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_C,
 		.force	= IPIC_SIFCR_H,
@@ -58,7 +55,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 3,
 	},
 	[9] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_D,
 		.force	= IPIC_SIFCR_H,
@@ -66,7 +62,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 0,
 	},
 	[10] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_D,
 		.force	= IPIC_SIFCR_H,
@@ -74,7 +69,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 1,
 	},
 	[11] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_D,
 		.force	= IPIC_SIFCR_H,
@@ -82,7 +76,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 2,
 	},
 	[12] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_D,
 		.force	= IPIC_SIFCR_H,
@@ -90,7 +83,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 3,
 	},
 	[13] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_D,
 		.force	= IPIC_SIFCR_H,
@@ -98,7 +90,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 4,
 	},
 	[14] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_D,
 		.force	= IPIC_SIFCR_H,
@@ -106,7 +97,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 5,
 	},
 	[15] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_D,
 		.force	= IPIC_SIFCR_H,
@@ -114,7 +104,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 6,
 	},
 	[16] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_D,
 		.force	= IPIC_SIFCR_H,
@@ -122,7 +111,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 7,
 	},
 	[17] = {
-		.pend	= IPIC_SEPNR,
+		.ack	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SEFCR,
@@ -130,7 +119,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 5,
 	},
 	[18] = {
-		.pend	= IPIC_SEPNR,
+		.ack	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SEFCR,
@@ -138,7 +127,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 6,
 	},
 	[19] = {
-		.pend	= IPIC_SEPNR,
+		.ack	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SEFCR,
@@ -146,7 +135,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 7,
 	},
 	[20] = {
-		.pend	= IPIC_SEPNR,
+		.ack	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SEFCR,
@@ -154,7 +143,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 4,
 	},
 	[21] = {
-		.pend	= IPIC_SEPNR,
+		.ack	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SEFCR,
@@ -162,7 +151,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 5,
 	},
 	[22] = {
-		.pend	= IPIC_SEPNR,
+		.ack	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SEFCR,
@@ -170,7 +159,7 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 6,
 	},
 	[23] = {
-		.pend	= IPIC_SEPNR,
+		.ack	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SEFCR,
@@ -178,7 +167,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 7,
 	},
 	[32] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_A,
 		.force	= IPIC_SIFCR_H,
@@ -186,7 +174,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 0,
 	},
 	[33] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_A,
 		.force	= IPIC_SIFCR_H,
@@ -194,7 +181,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 1,
 	},
 	[34] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_A,
 		.force	= IPIC_SIFCR_H,
@@ -202,7 +188,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 2,
 	},
 	[35] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_A,
 		.force	= IPIC_SIFCR_H,
@@ -210,7 +195,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 3,
 	},
 	[36] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_A,
 		.force	= IPIC_SIFCR_H,
@@ -218,7 +202,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 4,
 	},
 	[37] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_A,
 		.force	= IPIC_SIFCR_H,
@@ -226,7 +209,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 5,
 	},
 	[38] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_A,
 		.force	= IPIC_SIFCR_H,
@@ -234,7 +216,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 6,
 	},
 	[39] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_A,
 		.force	= IPIC_SIFCR_H,
@@ -242,7 +223,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 7,
 	},
 	[42] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_B,
 		.force	= IPIC_SIFCR_H,
@@ -250,7 +230,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 2,
 	},
 	[44] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_B,
 		.force	= IPIC_SIFCR_H,
@@ -258,7 +237,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 4,
 	},
 	[45] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_B,
 		.force	= IPIC_SIFCR_H,
@@ -266,7 +244,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 5,
 	},
 	[46] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_B,
 		.force	= IPIC_SIFCR_H,
@@ -274,7 +251,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 6,
 	},
 	[47] = {
-		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
 		.prio	= IPIC_SIPRR_B,
 		.force	= IPIC_SIFCR_H,
@@ -282,7 +258,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 7,
 	},
 	[48] = {
-		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SEFCR,
@@ -290,7 +265,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 4,
 	},
 	[64] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SIFCR_L,
@@ -298,7 +272,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 0,
 	},
 	[65] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SIFCR_L,
@@ -306,7 +279,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 1,
 	},
 	[66] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SIFCR_L,
@@ -314,7 +286,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 2,
 	},
 	[67] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_A,
 		.force	= IPIC_SIFCR_L,
@@ -322,7 +293,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 3,
 	},
 	[68] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SIFCR_L,
@@ -330,7 +300,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 0,
 	},
 	[69] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SIFCR_L,
@@ -338,7 +307,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 1,
 	},
 	[70] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SIFCR_L,
@@ -346,7 +314,6 @@ static struct ipic_info ipic_info[] = {
 		.prio_mask = 2,
 	},
 	[71] = {
-		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
 		.prio	= IPIC_SMPRR_B,
 		.force	= IPIC_SIFCR_L,
@@ -354,133 +321,114 @@ static struct ipic_info ipic_info[] = {
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
@@ -534,23 +482,33 @@ static void ipic_mask_irq(unsigned int virq)
 	temp &= ~(1 << (31 - ipic_info[src].bit));
 	ipic_write(ipic->regs, ipic_info[src].mask, temp);
 
+	/* mb() can't guarantee that masking is finished.  But it does finish
+	 * for nearly all cases. */
+	mb();
+
 	spin_unlock_irqrestore(&ipic_lock, flags);
 }
 
 static void ipic_ack_irq(unsigned int virq)
 {
-	struct ipic *ipic = ipic_from_irq(virq);
 	unsigned int src = ipic_irq_to_hw(virq);
-	unsigned long flags;
-	u32 temp;
 
-	spin_lock_irqsave(&ipic_lock, flags);
+	/* Only external interrupts in edge mode support ACK */
+	if (unlikely(ipic_info[src].ack &&
+			((get_irq_desc(virq)->status & IRQ_TYPE_SENSE_MASK) ==
+			IRQ_TYPE_EDGE_FALLING))) {
+		struct ipic *ipic = ipic_from_irq(virq);
+		unsigned long flags;
+		u32 temp;
 
-	temp = ipic_read(ipic->regs, ipic_info[src].pend);
-	temp |= (1 << (31 - ipic_info[src].bit));
-	ipic_write(ipic->regs, ipic_info[src].pend, temp);
+		spin_lock_irqsave(&ipic_lock, flags);
 
-	spin_unlock_irqrestore(&ipic_lock, flags);
+		temp = ipic_read(ipic->regs, ipic_info[src].ack);
+		temp |= (1 << (31 - ipic_info[src].bit));
+		ipic_write(ipic->regs, ipic_info[src].ack, temp);
+
+		spin_unlock_irqrestore(&ipic_lock, flags);
+	}
 }
 
 static void ipic_mask_irq_and_ack(unsigned int virq)
@@ -566,9 +524,18 @@ static void ipic_mask_irq_and_ack(unsigned int virq)
 	temp &= ~(1 << (31 - ipic_info[src].bit));
 	ipic_write(ipic->regs, ipic_info[src].mask, temp);
 
-	temp = ipic_read(ipic->regs, ipic_info[src].pend);
-	temp |= (1 << (31 - ipic_info[src].bit));
-	ipic_write(ipic->regs, ipic_info[src].pend, temp);
+	/* Only external interrupts in edge mode support ACK */
+	if (unlikely(ipic_info[src].ack &&
+			((get_irq_desc(virq)->status & IRQ_TYPE_SENSE_MASK) ==
+			IRQ_TYPE_EDGE_FALLING))) {
+		temp = ipic_read(ipic->regs, ipic_info[src].ack);
+		temp |= (1 << (31 - ipic_info[src].bit));
+		ipic_write(ipic->regs, ipic_info[src].ack, temp);
+	} else {
+		/* mb() can't guarantee that masking is finished.  But it does
+		 * finish for nearly all cases. */
+		mb();
+	}
 
 	spin_unlock_irqrestore(&ipic_lock, flags);
 }
diff --git a/arch/powerpc/sysdev/ipic.h b/arch/powerpc/sysdev/ipic.h
index 1158b8f..5c036e4 100644
--- a/arch/powerpc/sysdev/ipic.h
+++ b/arch/powerpc/sysdev/ipic.h
@@ -50,7 +50,8 @@ struct ipic {
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
