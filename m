Return-Path: <mmlnx@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 09D5EB7334
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jul 2009 04:44:49 +1000 (EST)
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9553BDDD1B
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2009 04:44:48 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n6FIdjbd020922
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jul 2009 12:39:45 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n6FIieIo120432
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jul 2009 12:44:40 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6FIidiZ004778
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Jul 2009 12:44:40 -0600
Message-ID: <4A5E23D0.9020906@us.ibm.com>
Date: Wed, 15 Jul 2009 11:45:36 -0700
From: Mike Mason <mmlnx@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, linux-pci@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, benh@kernel.crashing.org,
	linasvepstas@gmail.com
Subject: [PATCH] Support for PCI Express reset type in EEH
References: <4A5CCFDF.7000901@us.ibm.com>
In-Reply-To: <4A5CCFDF.7000901@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Richard Lary <rlary@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

By default, EEH does what's known as a "hot reset" during error recovery of a PCI Express device.  We've found a case where the device needs a "fundamental reset" to recover properly.  The current PCI error recovery and EEH frameworks do not support this distinction.

The attached patch (courtesy of Richard Lary) adds a bit field to pci_dev that indicates whether the device requires a fundamental reset during error recovery.  This bit can be checked by EEH to determine which reset type is required.

This patch supersedes the previously submitted patch that implemented a reset type callback.

Please review and let me know of any concerns.

Signed-off-by: Mike Mason <mmlnx@us.ibm.com> 

diff -uNrp a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
--- a/arch/powerpc/kernel/pci_64.c	2009-07-13 14:25:24.000000000 -0700
+++ b/arch/powerpc/kernel/pci_64.c	2009-07-15 10:26:26.000000000 -0700
@@ -143,6 +143,7 @@ struct pci_dev *of_create_pci_dev(struct
 	dev->dev.bus = &pci_bus_type;
 	dev->devfn = devfn;
 	dev->multifunction = 0;		/* maybe a lie? */
+	dev->fndmntl_rst_rqd = 0;       /* pcie fundamental reset required */
 
 	dev->vendor = get_int_prop(node, "vendor-id", 0xffff);
 	dev->device = get_int_prop(node, "device-id", 0xffff);
diff -uNrp a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
--- a/arch/powerpc/platforms/pseries/eeh.c	2009-06-09 20:05:27.000000000 -0700
+++ b/arch/powerpc/platforms/pseries/eeh.c	2009-07-15 10:29:04.000000000 -0700
@@ -744,7 +744,15 @@ int pcibios_set_pcie_reset_state(struct
 
 static void __rtas_set_slot_reset(struct pci_dn *pdn)
 {
-	rtas_pci_slot_reset (pdn, 1);
+	struct pci_dev *dev = pdn->pcidev;
+
+	/* Determine type of EEH reset required by device,
+	 * default hot reset or fundamental reset
+	 */
+	if (dev->fndmntl_rst_rqd)
+		rtas_pci_slot_reset(pdn, 3);
+	else
+		rtas_pci_slot_reset(pdn, 1);
 
 	/* The PCI bus requires that the reset be held high for at least
 	 * a 100 milliseconds. We wait a bit longer 'just in case'.  */
diff -uNrp a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	2009-07-13 14:25:37.000000000 -0700
+++ b/include/linux/pci.h	2009-07-15 10:25:37.000000000 -0700
@@ -273,6 +273,7 @@ struct pci_dev {
 	unsigned int	ari_enabled:1;	/* ARI forwarding */
 	unsigned int	is_managed:1;
 	unsigned int	is_pcie:1;
+	unsigned int    fndmntl_rst_rqd:1; /* Dev requires fundamental reset */
 	unsigned int	state_saved:1;
 	unsigned int	is_physfn:1;
 	unsigned int	is_virtfn:1;
