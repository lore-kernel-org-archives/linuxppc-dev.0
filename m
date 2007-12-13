Return-Path: <benh@ozlabs.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 13 Dec 2007 18:38:43 +1100
Subject: [PATCH 16/20] [POWERPC] Rework 4xx clock probing in boot wrapper
Message-Id: <20071213073849.8FD3CDE055@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This reworks the boot wrapper library function that probes
the chip clocks. Better separate the base function that is
used on 440GX,SPe,EP,... from the uart fixups as those need
different device-tree path on different processors.

Also, rework the function itself based on the arch/ppc code
from Eugene Surovegin which I find more readable, and which
handles one more bypass case. Also handle the subtle difference
between 440EP/EPx and 440SPe/GX, on the former, PerClk is derived
from the PLB clock while on the later, it's derived from the OPB. 

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/boot/4xx.c            |  272 +++++++++++++++++++++++++++----------
 arch/powerpc/boot/4xx.h            |   11 +
 arch/powerpc/boot/bamboo.c         |    2 
 arch/powerpc/boot/cuboot-sequoia.c |    2 
 arch/powerpc/boot/cuboot-taishan.c |    4 
 arch/powerpc/boot/dcr.h            |   17 ++
 arch/powerpc/boot/ebony.c          |   60 --------
 7 files changed, 233 insertions(+), 135 deletions(-)

--- linux-work.orig/arch/powerpc/boot/4xx.c	2007-12-03 14:25:34.000000000 +1100
+++ linux-work/arch/powerpc/boot/4xx.c	2007-12-03 14:26:09.000000000 +1100
@@ -275,89 +275,225 @@ void ibm4xx_fixup_ebc_ranges(const char 
 	setprop(devp, "ranges", ranges, (p - ranges) * sizeof(u32));
 }
 
