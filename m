Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3CD93DE050
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 19:01:49 +1100 (EST)
Date: Fri, 26 Jan 2007 01:59:30 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for_paulus' branch for 2.6.21
Message-ID: <Pine.LNX.4.64.0701260155140.331@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'for_paulus' branch of
master.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git

to receive the following updates:

  arch/powerpc/Kconfig                       |    2 +-
  arch/powerpc/configs/mpc834x_itx_defconfig |    7 ++++---
  arch/powerpc/configs/mpc834x_mds_defconfig |    3 +--
  arch/powerpc/configs/mpc8360emds_defconfig |    3 +--
  arch/powerpc/kernel/iomap.c                |   20 ++++++++++----------
  arch/powerpc/platforms/83xx/misc.c         |   29 +++++++++++++++++++++--------
  arch/powerpc/platforms/83xx/mpc832x_mds.c  |    2 +-
  arch/powerpc/platforms/83xx/mpc834x_itx.c  |    2 +-
  arch/powerpc/platforms/83xx/mpc834x_sys.c  |    2 +-
  arch/powerpc/platforms/83xx/mpc8360e_pb.c  |    2 +-
  arch/powerpc/sysdev/ipic.c                 |   15 +++++++++------
  arch/powerpc/sysdev/qe_lib/qe_ic.c         |    4 ++--
  include/asm-powerpc/ipic.h                 |    2 +-
  13 files changed, 54 insertions(+), 39 deletions(-)

Kumar Gala (5):
       [POWERPC] 83xx: Fix Kconfig to only enable FP math emulation for the MPC832x
       [POWERPC] 83xx: Don't call ioremap in the reset function
       [POWERPC] 83xx:  Make platform *_init_IRQ() static
       [POWERPC] 83xx: Return a point to the struct ipic from ipic_init()
       [POWERPC] Remove fastcall function attribute

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 0855d55..54d77a5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -720,7 +720,7 @@ config FORCE_MAX_ZONEORDER

  config MATH_EMULATION
  	bool "Math emulation"
-	depends on 4xx || 8xx || E200 || PPC_83xx || E500
+	depends on 4xx || 8xx || E200 || PPC_MPC832x || E500
  	---help---
  	  Some PowerPC chips designed for embedded applications do not have
  	  a floating-point unit and therefore do not implement the
diff --git a/arch/powerpc/configs/mpc834x_itx_defconfig b/arch/powerpc/configs/mpc834x_itx_defconfig
index 45757b6..7902806 100644
--- a/arch/powerpc/configs/mpc834x_itx_defconfig
+++ b/arch/powerpc/configs/mpc834x_itx_defconfig
@@ -1,7 +1,7 @@
  #
  # Automatically generated make config: don't edit
  # Linux kernel version: 2.6.20-rc5
-# Mon Jan 22 22:23:43 2007
+# Fri Jan 26 00:19:02 2007
  #
  # CONFIG_PPC64 is not set
  CONFIG_PPC32=y
@@ -149,7 +149,6 @@ CONFIG_PREEMPT_NONE=y
  # CONFIG_PREEMPT is not set
  CONFIG_BINFMT_ELF=y
  # CONFIG_BINFMT_MISC is not set
-CONFIG_MATH_EMULATION=y
  CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
  CONFIG_ARCH_FLATMEM_ENABLE=y
  CONFIG_ARCH_POPULATES_NODE_MAP=y
@@ -324,6 +323,7 @@ CONFIG_MTD=y
  # User Modules And Translation Layers
  #
  CONFIG_MTD_CHAR=y
+# CONFIG_MTD_BLKDEVS is not set
  # CONFIG_MTD_BLOCK is not set
  # CONFIG_MTD_BLOCK_RO is not set
  # CONFIG_FTL is not set
@@ -366,6 +366,7 @@ CONFIG_MTD_PHYSMAP=y
  CONFIG_MTD_PHYSMAP_START=0xfe000000
  CONFIG_MTD_PHYSMAP_LEN=0x1000000
  CONFIG_MTD_PHYSMAP_BANKWIDTH=2
