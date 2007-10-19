Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 72394DDEFD
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 21:28:32 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l9JBSRwh015104
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 04:28:27 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l9JBSNKY016129
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 06:28:26 -0500 (CDT)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH v7 2/9] ipic: add new interrupts introduced by new chip
Date: Fri, 19 Oct 2007 19:38:43 +0800
Message-Id: <1192793930-26039-3-git-send-email-leoli@freescale.com>
In-Reply-To: <1192793930-26039-2-git-send-email-leoli@freescale.com>
References: <1192793930-26039-1-git-send-email-leoli@freescale.com>
	<1192793930-26039-2-git-send-email-leoli@freescale.com>
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
MPC837x.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/sysdev/ipic.c |  138 ++++++++++++++++++++++++++++++++++++++++++--
 arch/powerpc/sysdev/ipic.h |    7 +-
 include/asm-powerpc/ipic.h |   12 ++--
 3 files changed, 143 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index 05a56e5..7168b03 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -33,6 +33,30 @@ static struct ipic * primary_ipic;
 static DEFINE_SPINLOCK(ipic_lock);
 
 static struct ipic_info ipic_info[] = {
+	[1] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_C,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 16,
+		.prio_mask = 0,
+	},
+	[2] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_C,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 17,
+		.prio_mask = 1,
+	},
+	[4] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_C,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 19,
+		.prio_mask = 3,
+	},
 	[9] = {
 		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
@@ -57,6 +81,22 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 26,
 		.prio_mask = 2,
 	},
+	[12] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_D,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 27,
+		.prio_mask = 3,
+	},
+	[13] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_D,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 28,
+		.prio_mask = 4,
+	},
 	[14] = {
 		.pend	= IPIC_SIPNR_H,
 		.mask	= IPIC_SIMSR_H,
@@ -201,6 +241,46 @@ static struct ipic_info ipic_info[] = {
 		.bit	= 7,
 		.prio_mask = 7,
 	},
+	[42] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_B,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 10,
+		.prio_mask = 2,
+	},
+	[44] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_B,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 12,
+		.prio_mask = 4,
+	},
+	[45] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_B,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 13,
+		.prio_mask = 5,
+	},
+	[46] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_B,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 14,
+		.prio_mask = 6,
+	},
+	[47] = {
+		.pend	= IPIC_SIPNR_H,
+		.mask	= IPIC_SIMSR_H,
+		.prio	= IPIC_SIPRR_B,
+		.force	= IPIC_SIFCR_H,
+		.bit	= 15,
+		.prio_mask = 7,
+	},
 	[48] = {
 		.pend	= IPIC_SEPNR,
 		.mask	= IPIC_SEMSR,
@@ -336,6 +416,20 @@ static struct ipic_info ipic_info[] = {
 		.force	= IPIC_SIFCR_L,
 		.bit	= 16,
 	},
+	[81] = {
+		.pend	= IPIC_SIPNR_L,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 17,
+	},
+	[82] = {
+		.pend	= IPIC_SIPNR_L,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 18,
+	},
 	[84] = {
 		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
@@ -350,6 +444,34 @@ static struct ipic_info ipic_info[] = {
 		.force	= IPIC_SIFCR_L,
 		.bit	= 21,
 	},
+	[86] = {
+		.pend	= IPIC_SIPNR_L,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 22,
+	},
+	[87] = {
+		.pend	= IPIC_SIPNR_L,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 23,
+	},
+	[88] = {
+		.pend	= IPIC_SIPNR_L,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 24,
+	},
+	[89] = {
+		.pend	= IPIC_SIPNR_L,
+		.mask	= IPIC_SIMSR_L,
+		.prio	= 0,
+		.force	= IPIC_SIFCR_L,
+		.bit	= 25,
+	},
 	[90] = {
 		.pend	= IPIC_SIPNR_L,
 		.mask	= IPIC_SIMSR_L,
@@ -593,6 +715,10 @@ struct ipic * __init ipic_init(struct device_node *node, unsigned int flags)
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
@@ -600,7 +726,7 @@ struct ipic * __init ipic_init(struct device_node *node, unsigned int flags)
 	if (flags & IPIC_SPREADMODE_MIX_B)
 		temp |= SICFR_MPSB;
 
-	ipic_write(ipic->regs, IPIC_SICNR, temp);
+	ipic_write(ipic->regs, IPIC_SICFR, temp);
 
 	/* handle MCP route */
 	temp = 0;
@@ -672,10 +798,12 @@ void ipic_set_highest_priority(unsigned int virq)
 
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
index bb309a5..1158b8f 100644
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
