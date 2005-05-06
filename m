Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id A19B467B23
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 May 2005 17:54:11 +1000 (EST)
Message-ID: <427B22A0.8010704@ru.mvista.com>
Date: Fri, 06 May 2005 11:54:08 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
Content-Type: multipart/mixed; boundary="------------010602070500030707040303"
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: [RFC][PATCH 2.6.12-rc2] Updated platform additions for 82xx
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
--------------010602070500030707040303
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

Kumar,
This is just the base platform additions as you asked. I only included 
changes to mentioned files. All board-specific stuff should be redefined 
in the  relative board-specific header if it does not suit the default 
values.

Signed-off-by: Vitaly Bordug<vbordug@ru.mvista.com>

-- 
Sincerely, 
Vitaly


--------------010602070500030707040303
Content-Type: text/x-patch;
 name="basic_platform_st.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="basic_platform_st.patch"

diff -Nru a/arch/ppc/syslib/mpc82xx_devices.c b/arch/ppc/syslib/mpc82xx_devices.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/mpc82xx_devices.c	2005-05-06 11:50:41 +04:00
@@ -0,0 +1,209 @@
+/*
+ * arch/ppc/syslib/mpc82xx_devices.c
+ *
+ * MPC82xx Device descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. 
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ * 
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ */
+
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/ioport.h>
+#include <linux/fsl_devices.h>
+#include <asm/mpc8260.h>
+#include <asm/cpm2.h>
+#include <asm/immap_cpm2.h>
+#include <asm/irq.h>
+#include <asm/ppc_sys.h>
+#include <asm/ppcboot.h>
+
+
+/* FCC1 Clock Source Configuration.  These can be redefined in the board specific file.
+   Can only choose from CLK9-12 */
+#ifndef F1_RXCLK
+#define F1_RXCLK	12
+#endif
+
+#ifndef F1_TXCLK
+#define F1_TXCLK	11
+#endif
+
+/* FCC2 Clock Source Configuration.  These can be redefined in the board specific file.
+   Can only choose from CLK13-16 */
+#ifndef F2_RXCLK
+#define F2_RXCLK	13
+#endif
+
+#ifndef F2_TXCLK
+#define F2_TXCLK	14
+#endif
+
+/* FCC3 Clock Source Configuration.  These can be redefined in the board specific file.
+   Can only choose from CLK13-16 */
+#ifndef F3_RXCLK
+#define F3_RXCLK	15
+#endif
+
+#ifndef F3_TXCLK
+#define F3_TXCLK	16
+#endif
+
+/* MDIO and MDCK settings. These can be redefined in the board specific file.*/
+#ifndef PC_MDIO
+#define PC_MDIO		0x00000004U
+#endif
+
+#ifndef PC_MDCK
+#define PC_MDCK		0x00000020U
+#endif
+
+/* Automatically generates register configurations */
+#define PC_CLK(x)	((uint)(1<<(x-1)))	/* FCC CLK I/O ports */
+
+#define CMXFCR_RF1CS(x)	((uint)((x-5)<<27))	/* FCC1 Receive Clock Source */
+#define CMXFCR_TF1CS(x)	((uint)((x-5)<<24))	/* FCC1 Transmit Clock Source */
+#define CMXFCR_RF2CS(x)	((uint)((x-9)<<19))	/* FCC2 Receive Clock Source */
+#define CMXFCR_TF2CS(x) ((uint)((x-9)<<16))	/* FCC2 Transmit Clock Source */
+#define CMXFCR_RF3CS(x)	((uint)((x-9)<<11))	/* FCC3 Receive Clock Source */
+#define CMXFCR_TF3CS(x) ((uint)((x-9)<<8))	/* FCC3 Transmit Clock Source */
+
+#define PC_F1RXCLK	PC_CLK(F1_RXCLK)
+#define PC_F1TXCLK	PC_CLK(F1_TXCLK)
+#define CMX1_CLK_ROUTE	(CMXFCR_RF1CS(F1_RXCLK) | CMXFCR_TF1CS(F1_TXCLK))
+#define CMX1_CLK_MASK	((uint)0xff000000)
+
+#define PC_F2RXCLK	PC_CLK(F2_RXCLK)
+#define PC_F2TXCLK	PC_CLK(F2_TXCLK)
+#define CMX2_CLK_ROUTE	(CMXFCR_RF2CS(F2_RXCLK) | CMXFCR_TF2CS(F2_TXCLK))
+#define CMX2_CLK_MASK	((uint)0x00ff0000)
+
+#define PC_F3RXCLK	PC_CLK(F3_RXCLK)
+#define PC_F3TXCLK	PC_CLK(F3_TXCLK)
+#define CMX3_CLK_ROUTE	(CMXFCR_RF3CS(F3_RXCLK) | CMXFCR_TF3CS(F3_TXCLK))
+#define CMX3_CLK_MASK	((uint)0x0000ff00)
+
+/* We use offsets for IORESOURCE_MEM since we do not know at compile time
+ * what IMMRBAR is, will get fixed up by mach_mpc82xx_fixup
+ */
+
+static struct cpm2_fec_platform_data mpc82xx_fcc1_pdata = {
+	.cp_page	= CPM_CR_FCC1_PAGE,
+	.cp_block 	= CPM_CR_FCC1_SBLOCK,
+	.clk_trx 	= (PC_F1RXCLK | PC_F1TXCLK),
+	.clk_route	= CMX1_CLK_ROUTE,
+	.clk_mask	= CMX1_CLK_MASK,
+	.mdio		= PC_MDIO,
+	.mdck		= PC_MDCK,
+	
+	.device_flags	= FSL_CPM2_FEC_BRD_HAS_PHY_INTR,
+	.phyid 		= 0,
+	.interruptPHY	= SIU_INT_IRQ5,
+};
+
+static struct cpm2_fec_platform_data mpc82xx_fcc2_pdata = {
+	.cp_page	= CPM_CR_FCC2_PAGE,
+	.cp_block 	= CPM_CR_FCC2_SBLOCK,
+	.clk_trx 	= (PC_F2RXCLK | PC_F2TXCLK),
+	.clk_route	= CMX2_CLK_ROUTE,
+	.clk_mask	= CMX2_CLK_MASK,
+	.mdio		= PC_MDIO,
+	.mdck		= PC_MDCK,
+	
+	.device_flags	= FSL_CPM2_FEC_BRD_HAS_PHY_INTR,	
+	.phyid 		= 3,
+	.interruptPHY	= SIU_INT_IRQ5,
+};
+
+
+
+struct platform_device ppc_sys_platform_devices[] = {
+	[MPC82xx_FCC1] = {
+		.name = "cpm2_fcc",
+		.id	= 1,
+		.dev.platform_data = &mpc82xx_fcc1_pdata,
+		.num_resources	 = 4,
+		.resource = (struct resource[]) {
+			{
+				.name	= "fcc_regs",
+				.start	= 0x11300,
+				.end	= 0x1131f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "fcc_pram",
+				.start	= 0x8400,
+				.end	= 0x84ff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "fcc_mem",
+				.start	= 0x9000,
+				.end	= 0x907f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= SIU_INT_FCC1,
+				.end	= SIU_INT_FCC1,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	},
+	[MPC82xx_FCC2] = {
+		.name = "cpm2_fcc",
+		.id	= 2,
+		.dev.platform_data = &mpc82xx_fcc2_pdata,
+		.num_resources	 = 4,
+		.resource = (struct resource[]) {
+			{
+				.name	= "fcc_regs",
+				.start	= 0x11320,
+				.end	= 0x1133f,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "fcc_pram",
+				.start	= 0x8500,
+				.end	= 0x85ff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "fcc_mem",
+				.start	= 0x9080,
+				.end	= 0x90ff,
+				.flags	= IORESOURCE_MEM,
+			},
+			{
+				.name	= "interrupt",
+				.start	= SIU_INT_FCC2,
+				.end	= SIU_INT_FCC2,
+				.flags	= IORESOURCE_IRQ,
+			},
+		},
+	}
+};
+
+static int __init mach_mpc82xx_fixup(struct platform_device *pdev)
+{
+	ppc_sys_fixup_mem_resource(pdev, CPM_MAP_ADDR);
+	return 0;
+}
+
+static int __init mach_mpc82xx_init(void)
+{
+	if (ppc_md.progress)
+		ppc_md.progress("mach_mpc82xx_init:enter", 0);
+	ppc_sys_device_fixup = mach_mpc82xx_fixup;
+	return 0;
+}
+
+postcore_initcall(mach_mpc82xx_init);
diff -Nru a/arch/ppc/syslib/mpc82xx_sys.c b/arch/ppc/syslib/mpc82xx_sys.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/mpc82xx_sys.c	2005-05-06 11:50:41 +04:00
@@ -0,0 +1,42 @@
+/*
+ * arch/ppc/syslib/mpc82xx_devices.c
+ *
+ * MPC82xx System descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. 
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ * 
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+
+#include <asm/ppc_sys.h>
+
+
+struct ppc_sys_spec *cur_ppc_sys_spec;
+struct ppc_sys_spec ppc_sys_specs[] = {
+
+	{	
+		.ppc_sys_name	= "MPC8272ads",
+		.mask 		= 0xFFFF0000,
+		.value 		= 0x0c100000,
+		.num_devices 	= 2,
+		.device_list = (enum ppc_sys_devices[])
+		{
+			MPC82xx_FCC1,
+			MPC82xx_FCC2,
+		},
+	},
+	{	/* default match */
+		.ppc_sys_name	= "",
+		.mask 		= 0x00000000,
+		.value 		= 0x00000000,
+	},
+};
diff -Nru a/include/asm-ppc/mpc8260.h b/include/asm-ppc/mpc8260.h
--- a/include/asm-ppc/mpc8260.h	2005-05-06 11:50:41 +04:00
+++ b/include/asm-ppc/mpc8260.h	2005-05-06 11:50:41 +04:00
@@ -74,6 +74,11 @@
 extern unsigned char __res[];
 #endif
 
+enum ppc_sys_devices {
+	MPC82xx_FCC1,
+	MPC82xx_FCC2,
+};
+
 #endif /* CONFIG_8260 */
 #endif /* !__ASM_PPC_MPC8260_H__ */
 #endif /* __KERNEL__ */
diff -Nru a/include/asm-ppc/ppc_sys.h b/include/asm-ppc/ppc_sys.h
--- a/include/asm-ppc/ppc_sys.h	2005-05-06 11:50:41 +04:00
+++ b/include/asm-ppc/ppc_sys.h	2005-05-06 11:50:41 +04:00
@@ -27,6 +27,8 @@
 #include <asm/mpc85xx.h>
 #elif defined(CONFIG_PPC_MPC52xx)
 #include <asm/mpc52xx.h>
+#elif defined(CONFIG_8260)
+#include <asm/mpc8260.h>
 #else
 #error "need definition of ppc_sys_devices"
 #endif

--------------010602070500030707040303--
