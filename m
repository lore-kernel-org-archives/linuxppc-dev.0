Return-Path: <anton@samba.org>
Date: Mon, 25 Jun 2012 14:24:44 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au,
 miltonm@bga.com, nacc@us.ibm.com, brking@linux.vnet.ibm.com,
 rcj@linux.vnet.ibm.com
Subject: [PATCH 2/4] powerpc: vio: Separate vio bus probe and device probe
Message-ID: <20120625142444.17caef00@kryten>
In-Reply-To: <20120625142353.0a92791a@kryten>
References: <20120625142353.0a92791a@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Similar to PCI, separate the bus probe from device probe. This allows
us to attach bus notifiers for DMA debug and IOMMU fault injection
before devices have been probed.

Signed-off-by: Anton Blanchard <anton@samba.org>  
---

Index: linux-build/arch/powerpc/kernel/vio.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/vio.c	2012-06-08 09:14:19.282098456 +1000
+++ linux-build/arch/powerpc/kernel/vio.c	2012-06-08 09:16:53.856359566 +1000
@@ -1497,12 +1497,18 @@ static int __init vio_bus_init(void)
 	if (firmware_has_feature(FW_FEATURE_CMO))
 		vio_cmo_bus_init();
 
+	return 0;
+}
+postcore_initcall(vio_bus_init);
+
+static int __init vio_device_init(void)
+{
 	vio_bus_scan_register_devices("vdevice");
 	vio_bus_scan_register_devices("ibm,platform-facilities");
 
 	return 0;
 }
-__initcall(vio_bus_init);
+device_initcall(vio_device_init);
 
 static ssize_t name_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