+# CONFIG_MTD_PHYSMAP_OF is not set
  # CONFIG_MTD_PLATRAM is not set

  #
@@ -390,6 +391,7 @@ CONFIG_MTD_PHYSMAP_BANKWIDTH=2
  # NAND Flash Device Drivers
  #
  # CONFIG_MTD_NAND is not set
+# CONFIG_MTD_NAND_CAFE is not set

  #
  # OneNAND Flash Device Drivers
@@ -1011,7 +1013,6 @@ CONFIG_USB=y
  CONFIG_USB_DEVICEFS=y
  # CONFIG_USB_BANDWIDTH is not set
  # CONFIG_USB_DYNAMIC_MINORS is not set
-# CONFIG_USB_MULTITHREAD_PROBE is not set
  # CONFIG_USB_OTG is not set

  #
diff --git a/arch/powerpc/configs/mpc834x_mds_defconfig b/arch/powerpc/configs/mpc834x_mds_defconfig
index c24db58..9eaed3a 100644
--- a/arch/powerpc/configs/mpc834x_mds_defconfig
+++ b/arch/powerpc/configs/mpc834x_mds_defconfig
@@ -1,7 +1,7 @@
  #
  # Automatically generated make config: don't edit
  # Linux kernel version: 2.6.20-rc5
-# Mon Jan 22 22:24:10 2007
+# Fri Jan 26 00:19:27 2007
  #
  # CONFIG_PPC64 is not set
  CONFIG_PPC32=y
@@ -149,7 +149,6 @@ CONFIG_PREEMPT_NONE=y
  # CONFIG_PREEMPT is not set
  CONFIG_BINFMT_ELF=y
  # CONFIG_BINFMT_MISC is not set
-CONFIG_MATH_EMULATION=y
  CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
  CONFIG_ARCH_FLATMEM_ENABLE=y
  CONFIG_ARCH_POPULATES_NODE_MAP=y
diff --git a/arch/powerpc/configs/mpc8360emds_defconfig b/arch/powerpc/configs/mpc8360emds_defconfig
index 58e6795..bbe38cc 100644
--- a/arch/powerpc/configs/mpc8360emds_defconfig
+++ b/arch/powerpc/configs/mpc8360emds_defconfig
@@ -1,7 +1,7 @@
  #
  # Automatically generated make config: don't edit
  # Linux kernel version: 2.6.20-rc5
-# Mon Jan 22 22:24:40 2007
+# Fri Jan 26 00:19:45 2007
  #
  # CONFIG_PPC64 is not set
  CONFIG_PPC32=y
@@ -150,7 +150,6 @@ CONFIG_PREEMPT_NONE=y
  # CONFIG_PREEMPT is not set
  CONFIG_BINFMT_ELF=y
  # CONFIG_BINFMT_MISC is not set
-CONFIG_MATH_EMULATION=y
  CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
  CONFIG_ARCH_FLATMEM_ENABLE=y
  CONFIG_ARCH_POPULATES_NODE_MAP=y
diff --git a/arch/powerpc/kernel/iomap.c b/arch/powerpc/kernel/iomap.c
index c681133..601ef79 100644
--- a/arch/powerpc/kernel/iomap.c
+++ b/arch/powerpc/kernel/iomap.c
@@ -12,23 +12,23 @@
   * Here comes the ppc64 implementation of the IOMAP
   * interfaces.
   */
-unsigned int fastcall ioread8(void __iomem *addr)
+unsigned int ioread8(void __iomem *addr)
  {
  	return readb(addr);
  }
-unsigned int fastcall ioread16(void __iomem *addr)
+unsigned int ioread16(void __iomem *addr)
  {
  	return readw(addr);
  }
-unsigned int fastcall ioread16be(void __iomem *addr)
+unsigned int ioread16be(void __iomem *addr)
  {
  	return in_be16(addr);
  }
