Return-Path: <krafft@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BC0F667EB3
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 02:46:41 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id kBIFkafq015614
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Dec 2006 15:46:36 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kBIFka3x2625756
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Dec 2006 16:46:36 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kBIFkXPA019594
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Dec 2006 16:46:34 +0100
Date: Mon, 18 Dec 2006 16:42:29 +0100
From: Christian Krafft <krafft@de.ibm.com>
To: Christian Krafft <krafft@linux.ibm.com>
Subject: Re: [patch 0/1] ipmi: update: add autosensing of ipmi devices on
	powerpc using of device tree
Message-ID: <20061218164229.6a8b0df7@localhost>
In-Reply-To: <20061218163846.337fed65@localhost>
References: <20061218163846.337fed65@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Arnd,
	openipmi-developer@lists.sourceforge.net
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


Index: linux-2.6.19/drivers/char/ipmi/ipmi_si_intf.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.19/drivers/char/ipmi/ipmi_si_intf.c
@@ -9,6 +9,7 @@
  *         source@mvista.com
  *
  * Copyright 2002 MontaVista Software Inc.
+ * Copyright 2006 IBM Corp., Christian Krafft <krafft@de.ibm.com>
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License as published by the
@@ -64,6 +65,12 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
=20
+/* only exists on powerpc */
+#ifdef CONFIG_PPC_OF
+#include <asm/of_device.h>
+#include <asm/of_platform.h>
+#endif
+
 #define PFX "ipmi_si: "
=20
 /* Measure times between events in the driver. */
@@ -1888,6 +1895,96 @@ static struct pci_driver ipmi_pci_driver
 #endif /* CONFIG_PCI */
=20
=20
+#ifdef CONFIG_PPC_OF
+static int ipmi_of_probe(struct of_device *dev,
+			 const struct of_device_id *match)
+{
+	struct smi_info *info;
+	struct resource resource;
+	const int *regsize, *regspacing, *regshift;
+	struct device_node *np =3D dev->node;
+	int ret;
+
+	dev_info(&dev->dev, PFX "probing via device tree\n");
+
+	ret =3D of_address_to_resource(np, 0, &resource);
+	if (ret) {
+		dev_warn(&dev->dev, PFX "invalid address from OF\n");
+		return ret;
+	}
+
+	regsize =3D get_property(np, "reg-size", NULL);
+	regspacing =3D get_property(np, "reg-spacing", NULL);
+	regshift =3D get_property(np, "reg-shift", NULL);
+
+	info =3D kzalloc(sizeof(*info), GFP_KERNEL);
+
+	if (!info) {
+		dev_err(&dev->dev,
+			PFX "could not allocate memory for OF probe\n");
+		return -ENOMEM;
+	}
+
+	info->si_type		=3D (enum si_type) match->data;
+	info->addr_source	=3D "device-tree";
+	info->io_setup		=3D mem_setup;
+	info->irq_setup		=3D std_irq_setup;
+
+	info->io.addr_type	=3D IPMI_MEM_ADDR_SPACE;
+	info->io.addr_data	=3D resource.start;
+
+	if (!regsize)
+		info->io.regsize =3D DEFAULT_REGSPACING;
+	else
+		info->io.regsize =3D *regsize;
+
+	if (!regspacing)
+		info->io.regspacing =3D DEFAULT_REGSPACING;
+	else
+		info->io.regspacing =3D *regspacing;
+
+	if (!regshift)
+		info->io.regshift =3D 0;
+	else
+		info->io.regshift =3D *regshift;
+
+	info->irq		=3D irq_of_parse_and_map(dev->node, 0);
+	info->dev		=3D &dev->dev;
+
+	dev_dbg(&dev->dev, "addr 0x%lx regsize %ld spacing %ld irq %x\n",
+		info->io.addr_data, info->io.regsize, info->io.regspacing,
+		info->irq);
+
+	dev->dev.driver_data =3D (void*) info;
+
+	return try_smi_init(info);
+}
+
+static int ipmi_of_remove(struct of_device *dev)
+{
+	/* should call
+	 * cleanup_one_si(dev->dev.driver_data); */
+	return 0;
+}
+
+static struct of_device_id ipmi_match[] =3D
+{
+	{ .type =3D "ipmi", .compatible =3D "ipmi-kcs",  .data =3D (void*)SI_KCS =
},
+	{ .type =3D "ipmi", .compatible =3D "ipmi-smic", .data =3D (void*)SI_SMIC=
 },
+	{ .type =3D "ipmi", .compatible =3D "ipmi-bt",   .data =3D (void*)SI_BT },
+	{},
+};
+
+static struct of_platform_driver ipmi_of_platform_driver =3D
+{
+	.name		=3D "ipmi",
+	.match_table	=3D ipmi_match,
+	.probe		=3D ipmi_of_probe,
+	.remove		=3D __devexit_p(ipmi_of_remove),
+};
+#endif /* CONFIG_PPC_OF */
+
+
 static int try_get_dev_id(struct smi_info *smi_info)
 {
 	unsigned char         msg[2];
@@ -2490,6 +2587,10 @@ static __devinit int init_ipmi_si(void)
 	pci_module_init(&ipmi_pci_driver);
 #endif
=20
+#ifdef CONFIG_PPC_OF
+	of_register_platform_driver(&ipmi_of_platform_driver);
+#endif
+
 	if (si_trydefaults) {
 		mutex_lock(&smi_infos_lock);
 		if (list_empty(&smi_infos)) {
@@ -2587,6 +2688,10 @@ static __exit void cleanup_ipmi_si(void)
 	pci_unregister_driver(&ipmi_pci_driver);
 #endif
=20
+#ifdef CONFIG_PPC_OF
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
