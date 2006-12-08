Return-Path: <minyard@acm.org>
Received: from mta13.adelphia.net (mta13.mail.adelphia.net [68.168.78.44])
	by ozlabs.org (Postfix) with ESMTP id AFAC367BE1
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 05:59:05 +1100 (EST)
Date: Fri, 8 Dec 2006 12:59:02 -0600
From: Corey Minyard <minyard@acm.org>
To: Christian Krafft <krafft@de.ibm.com>
Subject: Re: [Openipmi-developer] [patch 1/1] ipmi: add autosensing of ipmi
	device on powerpc using device-tree
Message-ID: <20061208185902.GA14675@localdomain>
References: <20061207172259.64168f8c@localhost>
	<20061207172445.2108cf43@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061207172445.2108cf43@localhost>
Cc: linuxppc-dev@ozlabs.org, openipmi-developer@lists.sourceforge.net
Reply-To: minyard@acm.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I reviewed this some more, and I cleaned up some formatting (breaking
long lines) and enhanced the error reporting strings.

I believe the following:

@@ -2583,6 +2678,10 @@ static __exit void cleanup_ipmi_si(void)
 	pci_unregister_driver(&ipmi_pci_driver);
 #endif
 
+#ifdef CONFIG_OF_PPC
+	of_unregister_platform_driver(&ipmi_of_platform_driver);
+#endif
+

Uses the wrong CONFIG option, which I have adjusted.


+       if (match->data) {
+               dev_warn(&dev->dev, "unknown interface type\n");
+               return -ENODEV;
+       }
+

What's this mean?  I don't understand the error.


+	info->io.regsize	= resource0.end - resource0.start + 1;
+	info->io.regspacing	= resource1.start - resource0.start;

Are you sure this is a reliable way to check the register spacing and
register size?  Register size means "how big is a register (8, 16, 32
bits)".  Register spacing means (how many bytes are there between
registers.  If you had two registers that were 8 bits and 4 bytes
apart, for instance, I don't believe the above calculations would work.


+static int ipmi_of_remove(struct of_device *dev)
+{
+	return 0;
+}

With the newest IPMI patches (only in git right now), hot removal of
interfaces is supported.  Is that what this is for?  If so, you can
call cleanup_one_si() on the interface.

Here's a new patch.  Can you test that unloading the module works
correctly?

-Corey


This patch adds support for of_platform_driver to the ipmi_si module.
When loading the module, the driver will be registered to of_platform.
The driver will be probed for all devices with the type ipmi. It's supporting
devices with compatible settings ipmi-kcs, ipmi-smic and ipmi-bt.
Only ipmi-kcs could be tested.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Acked-by: Heiko J Schick <schihei@de.ibm.com>
Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.19/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
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
 
+/* only exists on powerpc */
+#ifdef CONFIG_PPC_OF
+#include <asm/of_device.h>
+#include <asm/of_platform.h>
+#endif
+
 #define PFX "ipmi_si: "
 
 /* Measure times between events in the driver. */
@@ -2174,6 +2181,89 @@ static struct pci_driver ipmi_pci_driver
 #endif /* CONFIG_PCI */
 
 
+#ifdef CONFIG_PPC_OF
+static int ipmi_of_probe(struct of_device *dev,
+			 const struct of_device_id *match)
+{
+	struct smi_info *info;
+	struct resource resource0, resource1;
+	struct device_node *np = dev->node;
+	int ret;
+
+	dev_info(&dev->dev, PFX "probing via device tree\n");
+
+	if (match->data) {
+		dev_warn(&dev->dev, PFX "unknown OF interface type\n");
+		return -ENODEV;
+	}
+
+	ret = of_address_to_resource(np, 0, &resource0);
+	if (ret) {
+		dev_warn(&dev->dev, PFX "invalid address 0 from OF\n");
+		return ret;
+	}
+
+	ret = of_address_to_resource(np, 1, &resource1);
+	if (ret) {
+		dev_warn(&dev->dev, PFX "invalid address 1 from OF\n");
+		return ret;
+	}
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		dev_err(&dev->dev,
+			PFX "could not allocate memory for OF probe\n");
+		return -ENOMEM;
+	}
+
+	info->si_type		= (enum si_type) match->data;
+	info->addr_source	= "device-tree";
+	info->io_setup		= mem_setup;
+	info->irq_setup		= std_irq_setup;
+
+	info->io.addr_type	= IPMI_MEM_ADDR_SPACE;
+	info->io.addr_data	= resource0.start;
+	info->io.regsize	= resource0.end - resource0.start + 1;
+	info->io.regspacing	= resource1.start - resource0.start;
+	info->io.regshift	= 0; /* regshift property if needed */
+	info->irq		= irq_of_parse_and_map(dev->node, 0);
+	info->dev		= &dev->dev;
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
+static struct of_device_id ipmi_match[] =
+{
+	{ .type = "ipmi", .compatible = "ipmi-kcs",  .data = (void*)SI_KCS },
+	{ .type = "ipmi", .compatible = "ipmi-smic", .data = (void*)SI_SMIC },
+	{ .type = "ipmi", .compatible = "ipmi-bt",   .data = (void*)SI_BT },
+	{},
+};
+
+static struct of_platform_driver ipmi_of_platform_driver =
+{
+	.name		= "ipmi",
+	.match_table	= ipmi_match,
+	.probe		= ipmi_of_probe,
+	.remove		= ipmi_of_remove
+};
+
+static void __devinit of_find_bmc(void)
+{
+	of_register_platform_driver(&ipmi_of_platform_driver);
+}
+#endif /* CONFIG_PPC_OF */
+
+
 static int try_get_dev_id(struct smi_info *smi_info)
 {
 	unsigned char         msg[2];
@@ -2798,6 +2888,10 @@ static __devinit int init_ipmi_si(void)
 	}
 #endif
 
+#ifdef CONFIG_PPC_OF
+	of_find_bmc();
+#endif
+
 	if (si_trydefaults) {
 		mutex_lock(&smi_infos_lock);
 		if (list_empty(&smi_infos)) {
@@ -2895,6 +2989,10 @@ static __exit void cleanup_ipmi_si(void)
 	pci_unregister_driver(&ipmi_pci_driver);
 #endif
 
+#ifdef CONFIG_PPC_OF
+	of_unregister_platform_driver(&ipmi_of_platform_driver);
+#endif
+
 	mutex_lock(&smi_infos_lock);
 	list_for_each_entry_safe(e, tmp_e, &smi_infos, link)
 		cleanup_one_si(e);
