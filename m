Return-Path: <krafft@de.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E6DBB67D3B
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 03:28:38 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.8/8.13.8) with ESMTP id kB7GSRUS155640
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 16:28:27 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kB7GSR5l925790
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 16:28:27 GMT
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kB7GSQOr015495
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Dec 2006 16:28:27 GMT
Date: Thu, 7 Dec 2006 17:24:45 +0100
From: Christian Krafft <krafft@de.ibm.com>
To: Christian Krafft <krafft@de.ibm.com>
Subject: Re: [patch 1/1] ipmi: add autosensing of ipmi device on powerpc
	using device-tree
Message-ID: <20061207172445.2108cf43@localhost>
In-Reply-To: <20061207172259.64168f8c@localhost>
References: <20061207172259.64168f8c@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, openipmi-developer@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for of_platform_driver to the ipmi_si module.
When loading the module, the driver will be registered to of_platform.
The driver will be probed for all devices with the type ipmi. It's supporti=
ng
devices with compatible settings ipmi-kcs, ipmi-smic and ipmi-bt.
Only ipmi-kcs could be tested.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>

Index: linux-2.6.19-rc6/drivers/char/ipmi/ipmi_si_intf.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-rc6.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.19-rc6/drivers/char/ipmi/ipmi_si_intf.c
@@ -9,6 +9,7 @@
  *         source@mvista.com
  *
  * Copyright 2002 MontaVista Software Inc.
+ * Copyright 2006 IBM Corp., Christian Krafft <krafft@de.ibm.com>
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License as published by the
@@ -62,6 +63,12 @@
 #include <linux/init.h>
 #include <linux/dmi.h>
=20
+/* only exists on powerpc */
+#ifdef CONFIG_PPC_OF
+#include <asm/of_device.h>
+#include <asm/of_platform.h>
+#endif
+
 /* Measure times between events in the driver. */
 #undef DEBUG_TIMING
=20
@@ -1884,6 +1891,90 @@ static struct pci_driver ipmi_pci_driver
 #endif /* CONFIG_PCI */
=20
=20
+#ifdef CONFIG_PPC_OF
+static int ipmi_of_probe(struct of_device *dev, const struct of_device_id =
*match)
+{
+	struct smi_info *info;
+	struct resource resource0, resource1;
+	struct device_node *np =3D dev->node;
+	int ret;
+
+	dev_info(&dev->dev, "probing via device tree\n");
+
+	if (match->data) {
+		dev_warn(&dev->dev, "unknown interface type\n");
+		return -ENODEV;
+	}
+
+	ret =3D of_address_to_resource(np, 0, &resource0);
+
+	if (ret) {
+		dev_warn(&dev->dev, "invalid address\n");
+		return ret;
+	}
+
+	ret =3D of_address_to_resource(np, 1, &resource1);
+
+	if (ret) {
+		dev_warn(&dev->dev, "invalid address\n");
+		return ret;
+	}
+
+	info =3D kzalloc(sizeof(*info), GFP_KERNEL);
+
+	if (!info) {
+		dev_err(&dev->dev, "could not allocate memory\n");
+		return -ENOMEM;
+	}
+
+	info->si_type		=3D (enum si_type) match->data;
+	info->addr_source	=3D "device-tree";
+	info->io_setup		=3D mem_setup;
+	info->irq_setup		=3D std_irq_setup;
+
+	info->io.addr_type	=3D IPMI_MEM_ADDR_SPACE;
+	info->io.addr_data	=3D resource0.start;
+	info->io.regsize	=3D resource0.end - resource0.start + 1;
+	info->io.regspacing	=3D resource1.start - resource0.start;
+	info->io.regshift	=3D 0; /* regshift property if needed */
+	info->irq		=3D irq_of_parse_and_map(dev->node, 0);
+	info->dev		=3D &dev->dev;
+
+	dev_dbg(&dev->dev, "addr 0x%lx regsize %ld spacing %ld irq %x\n",
+		info->io.addr_data, info->io.regsize, info->io.regspacing,
+		info->irq);
+
+	return try_smi_init(info);
+}
+
+static int ipmi_of_remove(struct of_device *dev)
+{
+	return 0;
+}
+
+static struct of_device_id ipmi_match[] =3D
+{
+	{ .type =3D "ipmi",	.compatible =3D "ipmi-kcs",	.data =3D (void*)SI_KCS },
+	{ .type =3D "ipmi",	.compatible =3D "ipmi-smic",	.data =3D (void*)SI_SMIC=
 },
+	{ .type =3D "ipmi",	.compatible =3D "ipmi-bt",	.data =3D (void*)SI_BT },
+	{},
+};
+
+static struct of_platform_driver ipmi_of_platform_driver =3D
+{
+	.name		=3D "ipmi",
+	.match_table	=3D ipmi_match,
+	.probe		=3D ipmi_of_probe,
+	.remove		=3D ipmi_of_remove
+};
+
+static void __devinit of_find_bmc(void)
+{
+	of_register_platform_driver(&ipmi_of_platform_driver);
+}
+#endif /* CONFIG_PM_OF */
+
+
 static int try_get_dev_id(struct smi_info *smi_info)
 {
 	unsigned char         msg[2];
@@ -2486,6 +2577,10 @@ static __devinit int init_ipmi_si(void)
 	pci_module_init(&ipmi_pci_driver);
 #endif
=20
+#ifdef CONFIG_PPC_OF
+	of_find_bmc();
+#endif
+
 	if (si_trydefaults) {
 		mutex_lock(&smi_infos_lock);
 		if (list_empty(&smi_infos)) {
@@ -2583,6 +2678,10 @@ static __exit void cleanup_ipmi_si(void)
 	pci_unregister_driver(&ipmi_pci_driver);
 #endif
=20
+#ifdef CONFIG_OF_PPC
+	of_unregister_platform_driver(&ipmi_of_platform_driver);
+#endif
+
 	mutex_lock(&smi_infos_lock);
 	list_for_each_entry_safe(e, tmp_e, &smi_infos, link)
 		cleanup_one_si(e);


--=20
Mit freundlichen Gr=FCssen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,=20
Linux Kernel Development
IT Specialist
