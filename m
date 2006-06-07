Return-Path: <moilanen@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1B77767B37
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2006 07:14:06 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e31.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k57LE4kq027378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jun 2006 17:14:04 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k57LDxDl250720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jun 2006 15:13:59 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k57LE36B012431
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jun 2006 15:14:03 -0600
Date: Wed, 7 Jun 2006 16:05:46 -0500
From: Jake Moilanen <moilanen@austin.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] PCIe device_type pciex
Message-Id: <20060607160546.3ec7d581.moilanen@austin.ibm.com>
In-Reply-To: <20060607160212.1203d9ea.moilanen@austin.ibm.com>
References: <20060607160212.1203d9ea.moilanen@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds support to recognize the PCIe device_type "pciex" and made
the portdrv buildable.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>


Index: 2.6/arch/powerpc/Kconfig
===================================================================
--- 2.6.orig/arch/powerpc/Kconfig	2006-05-31 15:33:57.000000000 -0500
+++ 2.6/arch/powerpc/Kconfig	2006-05-31 15:34:10.000000000 -0500
@@ -849,6 +849,8 @@
 
 endchoice
 
+source "drivers/pci/pcie/Kconfig"
+
 source "drivers/pci/Kconfig"
 
 source "drivers/pcmcia/Kconfig"
Index: 2.6/arch/powerpc/kernel/pci_64.c
===================================================================
--- 2.6.orig/arch/powerpc/kernel/pci_64.c	2006-05-31 15:33:57.000000000 -0500
+++ 2.6/arch/powerpc/kernel/pci_64.c	2006-05-31 15:34:10.000000000 -0500
@@ -396,7 +396,7 @@
 
 	dev->current_state = 4;		/* unknown power state */
 
-	if (!strcmp(type, "pci")) {
+	if (!strcmp(type, "pci") || !strcmp(type, "pciex")) {
 		/* a PCI-PCI bridge */
 		dev->hdr_type = PCI_HEADER_TYPE_BRIDGE;
 		dev->rom_base_reg = PCI_ROM_ADDRESS1;
Index: 2.6/arch/powerpc/kernel/rtas_pci.c
===================================================================
--- 2.6.orig/arch/powerpc/kernel/rtas_pci.c	2006-05-31 15:33:57.000000000 -0500
+++ 2.6/arch/powerpc/kernel/rtas_pci.c	2006-05-31 15:34:10.000000000 -0500
@@ -313,7 +313,9 @@
 	for (node = of_get_next_child(root, NULL);
 	     node != NULL;
 	     node = of_get_next_child(root, node)) {
-		if (node->type == NULL || strcmp(node->type, "pci") != 0)
+
+		if (node->type == NULL || (strcmp(node->type, "pci") != 0 &&
+					   strcmp(node->type, "pciex") != 0))
 			continue;
 
 		phb = pcibios_alloc_controller(node);
