Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4425E67A60
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Apr 2006 02:50:02 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FZ9gL-0001oZ-Gw
	for linuxppc-embedded@ozlabs.org; Thu, 27 Apr 2006 18:49:34 +0200
Received: from icarus.icarus.com ([64.105.89.2])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 27 Apr 2006 18:49:33 +0200
Received: from steve by icarus.icarus.com with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 27 Apr 2006 18:49:33 +0200
To: linuxppc-embedded@ozlabs.org
From: Stephen Williams <steve@icarus.com>
Subject: Re: PPC 405GPr support in linux 2.4.32
Date: Thu, 27 Apr 2006 09:48:42 -0700
Message-ID: <4450F5EA.4090105@icarus.com>
References: <e2ov5s$1hn$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060700040204030601010603"
In-Reply-To: <e2ov5s$1hn$1@sea.gmane.org>
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060700040204030601010603
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Stephen Williams wrote:
> ... seems completely missing in the linux-2.3.32 tree from kernel.org.
> This used to be in the linuxppc-2.4 BK tree that no longer exists, so
> what happened to the ppc405GPr support?!

The attached patch adds the ibm405gpr support files from various
places and adds the core support to Linux 2.4. Although this diff
was done relative Marcelo's git tree, it actually touches no C files,
only a few config and make files (Plus it adds the gpr support c/h
files) so it should apply to any recent 2.4 kernel tree.

I'm almost ready with a patch that does a similar thing with
the SystemACE driver.

-- 
Steve Williams                "The woods are lovely, dark and deep.
steve at icarus.com           But I have promises to keep,
http://www.icarus.com         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."

--------------060700040204030601010603
Content-Type: text/plain;
 name="0001-Core-ppc405GPr-support.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Core-ppc405GPr-support.txt"

>From nobody Mon Sep 17 00:00:00 2001
From: Stephen Williams <steve@wing.icarus.com>
Date: Thu Apr 27 08:45:41 2006 -0700
Subject: [PATCH]  Core ppc405GPr support.

Signed-off-by: Stephen Williams <steve@wing.icarus.com>


---

 arch/ppc/config.in             |    3 -
 arch/ppc/platforms/Makefile    |    1 
 arch/ppc/platforms/ibm405gpr.c |  108 ++++++++++++++++++++++
 arch/ppc/platforms/ibm405gpr.h |  193 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 304 insertions(+), 1 deletions(-)
 create mode 100644 arch/ppc/platforms/ibm405gpr.c
 create mode 100644 arch/ppc/platforms/ibm405gpr.h

ac23ca9a2f268eec56eea0edd595502ef6e94abc
diff --git a/arch/ppc/config.in b/arch/ppc/config.in
index ade3865..089d479 100644
--- a/arch/ppc/config.in
+++ b/arch/ppc/config.in
@@ -232,7 +232,8 @@ if [ "$CONFIG_4xx" = "y" ]; then
 #
 # Set options based on processor implementation
 #
-  if [ "$CONFIG_405GP" = "y" -o "$CONFIG_STB03xxx" = "y" ]; then
+  if [ "$CONFIG_405GP" = "y" -o "$CONFIG_405GPR" = "y" \
+	-o "$CONFIG_STB03xxx" = "y" ]; then
     define_bool CONFIG_IBM_OCP y
     define_bool CONFIG_PPC_OCP y
     define_bool CONFIG_405 y
diff --git a/arch/ppc/platforms/Makefile b/arch/ppc/platforms/Makefile
index ab84e70..3aaebc6 100644
--- a/arch/ppc/platforms/Makefile
+++ b/arch/ppc/platforms/Makefile
@@ -29,6 +29,7 @@ O_TARGET := platform.o
 export-objs			:= prep_setup.o ibm440gp.o ibm440gx.o
 
 obj-$(CONFIG_405GP)		+= ibm405gp.o
+obj-$(CONFIG_405GPR)		+= ibm405gpr.o
 obj-$(CONFIG_440GP)		+= ibm440gp.o
 obj-$(CONFIG_440GX)		+= ibm440gx.o
 
