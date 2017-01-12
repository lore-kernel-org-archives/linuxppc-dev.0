Return-Path: <kishon@ti.com>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzkYq6dRdzDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 22:49:03 +1100 (AEDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@axis.com>, <linux-arm-msm@vger.kernel.org>,
 <nsekhar@ti.com>, <kishon@ti.com>
Subject: [PATCH 31/37] misc: Add host side pci driver for pci test function
 device
Date: Thu, 12 Jan 2017 15:56:20 +0530
Message-ID: <1484216786-17292-32-git-send-email-kishon@ti.com>
In-Reply-To: <1484216786-17292-1-git-send-email-kishon@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add PCI endpoint test driver that can verify base address
register, legacy interrupt/MSI interrupt and read/write/copy
buffers between host and device. The corresponding pci-epf-test
function driver should be used on the EP side.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/misc/Kconfig             |    7 +
 drivers/misc/Makefile            |    1 +
 drivers/misc/pci_endpoint_test.c |  533 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/Kbuild        |    1 +
 include/uapi/linux/pcitest.h     |   19 ++
 5 files changed, 561 insertions(+)
 create mode 100644 drivers/misc/pci_endpoint_test.c
 create mode 100644 include/uapi/linux/pcitest.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 64971ba..14a95a6 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -766,6 +766,13 @@ config PANEL_BOOT_MESSAGE
 	  An empty message will only clear the display at driver init time. Any other
 	  printf()-formatted message is valid with newline and escape codes.
 
+config PCI_ENDPOINT_TEST
+	depends on PCI || COMPILE_TEST
+	tristate "PCI Endpoint Test driver"
+	---help---
+           Enable this configuration option to enable the host side test driver
+           for PCI Endpoint.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 3198336..64a532ac2 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -53,6 +53,7 @@ obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_VEXPRESS_SYSCFG)	+= vexpress-syscfg.o
 obj-$(CONFIG_CXL_BASE)		+= cxl/
 obj-$(CONFIG_PANEL)             += panel.o
+obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 
 lkdtm-$(CONFIG_LKDTM)		+= lkdtm_core.o
 lkdtm-$(CONFIG_LKDTM)		+= lkdtm_bugs.o
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
new file mode 100644
index 0000000..920b14c
--- /dev/null
+++ b/drivers/misc/pci_endpoint_test.c
@@ -0,0 +1,533 @@
+/**
+ * Host side test driver to test endpoint functionality
+ *
+ * Copyright (C) 2017 Texas Instruments
+ * Author: Kishon Vijay Abraham I <kishon@ti.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 of
+ * the License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/crc32.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <linux/pci_ids.h>
+
+#include <linux/pci_regs.h>
+
+#include <uapi/linux/pcitest.h>
+
+#define DRV_MODULE_NAME			"pci-endpoint-test"
+
+#define PCI_ENDPOINT_TEST_MAGIC		0x0
+
+#define PCI_ENDPOINT_TEST_COMMAND	0x4
+#define COMMAND_RAISE_LEGACY_IRQ	BIT(0)
+#define COMMAND_RAISE_MSI_IRQ		BIT(1)
+#define MSI_NUMBER_SHIFT		2
+/* 6 bits for MSI number */
+#define COMMAND_READ                    BIT(8)
+#define COMMAND_WRITE                   BIT(9)
+#define COMMAND_COPY                    BIT(10)
+
+#define PCI_ENDPOINT_TEST_STATUS	0x8
+#define STATUS_READ_SUCCESS             BIT(0)
+#define STATUS_READ_FAIL                BIT(1)
+#define STATUS_WRITE_SUCCESS            BIT(2)
+#define STATUS_WRITE_FAIL               BIT(3)
+#define STATUS_COPY_SUCCESS             BIT(4)
+#define STATUS_COPY_FAIL                BIT(5)
+#define STATUS_IRQ_RAISED               BIT(6)
+#define STATUS_SRC_ADDR_INVALID         BIT(7)
+#define STATUS_DST_ADDR_INVALID         BIT(8)
+
+#define PCI_ENDPOINT_TEST_LOWER_SRC_ADDR	0xc
+#define PCI_ENDPOINT_TEST_UPPER_SRC_ADDR	0x10
+
+#define PCI_ENDPOINT_TEST_LOWER_DST_ADDR	0x14
+#define PCI_ENDPOINT_TEST_UPPER_DST_ADDR	0x18
+
+#define PCI_ENDPOINT_TEST_SIZE		0x1c
+#define PCI_ENDPOINT_TEST_CHECKSUM	0x20
+
+static DEFINE_IDA(pci_endpoint_test_ida);
+
+#define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
+					    miscdev)
+enum pci_barno {
+	BAR_0,
+	BAR_1,
+	BAR_2,
+	BAR_3,
+	BAR_4,
+	BAR_5,
+};
+
+struct pci_endpoint_test {
+	struct pci_dev	*pdev;
+	void __iomem	*base;
+	void __iomem	*bar[6];
+	struct completion irq_raised;
+	int		last_irq;
+	/* mutex to protect the ioctls */
+	struct mutex	mutex;
+	struct miscdevice miscdev;
+};
+
+static int bar_size[] = { 4, 512, 1024, 16384, 131072, 1048576 };
+
+static inline u32 pci_endpoint_test_readl(struct pci_endpoint_test *test,
+					  u32 offset)
+{
+	return readl(test->base + offset);
+}
+
+static inline void pci_endpoint_test_writel(struct pci_endpoint_test *test,
+					    u32 offset, u32 value)
+{
+	writel(value, test->base + offset);
+}
+
+static inline u32 pci_endpoint_test_bar_readl(struct pci_endpoint_test *test,
+					      int bar, int offset)
+{
+	return readl(test->bar[bar] + offset);
+}
+
+static inline void pci_endpoint_test_bar_writel(struct pci_endpoint_test *test,
+						int bar, u32 offset, u32 value)
+{
+	writel(value, test->bar[bar] + offset);
+}
+
+static irqreturn_t pci_endpoint_test_irqhandler(int irq, void *dev_id)
+{
+	struct pci_endpoint_test *test = dev_id;
+	u32 reg;
+
+	reg = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+	if (reg & STATUS_IRQ_RAISED) {
+		test->last_irq = irq;
+		complete(&test->irq_raised);
+		reg &= ~STATUS_IRQ_RAISED;
+	}
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_STATUS,
+				 reg);
+
+	return IRQ_HANDLED;
+}
+
+static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
+				  enum pci_barno barno)
+{
+	int j;
+	u32 val;
+	int size;
+
+	if (!test->bar[barno])
+		return false;
+
+	size = bar_size[barno];
+
+	for (j = 0; j < size; j += 4)
+		pci_endpoint_test_bar_writel(test, barno, j, 0xA0A0A0A0);
+
+	for (j = 0; j < size; j += 4) {
+		val = pci_endpoint_test_bar_readl(test, barno, j);
+		if (val != 0xA0A0A0A0)
+			return false;
+	}
+
+	return true;
+}
+
+static bool pci_endpoint_test_legacy_irq(struct pci_endpoint_test *test)
+{
+	u32 val;
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 COMMAND_RAISE_LEGACY_IRQ);
+	val = wait_for_completion_timeout(&test->irq_raised,
+					  msecs_to_jiffies(1000));
+	if (!val)
+		return false;
+
+	return true;
+}
+
+static bool pci_endpoint_test_msi_irq(struct pci_endpoint_test *test,
+				      u8 msi_num)
+{
+	u32 val;
+	struct pci_dev *pdev = test->pdev;
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 msi_num << MSI_NUMBER_SHIFT |
+				 COMMAND_RAISE_MSI_IRQ);
+	val = wait_for_completion_timeout(&test->irq_raised,
+					  msecs_to_jiffies(1000));
+	if (!val)
+		return false;
+
+	if (test->last_irq - pdev->irq == msi_num - 1)
+		return true;
+
+	return false;
+}
+
+static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
+{
+	bool ret = false;
+	void *src_addr;
+	void *dst_addr;
+	dma_addr_t src_phys_addr;
+	dma_addr_t dst_phys_addr;
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	u32 src_crc32;
+	u32 dst_crc32;
+
+	src_addr = dma_alloc_coherent(dev, size, &src_phys_addr, GFP_KERNEL);
+	if (!src_addr) {
+		dev_err(dev, "failed to allocate source buffer\n");
+		ret = false;
+		goto err;
+	}
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_SRC_ADDR,
+				 lower_32_bits(src_phys_addr));
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_SRC_ADDR,
+				 upper_32_bits(src_phys_addr));
+
+	get_random_bytes(src_addr, size);
+	src_crc32 = crc32_le(~0, src_addr, size);
+
+	dst_addr = dma_alloc_coherent(dev, size, &dst_phys_addr, GFP_KERNEL);
+	if (!dst_addr) {
+		dev_err(dev, "failed to allocate destination address\n");
+		ret = false;
+		goto err_src_addr;
+	}
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_DST_ADDR,
+				 lower_32_bits(dst_phys_addr));
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_DST_ADDR,
+				 upper_32_bits(dst_phys_addr));
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE,
+				 size);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 1 << MSI_NUMBER_SHIFT | COMMAND_COPY);
+
+	wait_for_completion(&test->irq_raised);
+
+	dst_crc32 = crc32_le(~0, dst_addr, size);
+	if (dst_crc32 == src_crc32)
+		ret = true;
+
+	dma_free_coherent(dev, size, dst_addr, dst_phys_addr);
+
+err_src_addr:
+	dma_free_coherent(dev, size, src_addr, src_phys_addr);
+
+err:
+	return ret;
+}
+
+static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
+{
+	bool ret = false;
+	u32 reg;
+	void *addr;
+	dma_addr_t phys_addr;
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	u32 crc32;
+
+	addr = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
+	if (!addr) {
+		dev_err(dev, "failed to allocate address\n");
+		ret = false;
+		goto err;
+	}
+
+	get_random_bytes(addr, size);
+
+	crc32 = crc32_le(~0, addr, size);
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_CHECKSUM,
+				 crc32);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_SRC_ADDR,
+				 lower_32_bits(phys_addr));
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_SRC_ADDR,
+				 upper_32_bits(phys_addr));
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 1 << MSI_NUMBER_SHIFT | COMMAND_READ);
+
+	wait_for_completion(&test->irq_raised);
+
+	reg = pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_STATUS);
+	if (reg & STATUS_READ_SUCCESS)
+		ret = true;
+
+	dma_free_coherent(dev, size, addr, phys_addr);
+
+err:
+	return ret;
+}
+
+static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
+{
+	bool ret = false;
+	void *addr;
+	dma_addr_t phys_addr;
+	struct pci_dev *pdev = test->pdev;
+	struct device *dev = &pdev->dev;
+	u32 crc32;
+
+	addr = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
+	if (!addr) {
+		dev_err(dev, "failed to allocate destination address\n");
+		ret = false;
+		goto err;
+	}
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_LOWER_DST_ADDR,
+				 lower_32_bits(phys_addr));
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_DST_ADDR,
+				 upper_32_bits(phys_addr));
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_SIZE, size);
+
+	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_COMMAND,
+				 1 << MSI_NUMBER_SHIFT | COMMAND_WRITE);
+
+	wait_for_completion(&test->irq_raised);
+
+	crc32 = crc32_le(~0, addr, size);
+	if (crc32 == pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM))
+		ret = true;
+
+	dma_free_coherent(dev, size, addr, phys_addr);
+err:
+	return ret;
+}
+
+static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
+				    unsigned long arg)
+{
+	int ret = -EINVAL;
+	enum pci_barno bar;
+	struct pci_endpoint_test *test = to_endpoint_test(file->private_data);
+
+	mutex_lock(&test->mutex);
+	switch (cmd) {
+	case PCITEST_BAR:
+		bar = arg;
+		if (bar < 0 || bar > 5)
+			goto ret;
+		ret = pci_endpoint_test_bar(test, bar);
+		break;
+	case PCITEST_LEGACY_IRQ:
+		ret = pci_endpoint_test_legacy_irq(test);
+		break;
+	case PCITEST_MSI:
+		ret = pci_endpoint_test_msi_irq(test, arg);
+		break;
+	case PCITEST_WRITE:
+		ret = pci_endpoint_test_write(test, arg);
+		break;
+	case PCITEST_READ:
+		ret = pci_endpoint_test_read(test, arg);
+		break;
+	case PCITEST_COPY:
+		ret = pci_endpoint_test_copy(test, arg);
+		break;
+	}
+
+ret:
+	mutex_unlock(&test->mutex);
+	return ret;
+}
+
+static const struct file_operations pci_endpoint_test_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = pci_endpoint_test_ioctl,
+};
+
+static int pci_endpoint_test_probe(struct pci_dev *pdev,
+				   const struct pci_device_id *ent)
+{
+	int i;
+	int err;
+	int irq;
+	int id;
+	char name[20];
+	enum pci_barno bar;
+	void __iomem *base;
+	struct device *dev = &pdev->dev;
+	struct pci_endpoint_test *test;
+	struct miscdevice *misc_device;
+
+	if (pci_is_bridge(pdev))
+		return -ENODEV;
+
+	test = devm_kzalloc(dev, sizeof(*test), GFP_KERNEL);
+	if (!test)
+		return -ENOMEM;
+
+	test->pdev = pdev;
+	init_completion(&test->irq_raised);
+	mutex_init(&test->mutex);
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		dev_err(dev, "Cannot enable PCI device\n");
+		return err;
+	}
+
+	err = pci_request_regions(pdev, DRV_MODULE_NAME);
+	if (err) {
+		dev_err(dev, "Cannot obtain PCI resources\n");
+		goto err_disable_pdev;
+	}
+
+	pci_set_master(pdev);
+
+	irq = pci_enable_msi_range(pdev, 1, 32);
+	if (irq < 0)
+		dev_err(dev, "failed to get MSI interrupts\n");
+
+	err = devm_request_irq(dev, pdev->irq, pci_endpoint_test_irqhandler,
+			       IRQF_SHARED, DRV_MODULE_NAME, test);
+	if (err) {
+		dev_err(dev, "failed to request irq\n");
+		goto err_disable_msi;
+	}
+
+	for (i = 1; i < irq; i++) {
+		err = devm_request_irq(dev, pdev->irq + i,
+				       pci_endpoint_test_irqhandler,
+				       IRQF_SHARED, DRV_MODULE_NAME, test);
+		if (err)
+			dev_err(dev, "failed to request irq for MSI %d\n",
+				i + 1);
+	}
+
+	for (bar = BAR_0; bar <= BAR_5; bar++) {
+		base = pci_ioremap_bar(pdev, bar);
+		if (!base) {
+			dev_err(dev, "failed to read BAR%d\n", bar);
+			WARN_ON(bar == BAR_0);
+		}
+		test->bar[bar] = base;
+	}
+
+	test->base = test->bar[0];
+	if (!test->base) {
+		dev_err(dev, "Cannot perform PCI test without BAR0\n");
+		goto err_iounmap;
+	}
+
+	pci_set_drvdata(pdev, test);
+
+	id = ida_simple_get(&pci_endpoint_test_ida, 0, 0, GFP_KERNEL);
+	if (id < 0) {
+		dev_err(dev, "unable to get id\n");
+		goto err_iounmap;
+	}
+
+	snprintf(name, sizeof(name), DRV_MODULE_NAME ".%d", id);
+	misc_device = &test->miscdev;
+	misc_device->minor = MISC_DYNAMIC_MINOR;
+	misc_device->name = name;
+	misc_device->fops = &pci_endpoint_test_fops,
+
+	err = misc_register(misc_device);
+	if (err) {
+		dev_err(dev, "failed to register device\n");
+		goto err_ida_remove;
+	}
+
+	return 0;
+
+err_ida_remove:
+	ida_simple_remove(&pci_endpoint_test_ida, id);
+
+err_iounmap:
+	for (bar = BAR_0; bar <= BAR_5; bar++) {
+		if (test->bar[bar])
+			pci_iounmap(pdev, test->bar[bar]);
+	}
+
+err_disable_msi:
+	pci_disable_msi(pdev);
+	pci_release_regions(pdev);
+
+err_disable_pdev:
+	pci_disable_device(pdev);
+
+	return err;
+}
+
+static void pci_endpoint_test_remove(struct pci_dev *pdev)
+{
+	int id;
+	enum pci_barno bar;
+	struct pci_endpoint_test *test = pci_get_drvdata(pdev);
+	struct miscdevice *misc_device = &test->miscdev;
+
+	if (sscanf(misc_device->name, DRV_MODULE_NAME ".%d", &id) != 1)
+		return;
+
+	misc_deregister(&test->miscdev);
+	ida_simple_remove(&pci_endpoint_test_ida, id);
+	for (bar = BAR_0; bar <= BAR_5; bar++) {
+		if (test->bar[bar])
+			pci_iounmap(pdev, test->bar[bar]);
+	}
+	pci_disable_msi(pdev);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+}
+
+static const struct pci_device_id pci_endpoint_test_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_ANY_ID) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
+
+static struct pci_driver pci_endpoint_test_driver = {
+	.name		= DRV_MODULE_NAME,
+	.id_table	= pci_endpoint_test_tbl,
+	.probe		= pci_endpoint_test_probe,
+	.remove		= pci_endpoint_test_remove,
+};
+module_pci_driver(pci_endpoint_test_driver);
+
+MODULE_DESCRIPTION("PCI ENDPOINT TEST DRIVER");
+MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/uapi/linux/Kbuild b/include/uapi/linux/Kbuild
index a8b93e6..f3c2769 100644
--- a/include/uapi/linux/Kbuild
+++ b/include/uapi/linux/Kbuild
@@ -329,6 +329,7 @@ header-y += parport.h
 header-y += patchkey.h
 header-y += pci.h
 header-y += pci_regs.h
