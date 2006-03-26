Return-Path: <tnt@246tNt.com>
Received: from outmx010.isp.belgacom.be (outmx010.isp.belgacom.be
	[195.238.5.233])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D647B67A39
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 26 Mar 2006 22:37:21 +1100 (EST)
Received: from outmx010.isp.belgacom.be (localhost [127.0.0.1])
	by outmx010.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k2QBbALF009945
	for <linuxppc-embedded@ozlabs.org>; Sun, 26 Mar 2006 13:37:10 +0200
	(envelope-from <tnt@246tNt.com>)
Date: Sun, 26 Mar 2006 13:37:07 +0200
Message-ID: <1.20060326_133535_93e6_tnt@patchsend.246tNt.com>
From: Sylvain Munaut <tnt@246tNt.com>
To: Linux PPC embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 1/4] ppc32: Adds support for the PCI hostbridge in MPC5200B
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <0.20060326_133535_93e6_tnt@patchsend.246tNt.com>
References: <0.20060326_133535_93e6_tnt@patchsend.246tNt.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ppc32: Adds support for the PCI hostbridge in MPC5200B

Signed-off-by: John Rigby <jrigby@freescale.com>
Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
---
commit d2c9f75189b6bd63b94cc78f8522a44c4476939a
tree 384ab1d358439be5cddbab68cfa542390ac784f4
parent 3cbb90a9cb7854b1110663919d5bc3da3f46d5e3
author Sylvain Munaut <tnt@246tNt.com> 1138559991 +0100
committer Sylvain Munaut <tnt@246tNt.com> 1143311787 +0100

 arch/ppc/syslib/mpc52xx_pci.c |    3 ++-
 include/linux/pci_ids.h       |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

---
d2c9f75189b6bd63b94cc78f8522a44c4476939a
diff --git a/arch/ppc/syslib/mpc52xx_pci.c b/arch/ppc/syslib/mpc52xx_pci.c
index 9ec525f..5a5a7a9 100644
--- a/arch/ppc/syslib/mpc52xx_pci.c
+++ b/arch/ppc/syslib/mpc52xx_pci.c
@@ -225,7 +225,8 @@ mpc52xx_pci_fixup_resources(struct pci_d
 	/* The PCI Host bridge of MPC52xx has a prefetch memory resource
 	   fixed to 1Gb. Doesn't fit in the resource system so we remove it */
 	if ( (dev->vendor == PCI_VENDOR_ID_MOTOROLA) &&
-	     (dev->device == PCI_DEVICE_ID_MOTOROLA_MPC5200) ) {
+	     (   dev->device == PCI_DEVICE_ID_MOTOROLA_MPC5200
+	      || dev->device == PCI_DEVICE_ID_MOTOROLA_MPC5200B) ) {
 		struct resource *res = &dev->resource[1];
 		res->start = res->end = res->flags = 0;
 	}
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 6f080ae..72d1b67 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -772,6 +772,7 @@
 #define PCI_DEVICE_ID_MOTOROLA_HAWK	0x4803
 #define PCI_DEVICE_ID_MOTOROLA_HARRIER	0x480b
 #define PCI_DEVICE_ID_MOTOROLA_MPC5200	0x5803
+#define PCI_DEVICE_ID_MOTOROLA_MPC5200B	0x5809
 
 #define PCI_VENDOR_ID_PROMISE		0x105a
 #define PCI_DEVICE_ID_PROMISE_20265	0x0d30
