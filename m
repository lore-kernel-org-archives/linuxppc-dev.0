Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound8-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5643667C68
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 11:17:25 +1100 (EST)
Message-ID: <45775D8E.5040808@am.sony.com>
Date: Wed, 06 Dec 2006 16:17:18 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/2] ps3: repository code cleanups
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Various fixes for the PS3 repository code:

  - Sync signatures of function prototypes and implementations (enum vs.
    unsigned int)
  - Correct references to `regions' as `registers':
      o Correct enum ps3_region_type as enum ps3_reg_type,
      o Correct PS3_REGION_TYPE_* as PS3_REG_TYPE_*,
      o Correct ps3_repository_find_region() as ps3_repository_find_reg().
  - Correct function name in pr_debug() call
  - Export repository functions needed by the PS3 storage driver
  - Minor error condition improvements.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---

Please apply.

 arch/powerpc/platforms/ps3/repository.c |   41 +++++++++++++++++++++-----------
 include/asm-powerpc/ps3.h               |   16 ++++++------
 2 files changed, 36 insertions(+), 21 deletions(-)

--- cell--common--7.orig/arch/powerpc/platforms/ps3/repository.c
+++ cell--common--7/arch/powerpc/platforms/ps3/repository.c
@@ -181,6 +181,7 @@ int ps3_repository_read_bus_id(unsigned 
 	*bus_id = v1;
 	return result;
 }
+EXPORT_SYMBOL_GPL(ps3_repository_read_bus_id);
 
 int ps3_repository_read_bus_type(unsigned int bus_index,
 	enum ps3_bus_type *bus_type)
@@ -196,6 +197,7 @@ int ps3_repository_read_bus_type(unsigne
 	*bus_type = v1;
 	return result;
 }
+EXPORT_SYMBOL_GPL(ps3_repository_read_bus_type);
 
 int ps3_repository_read_bus_num_dev(unsigned int bus_index,
 	unsigned int *num_dev)
@@ -211,6 +213,7 @@ int ps3_repository_read_bus_num_dev(unsi
 	*num_dev = v1;
 	return result;
 }
+EXPORT_SYMBOL_GPL(ps3_repository_read_bus_num_dev);
 
 int ps3_repository_read_dev_str(unsigned int bus_index,
 	unsigned int dev_index, const char *dev_str, u64 *value)
@@ -238,6 +241,7 @@ int ps3_repository_read_dev_id(unsigned 
 	*dev_id = v1;
 	return result;
 }
+EXPORT_SYMBOL_GPL(ps3_repository_read_dev_id);
 
 int ps3_repository_read_dev_type(unsigned int bus_index,
 	unsigned int dev_index, enum ps3_dev_type *dev_type)
@@ -254,10 +258,11 @@ int ps3_repository_read_dev_type(unsigne
 	*dev_type = v1;
 	return result;
 }