-#define SPRN_CCR1 0x378
-void ibm440ep_fixup_clocks(unsigned int sysclk, unsigned int ser_clk)
+/* Calculate 440GP clocks */
+void ibm440gp_fixup_clocks(unsigned int sys_clk, unsigned int ser_clk)
 {
-	u32 cpu, plb, opb, ebc, tb, uart0, m, vco;
-	u32 reg;
-	u32 fwdva, fwdvb, fbdv, lfbdv, opbdv0, perdv0, spcid0, prbdv0, tmp;
-
-	mtdcr(DCRN_CPR0_ADDR, CPR0_PLLD0);
-	reg = mfdcr(DCRN_CPR0_DATA);
-	tmp = (reg & 0x000F0000) >> 16;
-	fwdva = tmp ? tmp : 16;
-	tmp = (reg & 0x00000700) >> 8;
-	fwdvb = tmp ? tmp : 8;
-	tmp = (reg & 0x1F000000) >> 24;
-	fbdv = tmp ? tmp : 32;
-	lfbdv = (reg & 0x0000007F);
-
-	mtdcr(DCRN_CPR0_ADDR, CPR0_OPBD0);
-	reg = mfdcr(DCRN_CPR0_DATA);
-	tmp = (reg & 0x03000000) >> 24;
-	opbdv0 = tmp ? tmp : 4;
-
-	mtdcr(DCRN_CPR0_ADDR, CPR0_PERD0);
-	reg = mfdcr(DCRN_CPR0_DATA);
-	tmp = (reg & 0x07000000) >> 24;
-	perdv0 = tmp ? tmp : 8;
-
-	mtdcr(DCRN_CPR0_ADDR, CPR0_PRIMBD0);
-	reg = mfdcr(DCRN_CPR0_DATA);
-	tmp = (reg & 0x07000000) >> 24;
-	prbdv0 = tmp ? tmp : 8;
-
-	mtdcr(DCRN_CPR0_ADDR, CPR0_SCPID);
-	reg = mfdcr(DCRN_CPR0_DATA);
-	tmp = (reg & 0x03000000) >> 24;
-	spcid0 = tmp ? tmp : 4;
-
-	/* Calculate M */
-	mtdcr(DCRN_CPR0_ADDR, CPR0_PLLC0);
-	reg = mfdcr(DCRN_CPR0_DATA);
-	tmp = (reg & 0x03000000) >> 24;
-	if (tmp == 0) { /* PLL output */
-		tmp = (reg & 0x20000000) >> 29;
-		if (!tmp) /* PLLOUTA */
-			m = fbdv * lfbdv * fwdva;
+	u32 sys0 = mfdcr(DCRN_CPC0_SYS0);
+	u32 cr0 = mfdcr(DCRN_CPC0_CR0);
+	u32 cpu, plb, opb, ebc, tb, uart0, uart1, m;
+	u32 opdv = CPC0_SYS0_OPDV(sys0);
+	u32 epdv = CPC0_SYS0_EPDV(sys0);
+
+	if (sys0 & CPC0_SYS0_BYPASS) {
+		/* Bypass system PLL */
+		cpu = plb = sys_clk;
+	} else {
+		if (sys0 & CPC0_SYS0_EXTSL)
+			/* PerClk */
+			m = CPC0_SYS0_FWDVB(sys0) * opdv * epdv;
 		else
-			m = fbdv * lfbdv * fwdvb;
+			/* CPU clock */
+			m = CPC0_SYS0_FBDV(sys0) * CPC0_SYS0_FWDVA(sys0);
+		cpu = sys_clk * m / CPC0_SYS0_FWDVA(sys0);
+		plb = sys_clk * m / CPC0_SYS0_FWDVB(sys0);
 	}
-	else if (tmp == 1) /* CPU output */
-		m = fbdv * fwdva;
+
+	opb = plb / opdv;
+	ebc = opb / epdv;
+
+	/* FIXME: Check if this is for all 440GP, or just Ebony */
+	if ((mfpvr() & 0xf0000fff) == 0x40000440)
+		/* Rev. B 440GP, use external system clock */
+		tb = sys_clk;
 	else
-		m = perdv0 * opbdv0 * fwdvb;
+		/* Rev. C 440GP, errata force us to use internal clock */
+		tb = cpu;
 
-	vco = (m * sysclk) + (m >> 1);
-	cpu = vco / fwdva;
-	plb = vco / fwdvb / prbdv0;
-	opb = plb / opbdv0;
-	ebc = plb / perdv0;
+	if (cr0 & CPC0_CR0_U0EC)
+		/* External UART clock */
+		uart0 = ser_clk;
+	else
+		/* Internal UART clock */
+		uart0 = plb / CPC0_CR0_UDIV(cr0);
 
-	/* FIXME */
-	uart0 = ser_clk;
+	if (cr0 & CPC0_CR0_U1EC)
+		/* External UART clock */
+		uart1 = ser_clk;
+	else
+		/* Internal UART clock */
+		uart1 = plb / CPC0_CR0_UDIV(cr0);
+
+	printf("PPC440GP: SysClk = %dMHz (%x)\n\r",
+	       (sys_clk + 500000) / 1000000, sys_clk);
+
+	dt_fixup_cpu_clocks(cpu, tb, 0);
+
+	dt_fixup_clock("/plb", plb);
+	dt_fixup_clock("/plb/opb", opb);
+	dt_fixup_clock("/plb/opb/ebc", ebc);
+	dt_fixup_clock("/plb/opb/serial@40000200", uart0);
+	dt_fixup_clock("/plb/opb/serial@40000300", uart1);
+}
+
+#define SPRN_CCR1 0x378
+
+static inline u32 __fix_zero(u32 v, u32 def)
+{
+	return v ? v : def;
+}
+
+static unsigned int __ibm440eplike_fixup_clocks(unsigned int sys_clk,
+						unsigned int tmr_clk,
+						int per_clk_from_opb)
+{
+	/* PLL config */
+	u32 pllc  = CPR0_READ(DCRN_CPR0_PLLC);
+	u32 plld  = CPR0_READ(DCRN_CPR0_PLLD);
+
+	/* Dividers */
+	u32 fbdv   = __fix_zero((plld >> 24) & 0x1f, 32);
+	u32 fwdva  = __fix_zero((plld >> 16) & 0xf, 16);
+	u32 fwdvb  = __fix_zero((plld >> 8) & 7, 8);
+	u32 lfbdv  = __fix_zero(plld & 0x3f, 64);
+	u32 pradv0 = __fix_zero((CPR0_READ(DCRN_CPR0_PRIMAD) >> 24) & 7, 8);
+	u32 prbdv0 = __fix_zero((CPR0_READ(DCRN_CPR0_PRIMBD) >> 24) & 7, 8);
+	u32 opbdv0 = __fix_zero((CPR0_READ(DCRN_CPR0_OPBD) >> 24) & 3, 4);
+	u32 perdv0 = __fix_zero((CPR0_READ(DCRN_CPR0_PERD) >> 24) & 3, 4);
+
+	/* Input clocks for primary dividers */
+	u32 clk_a, clk_b;
+
+	/* Resulting clocks */
+	u32 cpu, plb, opb, ebc, vco;
+
+	/* Timebase */
+	u32 ccr1, tb = tmr_clk;
+
+	if (pllc & 0x40000000) {
+		u32 m;
+
+		/* Feedback path */
+		switch ((pllc >> 24) & 7) {
+		case 0:
+			/* PLLOUTx */
+			m = ((pllc & 0x20000000) ? fwdvb : fwdva) * lfbdv;
+			break;
+		case 1:
+			/* CPU */
+			m = fwdva * pradv0;
+			break;
+		case 5:
+			/* PERClk */
+			m = fwdvb * prbdv0 * opbdv0 * perdv0;
+			break;
+		default:
+			printf("WARNING ! Invalid PLL feedback source !\n");
+			goto bypass;
+		}
+		m *= fbdv;
+		vco = sys_clk * m;
+		clk_a = vco / fwdva;
+		clk_b = vco / fwdvb;
+	} else {
+bypass:
+		/* Bypass system PLL */
+		vco = 0;
+		clk_a = clk_b = sys_clk;
+	}
+
+	cpu = clk_a / pradv0;
+	plb = clk_b / prbdv0;
+	opb = plb / opbdv0;
+	ebc = (per_clk_from_opb ? opb : plb) / perdv0;
 
 	/* Figure out timebase.  Either CPU or default TmrClk */
-	asm volatile (
-			"mfspr	%0,%1\n"
-			:
-			"=&r"(reg) : "i"(SPRN_CCR1));
-	if (reg & 0x0080)
-		tb = 25000000; /* TmrClk is 25MHz */
-	else
+	ccr1 = mfspr(SPRN_CCR1);
+
+	/* If passed a 0 tmr_clk, force CPU clock */
+	if (tb == 0) {
+		ccr1 &= ~0x80u;
+		mtspr(SPRN_CCR1, ccr1);
+	}
+	if ((ccr1 & 0x0080) == 0)
 		tb = cpu;
 
 	dt_fixup_cpu_clocks(cpu, tb, 0);
 	dt_fixup_clock("/plb", plb);
 	dt_fixup_clock("/plb/opb", opb);
 	dt_fixup_clock("/plb/opb/ebc", ebc);
-	dt_fixup_clock("/plb/opb/serial@ef600300", uart0);
-	dt_fixup_clock("/plb/opb/serial@ef600400", uart0);
-	dt_fixup_clock("/plb/opb/serial@ef600500", uart0);
-	dt_fixup_clock("/plb/opb/serial@ef600600", uart0);
+
+	return plb;
+}
+
+static void eplike_fixup_uart_clk(int index, const char *path,
+				  unsigned int ser_clk,
+				  unsigned int plb_clk)
+{
+	unsigned int sdr;
+	unsigned int clock;
+
+	switch (index) {
+	case 0:
+		sdr = SDR0_READ(DCRN_SDR0_UART0);
+		break;
+	case 1:
+		sdr = SDR0_READ(DCRN_SDR0_UART1);
+		break;
+	case 2:
+		sdr = SDR0_READ(DCRN_SDR0_UART2);
+		break;
+	case 3:
+		sdr = SDR0_READ(DCRN_SDR0_UART3);
+		break;
+	default:
+		return;
+	}
+
+	if (sdr & 0x00800000u)
+		clock = ser_clk;
+	else
+		clock = plb_clk / __fix_zero(sdr & 0xff, 256);
+
+	dt_fixup_clock(path, clock);
+}
+
+void ibm440ep_fixup_clocks(unsigned int sys_clk,
+			   unsigned int ser_clk,
+			   unsigned int tmr_clk)
+{
+	unsigned int plb_clk = __ibm440eplike_fixup_clocks(sys_clk, tmr_clk, 0);
+
+	/* serial clocks beed fixup based on int/ext */
+	eplike_fixup_uart_clk(0, "/plb/opb/serial@ef600300", ser_clk, plb_clk);
+	eplike_fixup_uart_clk(1, "/plb/opb/serial@ef600400", ser_clk, plb_clk);
+	eplike_fixup_uart_clk(2, "/plb/opb/serial@ef600500", ser_clk, plb_clk);
+	eplike_fixup_uart_clk(3, "/plb/opb/serial@ef600600", ser_clk, plb_clk);
+}
+
+void ibm440gx_fixup_clocks(unsigned int sys_clk,
+			   unsigned int ser_clk,
+			   unsigned int tmr_clk)
+{
+	unsigned int plb_clk = __ibm440eplike_fixup_clocks(sys_clk, tmr_clk, 1);
+
+	/* serial clocks beed fixup based on int/ext */
+	eplike_fixup_uart_clk(0, "/plb/opb/serial@40000200", ser_clk, plb_clk);
+	eplike_fixup_uart_clk(1, "/plb/opb/serial@40000300", ser_clk, plb_clk);
+}
+
+void ibm440spe_fixup_clocks(unsigned int sys_clk,
+			    unsigned int ser_clk,
+			    unsigned int tmr_clk)
+{
+	unsigned int plb_clk = __ibm440eplike_fixup_clocks(sys_clk, tmr_clk, 1);
+
+	/* serial clocks beed fixup based on int/ext */
+	eplike_fixup_uart_clk(0, "/plb/opb/serial@10000200", ser_clk, plb_clk);
+	eplike_fixup_uart_clk(1, "/plb/opb/serial@10000300", ser_clk, plb_clk);
+	eplike_fixup_uart_clk(2, "/plb/opb/serial@10000600", ser_clk, plb_clk);
 }
 
-void ibm405gp_fixup_clocks(unsigned int sysclk, unsigned int ser_clk)
+void ibm405gp_fixup_clocks(unsigned int sys_clk, unsigned int ser_clk)
 {
 	u32 pllmr = mfdcr(DCRN_CPC0_PLLMR);
 	u32 cpc0_cr0 = mfdcr(DCRN_405_CPC0_CR0);
@@ -374,7 +510,7 @@ void ibm405gp_fixup_clocks(unsigned int 
 
 	m = fwdv * fbdv * cbdv;
 
-	cpu = sysclk * m / fwdv;
+	cpu = sys_clk * m / fwdv;
 	plb = cpu / cbdv;
 	opb = plb / opdv;
 	ebc = plb / epdv;
Index: linux-work/arch/powerpc/boot/4xx.h
===================================================================
--- linux-work.orig/arch/powerpc/boot/4xx.h	2007-12-03 14:25:34.000000000 +1100
+++ linux-work/arch/powerpc/boot/4xx.h	2007-12-03 14:26:09.000000000 +1100
@@ -18,7 +18,14 @@ void ibm44x_dbcr_reset(void);
 void ibm40x_dbcr_reset(void);
 void ibm4xx_quiesce_eth(u32 *emac0, u32 *emac1);
 void ibm4xx_fixup_ebc_ranges(const char *ebc);
-void ibm440ep_fixup_clocks(unsigned int sysclk, unsigned int ser_clk);
-void ibm405gp_fixup_clocks(unsigned int sysclk, unsigned int ser_clk);
+
+void ibm405gp_fixup_clocks(unsigned int sys_clk, unsigned int ser_clk);
+void ibm440gp_fixup_clocks(unsigned int sys_clk, unsigned int ser_clk);
+void ibm440ep_fixup_clocks(unsigned int sys_clk, unsigned int ser_clk,
+			   unsigned int tmr_clk);
+void ibm440gx_fixup_clocks(unsigned int sys_clk, unsigned int ser_clk,
+			   unsigned int tmr_clk);
+void ibm440spe_fixup_clocks(unsigned int sys_clk, unsigned int ser_clk,
+			    unsigned int tmr_clk);
 
 #endif /* _POWERPC_BOOT_4XX_H_ */
Index: linux-work/arch/powerpc/boot/ebony.c
===================================================================
--- linux-work.orig/arch/powerpc/boot/ebony.c	2007-12-03 14:25:34.000000000 +1100
+++ linux-work/arch/powerpc/boot/ebony.c	2007-12-03 14:26:09.000000000 +1100
@@ -31,66 +31,6 @@
 
 static u8 *ebony_mac0, *ebony_mac1;
 
-/* Calculate 440GP clocks */
-void ibm440gp_fixup_clocks(unsigned int sysclk, unsigned int ser_clk)
-{
-	u32 sys0 = mfdcr(DCRN_CPC0_SYS0);
-	u32 cr0 = mfdcr(DCRN_CPC0_CR0);
-	u32 cpu, plb, opb, ebc, tb, uart0, uart1, m;
-	u32 opdv = CPC0_SYS0_OPDV(sys0);
-	u32 epdv = CPC0_SYS0_EPDV(sys0);
-
-	if (sys0 & CPC0_SYS0_BYPASS) {
-		/* Bypass system PLL */
-		cpu = plb = sysclk;
-	} else {
-		if (sys0 & CPC0_SYS0_EXTSL)
-			/* PerClk */
-			m = CPC0_SYS0_FWDVB(sys0) * opdv * epdv;
-		else
-			/* CPU clock */
-			m = CPC0_SYS0_FBDV(sys0) * CPC0_SYS0_FWDVA(sys0);
-		cpu = sysclk * m / CPC0_SYS0_FWDVA(sys0);
-		plb = sysclk * m / CPC0_SYS0_FWDVB(sys0);
-	}
-
-	opb = plb / opdv;
-	ebc = opb / epdv;
-
-	/* FIXME: Check if this is for all 440GP, or just Ebony */
-	if ((mfpvr() & 0xf0000fff) == 0x40000440)
-		/* Rev. B 440GP, use external system clock */
-		tb = sysclk;
-	else
-		/* Rev. C 440GP, errata force us to use internal clock */
-		tb = cpu;
-
-	if (cr0 & CPC0_CR0_U0EC)
-		/* External UART clock */
-		uart0 = ser_clk;
-	else
-		/* Internal UART clock */
-		uart0 = plb / CPC0_CR0_UDIV(cr0);
-
-	if (cr0 & CPC0_CR0_U1EC)
-		/* External UART clock */
-		uart1 = ser_clk;
-	else
-		/* Internal UART clock */
-		uart1 = plb / CPC0_CR0_UDIV(cr0);
-
-	printf("PPC440GP: SysClk = %dMHz (%x)\n\r",
-	       (sysclk + 500000) / 1000000, sysclk);
-
-	dt_fixup_cpu_clocks(cpu, tb, 0);
-
-	dt_fixup_clock("/plb", plb);
-	dt_fixup_clock("/plb/opb", opb);
-	dt_fixup_clock("/plb/opb/ebc", ebc);
-	dt_fixup_clock("/plb/opb/serial@40000200", uart0);
-	dt_fixup_clock("/plb/opb/serial@40000300", uart1);
-}
-
 #define EBONY_FPGA_PATH		"/plb/opb/ebc/fpga"
 #define	EBONY_FPGA_FLASH_SEL	0x01
 #define EBONY_SMALL_FLASH_PATH	"/plb/opb/ebc/small-flash"
Index: linux-work/arch/powerpc/boot/dcr.h
===================================================================
--- linux-work.orig/arch/powerpc/boot/dcr.h	2007-12-03 14:25:34.000000000 +1100
+++ linux-work/arch/powerpc/boot/dcr.h	2007-12-03 14:26:09.000000000 +1100
@@ -160,6 +160,23 @@ static const unsigned long sdram_bxcr[] 
 #define DCRN_CPR0_PERD					0x0e0
 #define DCRN_CPR0_MALD					0x100
 
+#define DCRN_SDR0_CONFIG_ADDR 	0xe
+#define DCRN_SDR0_CONFIG_DATA	0xf
+
+/* SDR read/write helper macros */
+#define SDR0_READ(offset) ({\
+	mtdcr(DCRN_SDR0_CONFIG_ADDR, offset); \
+	mfdcr(DCRN_SDR0_CONFIG_DATA); })
+#define SDR0_WRITE(offset, data) ({\
+	mtdcr(DCRN_SDR0_CONFIG_ADDR, offset); \
+	mtdcr(DCRN_SDR0_CONFIG_DATA, data); })
+
+#define DCRN_SDR0_UART0		0x0120
+#define DCRN_SDR0_UART1		0x0121
+#define DCRN_SDR0_UART2		0x0122
+#define DCRN_SDR0_UART3		0x0123
+
+
 /* CPRs read/write helper macros - based off include/asm-ppc/ibm44x.h */
 
 #define DCRN_CPR0_CFGADDR				0xc
