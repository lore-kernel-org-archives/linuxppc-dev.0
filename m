Return-Path: <krafft@de.ibm.com>
Received: from mtagate7.uk.ibm.com (mtagate7.uk.ibm.com [195.212.29.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B5938DE018
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 14:34:37 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate7.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l0P3XmOs065820
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 03:33:48 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l0P3XmEH1646740
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 03:33:48 GMT
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l0P3Xl0A008798
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 03:33:48 GMT
Date: Thu, 25 Jan 2007 14:34:15 +1100
From: Christian Krafft <krafft@de.ibm.com>
To: Christian Krafft <krafft@de.ibm.com>
Subject: Re: [patch 1/1] next updated version, fixed cleanup and some minors
Message-ID: <20070125143415.10f43bfa@localhost>
In-Reply-To: <20070125143056.47cbd5d2@localhost>
References: <20061218163846.337fed65@localhost> <45882913.2000609@acm.org>
	<20061220154517.6341fce6@localhost>
	<200612210111.28186.arnd@arndb.de>
	<20070125104540.65a1f557@localhost>
	<DA5708FC-F9AB-4782-A48D-40B26990A24F@kernel.crashing.org>
	<20070125143056.47cbd5d2@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, openipmi-developer@lists.sourceforge.net,
	Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>
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
Signed-off-by: Corey Minyard <minyard@acm.org>

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
+#define DEFAULT_REGSIZE		1
=20
 static int           si_trydefaults =3D 1;
 static char          *si_type[SI_MAX_PARMS];
@@ -2174,6 +2181,99 @@ static struct pci_driver ipmi_pci_driver
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
+	if (regsize && proplen !=3D 4) {
+		dev_warn(&dev->dev, PFX "invalid regsize from OF\n");
+		return -EINVAL;
+	}
+
+	regspacing =3D get_property(np, "reg-spacing", &proplen);
+	if (regspacing && proplen !=3D 4) {
+		dev_warn(&dev->dev, PFX "invalid regspacing from OF\n");
+		return -EINVAL;
+	}
+
+	regshift =3D get_property(np, "reg-shift", &proplen);
+	if (regshift && proplen !=3D 4) {
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
+	cleanup_one_si(dev->dev.driver_data);
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
@@ -2798,6 +2898,10 @@ static __devinit int init_ipmi_si(void)
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
@@ -2895,6 +2999,10 @@ static __exit void cleanup_ipmi_si(void)
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
