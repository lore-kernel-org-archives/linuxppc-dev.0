Return-Path: <grant@secretlab.ca>
Received: from localhost (S0106001346b91f0f.cg.shawcable.net [68.147.210.21])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5F0B0689EC
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Jan 2006 21:32:26 +1100 (EST)
Date: Sat, 14 Jan 2006 02:48:41 -0700
From: "Grant C. Likely" <grant.likely@secretlab.ca>
To: linuxppc-embedded@ozlabs.org, mporter@kernel.crashing.org,
	glikely@gmail.com
Subject: [PATCH 04/10] Migrate ML300 reference design to the platform bus
Message-ID: <20060114094841.GA12759@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Signed-off-by: Grant C. Likely <grant.likely@secretlab.ca>

---

 arch/ppc/Kconfig.debug                |    2 -
 arch/ppc/platforms/4xx/xilinx_ml300.c |   74 +++++++++++++++++++++++----------
 arch/ppc/platforms/4xx/xilinx_ml300.h |    2 -
 arch/ppc/syslib/Makefile              |    2 -
 arch/ppc/syslib/xilinx_pic.c          |   10 ++--
 5 files changed, 60 insertions(+), 30 deletions(-)

a13976d8a19837c07e485ae3ae7179668b4b9986
diff --git a/arch/ppc/Kconfig.debug b/arch/ppc/Kconfig.debug
index 61653cb..8cc75ab 100644
--- a/arch/ppc/Kconfig.debug
+++ b/arch/ppc/Kconfig.debug
@@ -67,7 +67,7 @@ config SERIAL_TEXT_DEBUG
 
 config PPC_OCP
 	bool
-	depends on IBM_OCP || XILINX_OCP
+	depends on IBM_OCP
 	default y
 
 endmenu
diff --git a/arch/ppc/platforms/4xx/xilinx_ml300.c b/arch/ppc/platforms/4xx/xilinx_ml300.c
index b0de0a2..267afb5 100644
--- a/arch/ppc/platforms/4xx/xilinx_ml300.c
+++ b/arch/ppc/platforms/4xx/xilinx_ml300.c
@@ -17,12 +17,14 @@
 #include <linux/tty.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
+#include <linux/serial_8250.h>
 #include <linux/serialP.h>
 #include <asm/io.h>
 #include <asm/machdep.h>
-#include <asm/ocp.h>
+#include <asm/ppc_sys.h>
 
-#include <platforms/4xx/virtex.h>	/* for NR_SER_PORTS */
+#include <syslib/gen550.h>
+#include <platforms/4xx/xparameters/xparameters.h>
 
 /*
  * As an overview of how the following functions (platform_init,
@@ -54,6 +56,22 @@
  *          ppc4xx_pic_init			arch/ppc/syslib/xilinx_pic.c
  */
 
+/* Board specifications structures */
+struct ppc_sys_spec *cur_ppc_sys_spec;
+struct ppc_sys_spec ppc_sys_specs[] = {
+	{
+		/* Only one entry, always assume the same design */
+		.ppc_sys_name	= "Xilinx ML300 Reference Design",
+		.mask 		= 0x00000000,
+		.value 		= 0x00000000,
+		.num_devices	= 1,
+		.device_list	= (enum ppc_sys_devices[])
+		{
+			VIRTEX_UART,
+		},
+	},
+};
+
 #if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
 
 static volatile unsigned *powerdown_base =
@@ -80,28 +98,39 @@ ml300_map_io(void)
 #endif
 }
 
+/* Early serial support functions */
 static void __init