Index: linux-work/arch/powerpc/boot/bamboo.c
===================================================================
--- linux-work.orig/arch/powerpc/boot/bamboo.c	2007-12-03 14:25:34.000000000 +1100
+++ linux-work/arch/powerpc/boot/bamboo.c	2007-12-03 14:26:09.000000000 +1100
@@ -30,7 +30,7 @@ static void bamboo_fixups(void)
 {
 	unsigned long sysclk = 33333333;
 
-	ibm440ep_fixup_clocks(sysclk, 11059200);
+	ibm440ep_fixup_clocks(sysclk, 11059200, 25000000);
 	ibm4xx_sdram_fixup_memsize();
 	ibm4xx_quiesce_eth((u32 *)0xef600e00, (u32 *)0xef600f00);
 	dt_fixup_mac_addresses(bamboo_mac0, bamboo_mac1);
Index: linux-work/arch/powerpc/boot/cuboot-sequoia.c
===================================================================
--- linux-work.orig/arch/powerpc/boot/cuboot-sequoia.c	2007-12-03 14:25:25.000000000 +1100
+++ linux-work/arch/powerpc/boot/cuboot-sequoia.c	2007-12-03 14:26:09.000000000 +1100
@@ -39,7 +39,7 @@ static void sequoia_fixups(void)
 {
 	unsigned long sysclk = 33333333;
 
-	ibm440ep_fixup_clocks(sysclk, 11059200);
+	ibm440ep_fixup_clocks(sysclk, 11059200, 25000000);
 	ibm4xx_fixup_ebc_ranges("/plb/opb/ebc");
 	ibm4xx_denali_fixup_memsize();
 	dt_fixup_mac_addresses(&bd.bi_enetaddr, &bd.bi_enet1addr);
Index: linux-work/arch/powerpc/boot/cuboot-taishan.c
===================================================================
--- linux-work.orig/arch/powerpc/boot/cuboot-taishan.c	2007-12-03 14:25:54.000000000 +1100
+++ linux-work/arch/powerpc/boot/cuboot-taishan.c	2007-12-03 14:26:09.000000000 +1100
@@ -34,9 +34,7 @@ static void taishan_fixups(void)
 	   registers */
 	unsigned long sysclk = 33000000;
 
-	/* 440EP Clock logic is all but identical to 440GX
-	   so we just use that code for now at least */
-	ibm440ep_fixup_clocks(sysclk, 6 * 1843200);
+	ibm440gx_fixup_clocks(sysclk, 6 * 1843200, 25000000);
 
 	ibm4xx_sdram_fixup_memsize();
 
