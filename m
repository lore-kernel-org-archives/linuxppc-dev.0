Return-Path: <wfp5p@viridian.itc.virginia.edu>
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 222/493] char: remove use of __devinit
Date: Mon, 19 Nov 2012 13:22:51 -0500
Message-Id: <1353349642-3677-222-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: cbe-oss-dev@lists.ozlabs.org, Geoff Levand <geoff@infradead.org>,
 platform-driver-x86@vger.kernel.org, Mattia Dongili <malattia@linux.it>,
 Amit Shah <amit.shah@redhat.com>, openipmi-developer@lists.sourceforge.net,
 virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Geoff Levand <geoff@infradead.org> 
Cc: Mattia Dongili <malattia@linux.it> 
Cc: Amit Shah <amit.shah@redhat.com> 
Cc: openipmi-developer@lists.sourceforge.net 
Cc: linuxppc-dev@lists.ozlabs.org 
Cc: cbe-oss-dev@lists.ozlabs.org 
Cc: platform-driver-x86@vger.kernel.org 
Cc: virtualization@lists.linux-foundation.org 
---
 drivers/char/ipmi/ipmi_si_intf.c           | 24 ++++++++++++------------
 drivers/char/ps3flash.c                    |  2 +-
 drivers/char/sonypi.c                      | 10 +++++-----
 drivers/char/tb0219.c                      |  2 +-
 drivers/char/virtio_console.c              |  2 +-
 drivers/char/xilinx_hwicap/xilinx_hwicap.c |  6 +++---
 6 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_intf.c b/drivers/char/ipmi/ipmi_si_intf.c
index b1e0356..29b6bad 100644
--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -1836,7 +1836,7 @@ static int hotmod_handler(const char *val, struct kernel_param *kp)
 	return rv;
 }
 
-static int __devinit hardcode_find_bmc(void)
+static int hardcode_find_bmc(void)
 {
 	int ret = -ENODEV;
 	int             i;
@@ -2023,7 +2023,7 @@ struct SPMITable {
 	s8      spmi_id[1]; /* A '\0' terminated array starts here. */
 };
 
-static int __devinit try_init_spmi(struct SPMITable *spmi)
+static int try_init_spmi(struct SPMITable *spmi)
 {
 	struct smi_info  *info;
 
@@ -2106,7 +2106,7 @@ static int __devinit try_init_spmi(struct SPMITable *spmi)
 	return 0;
 }
 
-static void __devinit spmi_find_bmc(void)
+static void spmi_find_bmc(void)
 {
 	acpi_status      status;
 	struct SPMITable *spmi;
@@ -2128,7 +2128,7 @@ static void __devinit spmi_find_bmc(void)
 	}
 }
 
