Return-Path: <wfarnsworth@mvista.com>
Received: from hermes.mvista.com (gateway-1237.mvista.com [63.81.120.158])
	by ozlabs.org (Postfix) with ESMTP id 2404667A40
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Mar 2006 10:45:53 +1100 (EST)
Subject: Re: [PATCH 1/6] Support for UART 2 on 440SP and Luan
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <1141256113.25761.14.camel@rhino.az.mvista.com>
References: <1141256113.25761.14.camel@rhino.az.mvista.com>
Content-Type: multipart/mixed; boundary="=-S79XRZpzUE3TrEdAZmHV"
Message-Id: <1141256751.25761.19.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 01 Mar 2006 16:45:52 -0700
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-S79XRZpzUE3TrEdAZmHV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This fixes the IRQ number for UART 2 on the 440SP and adds support to
ibm440gx_get_clocks() for it.  It also enables the UART on the Luan.

--Wade

Signed off by: Wade Farnsworth <wfarnsworth@mvista.com>

--=-S79XRZpzUE3TrEdAZmHV
Content-Disposition: attachment; filename=luan-uart2.patch
Content-Type: text/x-patch; name=luan-uart2.patch
Content-Transfer-Encoding: 7bit

diff --git a/arch/ppc/platforms/4xx/ibm440sp.h b/arch/ppc/platforms/4xx/ibm440sp.h
--- a/arch/ppc/platforms/4xx/ibm440sp.h
+++ b/arch/ppc/platforms/4xx/ibm440sp.h
@@ -27,7 +27,7 @@
 #define PPC440SP_UART2_ADDR	0x00000001f0000600ULL
 #define UART0_INT		0
 #define UART1_INT		1
-#define UART2_INT		2
+#define UART2_INT		37
 
 /* Clock and Power Management */
 #define IBM_CPM_IIC0		0x80000000	/* IIC interface */
diff --git a/arch/ppc/platforms/4xx/luan.c b/arch/ppc/platforms/4xx/luan.c
--- a/arch/ppc/platforms/4xx/luan.c
+++ b/arch/ppc/platforms/4xx/luan.c
@@ -296,9 +296,12 @@ luan_early_serial_map(void)
 		printk("Early serial init of port 1 failed\n");
 	}
 
+	/* Enable UART2 */
+	SDR_WRITE(DCRN_SDR_PFC1, SDR_READ(DCRN_SDR_PFC1) | 0x01000000);
+	
 	port.membase = ioremap64(PPC440SP_UART2_ADDR, 8);
 	port.irq = UART2_INT;
-	port.uartclk = BASE_BAUD;
+	port.uartclk = clocks.uart2;
 	port.line = 2;
 
 	if (early_serial_setup(&port) != 0) {
diff --git a/arch/ppc/syslib/ibm440gx_common.c b/arch/ppc/syslib/ibm440gx_common.c
--- a/arch/ppc/syslib/ibm440gx_common.c
+++ b/arch/ppc/syslib/ibm440gx_common.c
@@ -34,8 +34,10 @@ void __init ibm440gx_get_clocks(struct i
 	u32 plld  = CPR_READ(DCRN_CPR_PLLD);
 	u32 uart0 = SDR_READ(DCRN_SDR_UART0);
 	u32 uart1 = SDR_READ(DCRN_SDR_UART1);
-#ifdef CONFIG_440EP
+#if defined(CONFIG_440EP) || defined(CONFIG_440SP)
 	u32 uart2 = SDR_READ(DCRN_SDR_UART2);
+#endif
+#if defined(CONFIG_440EP)
 	u32 uart3 = SDR_READ(DCRN_SDR_UART3);
 #endif
 
@@ -100,12 +102,15 @@ bypass:
 		p->uart1 = ser_clk;
 	else
 		p->uart1 = p->plb / __fix_zero(uart1 & 0xff, 256);
-#ifdef CONFIG_440EP
+
+#if defined(CONFIG_440EP) || (CONFIG_440SP)
 	if (uart2 & 0x00800000)
 		p->uart2 = ser_clk;
 	else
 		p->uart2 = p->plb / __fix_zero(uart2 & 0xff, 256);
+#endif
 
+#ifdef CONFIG_440EP
 	if (uart3 & 0x00800000)
 		p->uart3 = ser_clk;
 	else
diff --git a/arch/ppc/syslib/ibm44x_common.h b/arch/ppc/syslib/ibm44x_common.h
--- a/arch/ppc/syslib/ibm44x_common.h
+++ b/arch/ppc/syslib/ibm44x_common.h
@@ -29,8 +29,10 @@ struct ibm44x_clocks {
 	unsigned int ebc;	/* PerClk */
 	unsigned int uart0;
 	unsigned int uart1;
-#ifdef CONFIG_440EP
+#if defined(CONFIG_440EP) || defined(CONFIG_440SP)
 	unsigned int uart2;
+#endif
+#if defined(CONFIG_440EP)
 	unsigned int uart3;
 #endif
 };
diff --git a/include/asm-ppc/ibm44x.h b/include/asm-ppc/ibm44x.h
--- a/include/asm-ppc/ibm44x.h
+++ b/include/asm-ppc/ibm44x.h
@@ -179,8 +179,10 @@
 #define DCRN_SDR_UART0		0x0120
 #define DCRN_SDR_UART1		0x0121
 
-#ifdef CONFIG_440EP
+#if defined(CONFIG_440EP) || defined(CONFIG_440SP)
 #define DCRN_SDR_UART2		0x0122
+#endif
+#if defined(CONFIG_440EP)
 #define DCRN_SDR_UART3		0x0123
 #define DCRN_SDR_CUST0		0x4000
 #endif

--=-S79XRZpzUE3TrEdAZmHV--
