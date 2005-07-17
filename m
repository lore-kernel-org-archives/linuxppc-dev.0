Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.203])
	by ozlabs.org (Postfix) with ESMTP id E807B67C5A
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Jul 2005 17:06:05 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i27so864074wra
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Jul 2005 00:06:03 -0700 (PDT)
Message-ID: <528646bc0507170006540ac67a@mail.gmail.com>
Date: Sun, 17 Jul 2005 01:06:03 -0600
From: Grant Likely <glikely@gmail.com>
To: linuxppc-embedded@ozlabs.org, Sylvain Munaut <tnt@246tnt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [PATCH] ppc32: Register definition for MPC52xx
Reply-To: Grant Likely <glikely@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Here are additional register definitions for the MPC52xx.  CDM clock
enables and port config bit settings in mpc52xx.h.  Registers needed
to support non-UART PSC modes in mpc52xx_psc.h.  Drivers which use
these regs/bits are to follow once I'm happy with them, but I thought
that others may be interested in them now.

Cheers,
g.

Signed-off-by: Grant Likely <grant.likely@gdcanada.com>

General Dynamics Canada, Ltd. relinquishes copywrite on this patch to
the public domain

--- k/include/asm-ppc/mpc52xx.h  (mode:100644)
+++ l/include/asm-ppc/mpc52xx.h  (mode:100644)
@@ -146,6 +146,28 @@ enum ppc_sys_devices {
 #define MPC52xx_XLB_ARB_IRQ=09=09(MPC52xx_PERP_IRQ_BASE + 21)
 #define MPC52xx_BDLC_IRQ=09=09(MPC52xx_PERP_IRQ_BASE + 22)
=20
+/* CDM Cloke enable bits */
+#define MPC52xx_CDM_CLKENABLE_MEM_CLK=09=09(0x00080000)
+#define MPC52xx_CDM_CLKENABLE_PCI_CLK=09=09(0x00040000)
+#define MPC52xx_CDM_CLKENABLE_LPC_CLK=09=09(0x00020000)
+#define MPC52xx_CDM_CLKENABLE_SIT_CLK=09=09(0x00010000)
+#define MPC52xx_CDM_CLKENABLE_SCOM_CLK=09=09(0x00008000)
+#define MPC52xx_CDM_CLKENABLE_ATA_CLK=09=09(0x00004000)
+#define MPC52xx_CDM_CLKENABLE_ETH_CLK=09=09(0x00002000)
+#define MPC52xx_CDM_CLKENABLE_USB_CLK=09=09(0x00001000)
+#define MPC52xx_CDM_CLKENABLE_SPI_CLK=09=09(0x00000800)
+#define MPC52xx_CDM_CLKENABLE_BDLC_CLK=09=09(0x00000400)
+#define MPC52xx_CDM_CLKENABLE_IRRX_CLK=09=09(0x00000200)
+#define MPC52xx_CDM_CLKENABLE_IRTX_CLK=09=09(0x00000100)
+#define MPC52xx_CDM_CLKENABLE_PSC345_CLK=09(0x00000080)
+#define MPC52xx_CDM_CLKENABLE_PSC2_CLK=09=09(0x00000040)
+#define MPC52xx_CDM_CLKENABLE_PSC1_CLK=09=09(0x00000020)
+#define MPC52xx_CDM_CLKENABLE_PSC6_CLK=09=09(0x00000010)
+#define MPC52xx_CDM_CLKENABLE_MSCAN_CLK=09=09(0x00000008)
+#define MPC52xx_CDM_CLKENABLE_I2C_CLK=09=09(0x00000004)
+#define MPC52xx_CDM_CLKENABLE_TIMER_CLK=09=09(0x00000002)
+#define MPC52xx_CDM_CLKENABLE_GPIO_CLK=09=09(0x00000001)
+
=20
=20
 /* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
@@ -266,6 +288,49 @@ struct mpc52xx_rtc {
 };
=20
  /* GPIO */
+#define PORT_CONFIG_CS1=09=09=090x80000000
+#define PORT_CONFIG_ALT_MASK=09=090x30000000
+#define PORT_CONFIG_CS7=09=09=090x08000000
+#define PORT_CONFIG_CS6=09=09=090x04000000
+#define PORT_CONFIG_ATA=09=09=090x03000000
+#define PORT_CONFIG_IR_USB_CLK=09=090x00800000
+#define PORT_CONFIG_IRDA_MASK=09=090x00700000 /* PSC6 */
+#define PORT_CONFIG_IRDA_GPIO=09=090x00000000
+#define PORT_CONFIG_IRDA_UART=09=090x00500000
+#define PORT_CONFIG_IRDA_CODEC=09=090x00700000
+#define PORT_CONFIG_ETHER_MASK=09=090x000F0000
+#define PORT_CONFIG_PCI_DIS=09=090x00008000
+#define PORT_CONFIG_USB_SE=09=090x00004000 /* Single ended mode */
+#define PORT_CONFIG_USB_MASK=09=090x00004000 /* (USB1 or 2 UARTs) */
+#define PORT_CONFIG_USB_USB=09=090x00001000
+#define PORT_CONFIG_USB_2UART=09=090x00002000
+#define PORT_CONFIG_PSC3_MASK=09=090x00000F00
+#define PORT_CONFIG_PSC3_GPIO=09=090x00000000
+#define PORT_CONFIG_PSC3_USB2=09=090x00000100
+#define PORT_CONFIG_PSC3_UART=09=090x00000400
+#define PORT_CONFIG_PSC3_UARTE_CD=090x00000500
+#define PORT_CONFIG_PSC3_CODEC=09=090x00000600
+#define PORT_CONFIG_PSC3_CODEC_MCLK=090x00000700
+#define PORT_CONFIG_PSC3_SPI=09=090x00000800
+#define PORT_CONFIG_PSC3_SPI_UART=090x00000C00
+#define PORT_CONFIG_PSC3_SPI_UARTE=090x00000D00
+#define PORT_CONFIG_PSC3_SPI_CODEC=090x00000E00
+#define PORT_CONFIG_PSC2_MASK=09=090x00000070
+#define PORT_CONFIG_PSC2_GPIO=09=090x00000000
+#define PORT_CONFIG_PSC2_CAN=09=090x00000010
+#define PORT_CONFIG_PSC2_AC97=09=090x00000020
+#define PORT_CONFIG_PSC2_UART=09=090x00000040
+#define PORT_CONFIG_PSC2_UARTE_CD=090x00000050
+#define PORT_CONFIG_PSC2_CODEC=09=090x00000060
+#define PORT_CONFIG_PSC2_CODEC_MCLK=090x00000070
+#define PORT_CONFIG_PSC1_MASK=09=090x00000007
+#define PORT_CONFIG_PSC1_GPIO=09=090x00000000
+#define PORT_CONFIG_PSC1_AC97=09=090x00000002
+#define PORT_CONFIG_PSC1_UART=09=090x00000004
+#define PORT_CONFIG_PSC1_UARTE_CD=090x00000005
+#define PORT_CONFIG_PSC1_CODEC=09=090x00000006
+#define PORT_CONFIG_PSC1_CODEC_MCLK=090x00000007
+
  struct mpc52xx_gpio {
  =09u32=09port_config;=09/* GPIO + 0x00 */
  =09u32=09simple_gpioe;=09/* GPIO + 0x04 */
--- k/include/asm-ppc/mpc52xx_psc.h  (mode:100644)
+++ l/include/asm-ppc/mpc52xx_psc.h  (mode:100644)
@@ -72,6 +72,51 @@
 #define MPC52xx_PSC_D_CTS=09=090x10
 #define MPC52xx_PSC_D_DCD=09=090x20
=20
+/* PSC Serial Interface Control Register (SICR) bits */
+/* SICR Field masks */
+#define MPC52xx_PSC_SICR_ACRB=09=090x80000000
+#define MPC52xx_PSC_SICR_AWR=09=090x40000000
+#define MPC52xx_PSC_SICR_DTS1=09=090x20000000
+#define MPC52xx_PSC_SICR_SHDIR=09=090x10000000
+#define MPC52xx_PSC_SICR_SIM=09=090x0F000000
+#define MPC52xx_PSC_SICR_GENCLK=09=090x00800000
+#define MPC52xx_PSC_SICR_MULTIWD=090x00400000
+#define MPC52xx_PSC_SICR_CLKPOL=09=090x00200000
+#define MPC52xx_PSC_SICR_SYNCPOL=090x00100000
+#define MPC52xx_PSC_SICR_CELLSLAVE=090x00080000
+#define MPC52xx_PSC_SICR_CELL2XCLK=090x00040000
+#define MPC52xx_PSC_SICR_SPI=09=090x00008000
+#define MPC52xx_PSC_SICR_MSTR=09=090x00004000
+#define MPC52xx_PSC_SICR_CPOL=09=090x00002000
+#define MPC52xx_PSC_SICR_CPHA=09=090x00001000
+#define MPC52xx_PSC_SICR_USEEOF=09=090x00000800
+/* Operation modes */
+#define MPC52xx_PSC_SICR_SIM_UART=09=090x00000000
+#define MPC52xx_PSC_SICR_SIM_UART_DCD=09=090x08000000
+#define MPC52xx_PSC_SICR_SIM_CODEC8=09=090x01000000
+#define MPC52xx_PSC_SICR_SIM_CODEC16=09=090x02000000
+#define MPC52xx_PSC_SICR_SIM_AC97=09=090x03000000
+#define MPC52xx_PSC_SICR_SIM_SIR=09=090x04000000
+#define MPC52xx_PSC_SICR_SIM_SIR_DCD=09=090x0C000000
+#define MPC52xx_PSC_SICR_SIM_MIR=09=090x05000000
+#define MPC52xx_PSC_SICR_SIM_FIR=09=090x06000000
+#define MPC52xx_PSC_SICR_SIM_CODEC24=09=090x07000000
+#define MPC52xx_PSC_SICR_SIM_CODEC32=09=090x0F000000
+
+/* IRCR1 bit masks */
+#define MPC52xx_PSC_IRCR1_FD=09=09=090x04
+#define MPC52xx_PSC_IRCR1_SIPEN=09=09=090x02
+#define MPC52xx_PSC_IRCR1_SPUL=09=09=090x01
+
+/* IRCR2 bit masks */
+#define MPC52xx_PSC_IRCR2_SIPREQ=09=090x04
+#define MPC52xx_PSC_IRCR2_ABORT=09=09=090x02
+#define MPC52xx_PSC_IRCR2_NXTEOF=09=090x01
+
+/* Codec Clock Register fields */
+#define MPC52xx_PSC_CCR_FRAME_SYNC_DIV=09=090xFF00
+#define MPC52xx_PSC_CCR_BIT_CLK_DIV=09=090xFF00
+
  /* PSC mode fields */
 #define MPC52xx_PSC_MODE_5_BITS=09=09=090x00
 #define MPC52xx_PSC_MODE_6_BITS=09=09=090x01
