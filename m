Return-Path: <j.glisse@free.fr>
Message-ID: <41CF4D36.1020601@free.fr>
Date: Mon, 27 Dec 2004 00:45:58 +0100
From: Jerome Glisse <j.glisse@free.fr>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Content-Type: multipart/mixed; boundary="------------010503060906020107040506"
Subject: PATCH uninorth3 (G5) agp support (V2)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010503060906020107040506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Oops i forgot to enable AGP V3 on uninorth3 thus here
is the patch with this (forget the old patch) but you should
read my mail as i describe a bit the patch & ask for
testing.

best,
Jerome Glisse

--------------010503060906020107040506
Content-Type: text/plain;
 name="uninorth-patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="uninorth-patch2"

diff -Naur linux/drivers/char/agp/uninorth-agp.c linux-new/drivers/char/agp/uninorth-agp.c
--- linux/drivers/char/agp/uninorth-agp.c	2004-12-26 14:39:28.000000000 +0100
+++ linux-new/drivers/char/agp/uninorth-agp.c	2004-12-27 00:40:31.186734608 +0100
@@ -8,8 +8,37 @@
 #include <linux/agp_backend.h>
 #include <asm/uninorth.h>
 #include <asm/pci-bridge.h>
+#include <asm/sections.h>
+#include <asm/prom.h>
 #include "agp.h"
 
+/*
+ * NOTES for uninorth3 (G5 AGP) supports :
+ *
+ * This are redundant with arch/ppc(64)/platforms/pmac_features.c,
+ * we need to know uninorth_rev any other way ?
+ *
+ * There maybe also possibility to have bigger cache line size for
+ * agp (see pmac_pci.c and look for cache line). Need to be investigated
+ * by someone.
+ *
+ * Darwin seems to add UNI_N_CFG_GART_PERFRD for all agp3 controller but
+ * this seems to work without this, so in order to minimize code differences
+ * between AGP2 & AGP3 uninorth, i do not set this.
+ *
+ * PAGE size are hardcoded but this may change, see asm/page.h.
+ *
+ * Jerome Glisse <j.glisse@free.fr>
+ */
+static struct device_node* uninorth_node __pmacdata;
+static u32 __iomem * uninorth_base __pmacdata;
+static u32 uninorth_rev __pmacdata;
+
+/*
+ * Uninorth reg. access. Note that Uni-N regs are big endian
+ */
+#define UN_REG(r)	(uninorth_base + ((r) >> 2))
+
 static int uninorth_fetch_size(void)
 {
 	int i;
@@ -17,7 +46,7 @@
 	struct aper_size_info_32 *values;
 
 	pci_read_config_dword(agp_bridge->dev, UNI_N_CFG_GART_BASE, &temp);
-	temp &= ~(0xfffff000);
+	temp &= ~PAGE_MASK;
 	values = A_SIZE_32(agp_bridge->driver->aperture_sizes);
 
 	for (i = 0; i < agp_bridge->driver->num_aperture_sizes; i++) {
@@ -73,7 +102,7 @@
 	/* aperture size and gatt addr */
 	pci_write_config_dword(agp_bridge->dev,
 		UNI_N_CFG_GART_BASE,
-		(agp_bridge->gatt_bus_addr & 0xfffff000)
+		(agp_bridge->gatt_bus_addr & PAGE_MASK)
 			| current_size->size_value);
 
 	/* HACK ALERT
@@ -111,14 +140,56 @@
 	}
 
 	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
-		agp_bridge->gatt_table[j] = cpu_to_le32((mem->memory[i] & 0xfffff000) | 0x00000001UL);
+		agp_bridge->gatt_table[j] = cpu_to_le32((mem->memory[i] &
+							 PAGE_MASK) |
+							0x00000001UL);
 		flush_dcache_range((unsigned long)__va(mem->memory[i]),
 				   (unsigned long)__va(mem->memory[i])+0x1000);
 	}
 	(void)in_le32((volatile u32*)&agp_bridge->gatt_table[pg_start]);
 	mb();
 	flush_dcache_range((unsigned long)&agp_bridge->gatt_table[pg_start], 
-		(unsigned long)&agp_bridge->gatt_table[pg_start + mem->page_count]);
+		(unsigned long)&agp_bridge->gatt_table[pg_start +
+							mem->page_count]);
+
+	uninorth_tlbflush(mem);
+	return 0;
+}
+
+static int uninorth3_insert_memory(struct agp_memory *mem, off_t pg_start,
+				int type)
+{
+	int i, j, num_entries;
+	void *temp;
+
+	temp = agp_bridge->current_size;
+	num_entries = A_SIZE_32(temp)->num_entries;
+
+	if (type != 0 || mem->type != 0)
+		/* We know nothing of memory types */
+		return -EINVAL;
+	if ((pg_start + mem->page_count) > num_entries)
+		return -EINVAL;
+
+	j = pg_start;
+
+	while (j < (pg_start + mem->page_count)) {
+		if (!PGE_EMPTY(agp_bridge, agp_bridge->gatt_table[j]))
+			return -EBUSY;
+		j++;
+	}
+
+	for (i = 0, j = pg_start; i < mem->page_count; i++, j++) {
+		agp_bridge->gatt_table[j] = ((mem->memory[i] >> PAGE_SHIFT) |
+						0x80000000UL);
+		flush_dcache_range((unsigned long)__va(mem->memory[i]),
+				   (unsigned long)__va(mem->memory[i])+0x1000);
+	}
+	(void)in_le32((volatile u32*)&agp_bridge->gatt_table[pg_start]);
+	mb();
+	flush_dcache_range((unsigned long)&agp_bridge->gatt_table[pg_start], 
+		(unsigned long)&agp_bridge->gatt_table[pg_start +
+							mem->page_count]);
 
 	uninorth_tlbflush(mem);
 	return 0;
@@ -134,7 +205,23 @@
 			      &command);
 
 	command = agp_collect_device_status(mode, command);
-	command |= 0x100;
+	command |= UNI_N_CFG_GART_ENABLE;
+	
+	if(uninorth_rev == 0x21) {
+		/*
+		 * Darwin disable AGP 4x on this revision, thus we
+		 * may assume it's broken. This is an AGP2 controller.
+		 */
+		command &= ~AGPSTAT2_4X;
+	}
+
+	if((uninorth_rev >= 0x30) && (uninorth_rev <= 0x33)) {
+		/*
+		 * We need to to set REQ_DEPTH to 7 for U3 versions 1.0, 2.1,
+		 * 2.2 and 2.3, Darwin do so.
+		 */
+		command |= (7 << AGPSTAT_RQ_DEPTH_SHIFT);
+	}
 
 	uninorth_tlbflush(NULL);
 
@@ -146,11 +233,17 @@
 		pci_read_config_dword(agp_bridge->dev,
 				       agp_bridge->capndx + PCI_AGP_COMMAND,
 				       &scratch);
-	} while ((scratch & 0x100) == 0 && ++timeout < 1000);
-	if ((scratch & 0x100) == 0)
+	} while ((scratch & UNI_N_CFG_GART_ENABLE) == 0 && ++timeout < 1000);
+	if ((scratch & UNI_N_CFG_GART_ENABLE) == 0)
 		printk(KERN_ERR PFX "failed to write UniNorth AGP command reg\n");
 
