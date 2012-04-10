Return-Path: <key@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "Equifax" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B2377B7327
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2012 01:10:10 +1000 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <key@linux.vnet.ibm.com>;
 Tue, 10 Apr 2012 09:10:06 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 2F3B91FF004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2012 09:08:18 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q3AF8ESE059822
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2012 09:08:16 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q3AF7jmE030317
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2012 09:07:48 -0600
Message-ID: <1334070530.16827.9.camel@key-ThinkPad-W510>
Subject: [PATCH v2 04/17] hwrng: pseries - PFO-based hwrng driver
From: Kent Yoder <key@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 10 Apr 2012 10:08:50 -0500
In-Reply-To: <1334070249.16827.1.camel@key-ThinkPad-W510>
References: <1334070249.16827.1.camel@key-ThinkPad-W510>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: key@linux.vnet.ibm.com, rcj@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds support for the Platform Facilities Option (PFO)-based hardware
random number generator for POWER hardware.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
Signed-off-by: Kent Yoder <key@linux.vnet.ibm.com>
---
 drivers/char/hw_random/Kconfig       |   13 +++++
 drivers/char/hw_random/Makefile      |    1 +
 drivers/char/hw_random/pseries-rng.c |   96 ++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+), 0 deletions(-)
 create mode 100644 drivers/char/hw_random/pseries-rng.c

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 0689bf6..9355347 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -250,3 +250,16 @@ config UML_RANDOM
 	  (check your distro, or download from
 	  http://sourceforge.net/projects/gkernel/).  rngd periodically reads
 	  /dev/hwrng and injects the entropy into /dev/random.
+
+config HW_RANDOM_PSERIES
+	tristate "pSeries HW Random Number Generator support"
+	depends on HW_RANDOM && PPC64 && IBMVIO
+	default HW_RANDOM
+	---help---
+	  This driver provides kernel-side support for the Random Number
+	  Generator hardware found on POWER7+ machines and above
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called pseries-rng.
+
+	  If unsure, say Y.
diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
index b2ff526..d901dfa 100644
--- a/drivers/char/hw_random/Makefile
+++ b/drivers/char/hw_random/Makefile
@@ -22,3 +22,4 @@ obj-$(CONFIG_HW_RANDOM_OCTEON) += octeon-rng.o
 obj-$(CONFIG_HW_RANDOM_NOMADIK) += nomadik-rng.o
 obj-$(CONFIG_HW_RANDOM_PICOXCELL) += picoxcell-rng.o
 obj-$(CONFIG_HW_RANDOM_PPC4XX) += ppc4xx-rng.o
+obj-$(CONFIG_HW_RANDOM_PSERIES) += pseries-rng.o
diff --git a/drivers/char/hw_random/pseries-rng.c b/drivers/char/hw_random/pseries-rng.c
new file mode 100644
index 0000000..5f11979
--- /dev/null
+++ b/drivers/char/hw_random/pseries-rng.c
@@ -0,0 +1,96 @@
+/*
+ * Copyright (C) 2010 Michael Neuling IBM Corporation
+ *
+ * Driver for the pseries hardware RNG for POWER7+ and above
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/module.h>
+#include <linux/hw_random.h>
+#include <asm/vio.h>
+
+#define MODULE_NAME "pseries-rng"
+
+static int pseries_rng_data_read(struct hwrng *rng, u32 *data)
+{
+	if (plpar_hcall(H_RANDOM, (unsigned long *)data) != H_SUCCESS) {
+		printk(KERN_ERR "pseries rng hcall error\n");
+		return 0;
+	}
+	return 8;
+}
+
+/**
+ * pseries_rng_get_desired_dma - Return desired DMA allocate for CMO operations
+ *
+ * This is a required function for a driver to operate in a CMO environment
+ * but this device does not make use of DMA allocations, return 0.
+ *
+ * Return value:
+ *	Number of bytes of IO data the driver will need to perform well -> 0
+ */
+static unsigned long pseries_rng_get_desired_dma(struct vio_dev *vdev)
+{
+	return 0;
+};
+
+static struct hwrng pseries_rng = {
+	.name		= MODULE_NAME,
+	.data_read	= pseries_rng_data_read,
+};
+
+static int __init pseries_rng_probe(struct vio_dev *dev,
+		const struct vio_device_id *id)
+{
+	return hwrng_register(&pseries_rng);
+}
+
+static int __exit pseries_rng_remove(struct vio_dev *dev)
+{
+	hwrng_unregister(&pseries_rng);
+	return 0;
+}
+
+static struct vio_device_id pseries_rng_driver_ids[] = {
+	{ "ibm,random-v1", "ibm,random"},
+	{ "", "" }
+};
+MODULE_DEVICE_TABLE(vio, pseries_rng_driver_ids);
+
+static struct vio_driver pseries_rng_driver = {
+	.name = MODULE_NAME,
+	.probe = pseries_rng_probe,
+	.remove = pseries_rng_remove,
+	.get_desired_dma = pseries_rng_get_desired_dma,
+	.id_table = pseries_rng_driver_ids
+};
+
+static int __init rng_init(void)
+{
+	printk(KERN_INFO "Registering IBM pSeries RNG driver\n");
+	return vio_register_driver(&pseries_rng_driver);
+}
+
+module_init(rng_init);
+
+static void __exit rng_exit(void)
+{
+	vio_unregister_driver(&pseries_rng_driver);
+}
+module_exit(rng_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Michael Neuling <mikey@neuling.org>");
+MODULE_DESCRIPTION("H/W RNG driver for IBM pSeries processors");
-- 
1.7.1