+header-y += pcitest.h
 header-y += perf_event.h
 header-y += personality.h
 header-y += pfkeyv2.h
diff --git a/include/uapi/linux/pcitest.h b/include/uapi/linux/pcitest.h
new file mode 100644
index 0000000..a6aa10c
--- /dev/null
+++ b/include/uapi/linux/pcitest.h
@@ -0,0 +1,19 @@
+/**
+ * pcitest.h - PCI test uapi defines
+ *
+ * Copyright (C) 2017 Texas Instruments
+ * Author: Kishon Vijay Abraham I <kishon@ti.com>
+ *
+ */
+
+#ifndef __UAPI_LINUX_PCITEST_H
+#define __UAPI_LINUX_PCITEST_H
+
+#define PCITEST_BAR		_IO('P', 0x1)
+#define PCITEST_LEGACY_IRQ	_IO('P', 0x2)
+#define PCITEST_MSI		_IOW('P', 0x3, int)
+#define PCITEST_WRITE		_IOW('P', 0x4, unsigned long)
+#define PCITEST_READ		_IOW('P', 0x5, unsigned long)
+#define PCITEST_COPY		_IOW('P', 0x6, unsigned long)
+
+#endif /* __UAPI_LINUX_PCITEST_H */
-- 
1.7.9.5
