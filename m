Return-Path: <krafft@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A5A4DDDDE6
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 10:45:18 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id l0ONjC0J016934
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 23:45:12 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l0ONjCLO2785326
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 00:45:12 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0ONjCDK014089
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 00:45:12 +0100
Date: Thu, 25 Jan 2007 10:45:40 +1100
From: Christian Krafft <krafft@de.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 1/1] updated version, fixed the compiler warning
Message-ID: <20070125104540.65a1f557@localhost>
In-Reply-To: <200612210111.28186.arnd@arndb.de>
References: <20061218163846.337fed65@localhost> <45882913.2000609@acm.org>
	<20061220154517.6341fce6@localhost>
	<200612210111.28186.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christian, linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	openipmi-developer@lists.sourceforge.net,
	Krafft <krafft@linux.vnet.ibm.com>
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
Acked-by: Heiko J Schick <schihei@de.ibm.com>

Index: linux/drivers/char/ipmi/ipmi_si_intf.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux/drivers/char/ipmi/ipmi_si_intf.c
@@ -9,6 +9,7 @@
  *         source@mvista.com
  *
  * Copyright 2002 MontaVista Software Inc.
+ * Copyright 2006 IBM Corp., Christian Krafft <krafft@de.ibm.com>
  *
  *  This program is free software; you can redistribute it and/or modify it
  *  under the terms of the GNU General Public License as published by the
@@ -64,6 +65,11 @@
 #include <linux/string.h>
 #include <linux/ctype.h>
=20
+#ifdef CONFIG_PPC_OF
+#include <asm/of_device.h>
+#include <asm/of_platform.h>
+#endif
+
 #define PFX "ipmi_si: "
=20
 /* Measure times between events in the driver. */
@@ -1006,6 +1012,7 @@ static DEFINE_MUTEX(smi_infos_lock);
 static int smi_num; /* Used to sequence the SMIs */
=20
 #define DEFAULT_REGSPACING	1
+#define DEFAULT_REGSIZE		DEFAULT_REGSPACING
=20
 static int           si_trydefaults =3D 1;
 static char          *si_type[SI_MAX_PARMS];
@@ -2174,6 +2181,100 @@ static struct pci_driver ipmi_pci_driver
 #endif /* CONFIG_PCI */
=20
=20
+#ifdef CONFIG_PPC_OF
+static int __devinit ipmi_of_probe(struct of_device *dev,
+			 const struct of_device_id *match)
+{
+	struct smi_info *info;
+	struct resource resource;
+	const int *regsize, *regspacing, *regshift;
+	struct device_node *np =3D dev->node;
+	int ret;
+	int proplen;
+
+	dev_info(&dev->dev, PFX "probing via device tree\n");
+
+	ret =3D of_address_to_resource(np, 0, &resource);
+	if (ret) {
+		dev_warn(&dev->dev, PFX "invalid address from OF\n");
+		return ret;
+	}
+
+	regsize =3D get_property(np, "reg-size", &proplen);
+	if (regsize && proplen!=3D4) {
+		dev_warn(&dev->dev, PFX "invalid regsize from OF\n");
+		return -EINVAL;
+	}
+
+	regspacing =3D get_property(np, "reg-spacing", &proplen);
+	if (regspacing && proplen!=3D4) {
+		dev_warn(&dev->dev, PFX "invalid regspacing from OF\n");
+		return -EINVAL;
+	}
+
+	regshift =3D get_property(np, "reg-shift", &proplen);
+	if (regshift && proplen!=3D4) {
+		dev_warn(&dev->dev, PFX "invalid regshift from OF\n");
+		return -EINVAL;
+	}
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
+	info->io.regsize	=3D regsize ? *regsize : DEFAULT_REGSIZE;
+	info->io.regspacing	=3D regspacing ? *regspacing : DEFAULT_REGSPACING;
+	info->io.regshift	=3D regshift ? *regshift : 0;
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
+static int __devexit ipmi_of_remove(struct of_device *dev)
+{
+	/* should call
+	 * cleanup_one_si(dev->dev.driver_data); */
+	return 0;
+}
+
+static struct of_device_id ipmi_match[] =3D
+{
+	{ .type =3D "ipmi", .compatible =3D "ipmi-kcs",  .data =3D (void *)(unsig=
ned long) SI_KCS },
+	{ .type =3D "ipmi", .compatible =3D "ipmi-smic", .data =3D (void *)(unsig=
ned long) SI_SMIC },
+	{ .type =3D "ipmi", .compatible =3D "ipmi-bt",   .data =3D (void *)(unsig=
ned long) SI_BT },
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
@@ -2798,6 +2899,10 @@ static __devinit int init_ipmi_si(void)
 	}
 #endif
=20
+#ifdef CONFIG_PPC_OF
+	of_register_platform_driver(&ipmi_of_platform_driver);
+#endif
+
 	if (si_trydefaults) {
 		mutex_lock(&smi_infos_lock);
 		if (list_empty(&smi_infos)) {
@@ -2895,6 +3000,10 @@ static __exit void cleanup_ipmi_si(void)
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