+ml300_early_serial_init(int num, struct plat_serial8250_port *pdata)
+{
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	struct uart_port serial_req;
+
+	memset(&serial_req, 0, sizeof(serial_req));
+	serial_req.mapbase	= pdata->mapbase;
+	serial_req.membase	= pdata->membase;
+	serial_req.irq		= pdata->irq;
+	serial_req.uartclk	= pdata->uartclk;
+	serial_req.regshift	= pdata->regshift;
+	serial_req.iotype	= pdata->iotype;
+	serial_req.flags	= pdata->flags;
+	gen550_init(num, &serial_req);
+#endif
+}
+
+void __init
 ml300_early_serial_map(void)
 {
 #ifdef CONFIG_SERIAL_8250
-	struct serial_state old_ports[] = { SERIAL_PORT_DFNS };
-	struct uart_port port;
-	int i;
-
-	/* Setup ioremapped serial port access */
-	for (i = 0; i < ARRAY_SIZE(old_ports); i++ ) {
-		memset(&port, 0, sizeof(port));
-		port.membase = ioremap((phys_addr_t)(old_ports[i].iomem_base), 16);
-		port.irq = old_ports[i].irq;
-		port.uartclk = old_ports[i].baud_base * 16;
-		port.regshift = old_ports[i].iomem_reg_shift;
-		port.iotype = SERIAL_IO_MEM;
-		port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
-		port.line = i;
-
-		if (early_serial_setup(&port) != 0) {
-			printk("Early serial init of port %d failed\n", i);
-		}
+	struct plat_serial8250_port *pdata;
+	int i = 0;
+
+	pdata = (struct plat_serial8250_port *) ppc_sys_get_pdata(VIRTEX_UART);
+	while(pdata && pdata->flags)
+	{
+		pdata->membase = ioremap(pdata->mapbase, 0x100);
+		ml300_early_serial_init(i, pdata);
+		pdata++;
+		i++;
 	}
 #endif /* CONFIG_SERIAL_8250 */
 }
@@ -109,9 +138,8 @@ ml300_early_serial_map(void)
 void __init
 ml300_setup_arch(void)
 {
-	ppc4xx_setup_arch();	/* calls ppc4xx_find_bridges() */
-
 	ml300_early_serial_map();
+	ppc4xx_setup_arch();	/* calls ppc4xx_find_bridges() */
 
 	/* Identify the system */
 	printk(KERN_INFO "Xilinx Virtex-II Pro port\n");
@@ -131,6 +159,8 @@ platform_init(unsigned long r3, unsigned
 {
 	ppc4xx_init(r3, r4, r5, r6, r7);
 
+	identify_ppc_sys_by_id(mfspr(SPRN_PVR));
+
 	ppc_md.setup_arch = ml300_setup_arch;
 	ppc_md.setup_io_mappings = ml300_map_io;
 	ppc_md.init_IRQ = ml300_init_irq;
diff --git a/arch/ppc/platforms/4xx/xilinx_ml300.h b/arch/ppc/platforms/4xx/xilinx_ml300.h
index 8993981..ae8bf13 100644
--- a/arch/ppc/platforms/4xx/xilinx_ml300.h
+++ b/arch/ppc/platforms/4xx/xilinx_ml300.h
@@ -41,7 +41,7 @@ typedef struct board_info {
 #define PPC4xx_ONB_IO_VADDR	0u
 #define PPC4xx_ONB_IO_SIZE	0u
 
-#define PPC4xx_MACHINE_NAME "Xilinx ML300"
+#define PPC4xx_MACHINE_NAME "Xilinx ML300 Reference System"
 
 #endif /* __ASM_XILINX_ML300_H__ */
 #endif /* __KERNEL__ */
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
index dc75f6e..301f0c2 100644
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_440SP)		+= ibm440gx_common.
 obj-$(CONFIG_440SPE)		+= ibm440gx_common.o ibm440sp_common.o ppc440spe_pcie.o
 ifeq ($(CONFIG_4xx),y)
 ifeq ($(CONFIG_XILINX_VIRTEX),y)
-obj-$(CONFIG_40x)		+= xilinx_pic.o
+obj-$(CONFIG_40x)		+= xilinx_pic.o ppc_sys.o
 else
 ifeq ($(CONFIG_403),y)
 obj-$(CONFIG_40x)		+= ppc403_pic.o
diff --git a/arch/ppc/syslib/xilinx_pic.c b/arch/ppc/syslib/xilinx_pic.c
index 848fb51..206872c 100644
--- a/arch/ppc/syslib/xilinx_pic.c
+++ b/arch/ppc/syslib/xilinx_pic.c
@@ -120,14 +120,14 @@ ppc4xx_pic_init(void)
 #error NR_IRQS > 32 not supported
 #endif
 
-#if XPAR_XINTC_USE_DCR == 0
-	intc = ioremap(XPAR_INTC_0_BASEADDR, 32);
+#if VIRTEX_XINTC_USE_DCR == 0
+	intc = ioremap(VIRTEX_INTC_BASEADDR, 32);
 
 	printk(KERN_INFO "Xilinx INTC #0 at 0x%08lX mapped to 0x%08lX\n",
-	       (unsigned long) XPAR_INTC_0_BASEADDR, (unsigned long) intc);
+	       (unsigned long) VIRTEX_INTC_BASEADDR, (unsigned long) intc);
 #else
 	printk(KERN_INFO "Xilinx INTC #0 at 0x%08lX (DCR)\n",
-	       (unsigned long) XPAR_INTC_0_BASEADDR);
+	       (unsigned long) VIRTEX_INTC_BASEADDR);
 #endif
 
 	/*
@@ -147,7 +147,7 @@ ppc4xx_pic_init(void)
 	for (i = 0; i < NR_IRQS; ++i) {
 		irq_desc[i].handler = &xilinx_intc;
 
-		if (XPAR_INTC_0_KIND_OF_INTR & (0x00000001 << i))
+		if (VIRTEX_INTC_KIND_OF_INTR & (0x00000001 << i))
 			irq_desc[i].status &= ~IRQ_LEVEL;
 		else
 			irq_desc[i].status |= IRQ_LEVEL;
-- 
1.1.2-g9e9b-dirty