-unsigned int fastcall ioread32(void __iomem *addr)
+unsigned int ioread32(void __iomem *addr)
  {
  	return readl(addr);
  }
-unsigned int fastcall ioread32be(void __iomem *addr)
+unsigned int ioread32be(void __iomem *addr)
  {
  	return in_be32(addr);
  }
@@ -38,23 +38,23 @@ EXPORT_SYMBOL(ioread16be);
  EXPORT_SYMBOL(ioread32);
  EXPORT_SYMBOL(ioread32be);

-void fastcall iowrite8(u8 val, void __iomem *addr)
+void iowrite8(u8 val, void __iomem *addr)
  {
  	writeb(val, addr);
  }
-void fastcall iowrite16(u16 val, void __iomem *addr)
+void iowrite16(u16 val, void __iomem *addr)
  {
  	writew(val, addr);
  }
-void fastcall iowrite16be(u16 val, void __iomem *addr)
+void iowrite16be(u16 val, void __iomem *addr)
  {
  	out_be16(addr, val);
  }
-void fastcall iowrite32(u32 val, void __iomem *addr)
+void iowrite32(u32 val, void __iomem *addr)
  {
  	writel(val, addr);
  }
-void fastcall iowrite32be(u32 val, void __iomem *addr)
+void iowrite32be(u32 val, void __iomem *addr)
  {
  	out_be32(addr, val);
  }
diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index f0c6df6..f01806c 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -18,23 +18,36 @@

  #include "mpc83xx.h"

+static __be32 __iomem *restart_reg_base;
+
+static int __init mpc83xx_restart_init(void)
+{
+	/* map reset restart_reg_baseister space */
+	restart_reg_base = ioremap(get_immrbase() + 0x900, 0xff);
+
+	return 0;
+}
+
+arch_initcall(mpc83xx_restart_init);
+
  void mpc83xx_restart(char *cmd)
  {
  #define RST_OFFSET	0x00000900
  #define RST_PROT_REG	0x00000018
  #define RST_CTRL_REG	0x0000001c
-	__be32 __iomem *reg;
-
-	/* map reset register space */
-	reg = ioremap(get_immrbase() + 0x900, 0xff);

  	local_irq_disable();

-	/* enable software reset "RSTE" */
-	out_be32(reg + (RST_PROT_REG >> 2), 0x52535445);
+	if (restart_reg_base) {
+		/* enable software reset "RSTE" */
+		out_be32(restart_reg_base + (RST_PROT_REG >> 2), 0x52535445);
+
+		/* set software hard reset */
+		out_be32(restart_reg_base + (RST_CTRL_REG >> 2), 0x2);
+	} else {
+		printk (KERN_EMERG "Error: Restart registers not mapped, spinning!\n");
+	}

-	/* set software hard reset */
-	out_be32(reg + (RST_CTRL_REG >> 2), 0x2);
  	for (;;) ;
  }

diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index 4d47119..36c75b0 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -153,7 +153,7 @@ static int __init mpc832x_declare_of_platform_devices(void)
  }
  device_initcall(mpc832x_declare_of_platform_devices);

-void __init mpc832x_sys_init_IRQ(void)
+static void __init mpc832x_sys_init_IRQ(void)
  {

  	struct device_node *np;
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index 314c42a..2446dea 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -81,7 +81,7 @@ static void __init mpc834x_itx_setup_arch(void)
  #endif
  }

-void __init mpc834x_itx_init_IRQ(void)
+static void __init mpc834x_itx_init_IRQ(void)
  {
  	struct device_node *np;

diff --git a/arch/powerpc/platforms/83xx/mpc834x_sys.c b/arch/powerpc/platforms/83xx/mpc834x_sys.c
index 80b735a..f30393f 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_sys.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_sys.c
@@ -79,7 +79,7 @@ static void __init mpc834x_sys_setup_arch(void)
  #endif
  }

