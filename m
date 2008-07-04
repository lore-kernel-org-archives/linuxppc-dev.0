Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5A673DE386
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 22:54:31 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m64CsRYm025935
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Jul 2008 08:54:27 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m64CsRvP229398
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Jul 2008 08:54:27 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m64CsQRG002504
	for <linuxppc-dev@ozlabs.org>; Fri, 4 Jul 2008 08:54:27 -0400
Date: Fri, 4 Jul 2008 07:54:18 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: [PATCH 08/16 v3] powerpc: Do not probe PCI buses or eBus devices
	if CMO is enabled
Message-ID: <20080704125418.GK1310@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080704124449.GA1310@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=46rom: Brian King <brking@linux.vnet.ibm.com>

The Cooperative Memory Overcommit (CMO) on System p does not currently
support native PCI devices or eBus devices when enabled. Prevent
PCI bus probe and eBus device probe if the feature is enabled.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---

 arch/powerpc/kernel/ibmebus.c          |    6 ++++++
 arch/powerpc/platforms/pseries/setup.c |    4 ++++
 2 files changed, 10 insertions(+)

Index: b/arch/powerpc/kernel/ibmebus.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/kernel/ibmebus.c
+++ b/arch/powerpc/kernel/ibmebus.c
@@ -45,6 +45,7 @@
 #include <linux/of_platform.h>
 #include <asm/ibmebus.h>
 #include <asm/abs_addr.h>
+#include <asm/firmware.h>
=20
 static struct device ibmebus_bus_device =3D { /* fake "parent" device */
 	.bus_id =3D "ibmebus",
@@ -332,6 +333,11 @@ static int __init ibmebus_bus_init(void)
 {
 	int err;
=20
+	if (firmware_has_feature(FW_FEATURE_CMO)) {
+		printk(KERN_WARNING "Not probing eBus since CMO is enabled\n");
+		return 0;
+	}
+
 	printk(KERN_INFO "IBM eBus Device Driver\n");
=20
 	err =3D of_bus_type_init(&ibmebus_bus_type, "ibmebus");
Index: b/arch/powerpc/platforms/pseries/setup.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -539,6 +539,10 @@ static void pseries_shared_idle_sleep(vo
=20
 static int pSeries_pci_probe_mode(struct pci_bus *bus)
 {
+	if (firmware_has_feature(FW_FEATURE_CMO)) {
+		dev_warn(&bus->dev, "Not probing PCI bus since CMO is enabled\n");
+		return PCI_PROBE_NONE;
+	}
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		return PCI_PROBE_DEVTREE;
 	return PCI_PROBE_NORMAL;