-	agp_device_command(command, 0);
+	if (agp_bridge->dev->device == PCI_DEVICE_ID_APPLE_UNI_N_AGP3) {
+			/* This is an AGP V3 */
+			agp_device_command(command, TRUE);
+	} else {
+			/* AGP V2 */
+			agp_device_command(command, FALSE);
+	}
 
 	uninorth_tlbflush(NULL);
 }
@@ -258,6 +351,22 @@
 	{4, 1024, 0, 1}
 };
 
+static struct aper_size_info_32 uninorth3_sizes[8] =
+{
+/*
+ * Not sure that uninorth3 supports that high aperture sizes but it
+ * would strange if it did not :)
+ */
+	{512, 131072, 7, 128},
+	{256, 65536, 6, 64},
+	{128, 32768, 5, 32},
+	{64, 16384, 4, 16},
+	{32, 8192, 3, 8},
+	{16, 4096, 2, 4},
+	{8, 2048, 1, 2},
+	{4, 1024, 0, 1}
+};
+
 struct agp_bridge_driver uninorth_agp_driver = {
 	.owner			= THIS_MODULE,
 	.aperture_sizes		= (void *)uninorth_sizes,
@@ -299,6 +408,10 @@
 		.device_id	= PCI_DEVICE_ID_APPLE_UNI_N_AGP2,
 		.chipset_name	= "UniNorth 2",
 	},
