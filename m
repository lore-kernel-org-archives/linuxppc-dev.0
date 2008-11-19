Return-Path: <azanella@linux.vnet.ibm.com>
Received: from igw1.br.ibm.com (igw1.br.ibm.com [32.104.18.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5AD55DDDF0
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 00:55:42 +1100 (EST)
Received: from d24relay01.br.ibm.com (unknown [9.8.31.16])
	by igw1.br.ibm.com (Postfix) with ESMTP id 73B1632C145
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 11:52:43 -0200 (BRDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.18.232.47])
	by d24relay01.br.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mAJEtC5t2613392
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 11:55:12 -0300
Received: from d24av02.br.ibm.com (loopback [127.0.0.1])
	by d24av02.br.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mAJDtZcO014112
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 11:55:35 -0200
Received: from [9.18.253.67] (bastet.br.ibm.com [9.18.253.67])
	by d24av02.br.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	mAJDtZ9r014106
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 11:55:35 -0200
Message-ID: <49241AD7.3060201@linux.vnet.ibm.com>
Date: Wed, 19 Nov 2008 11:55:35 -0200
From: Adhemerval Zanella <azanella@linux.vnet.ibm.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] IRQ assign for some PCIe devices
Content-Type: multipart/mixed; boundary="------------060700060303030202080102"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------060700060303030202080102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello all,

Fallowing a Benjamin Herrenschmidt request, I sending you a fix for IRQ 
assign for some PCIe devices. This bug affects multiple PCIe devices 
including Cadet-E, Squib-E, CISCO 4X SDR IB, and Knox adapters.

The problem lays in the fact OF does not create an "interrupt" property 
for some PCIe device (for instance 
"pci\@800000020000204/pci1014\,0339\@0/", an IBM Raid Controller) and 
the kernel code fails returning a IRQ 0 (invalid one) if this property 
is not present.

This patch changes the way to map interrupts to if the code can not get 
"interrupts" property from PCI OF node, it falls back to standard OF 
parsing. I verified and it worked fine with a pair of Squib-E SAS 
adapter on a P6-570.





--------------060700060303030202080102
Content-Type: text/x-patch;
 name="ppc64_irq_assign.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc64_irq_assign.patch"

diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index bc1fb27..a11d689 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -250,8 +250,11 @@ int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq)
 	 * parsing
 	 */
 	dn = pci_device_to_OF_node(pdev);
-	if (dn)
-		return of_irq_map_one(dn, 0, out_irq);
+	if (dn) {
+		rc = of_irq_map_one(dn, 0, out_irq);
+		if (!rc)
+			return rc;
+	}
 
 	/* Ok, we don't, time to have fun. Let's start by building up an
 	 * interrupt spec.  we assume #interrupt-cells is 1, which is standard

--------------060700060303030202080102--
