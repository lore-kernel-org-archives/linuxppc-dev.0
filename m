Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711111745h25e6845fq8de644093578f732@mail.gmail.com>
Date: Sun, 11 Nov 2007 20:45:32 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "PowerPC dev list" <Linuxppc-dev@ozlabs.org>
Subject: [RFC] Disabling platform bus and using only of_platform bus
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Disabling platform bus and using only of_platform bus works for my
mpc5200 system. Attached is a first pass at a patch implementing
of_platform bus only. Suggestions on the correct ways to do the things
needed?

alsa soc in kernel uses platform bus, asoc v2 is under development and
it removes asoc from the platform bus. I tested these patches with
asoc v2.

root@phyCORE-MPC5200B-tiny:/sys/bus ls
asoc         mdio_bus     of_platform  scsi         spi
i2c          mmc          pci          sdio         usb

BTW, turning off platform bus exposed some general problems (driver
core fixing up parent pointer to point at platform bus when the device
lives on of_platform bus). This is a useful thing to check out on all
of the powerpc platforms. The patch only fixes things up for mpc5200.

There is another patch that was already posted for review that moves
fsl_i2c out of fsl_soc and into mpc_i2c.c.

-----------------------------------------------------------------------------------------------------------

Make the platform bus optional on PowerPC

From: Jon Smirl <jonsmirl@gmail.com>


---

 drivers/base/Kconfig  |    8 ++++++++
 drivers/base/Makefile |    3 ++-
 drivers/base/init.c   |    2 ++
 3 files changed, 12 insertions(+), 1 deletions(-)


diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index d7da109..b05f4a2 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -26,6 +26,14 @@ config PREVENT_FIRMWARE_BUILD
 	  should be made.
 	  If unsure say Y here.

+config PLATFORM_BUS
+	bool "Create the platform bus"
+	default y
+	help
+	  The platform bus is used to access hardware built into the CPU or
on the motherboard.
+	  On the PowerPC architecture the of_platform bus replaces platform bus.
+	  If unsure say Y here.
+
 config FW_LOADER
 	tristate "Userspace firmware loading support"
 	depends on HOTPLUG
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index b39ea3f..60a15eb 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -1,10 +1,11 @@
 # Makefile for the Linux device tree

 obj-y			:= core.o sys.o bus.o dd.o \
-			   driver.o class.o platform.o \
+			   driver.o class.o \
 			   cpu.o firmware.o init.o map.o devres.o \
 			   attribute_container.o transport_class.o
 obj-y			+= power/
+obj-$(PLATFORM_BUS) += platform.o
 obj-$(CONFIG_HAS_DMA)	+= dma-mapping.o dmapool.o
 obj-$(CONFIG_ISA)	+= isa.o
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
diff --git a/drivers/base/init.c b/drivers/base/init.c
index 3713815..b8b276b 100644
--- a/drivers/base/init.c
+++ b/drivers/base/init.c
@@ -32,7 +32,9 @@ void __init driver_init(void)
 	/* These are also core pieces, but must come after the
 	 * core core pieces.
 	 */
+#ifdef CONFIG_PLATFORM_BUS
 	platform_bus_init();
+#endif
 	system_bus_init();
 	cpu_dev_init();
 	memory_dev_init();

-----------------------------------------------------------------------------------------------

Ifdef out some MPC83xx code that is building on the MPC5200

From: Jon Smirl <jonsmirl@gmail.com>


---

 arch/powerpc/kernel/setup-common.c |    2 ++
 arch/powerpc/sysdev/fsl_soc.c      |    7 ++++++-
 drivers/i2c/i2c-core.c             |   10 +++++-----
 drivers/scsi/hosts.c               |    6 ++++--
 4 files changed, 17 insertions(+), 8 deletions(-)


diff --git a/arch/powerpc/kernel/setup-common.c
b/arch/powerpc/kernel/setup-common.c
index 2de00f8..93afc97 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -439,6 +439,7 @@ void __init smp_setup_cpu_sibling_map(void)
 }
 #endif /* CONFIG_SMP */