+	{
+		.device_id	= PCI_DEVICE_ID_APPLE_UNI_N_AGP3,
+		.chipset_name	= "UniNorth 3",
+	},
 };
 
 static int __devinit agp_uninorth_probe(struct pci_dev *pdev,
@@ -327,6 +440,28 @@
 	return -ENODEV;
 
  found:
+	/*
+	 * Set specific functions & values for agp3 controller.
+	 */
+	if (pdev->device == PCI_DEVICE_ID_APPLE_UNI_N_AGP3) {
+		uninorth_agp_driver.insert_memory  = uninorth3_insert_memory;
+		uninorth_agp_driver.aperture_sizes = (void *)uninorth3_sizes;
+		uninorth_agp_driver.num_aperture_sizes = 8;
+	}
+
+	/* Locate core99 Uni-N */
+	uninorth_node = of_find_node_by_name(NULL, "uni-n");
+	/* Locate G5 u3 */
+	if (uninorth_node == NULL) {
+		uninorth_node = of_find_node_by_name(NULL, "u3");
+	}
+	if (uninorth_node && uninorth_node->n_addrs > 0) {
+		unsigned long address = uninorth_node->addrs[0].address;
+		uninorth_base = ioremap(address, 0x40000);
+		uninorth_rev = in_be32(UN_REG(UNI_N_VERSION));
+	}
+
+
 	bridge = agp_alloc_bridge();
 	if (!bridge)
 		return -ENOMEM;
diff -Naur linux/include/asm/uninorth.h linux-new/include/asm/uninorth.h
--- linux/include/asm/uninorth.h	2004-12-26 14:40:03.000000000 +0100
+++ linux-new/include/asm/uninorth.h	2004-12-26 14:57:20.000000000 +0100
@@ -34,6 +34,11 @@
 #define UNI_N_CFG_GART_ENABLE		0x00000100
 #define UNI_N_CFG_GART_2xRESET		0x00010000
 #define UNI_N_CFG_GART_DISSBADET	0x00020000
+/* The following seems to only be used only on U3 <j.glisse@free.fr> */
+#define UNI_N_CFG_GART_SYNCMODE		0x00040000
+#define UNI_N_CFG_GART_PERFRD		0x00080000
+#define UNI_N_CFG_GART_B2BGNT		0x00200000
+#define UNI_N_CFG_GART_FASTDDR		0x00400000
 
 /* My understanding of UniNorth AGP as of UniNorth rev 1.0x,
  * revision 1.5 (x4 AGP) may need further changes.
diff -Naur linux/include/asm-ppc/uninorth.h linux-new/include/asm-ppc/uninorth.h
--- linux/include/asm-ppc/uninorth.h	2004-12-26 14:40:03.000000000 +0100
+++ linux-new/include/asm-ppc/uninorth.h	2004-12-26 14:57:20.000000000 +0100
@@ -34,6 +34,11 @@
 #define UNI_N_CFG_GART_ENABLE		0x00000100
 #define UNI_N_CFG_GART_2xRESET		0x00010000
 #define UNI_N_CFG_GART_DISSBADET	0x00020000
+/* The following seems to only be used only on U3 <j.glisse@free.fr> */
+#define UNI_N_CFG_GART_SYNCMODE		0x00040000
+#define UNI_N_CFG_GART_PERFRD		0x00080000
+#define UNI_N_CFG_GART_B2BGNT		0x00200000
+#define UNI_N_CFG_GART_FASTDDR		0x00400000
 
 /* My understanding of UniNorth AGP as of UniNorth rev 1.0x,
  * revision 1.5 (x4 AGP) may need further changes.
diff -Naur linux/include/linux/pci_ids.h linux-new/include/linux/pci_ids.h
--- linux/include/linux/pci_ids.h	2004-12-26 14:40:05.000000000 +0100
+++ linux-new/include/linux/pci_ids.h	2004-12-26 14:50:19.000000000 +0100
@@ -842,6 +842,7 @@
 #define PCI_DEVICE_ID_APPLE_UNI_N_GMAC2	0x0032
 #define PCI_DEVIEC_ID_APPLE_UNI_N_ATA	0x0033
 #define PCI_DEVICE_ID_APPLE_UNI_N_AGP2	0x0034
+#define PCI_DEVICE_ID_APPLE_UNI_N_AGP3	0x0059
 #define PCI_DEVICE_ID_APPLE_IPID_ATA100	0x003b
 #define PCI_DEVICE_ID_APPLE_KEYLARGO_I	0x003e
 #define PCI_DEVICE_ID_APPLE_K2_ATA100	0x0043

--------------010503060906020107040506--
