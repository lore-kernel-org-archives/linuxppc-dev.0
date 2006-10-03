Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 395D967C3A
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 09:18:34 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Add of_platform_device_scan().
Date: Wed, 4 Oct 2006 01:18:09 +0200
References: <20061003225659.GA11955@ld0162-tx32.am.freescale.net>
In-Reply-To: <20061003225659.GA11955@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610040118.09416.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 04 October 2006 00:56, Scott Wood wrote:
> This patch adds of_platform_device_scan(), which adds matching device
> nodes to the of_platform bus. =A0The goal is to let drivers reuse the mat=
ch
> struct to do this, rather than have special code in fsl_soc.c (or
> equivalent) that knows which nodes to add.
>=20
> This will be used by the ucc_geth.c driver; in the current QE patchset,
> it registers an of_platform driver for devices that never get registered.
>=20

I think it would be much more helpful to have working probing of all
SOC buses during bootup. With your patch, we don't have the ability
to autoload modules based on the available devices, but can only
see devices that have been explicitly registered. This fundamentally
violates the principles of the linux device model.

Incidentally, I've experimented last week with doing exactly what
I think we should have. It doesn't yet do the thing I want it for
(allow PCI buses below SOC buses), but it should be able to scan
nested soc buses fine and thereby add all your devices to the
tree so you can attach drivers to them.

	Arnd <><

Index: linux-2.6/arch/powerpc/kernel/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.orig/arch/powerpc/kernel/Makefile
+++ linux-2.6/arch/powerpc/kernel/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_TAU)		+=3D tau_6xx.o
 obj32-$(CONFIG_SOFTWARE_SUSPEND) +=3D swsusp_32.o
 obj32-$(CONFIG_MODULES)		+=3D module_32.o
 obj-$(CONFIG_E500)		+=3D perfmon_fsl_booke.o
+obj-$(CONFIG_SOC)		+=3D soc.o
=20
 ifeq ($(CONFIG_PPC_MERGE),y)
=20
Index: linux-2.6/arch/powerpc/kernel/soc.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- /dev/null
+++ linux-2.6/arch/powerpc/kernel/soc.c
@@ -0,0 +1,152 @@
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+
+#include <asm/prom.h>
+#include <asm/of_device.h>
+#include <asm/ppc-pci.h>
+#include <asm-powerpc/axon_dcr.h>
+
+static int of_soc_create_device_name(struct device_node *node, char *name)
+{
+	const u32 *reg;
+	u64 addr;
+
+	reg =3D get_property(node, "dcr-reg", NULL);
+	if (reg) {
+		addr =3D of_translate_dcr_address(node, reg);
+		if (addr !=3D OF_BAD_ADDR)
+			goto found_dcr;
+	}
+	reg =3D get_property(node, "reg", NULL);
+	if (reg) {
+		addr =3D of_translate_address(node, reg);
+		if (addr !=3D OF_BAD_ADDR)
+			goto found;
+	}
+
+	return -EINVAL;
+
+found_dcr:
+	sprintf(name, "D%lx.%s", addr, node->name);
+	return 0;
+
+found:
+	sprintf(name, "%lx.%s", addr, node->name);
+	return 0;
+}
+
+static int of_soc_device_create(struct device_node *node, struct device *p=
arent)
+{
+	char name[BUS_ID_SIZE];
+	int ret;
+
+	printk("found node %s\n", node->name);
+	ret =3D of_soc_create_device_name(node, name);
+	if (ret)
+		return ret;
+
+	of_platform_device_create(node, name, parent);
+	return 0;
+}
+
+static int of_soc_bus_probe(struct of_device *dev,
+			const struct of_device_id *match)
+{
+	struct device_node *child;
+	int ret =3D -ENODEV;
+	for (child =3D NULL; (child =3D of_get_next_child(dev->node, child)); ) {
+		ret =3D of_soc_device_create(child, &dev->dev);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+static struct of_device_id of_soc_ids[] =3D {
+	{ .type =3D "soc", },
+	{ .compatible =3D "soc", },
+	{ .type =3D "spider", },
+	{ .type =3D "axon", },
+	{ .type =3D "plb5", },
+	{ .type =3D "plb4", },
+	{ .type =3D "opb", },
+	{},
+};
+
+static struct of_platform_driver of_soc_driver =3D {
+	.name =3D "soc",
+	.match_table =3D of_soc_ids,
+	.probe =3D of_soc_bus_probe,
+};
+
+#if 0
+static int of_pci_bus_probe(struct of_device *dev,
+			const struct of_device_id *match)
+{
+	struct pci_controller *phb;
+
+	phb =3D pcibios_alloc_controller(dev->node);
+	if (!phb)
+		return -ENODEV;
+	setup_phb(dev->node, phb);
+	pci_process_bridge_OF_ranges(phb, dev->node, 0);
+	pci_setup_phb_io(phb, 0);
+	return 0;
+}
+
+static struct of_device_id of_pci_ids[] =3D {
+	{ .type =3D "pci", },
+	{ .type =3D "pcie", },
+	{ .type =3D "pciex", },
+	{ .type =3D "ht", },
+	{ .compatible =3D "pci", },
+	{ .compatible =3D "pcie", },
+	{ .compatible =3D "pciex", },
+	{ .compatible =3D "ht", },
+};
+
+static struct of_platform_driver of_pci_driver =3D {
+	.name =3D "pci",
+	.match_table =3D of_pci_ids,
+	.probe =3D of_pci_bus_probe,
+};
+#endif
+
+static int of_soc_probe(void)
+{
+	struct device_node *root, *child;
+	int ret;
+
+	ret =3D 0;
+	root =3D of_find_node_by_path("/");
+	if (!root)
+		goto out;
+	ret =3D of_register_driver(&of_soc_driver);
+	if (ret)
+		goto out;
+
+#if 0
+	ret =3D of_register_driver(&of_pci_driver);
+	if (ret)
+		goto out2;
+#endif
+
+	for (child =3D NULL; (child =3D of_get_next_child(root, child)); ) {
+		if (strcmp(child->type, "spider") =3D=3D 0) {
+			ret =3D of_soc_device_create(child, NULL);
+			if (ret)
+				goto out3;
+		}
+	}
+
+	return 0;
+out3:
+	of_unregister_driver(&of_soc_driver);
+out2:
+	of_unregister_driver(&of_pci_driver);
+out:
+	return ret;
+}
+__initcall(of_soc_probe);
Index: linux-2.6/arch/powerpc/Kconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.orig/arch/powerpc/Kconfig
+++ linux-2.6/arch/powerpc/Kconfig
@@ -450,6 +450,7 @@ config PPC_IBM_CELL_BLADE
 	select MMIO_NVRAM
 	select PPC_UDBG_16550
 	select UDBG_RTAS_CONSOLE
+	select SOC
=20
 config UDBG_RTAS_CONSOLE
 	bool "RTAS based debug console"
@@ -544,6 +545,13 @@ config PPC_970_NAP
 	bool
 	default n
=20
+config SOC
+	bool
+	default n
+	help
+	  Support for probing of SOC (system-on-a-chip) buses from
+	  the device tree
+
 source "drivers/cpufreq/Kconfig"
=20
 config CPU_FREQ_PMAC
