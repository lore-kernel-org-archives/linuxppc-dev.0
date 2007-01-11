Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 788ECDDDF6
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jan 2007 16:08:48 +1100 (EST)
Subject: [PATCH] powerpc: Fix cell's mmio nvram to properly parse dt
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Thu, 11 Jan 2007 16:08:41 +1100
Message-Id: <1168492121.22458.391.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The mmio nvram driver (used by cell only atm) isn't properly parsing the
device-tree. It works ok for old blades where the nvram is at the root
of the DT but fails on Malta and CAB when it's hanging off axon. This
fixes it by using the proper OF parsing functions.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

It should be good for 2.6.20 but if not, I won't complain.

Index: linux-work/arch/powerpc/sysdev/mmio_nvram.c
===================================================================
--- linux-work.orig/arch/powerpc/sysdev/mmio_nvram.c	2007-01-02 11:12:52.000000000 +1100
+++ linux-work/arch/powerpc/sysdev/mmio_nvram.c	2007-01-10 15:34:11.000000000 +1100
@@ -80,33 +80,39 @@ static ssize_t mmio_nvram_get_size(void)
 int __init mmio_nvram_init(void)
 {
 	struct device_node *nvram_node;
-	const unsigned long *buffer;
-	int proplen;
 	unsigned long nvram_addr;
+	struct resource r;
 	int ret;
 
-	ret = -ENODEV;
 	nvram_node = of_find_node_by_type(NULL, "nvram");
-	if (!nvram_node)
+	if (!nvram_node) {
+		printk(KERN_WARNING "nvram: no node found in device-tree\n");
+		return -ENODEV;
+	}
+
+	ret = of_address_to_resource(nvram_node, 0, &r);
+	if (ret) {
+		printk(KERN_WARNING "nvram: failed to get address (err %d)\n",
+		       ret);
 		goto out;
-
-	ret = -EIO;
-	buffer = get_property(nvram_node, "reg", &proplen);
-	if (proplen != 2*sizeof(unsigned long))
-		goto out;
-
-	ret = -ENODEV;
-	nvram_addr = buffer[0];
-	mmio_nvram_len = buffer[1];
-	if ( (!mmio_nvram_len) || (!nvram_addr) )
+	}
+	nvram_addr = r.start;
+	mmio_nvram_len = r.end - r.start + 1;
+	if ( (!mmio_nvram_len) || (!nvram_addr) ) {
+		printk(KERN_WARNING "nvram: address or lenght is 0\n");
+		ret = -EIO;
 		goto out;
+	}
 
 	mmio_nvram_start = ioremap(nvram_addr, mmio_nvram_len);
-	if (!mmio_nvram_start)
+	if (!mmio_nvram_start) {
+		printk(KERN_WARNING "nvram: failed to ioremap\n");
+		ret = -ENOMEM;
 		goto out;
+	}
 
-	printk(KERN_INFO "mmio NVRAM, %luk mapped to %p\n",
-	       mmio_nvram_len >> 10, mmio_nvram_start);
+	printk(KERN_INFO "mmio NVRAM, %luk at 0x%lx mapped to %p\n",
+	       mmio_nvram_len >> 10, nvram_addr, mmio_nvram_start);
 
 	ppc_md.nvram_read	= mmio_nvram_read;
 	ppc_md.nvram_write	= mmio_nvram_write;
