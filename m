Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 54B30DE6A8
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 14:08:24 +1100 (EST)
Message-ID: <45BAC203.60702@am.sony.com>
Date: Fri, 26 Jan 2007 19:07:47 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/16] ps3: repository misc fixes
Content-Type: text/plain; charset=UTF-8
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
  - Minor error condition improvements.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

I removed the EXPORT_SYMBOL_GPL's as requested by Christoph.

 arch/powerpc/platforms/ps3/repository.c |   32 +++++++++++++++++++-------------
 include/asm-powerpc/ps3.h               |   16 ++++++++--------
 2 files changed, 27 insertions(+), 21 deletions(-)

--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/repository.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/repository.c
@@ -257,7 +257,7 @@ int ps3_repository_read_dev_type(unsigne
 
 int ps3_repository_read_dev_intr(unsigned int bus_index,
 	unsigned int dev_index, unsigned int intr_index,
-	unsigned int *intr_type, unsigned int* interrupt_id)
+	enum ps3_interrupt_type *intr_type, unsigned int* interrupt_id)
 {
 	int result;
 	u64 v1;
@@ -275,7 +275,8 @@ int ps3_repository_read_dev_intr(unsigne
 }
 
 int ps3_repository_read_dev_reg_type(unsigned int bus_index,
-	unsigned int dev_index, unsigned int reg_index, unsigned int *reg_type)
+	unsigned int dev_index, unsigned int reg_index,
+	enum ps3_reg_type *reg_type)
 {
 	int result;
 	u64 v1;
@@ -302,8 +303,8 @@ int ps3_repository_read_dev_reg_addr(uns
 }
 
 int ps3_repository_read_dev_reg(unsigned int bus_index,
-	unsigned int dev_index, unsigned int reg_index, unsigned int *reg_type,
-	u64 *bus_addr, u64 *len)
+	unsigned int dev_index, unsigned int reg_index,
+	enum ps3_reg_type *reg_type, u64 *bus_addr, u64 *len)
 {
 	int result = ps3_repository_read_dev_reg_type(bus_index, dev_index,
 		reg_index, reg_type);
@@ -343,7 +344,7 @@ int ps3_repository_dump_resource_info(un
 	}
 
 	for (res_index = 0; res_index < 10; res_index++) {
-		enum ps3_region_type reg_type;
+		enum ps3_reg_type reg_type;
 		u64 bus_addr;
 		u64 len;
 
@@ -487,7 +488,8 @@ static int find_device(unsigned int bus_
 			break;
 	}
 
-	BUG_ON(dev_index == num_dev);
+	if (dev_index == num_dev)
+		return -1;
 
 	pr_debug("%s:%d: found dev_type %u at dev_index %u\n",
 		__func__, __LINE__, dev_type, dev_index);
@@ -521,7 +523,7 @@ int ps3_repository_find_device (enum ps3
 	pr_debug("%s:%d: find bus_type %u, dev_type %u\n", __func__, __LINE__,
 		bus_type, dev_type);
 
-	dev->bus_index = UINT_MAX;
+	BUG_ON(start_dev && start_dev->bus_index > 10);
 
 	for (bus_index = start_dev ? start_dev->bus_index : 0; bus_index < 10;
 		bus_index++) {
@@ -532,13 +534,15 @@ int ps3_repository_find_device (enum ps3
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
@@ -604,7 +608,8 @@ int ps3_repository_find_interrupt(const 
 		}
 	}
 
-	BUG_ON(res_index == 10);
+	if (res_index == 10)
+		return -ENODEV;
 
 	pr_debug("%s:%d: found intr_type %u at res_index %u\n",
 		__func__, __LINE__, intr_type, res_index);
@@ -612,8 +617,8 @@ int ps3_repository_find_interrupt(const 
 	return result;
 }
 
-int ps3_repository_find_region(const struct ps3_repository_device *dev,
-	enum ps3_region_type reg_type, u64 *bus_addr, u64 *len)
+int ps3_repository_find_reg(const struct ps3_repository_device *dev,
+	enum ps3_reg_type reg_type, u64 *bus_addr, u64 *len)
 {
 	int result = 0;
 	unsigned int res_index;
@@ -623,7 +628,7 @@ int ps3_repository_find_region(const str
 	*bus_addr = *len = 0;
 
 	for (res_index = 0; res_index < 10; res_index++) {
-		enum ps3_region_type t;
+		enum ps3_reg_type t;
 		u64 a;
 		u64 l;
 
@@ -643,7 +648,8 @@ int ps3_repository_find_region(const str
 		}
 	}
 
-	BUG_ON(res_index == 10);
+	if (res_index == 10)
+		return -ENODEV;
 
 	pr_debug("%s:%d: found reg_type %u at res_index %u\n",
 		__func__, __LINE__, reg_type, res_index);
--- ps3-linux-dev.orig/include/asm-powerpc/ps3.h
+++ ps3-linux-dev/include/asm-powerpc/ps3.h
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
 
