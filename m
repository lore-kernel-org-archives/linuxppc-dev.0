Return-Path: <wfarnsworth@mvista.com>
Received: from hermes.mvista.com (gateway-1237.mvista.com [63.81.120.158])
	by ozlabs.org (Postfix) with ESMTP id 836AE67A5F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Mar 2006 10:53:00 +1100 (EST)
Subject: Re: [PATCH 5/6] Clock and power management define fixes for 440SP
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
In-Reply-To: <1141257084.25758.28.camel@rhino.az.mvista.com>
References: <1141256113.25761.14.camel@rhino.az.mvista.com>
	<1141256751.25761.19.camel@rhino.az.mvista.com>
	<1141256859.25758.22.camel@rhino.az.mvista.com>
	<1141257021.25761.26.camel@rhino.az.mvista.com>
	<1141257084.25758.28.camel@rhino.az.mvista.com>
Content-Type: multipart/mixed; boundary="=-bf8N2+ziezUiC/P/VRM8"
Message-Id: <1141257179.25758.31.camel@rhino.az.mvista.com>
Mime-Version: 1.0
Date: 01 Mar 2006 16:52:59 -0700
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-bf8N2+ziezUiC/P/VRM8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This fixes the clock and power management defines on the 440SP.

--Wade

Signed off by: Wade Farnsworth <wfarnsworth@mvista.com>

--=-bf8N2+ziezUiC/P/VRM8
Content-Disposition: attachment; filename=luan-cpm.patch
Content-Type: text/x-patch; name=luan-cpm.patch
Content-Transfer-Encoding: 7bit

diff --git a/arch/ppc/platforms/4xx/ibm440sp.h b/arch/ppc/platforms/4xx/ibm440sp.h
--- a/arch/ppc/platforms/4xx/ibm440sp.h
+++ b/arch/ppc/platforms/4xx/ibm440sp.h
@@ -32,33 +32,28 @@
 /* Clock and Power Management */
 #define IBM_CPM_IIC0		0x80000000	/* IIC interface */
 #define IBM_CPM_IIC1		0x40000000	/* IIC interface */
-#define IBM_CPM_PCI		0x20000000	/* PCI bridge */
-#define IBM_CPM_CPU		    0x02000000	/* processor core */
-#define IBM_CPM_DMA		    0x01000000	/* DMA controller */
-#define IBM_CPM_BGO		    0x00800000	/* PLB to OPB bus arbiter */
-#define IBM_CPM_BGI		    0x00400000	/* OPB to PLB bridge */
-#define IBM_CPM_EBC		    0x00200000	/* External Bux Controller */
-#define IBM_CPM_EBM		    0x00100000	/* Ext Bus Master Interface */
-#define IBM_CPM_DMC		    0x00080000	/* SDRAM peripheral controller */
-#define IBM_CPM_PLB		    0x00040000	/* PLB bus arbiter */
+#define IBM_CPM_PCIX0		0x20000000	/* PCIX bridge 0 */
+#define IBM_CPM_PCIX1		0x10000000	/* PCIX bridge 1 */
+#define IBM_CPM_PCIX2		0x08000000	/* PCIX bridge 2 */
+#define IBM_CPM_CPU		0x02000000	/* processor core */
+#define IBM_CPM_BGO		0x00800000	/* PLB to OPB bus arbiter */
+#define IBM_CPM_EBC		0x00200000	/* External Bux Controller */
+#define IBM_CPM_PLB		0x00040000	/* PLB bus arbiter */
 #define IBM_CPM_SRAM		0x00020000	/* SRAM memory controller */
-#define IBM_CPM_PPM		    0x00002000	/* PLB Performance Monitor */
 #define IBM_CPM_UIC1		0x00001000	/* Universal Interrupt Controller */
 #define IBM_CPM_GPIO0		0x00000800	/* General Purpose IO (??) */
-#define IBM_CPM_GPT		    0x00000400	/* General Purpose Timers  */
+#define IBM_CPM_GPT		0x00000400	/* General Purpose Timers  */
 #define IBM_CPM_UART0		0x00000200	/* serial port 0 */
 #define IBM_CPM_UART1		0x00000100	/* serial port 1 */
-#define IBM_CPM_UART2		0x00000100	/* serial port 1 */
 #define IBM_CPM_UIC0		0x00000080	/* Universal Interrupt Controller */
 #define IBM_CPM_TMRCLK		0x00000040	/* CPU timers */
 #define IBM_CPM_EMAC0  		0x00000020	/* EMAC 0     */
+#define IBM_CPM_UART2		0x00000010	/* serial port 2 */
 
-#define DFLT_IBM4xx_PM		~(IBM_CPM_UIC | IBM_CPM_UIC1 | IBM_CPM_CPU \
+#define DFLT_IBM4xx_PM		~(IBM_CPM_UIC0 | IBM_CPM_UIC1 | IBM_CPM_CPU \
 				| IBM_CPM_EBC | IBM_CPM_SRAM | IBM_CPM_BGO \
-				| IBM_CPM_EBM | IBM_CPM_PLB | IBM_CPM_OPB \
-				| IBM_CPM_TMRCLK | IBM_CPM_DMA | IBM_CPM_PCI \
-				| IBM_CPM_TAHOE0 | IBM_CPM_TAHOE1 \
-				| IBM_CPM_EMAC0 | IBM_CPM_EMAC1 \
-			  	| IBM_CPM_EMAC2 | IBM_CPM_EMAC3 )
+				| IBM_CPM_PLB | IBM_CPM_TMRCLK | IBM_CPM_PCIX0 \
+				| IBM_CPM_PCIX1 | IBM_CPM_PCIX2\
+				| IBM_CPM_EMAC0 )
 #endif /* __PPC_PLATFORMS_IBM440SP_H */
 #endif /* __KERNEL__ */

--=-bf8N2+ziezUiC/P/VRM8--