+EXPORT_SYMBOL_GPL(ps3_repository_read_dev_type);
 
 int ps3_repository_read_dev_intr(unsigned int bus_index,
 	unsigned int dev_index, unsigned int intr_index,
-	unsigned int *intr_type, unsigned int* interrupt_id)
+	enum ps3_interrupt_type *intr_type, unsigned int* interrupt_id)
 {
 	int result;
 	u64 v1;
@@ -273,9 +278,11 @@ int ps3_repository_read_dev_intr(unsigne
 	*interrupt_id = v2;
 	return result;
 }
+EXPORT_SYMBOL_GPL(ps3_repository_read_dev_intr);
 
 int ps3_repository_read_dev_reg_type(unsigned int bus_index,
-	unsigned int dev_index, unsigned int reg_index, unsigned int *reg_type)
+	unsigned int dev_index, unsigned int reg_index,
+	enum ps3_reg_type *reg_type)
 {
 	int result;
 	u64 v1;
@@ -302,8 +309,8 @@ int ps3_repository_read_dev_reg_addr(uns
 }
 
 int ps3_repository_read_dev_reg(unsigned int bus_index,
-	unsigned int dev_index, unsigned int reg_index, unsigned int *reg_type,
-	u64 *bus_addr, u64 *len)
+	unsigned int dev_index, unsigned int reg_index,
+	enum ps3_reg_type *reg_type, u64 *bus_addr, u64 *len)
 {
 	int result = ps3_repository_read_dev_reg_type(bus_index, dev_index,
 		reg_index, reg_type);
@@ -343,7 +350,7 @@ int ps3_repository_dump_resource_info(un
 	}
 
 	for (res_index = 0; res_index < 10; res_index++) {
-		enum ps3_region_type reg_type;
+		enum ps3_reg_type reg_type;
 		u64 bus_addr;
 		u64 len;
 
@@ -487,7 +494,8 @@ static int find_device(unsigned int bus_
 			break;
 	}
 
-	BUG_ON(dev_index == num_dev);
+	if (dev_index == num_dev)
+		return -1;
 
 	pr_debug("%s:%d: found dev_type %u at dev_index %u\n",
 		__func__, __LINE__, dev_type, dev_index);
@@ -521,7 +529,7 @@ int ps3_repository_find_device (enum ps3
 	pr_debug("%s:%d: find bus_type %u, dev_type %u\n", __func__, __LINE__,
 		bus_type, dev_type);
 
-	dev->bus_index = UINT_MAX;
+	BUG_ON(start_dev && start_dev->bus_index > 10);
 
 	for (bus_index = start_dev ? start_dev->bus_index : 0; bus_index < 10;
 		bus_index++) {
@@ -532,13 +540,15 @@ int ps3_repository_find_device (enum ps3
 		if (result) {
 			pr_debug("%s:%d read_bus_type failed\n",
 				__func__, __LINE__);
+			dev->bus_index = UINT_MAX;
 			return result;
 		}
 		if (x == bus_type)
 			break;
 	}
 
-	BUG_ON(bus_index == 10);
+	if (bus_index >= 10)
+		return -ENODEV;
 
 	pr_debug("%s:%d: found bus_type %u at bus_index %u\n",
 		__func__, __LINE__, bus_type, bus_index);
@@ -574,6 +584,7 @@ int ps3_repository_find_device (enum ps3
 
 	return result;
 }
+EXPORT_SYMBOL_GPL(ps3_repository_find_device);
 
 int ps3_repository_find_interrupt(const struct ps3_repository_device *dev,
 	enum ps3_interrupt_type intr_type, unsigned int *interrupt_id)
@@ -604,7 +615,8 @@ int ps3_repository_find_interrupt(const 
 		}
 	}
 
-	BUG_ON(res_index == 10);
+	if (res_index == 10)
+		return -ENODEV;
 
 	pr_debug("%s:%d: found intr_type %u at res_index %u\n",
 		__func__, __LINE__, intr_type, res_index);
@@ -612,8 +624,8 @@ int ps3_repository_find_interrupt(const 
 	return result;
 }
 
-int ps3_repository_find_region(const struct ps3_repository_device *dev,
-	enum ps3_region_type reg_type, u64 *bus_addr, u64 *len)
+int ps3_repository_find_reg(const struct ps3_repository_device *dev,
+	enum ps3_reg_type reg_type, u64 *bus_addr, u64 *len)
 {
 	int result = 0;
 	unsigned int res_index;
@@ -623,7 +635,7 @@ int ps3_repository_find_region(const str
 	*bus_addr = *len = 0;
 
 	for (res_index = 0; res_index < 10; res_index++) {
-		enum ps3_region_type t;
+		enum ps3_reg_type t;
 		u64 a;
 		u64 l;
 
@@ -643,7 +655,8 @@ int ps3_repository_find_region(const str
 		}
 	}
 
-	BUG_ON(res_index == 10);
+	if (res_index == 10)
+		return -ENODEV;
 
 	pr_debug("%s:%d: found reg_type %u at res_index %u\n",
 		__func__, __LINE__, reg_type, res_index);
@@ -761,6 +774,7 @@ int ps3_repository_read_boot_dat_address
 		0,
 		address, 0);
 }
+EXPORT_SYMBOL_GPL(ps3_repository_read_stor_dev_info);
 
 int ps3_repository_read_boot_dat_size(unsigned int *size)
 {
@@ -827,6 +841,7 @@ int ps3_repository_read_tb_freq(u64 node
 		0,
 		tb_freq, 0);
 }
+EXPORT_SYMBOL_GPL(ps3_repository_read_stor_dev_region);
 
 int ps3_repository_read_be_tb_freq(unsigned int be_index, u64 *tb_freq)
 {
--- cell--common--7.orig/include/asm-powerpc/ps3.h
+++ cell--common--7/include/asm-powerpc/ps3.h
@@ -277,10 +277,10 @@ enum ps3_interrupt_type {
 	PS3_INTERRUPT_TYPE_OTHER = 5,
 };
 
-enum ps3_region_type {
-	PS3_REGION_TYPE_SB_OHCI = 3,
-	PS3_REGION_TYPE_SB_EHCI = 4,
-	PS3_REGION_TYPE_SB_GPIO = 5,
+enum ps3_reg_type {
+	PS3_REG_TYPE_SB_OHCI = 3,
+	PS3_REG_TYPE_SB_EHCI = 4,
+	PS3_REG_TYPE_SB_GPIO = 5,
 };
 
 int ps3_repository_read_dev_str(unsigned int bus_index,
@@ -294,13 +294,13 @@ int ps3_repository_read_dev_intr(unsigne
 	enum ps3_interrupt_type *intr_type, unsigned int *interrupt_id);
 int ps3_repository_read_dev_reg_type(unsigned int bus_index,
 	unsigned int dev_index, unsigned int reg_index,
-	enum ps3_region_type *reg_type);
+	enum ps3_reg_type *reg_type);
 int ps3_repository_read_dev_reg_addr(unsigned int bus_index,
 	unsigned int dev_index, unsigned int reg_index, u64 *bus_addr,
 	u64 *len);
 int ps3_repository_read_dev_reg(unsigned int bus_index,
 	unsigned int dev_index, unsigned int reg_index,
-	enum ps3_region_type *reg_type, u64 *bus_addr, u64 *len);
+	enum ps3_reg_type *reg_type, u64 *bus_addr, u64 *len);
 
 /* repository bus enumerators */
 
@@ -322,8 +322,8 @@ static inline int ps3_repository_find_fi
 }
 int ps3_repository_find_interrupt(const struct ps3_repository_device *dev,
 	enum ps3_interrupt_type intr_type, unsigned int *interrupt_id);
-int ps3_repository_find_region(const struct ps3_repository_device *dev,
-	enum ps3_region_type reg_type, u64 *bus_addr, u64 *len);
+int ps3_repository_find_reg(const struct ps3_repository_device *dev,
+	enum ps3_reg_type reg_type, u64 *bus_addr, u64 *len);
 
 /* repository block device info */
 
