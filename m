Return-Path: <matthias.fuchs@esd-electronics.com>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2326BDDF27
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 09:23:19 +1100 (EST)
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net
	[151.189.8.20])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id C1BB424BF9B
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 23:23:14 +0100 (CET)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id B6E67213095
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 23:23:14 +0100 (CET)
Received: from bill.home (dslb-088-070-075-212.pools.arcor-ip.net
	[88.70.75.212])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 8F0FE19B321
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 23:23:10 +0100 (CET)
Received: from sammo.home (sammo.home [192.168.2.12])
	by bill.home (Postfix) with ESMTP id C0B837352B
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Dec 2007 23:23:06 +0100 (CET)
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 4xx: Add 405GPr and 405EP support in boot wrapper
Date: Thu, 6 Dec 2007 23:23:05 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200712062323.05672.matthias.fuchs@esd-electronics.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for 405GPr processors with optional
new mode strapping. ibm405gp_fixup_clocks() can now be used
for 405GP and 405GPr CPUs.

This is in preparation of porting the cpci405 platform support
from arch/ppc to arch/powerpc.

This patch also adds ibm405ep_fixup_clocks() to support
405EP CPUs from the boot wrapper.

Signed-off-by: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
---
 arch/powerpc/boot/4xx.c |   81 ++++++++++++++++++++++++++++++++++++++++++----
 arch/powerpc/boot/4xx.h |    1 +
 arch/powerpc/boot/dcr.h |    5 +++
 3 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/4xx.c b/arch/powerpc/boot/4xx.c
index 4dc0909..4ac9cb4 100644
--- a/arch/powerpc/boot/4xx.c
+++ b/arch/powerpc/boot/4xx.c
@@ -498,20 +498,45 @@ void ibm405gp_fixup_clocks(unsigned int sys_clk, unsigned int ser_clk)
 	u32 pllmr = mfdcr(DCRN_CPC0_PLLMR);
 	u32 cpc0_cr0 = mfdcr(DCRN_405_CPC0_CR0);
 	u32 cpc0_cr1 = mfdcr(DCRN_405_CPC0_CR1);
+	u32 psr = mfdcr(DCRN_405_CPC0_PSR);
 	u32 cpu, plb, opb, ebc, tb, uart0, uart1, m;
-	u32 fwdv, fbdv, cbdv, opdv, epdv, udiv;
+	u32 fwdv, fwdvb, fbdv, cbdv, opdv, epdv, ppdv, udiv;
 
 	fwdv = (8 - ((pllmr & 0xe0000000) >> 29));
 	fbdv = (pllmr & 0x1e000000) >> 25;
-	cbdv = ((pllmr & 0x00060000) >> 17) + 1;
-	opdv = ((pllmr & 0x00018000) >> 15) + 1;
-	epdv = ((pllmr & 0x00001800) >> 13) + 2;
+	if (fbdv == 0)
+		fbdv = 16;
+	cbdv = ((pllmr & 0x00060000) >> 17) + 1; /* CPU:PLB */
+	opdv = ((pllmr & 0x00018000) >> 15) + 1; /* PLB:OPB */
+	ppdv = ((pllmr & 0x00001800) >> 13) + 1; /* PLB:PCI */
+	epdv = ((pllmr & 0x00001800) >> 11) + 2; /* PLB:EBC */
 	udiv = ((cpc0_cr0 & 0x3e) >> 1) + 1;
 
-	m = fwdv * fbdv * cbdv;
+	/* check for 405GPr */
+	if ((mfpvr() & 0xfffffff0) == (0x50910951 & 0xfffffff0)) {
+		fwdvb = 8 - (pllmr & 0x00000007);
+		if (!(psr & 0x00001000)) /* PCI async mode enable == 0 */
+			if (psr & 0x00000020) /* New mode enable */
+				m = fwdvb * 2 * ppdv;
+			else
+				m = fwdvb * cbdv * ppdv;
+		else if (psr & 0x00000020) /* New mode enable */
+			if (psr & 0x00000800) /* PerClk synch mode */
+				m = fwdvb * 2 * epdv;
+			else
+				m = fbdv * fwdv;
+		else if (epdv == fbdv)
+			m = fbdv * cbdv * epdv;
+		else
+			m = fbdv * fwdvb * cbdv;
 
-	cpu = sys_clk * m / fwdv;
-	plb = cpu / cbdv;
+		cpu = sys_clk * m / fwdv;
+		plb = sys_clk * m / (fwdvb * cbdv);
+	} else {
+		m = fwdv * fbdv * cbdv;
+		cpu = sys_clk * m / fwdv;
+		plb = cpu / cbdv;
+	}
 	opb = plb / opdv;
 	ebc = plb / epdv;
 