-static int __devinit ipmi_pnp_probe(struct pnp_dev *dev,
+static int ipmi_pnp_probe(struct pnp_dev *dev,
 				    const struct pnp_device_id *dev_id)
 {
 	struct acpi_device *acpi_dev;
@@ -2258,7 +2258,7 @@ struct dmi_ipmi_data {
 	u8              slave_addr;
 };
 
-static int __devinit decode_dmi(const struct dmi_header *dm,
+static int decode_dmi(const struct dmi_header *dm,
 				struct dmi_ipmi_data *dmi)
 {
 	const u8	*data = (const u8 *)dm;
@@ -2320,7 +2320,7 @@ static int __devinit decode_dmi(const struct dmi_header *dm,
 	return 0;
 }
 
-static void __devinit try_init_dmi(struct dmi_ipmi_data *ipmi_data)
+static void try_init_dmi(struct dmi_ipmi_data *ipmi_data)
 {
 	struct smi_info *info;
 
@@ -2388,7 +2388,7 @@ static void __devinit try_init_dmi(struct dmi_ipmi_data *ipmi_data)
 		kfree(info);
 }
 
-static void __devinit dmi_find_bmc(void)
+static void dmi_find_bmc(void)
 {
 	const struct dmi_device *dev = NULL;
 	struct dmi_ipmi_data data;
@@ -2424,7 +2424,7 @@ static void ipmi_pci_cleanup(struct smi_info *info)
 	pci_disable_device(pdev);
 }
 
-static int __devinit ipmi_pci_probe_regspacing(struct smi_info *info)
+static int ipmi_pci_probe_regspacing(struct smi_info *info)
 {
 	if (info->si_type == SI_KCS) {
 		unsigned char	status;
@@ -2456,7 +2456,7 @@ static int __devinit ipmi_pci_probe_regspacing(struct smi_info *info)
 	return DEFAULT_REGSPACING;
 }
 
-static int __devinit ipmi_pci_probe(struct pci_dev *pdev,
+static int ipmi_pci_probe(struct pci_dev *pdev,
 				    const struct pci_device_id *ent)
 {
 	int rv;
@@ -2551,7 +2551,7 @@ static struct pci_driver ipmi_pci_driver = {
 #endif /* CONFIG_PCI */
 
 static struct of_device_id ipmi_match[];
-static int __devinit ipmi_probe(struct platform_device *dev)
+static int ipmi_probe(struct platform_device *dev)
 {
 #ifdef CONFIG_OF
 	const struct of_device_id *match;
@@ -3059,7 +3059,7 @@ static __devinitdata struct ipmi_default_vals
 	{ .port = 0 }
 };
 
-static void __devinit default_find_bmc(void)
+static void default_find_bmc(void)
 {
 	struct smi_info *info;
 	int             i;
@@ -3359,7 +3359,7 @@ static int try_smi_init(struct smi_info *new_smi)
 	return rv;
 }
 
-static int __devinit init_ipmi_si(void)
+static int init_ipmi_si(void)
 {
 	int  i;
 	char *str;
diff --git a/drivers/char/ps3flash.c b/drivers/char/ps3flash.c
index 6abdde4..588063ac 100644
--- a/drivers/char/ps3flash.c
+++ b/drivers/char/ps3flash.c
@@ -363,7 +363,7 @@ static struct miscdevice ps3flash_misc = {
 	.fops	= &ps3flash_fops,
 };
 
-static int __devinit ps3flash_probe(struct ps3_system_bus_device *_dev)
+static int ps3flash_probe(struct ps3_system_bus_device *_dev)
 {
 	struct ps3_storage_device *dev = to_ps3_storage_device(&_dev->core);
 	struct ps3flash_private *priv;
diff --git a/drivers/char/sonypi.c b/drivers/char/sonypi.c
index 34f0db3..861efa4 100644
--- a/drivers/char/sonypi.c
+++ b/drivers/char/sonypi.c
@@ -1164,7 +1164,7 @@ static struct acpi_driver sonypi_acpi_driver = {
 };
 #endif
 
-static int __devinit sonypi_create_input_devices(struct platform_device *pdev)
+static int sonypi_create_input_devices(struct platform_device *pdev)
 {
 	struct input_dev *jog_dev;
 	struct input_dev *key_dev;
@@ -1225,7 +1225,7 @@ static int __devinit sonypi_create_input_devices(struct platform_device *pdev)
 	return error;
 }
 
-static int __devinit sonypi_setup_ioports(struct sonypi_device *dev,
+static int sonypi_setup_ioports(struct sonypi_device *dev,
 				const struct sonypi_ioport_list *ioport_list)
 {
 	/* try to detect if sony-laptop is being used and thus
@@ -1265,7 +1265,7 @@ static int __devinit sonypi_setup_ioports(struct sonypi_device *dev,
 	return -EBUSY;
 }
 
-static int __devinit sonypi_setup_irq(struct sonypi_device *dev,
+static int sonypi_setup_irq(struct sonypi_device *dev,
 				      const struct sonypi_irq_list *irq_list)
 {
 	while (irq_list->irq) {
@@ -1282,7 +1282,7 @@ static int __devinit sonypi_setup_irq(struct sonypi_device *dev,
 	return -EBUSY;
 }
 
-static void __devinit sonypi_display_info(void)
+static void sonypi_display_info(void)
 {
 	printk(KERN_INFO "sonypi: detected type%d model, "
 	       "verbose = %d, fnkeyinit = %s, camera = %s, "
@@ -1304,7 +1304,7 @@ static void __devinit sonypi_display_info(void)
 		       sonypi_misc_device.minor);
 }
 
-static int __devinit sonypi_probe(struct platform_device *dev)
+static int sonypi_probe(struct platform_device *dev)
 {
 	const struct sonypi_ioport_list *ioport_list;
 	const struct sonypi_irq_list *irq_list;
diff --git a/drivers/char/tb0219.c b/drivers/char/tb0219.c
index 6bfe2af..76e3aea 100644
--- a/drivers/char/tb0219.c
+++ b/drivers/char/tb0219.c
@@ -284,7 +284,7 @@ static void tb0219_pci_irq_init(void)
 	vr41xx_set_irq_level(TB0219_PCI_SLOT3_PIN, IRQ_LEVEL_LOW);
 }
 
-static int __devinit tb0219_probe(struct platform_device *dev)
+static int tb0219_probe(struct platform_device *dev)
 {
 	int retval;
 
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 4ad8aca..b9d390b 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1848,7 +1848,7 @@ static void remove_controlq_data(struct ports_device *portdev)
  * config space to see how many ports the host has spawned.  We
  * initialize each port found.
  */
-static int __devinit virtcons_probe(struct virtio_device *vdev)
+static int virtcons_probe(struct virtio_device *vdev)
 {
 	struct ports_device *portdev;
 	int err;
diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
index 2c5d15b..547ed74 100644
--- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
@@ -595,7 +595,7 @@ static const struct file_operations hwicap_fops = {
 	.llseek = noop_llseek,
 };
 
-static int __devinit hwicap_setup(struct device *dev, int id,
+static int hwicap_setup(struct device *dev, int id,
 		const struct resource *regs_res,
 		const struct hwicap_driver_config *config,
 		const struct config_registers *config_regs)
@@ -740,7 +740,7 @@ static int __devexit hwicap_remove(struct device *dev)
 }
 
 #ifdef CONFIG_OF
-static int __devinit hwicap_of_probe(struct platform_device *op,
+static int hwicap_of_probe(struct platform_device *op,
 				     const struct hwicap_driver_config *config)
 {
 	struct resource res;
@@ -786,7 +786,7 @@ static inline int hwicap_of_probe(struct platform_device *op,
 #endif /* CONFIG_OF */
 
 static const struct of_device_id __devinitconst hwicap_of_match[];
-static int __devinit hwicap_drv_probe(struct platform_device *pdev)
+static int hwicap_drv_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	struct resource *res;
-- 
1.8.0