-void __init mpc834x_sys_init_IRQ(void)
+static void __init mpc834x_sys_init_IRQ(void)
  {
  	struct device_node *np;

diff --git a/arch/powerpc/platforms/83xx/mpc8360e_pb.c b/arch/powerpc/platforms/83xx/mpc8360e_pb.c
index 53b92a9..832aec4 100644
--- a/arch/powerpc/platforms/83xx/mpc8360e_pb.c
+++ b/arch/powerpc/platforms/83xx/mpc8360e_pb.c
@@ -158,7 +158,7 @@ static int __init mpc8360_declare_of_platform_devices(void)
  }
  device_initcall(mpc8360_declare_of_platform_devices);

-void __init mpc8360_sys_init_IRQ(void)
+static void __init mpc8360_sys_init_IRQ(void)
  {

  	struct device_node *np;
diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index 522aa14..473c415 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -557,8 +557,7 @@ static struct irq_host_ops ipic_host_ops = {
  	.xlate	= ipic_host_xlate,
  };

-void __init ipic_init(struct device_node *node,
-		unsigned int flags)
+struct ipic * __init ipic_init(struct device_node *node, unsigned int flags)
  {
  	struct ipic	*ipic;
  	struct resource res;
@@ -566,7 +565,7 @@ void __init ipic_init(struct device_node *node,

  	ipic = alloc_bootmem(sizeof(struct ipic));
  	if (ipic == NULL)
-		return;
+		return NULL;

  	memset(ipic, 0, sizeof(struct ipic));
  	ipic->of_node = of_node_get(node);
@@ -576,12 +575,14 @@ void __init ipic_init(struct device_node *node,
  				       &ipic_host_ops, 0);
  	if (ipic->irqhost == NULL) {
  		of_node_put(node);
-		return;
+		return NULL;
  	}

  	ret = of_address_to_resource(node, 0, &res);
-	if (ret)
-		return;
+	if (ret) {
+		of_node_put(node);
+		return NULL;
+	}

  	ipic->regs = ioremap(res.start, res.end - res.start + 1);

@@ -625,6 +626,8 @@ void __init ipic_init(struct device_node *node,

  	printk ("IPIC (%d IRQ sources) at %p\n", NR_IPIC_INTS,
  			primary_ipic->regs);
+
+	return ipic;
  }

  int ipic_set_priority(unsigned int virq, unsigned int priority)
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index 908568f..4d1dcb4 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -323,7 +323,7 @@ unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
  	return irq_linear_revmap(qe_ic->irqhost, irq);
  }

-void fastcall qe_ic_cascade_low(unsigned int irq, struct irq_desc *desc)
+void qe_ic_cascade_low(unsigned int irq, struct irq_desc *desc)
  {
  	struct qe_ic *qe_ic = desc->handler_data;
  	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic);
@@ -332,7 +332,7 @@ void fastcall qe_ic_cascade_low(unsigned int irq, struct irq_desc *desc)
  		generic_handle_irq(cascade_irq);
  }

-void fastcall qe_ic_cascade_high(unsigned int irq, struct irq_desc *desc)
+void qe_ic_cascade_high(unsigned int irq, struct irq_desc *desc)
  {
  	struct qe_ic *qe_ic = desc->handler_data;
  	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic);
diff --git a/include/asm-powerpc/ipic.h b/include/asm-powerpc/ipic.h
index 9fbb034..edec79d 100644
--- a/include/asm-powerpc/ipic.h
+++ b/include/asm-powerpc/ipic.h
@@ -78,7 +78,7 @@ extern u32 ipic_get_mcp_status(void);
  extern void ipic_clear_mcp_status(u32 mask);

  #ifdef CONFIG_PPC_MERGE
-extern void ipic_init(struct device_node *node, unsigned int flags);
+extern struct ipic * ipic_init(struct device_node *node, unsigned int flags);
  extern unsigned int ipic_get_irq(void);
  #else
  extern void ipic_init(phys_addr_t phys_addr, unsigned int flags,