@@ -542,3 +567,45 @@ void ibm405gp_fixup_clocks(unsigned int sys_clk, unsigned int ser_clk)
 	dt_fixup_clock("/plb/opb/serial@ef600400", uart1);
 }
 
+
+void ibm405ep_fixup_clocks(unsigned int sys_clk)
+{
+	u32 pllmr0 = mfdcr(DCRN_CPC0_PLLMR0);
+	u32 pllmr1 = mfdcr(DCRN_CPC0_PLLMR1);
+	u32 cpc0_ucr = mfdcr(DCRN_CPC0_UCR);
+	u32 cpu, plb, opb, ebc, uart0, uart1;
+	u32 fwdva, fwdvb, fbdv, cbdv, opdv, epdv;
+	u32 pllmr0_ccdv, tb, m;
+
+	fwdva = 8 - ((pllmr1 & 0x00070000) >> 16);
+	fwdvb = 8 - ((pllmr1 & 0x00007000) >> 12);
+	fbdv = (pllmr1 & 0x00f00000) >> 20;
+	if (fbdv == 0)
+		fbdv = 16;
+
+	cbdv = ((pllmr0 & 0x00030000) >> 16) + 1; /* CPU:PLB */
+	epdv = ((pllmr0 & 0x00000300) >> 8) + 2;  /* PLB:EBC */
+	opdv = ((pllmr0 & 0x00003000) >> 12) + 1; /* PLB:OPB */
+
+	m = fbdv * fwdvb;
+
+	pllmr0_ccdv = ((pllmr0 & 0x00300000) >> 20) + 1;
+	if (pllmr1 & 0x80000000)
+		cpu = sys_clk * m / (fwdva * pllmr0_ccdv);
+	else
+		cpu = sys_clk / pllmr0_ccdv;
+
+	plb = cpu / cbdv;
+	opb = plb / opdv;
+	ebc = plb / epdv;
+	tb = cpu;
+	uart0 = cpu / (cpc0_ucr & 0x0000007f);
+	uart1 = cpu / ((cpc0_ucr & 0x00007f00) >> 8);
+
+	dt_fixup_cpu_clocks(cpu, tb, 0);
+	dt_fixup_clock("/plb", plb);
+	dt_fixup_clock("/plb/opb", opb);
+	dt_fixup_clock("/plb/ebc", ebc);
+	dt_fixup_clock("/plb/opb/serial@ef600300", uart0);
+	dt_fixup_clock("/plb/opb/serial@ef600400", uart1);
+}
diff --git a/arch/powerpc/boot/4xx.h b/arch/powerpc/boot/4xx.h
index fbe0632..2606e64 100644
--- a/arch/powerpc/boot/4xx.h
+++ b/arch/powerpc/boot/4xx.h
@@ -20,6 +20,7 @@ void ibm4xx_quiesce_eth(u32 *emac0, u32 *emac1);
 void ibm4xx_fixup_ebc_ranges(const char *ebc);
 
 void ibm405gp_fixup_clocks(unsigned int sys_clk, unsigned int ser_clk);
+void ibm405ep_fixup_clocks(unsigned int sys_clk);
 void ibm440gp_fixup_clocks(unsigned int sys_clk, unsigned int ser_clk);
 void ibm440ep_fixup_clocks(unsigned int sys_clk, unsigned int ser_clk,
 			   unsigned int tmr_clk);
diff --git a/arch/powerpc/boot/dcr.h b/arch/powerpc/boot/dcr.h
index 0fde9b1..89f736e 100644
--- a/arch/powerpc/boot/dcr.h
+++ b/arch/powerpc/boot/dcr.h
@@ -146,7 +146,12 @@ static const unsigned long sdram_bxcr[] = { SDRAM0_B0CR, SDRAM0_B1CR,
 #define DCRN_CPC0_PLLMR 0xb0
 #define DCRN_405_CPC0_CR0 0xb1
 #define DCRN_405_CPC0_CR1 0xb2
+#define DCRN_405_CPC0_PSR 0xb4
 
+/* 405EP Clocking/Power Management/Chip Control regs */
+#define DCRN_CPC0_PLLMR0  0xf0
+#define DCRN_CPC0_PLLMR1  0xf4
+#define DCRN_CPC0_UCR     0xf5
 
 /* 440GX Clock control etc */
 
-- 
1.5.3.5