+#if defined(CONFIG_AMIGA) || defined(CONFIG_MAC) || defined(CONFIG_ATARI)
 static __init int add_pcspkr(void)
 {
 	struct device_node *np;
@@ -461,6 +462,7 @@ static __init int add_pcspkr(void)
 	return ret;
 }
 device_initcall(add_pcspkr);
+#endif

 void probe_machine(void)
 {
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index d6ef264..7017510 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -130,6 +130,7 @@ u32 get_baudrate(void)
 EXPORT_SYMBOL(get_baudrate);
 #endif /* CONFIG_CPM2 */

+#if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_85xx) ||
defined(CONFIG_PPC_86xx)
 static int __init gfar_mdio_of_init(void)
 {
 	struct device_node *np;
@@ -317,6 +318,7 @@ err:
 }

 arch_initcall(gfar_of_init);
+#endif

 #ifdef CONFIG_PPC_83xx
 static int __init mpc83xx_wdt_init(void)
@@ -379,7 +381,7 @@ nodev:
 }

 arch_initcall(mpc83xx_wdt_init);
-#endif
+

 static enum fsl_usb2_phy_modes determine_usb_phy(const char *phy_type)
 {
@@ -542,6 +544,7 @@ err:
 }

 arch_initcall(fsl_usb_of_init);
+#endif

 #ifndef CONFIG_PPC_CPM_NEW_BINDING
 #ifdef CONFIG_CPM2
@@ -1085,6 +1088,7 @@ arch_initcall(cpm_smc_uart_of_init);
 #endif /* CONFIG_8xx */
 #endif /* CONFIG_PPC_CPM_NEW_BINDING */

+#if defined(CONFIG_PPC_83xx)
 int __init fsl_spi_init(struct spi_board_info *board_infos,
 			unsigned int num_board_infos,
 			void (*activate_cs)(u8 cs, u8 polarity),
@@ -1174,6 +1178,7 @@ err:

 	return spi_register_board_info(board_infos, num_board_infos);
 }
+#endif

 #if defined(CONFIG_PPC_85xx) || defined(CONFIG_PPC_86xx)
 static __be32 __iomem *rstcr;
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 8b49860..f99b909 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -340,6 +340,11 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	struct list_head   *item;
 	struct i2c_driver  *driver;

+	if (adap->dev.parent == NULL) {
+		printk(KERN_ERR "I2C adapter driver [%s] forgot to specify "
+			 "physical device\n", adap->name);
+		return -ENODEV;
+	}
 	mutex_init(&adap->bus_lock);
 	mutex_init(&adap->clist_lock);
 	INIT_LIST_HEAD(&adap->clients);
@@ -351,11 +356,6 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
 	 * If the parent pointer is not set up,
 	 * we add this adapter to the host bus.
 	 */
-	if (adap->dev.parent == NULL) {
-		adap->dev.parent = &platform_bus;
-		pr_debug("I2C adapter driver [%s] forgot to specify "
-			 "physical device\n", adap->name);
-	}
 	sprintf(adap->dev.bus_id, "i2c-%d", adap->nr);
 	adap->dev.release = &i2c_adapter_dev_release;
 	adap->dev.class = &i2c_adapter_class;
diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 24271a8..377b66d 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -203,8 +203,10 @@ int scsi_add_host(struct Scsi_Host *shost, struct
device *dev)
 		goto out;
 	}

-	if (!shost->shost_gendev.parent)
-		shost->shost_gendev.parent = dev ? dev : &platform_bus;
+	if (!shost->shost_gendev.parent) {
+		printk(KERN_ERR "shost->shost_gendev.parent must not be NULL\n");
+		goto out;
+	}

 	error = device_add(&shost->shost_gendev);
 	if (error)


-- 
Jon Smirl
jonsmirl@gmail.com