diff --git a/arch/ppc/platforms/ibm405gpr.c b/arch/ppc/platforms/ibm405gpr.c
new file mode 100644
index 0000000..1e05b7d
--- /dev/null
+++ b/arch/ppc/platforms/ibm405gpr.c
@@ -0,0 +1,108 @@
+/*
+ *
+ *    Copyright 2000-2002 MontaVista Software Inc.
+ *	Current maintainer
+ *      Armin Kuster akuster@mvista.com
+ *
+ *    Module name: ibm405gpr.c
+ *
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR   IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT,  INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/threads.h>
+#include <linux/param.h>
+#include <linux/string.h>
+#include <platforms/ibm405gpr.h>
+#include <asm/ibm4xx.h>
+#include <asm/ocp.h>
+
+static struct ocp_func_emac_data ibm405gpr_emac0_def = {
+	.zmii_idx	= -1,		/* ZMII device index */
+	.zmii_mux	= 0,		/* ZMII input of this EMAC */
+	.mal_idx	= 0,		/* MAL device index */
+	.mal_rx_chan	= 0,		/* MAL rx channel number */
+	.mal_tx1_chan	= 0,		/* MAL tx channel 1 number */
+	.mal_tx2_chan	= 1,		/* MAL tx channel 2 number */
+	.wol_irq	= BL_MAC_WOL,	/* WOL interrupt number */
+	.mdio_idx	= -1,		/* No shared MDIO */
+};
+
+static struct ocp_func_mal_data ibm405gpr_mal0_def = {
+	.num_tx_chans	= 2*EMAC_NUMS,	/* Number of TX channels */
+	.num_rx_chans	= EMAC_NUMS,	/* Number of RX channels */
+};
+
+struct ocp_def core_ocp[]  __initdata = {
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_OPB,
+	  .index	= 0,
+	  .paddr	= OPB_BASE_START,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 0,
+	  .paddr	= UART0_IO_BASE,
+	  .irq		= UART0_INT,
+	  .pm		= IBM_CPM_UART0
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_16550,
+	  .index	= 1,
+	  .paddr	= UART1_IO_BASE,
+	  .irq		= UART1_INT,
+	  .pm		= IBM_CPM_UART1
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_IIC,
+	  .paddr	= IIC0_BASE,
+	  .irq		= IIC0_IRQ,
+	  .pm		= IBM_CPM_IIC0
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_GPIO,
+	  .paddr	= GPIO0_BASE,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= IBM_CPM_GPIO0
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_MAL,
+	  .paddr	= OCP_PADDR_NA,
+	  .irq		= OCP_IRQ_NA,
+	  .pm		= OCP_CPM_NA,
+	  .additions	= &ibm405gpr_mal0_def,
+	},
+	{ .vendor	= OCP_VENDOR_IBM,
+	  .function	= OCP_FUNC_EMAC,
+	  .index	= 0,
+	  .paddr	= EMAC0_BASE,
+	  .irq		= BL_MAC_ETH0,
+	  .pm		= IBM_CPM_EMAC0,
+	  .additions	= &ibm405gpr_emac0_def,
+	},
+	{ .vendor	= OCP_VENDOR_INVALID
+	}
+};
diff --git a/arch/ppc/platforms/ibm405gpr.h b/arch/ppc/platforms/ibm405gpr.h
new file mode 100644
index 0000000..273274c
--- /dev/null
+++ b/arch/ppc/platforms/ibm405gpr.h
@@ -0,0 +1,193 @@
+/*
+ * ibm405gpr.h
+ *
+ *
+ *      Armin Kuster akuster@mvista.com
+ *      Aug, 2002
+ *
+ *
+ * Copyright 2002 MontaVista Softare Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR   IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT,  INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *	Version 1.0 (10/01/02) - A. Kuster
+ *	Initial version	 
+ *
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASM_IBM405GPR_H__
+#define __ASM_IBM405GPR_H__
+
+#include <linux/config.h>
+#include <platforms/ibm_ocp.h>
+
+/* ibm405.h at bottom of this file */
+
+/* PCI
+ * PCI Bridge config reg definitions
+ * see 17-19 of manual
+ */
+
+#define PPC405_PCI_CONFIG_ADDR	0xeec00000
+#define PPC405_PCI_CONFIG_DATA	0xeec00004
+
+#define PPC405_PCI_PHY_MEM_BASE	0x80000000	/* hose_a->pci_mem_offset */
+						/* setbat */
+#define PPC405_PCI_MEM_BASE	PPC405_PCI_PHY_MEM_BASE	/* setbat */
+#define PPC405_PCI_PHY_IO_BASE	0xe8000000	/* setbat */
+#define PPC405_PCI_IO_BASE	PPC405_PCI_PHY_IO_BASE	/* setbat */
+
+#define PPC405_PCI_LOWER_MEM	0x80000000	/* hose_a->mem_space.start */
+#define PPC405_PCI_UPPER_MEM	0xBfffffff	/* hose_a->mem_space.end */
+#define PPC405_PCI_LOWER_IO	0x00000000	/* hose_a->io_space.start */
+#define PPC405_PCI_UPPER_IO	0x0000ffff	/* hose_a->io_space.end */
+
+#define PPC405_ISA_IO_BASE	PPC405_PCI_IO_BASE
+
+#define PPC4xx_PCI_IO_PADDR	((uint)PPC405_PCI_PHY_IO_BASE)
+#define PPC4xx_PCI_IO_VADDR	PPC4xx_PCI_IO_PADDR
+#define PPC4xx_PCI_IO_SIZE	((uint)64*1024)
+#define PPC4xx_PCI_CFG_PADDR	((uint)PPC405_PCI_CONFIG_ADDR)
+#define PPC4xx_PCI_CFG_VADDR	PPC4xx_PCI_CFG_PADDR
+#define PPC4xx_PCI_CFG_SIZE	((uint)4*1024)
+#define PPC4xx_PCI_LCFG_PADDR	((uint)0xef400000)
+#define PPC4xx_PCI_LCFG_VADDR	PPC4xx_PCI_LCFG_PADDR
+#define PPC4xx_PCI_LCFG_SIZE	((uint)4*1024)
+#define PPC4xx_ONB_IO_PADDR	((uint)0xef600000)
+#define PPC4xx_ONB_IO_VADDR	PPC4xx_ONB_IO_PADDR
+#define PPC4xx_ONB_IO_SIZE	((uint)4*1024)
+
+/* serial port defines */
+#define RS_TABLE_SIZE	2
+
+#define UART0_INT	0
+#define UART1_INT	1
+
+#define OPB_BASE_START	0x40000000
+#define EBIU_BASE_START	0xF0100000
+#define PCIL0_BASE	0xEF400000
+#define UART0_IO_BASE	0xEF600300
+#define UART1_IO_BASE	0xEF600400
+#define IIC0_BASE	0xEF600500
+#define OPB0_BASE	0xEF600600
+#define GPIO0_BASE	0xEF600700
+#define EMAC0_BASE	0xEF600800
+#define BL_MAC_WOL	9	/* WOL */
+#define BL_MAL_SERR	10	/* MAL SERR */
+#define BL_MAL_TXDE	13	/* MAL TXDE */
+#define BL_MAL_RXDE	14	/* MAL RXDE */
+#define BL_MAL_TXEOB	11	/* MAL TX EOB */
+#define BL_MAL_RXEOB	12	/* MAL RX EOB */
+#define BL_MAC_ETH0	15	/* MAC */
+
+#define EMAC_NUMS	1
+#define IIC0_IRQ	2
+
+#define IIC_OWN		0x55
+#define IIC_CLOCK	50
+#define BD_EMAC_ADDR(e,i) bi_enetaddr[i]
+
+#define STD_UART_OP(num)					\
+	{ 0, BASE_BAUD, 0, UART##num##_INT,			\
+		(ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST),	\
+		iomem_base: (u8 *)UART##num##_IO_BASE,		\
+		io_type: SERIAL_IO_MEM},
+
+#if defined(CONFIG_UART0_TTYS0)
+#define SERIAL_DEBUG_IO_BASE	UART0_IO_BASE
+#define SERIAL_PORT_DFNS	\
+	STD_UART_OP(0)		\
+	STD_UART_OP(1)
+#endif
+
+#if defined(CONFIG_UART0_TTYS1)
+#define SERIAL_DEBUG_IO_BASE	UART1_IO_BASE
+#define SERIAL_PORT_DFNS	\
+	STD_UART_OP(1)		\
+	STD_UART_OP(0)
+#endif
+
+/* DCR defines */
+#define DCRN_CHCR_BASE		0x0B1
+#define DCRN_CHPSR_BASE		0x0B4
+#define DCRN_CPMSR_BASE		0x0B8
+#define DCRN_CPMFR_BASE		0x0BA
+
+#define CHR0_U0EC	0x00000080	/* Select external clock for UART0 */
+#define CHR0_U1EC	0x00000040	/* Select external clock for UART1 */
+#define CHR0_UDIV	0x0000003E	/* UART internal clock divisor */
+#define CHR1_CETE	0x00800000	/* CPU external timer enable */
+
+#define DCRN_CHPSR_BASE         0x0B4
+#define  PSR_PLL_FWD_MASK        0xC0000000
+#define  PSR_PLL_FDBACK_MASK     0x30000000
+#define  PSR_PLL_TUNING_MASK     0x0E000000
+#define  PSR_PLB_CPU_MASK        0x01800000
+#define  PSR_OPB_PLB_MASK        0x00600000
+#define  PSR_PCI_PLB_MASK        0x00180000
+#define  PSR_EB_PLB_MASK         0x00060000
+#define  PSR_ROM_WIDTH_MASK      0x00018000
+#define  PSR_ROM_LOC             0x00004000
+#define  PSR_PCI_ASYNC_EN        0x00001000
+#define  PSR_PCI_ARBIT_EN        0x00000400
+
+#define IBM_CPM_IIC0		0x80000000	/* IIC interface */
+#define IBM_CPM_PCI		0x40000000	/* PCI bridge */
+#define IBM_CPM_CPU		0x20000000	/* processor core */
+#define IBM_CPM_DMA		0x10000000	/* DMA controller */
+#define IBM_CPM_OPB		0x08000000	/* PLB to OPB bridge */
+#define IBM_CPM_DCP		0x04000000	/* CodePack */
+#define IBM_CPM_EBC		0x02000000	/* ROM/SRAM peripheral controller */
+#define IBM_CPM_SDRAM0		0x01000000	/* SDRAM memory controller */
+#define IBM_CPM_PLB		0x00800000	/* PLB bus arbiter */
+#define IBM_CPM_GPIO0		0x00400000	/* General Purpose IO (??) */
+#define IBM_CPM_UART0		0x00200000	/* serial port 0 */
+#define IBM_CPM_UART1		0x00100000	/* serial port 1 */
+#define IBM_CPM_UIC		0x00080000	/* Universal Interrupt Controller */
+#define IBM_CPM_TMRCLK		0x00040000	/* CPU timers */
+#define IBM_CPM_EMAC0		0x00020000	/* on-chip ethernet MM unit */
+#define DFLT_IBM4xx_PM		~(IBM_CPM_PCI | IBM_CPM_CPU | IBM_CPM_DMA \
+					| IBM_CPM_OPB | IBM_CPM_EBC \
+					| IBM_CPM_SDRAM0 | IBM_CPM_PLB \
+					| IBM_CPM_UIC | IBM_CPM_TMRCLK)
+
+#define DCRN_DMA0_BASE		0x100
+#define DCRN_DMA1_BASE		0x108
+#define DCRN_DMA2_BASE		0x110
+#define DCRN_DMA3_BASE		0x118
+#define DCRNCAP_DMA_SG		1	/* have DMA scatter/gather capability */
+#define DCRN_DMASR_BASE		0x120
+#define DCRN_EBC_BASE		0x012
+#define DCRN_DCP0_BASE		0x014
+#define DCRN_MAL_BASE		0x180
+#define DCRN_OCM0_BASE		0x018
+#define DCRN_PLB0_BASE		0x084
+#define DCRN_PLLMR_BASE		0x0B0
+#define DCRN_POB0_BASE		0x0A0
+#define DCRN_SDRAM0_BASE	0x010
+#define DCRN_UIC0_BASE		0x0C0
+#define UIC0 DCRN_UIC0_BASE
+
+#include <platforms/ibm405.h>
+
+#endif				/* __ASM_IBM405GPR_H__ */
+#endif				/* __KERNEL__ */
-- 
1.2.6


--------------060700040204030601010603--
