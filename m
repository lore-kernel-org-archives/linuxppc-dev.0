Return-Path: <jwilliams@itee.uq.edu.au>
Received: from gum.itee.uq.edu.au (gum.itee.uq.edu.au [130.102.66.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5146CDDF54
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 17:59:31 +1000 (EST)
Message-ID: <463199EF.3090900@itee.uq.edu.au>
Date: Fri, 27 Apr 2007 16:36:31 +1000
From: John Williams <jwilliams@itee.uq.edu.au>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org, grant.likely@secretlab.ca
Subject: [RFC] SystemACE driver - abstract register ops
Content-Type: multipart/mixed; boundary="------------010408050508000108090909"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010408050508000108090909
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Grant,

Thanks for your work on the SystemACE driver - I'll be porting/merging 
this across to MicroBlaze very shortly.

Given that SysACE can be hooked up in any number of ways, bit widths, 
endians, PPC/Microblaze, can you please offer your comments on the 
attached patch?

It introduce a private ace_reg_ops structure, with various member 
functions for the different kinds of accesses to the HW.

This patch should not change the functionality of your original driver 
at all, it's just groundwork for what's to come.

I recognise that it adds indirection into the various access paths, and 
potentially a little bloat.  Whether this is better than #if 
1...#else...#endif is debatable.

Similar issues will arise for most (all?) of the Xilinx drivers that we 
will share between PPC and MicroBlaze.  Hopefully we can converge on a 
nice consistent and clean way of handling these dual arch drivers.

Cheers,

John

--------------010408050508000108090909
Content-Type: text/plain;
 name="xsysace-regops.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xsysace-regops.patch"

Index: linux-2.6.x-petalogix/drivers/block/xsysace.c
===================================================================
--- linux-2.6.x-petalogix/drivers/block/xsysace.c	(revision 2628)
+++ linux-2.6.x-petalogix/drivers/block/xsysace.c	(working copy)
@@ -73,6 +73,11 @@
  *    interrupt, then the kernel timer will expire and the driver can
  *    continue where it left off.
  *
+ *  SystemACE can be wired up in different endian orders and data widths.
+ *  It works on both PPC and MicroBlaze architectures.  For this reason,
+ *  an ace_reg_ops structure is used that abstracts away low level
+ *  endian/width/arch access to the HW registers.
+
  * To Do:
  *    - Add FPGA configuration control interface.
  *    - Request major number from lanana
@@ -161,32 +166,120 @@
 /* ---------------------------------------------------------------------
  * Low level register access
  */
+struct reg_ops {
+	u8 (*read8)(void *addr);
+	u16 (*read16)(void *addr);
+	u32 (*read32)(void *addr);
+	u32 (*readdata)(void *addr);
 
-/* register access macros */
+	void (*write16)(void *addr, u16 val);
+	void (*write32)(void *addr, u32 val);
+	void (*writedata)(void *addr, u32 val);
+};
+
+#define ace_reg_read8(ace, reg) (ace->ops->read8(ace->baseaddr + reg))
+#define ace_reg_read16(ace, reg) (ace->ops->read16(ace->baseaddr + reg))
+#define ace_reg_readdata(ace, reg) (ace->ops->readdata(ace->baseaddr + reg))
+#define ace_reg_read32(ace, reg) (ace->ops->read32(ace->baseaddr+reg))
+#define ace_reg_write16(ace, reg, val) (ace->ops->write16(ace->baseaddr+reg, val))
+#define ace_reg_writedata(ace, reg, val) (ace->ops->writedata(ace->baseaddr + reg, val))
+#define ace_reg_write32(ace, reg, val) (ace->ops->write32(ace->baseaddr+reg, val))
+
+/* register access functions */
 #if 1 /* Little endian 16-bit regs */
-#define ace_reg_read8(ace, reg) in_8(ace->baseaddr + reg)
-#define ace_reg_read16(ace, reg) in_le16(ace->baseaddr + reg)
-#define ace_reg_readdata(ace, reg) in_be16(ace->baseaddr + reg)
-#define ace_reg_read32(ace, reg) ((in_le16(ace->baseaddr + reg+2) << 16) | \
-                                  (in_le16(ace->baseaddr + reg)))
-#define ace_reg_write16(ace, reg, val) out_le16(ace->baseaddr + reg, val)
-#define ace_reg_writedata(ace, reg, val) out_be16(ace->baseaddr + reg, val)
-#define ace_reg_write32(ace, reg, val) { \
-                           out_le16(ace->baseaddr + reg+2, (val) >> 16); \
-                           out_le16(ace->baseaddr + reg, val); \
-                       }
+static u8 ace_le16_read8(void *addr)
+{
+	return in_8(addr);
+}
+
+static u16 ace_le16_read16(void *addr)
+{
+	return in_le16(addr);
+}
+
+static u32 ace_le16_read32(void *addr)
+{
+	return ((in_le16(addr+2) << 16) | (in_le16(addr)));
+}
+
+static u32 ace_le16_readdata(void *addr)
+{
+	return in_be16(addr);
+}
+
+static void ace_le16_write16(void *addr, u16 val)
+{
+	out_le16(addr, val);
+}
+
+static void ace_le16_write32(void *addr, u32 val)
+{
+	out_le16(addr+2,(val) >> 16); \
+	out_le16(addr, val);
+}
+
+static void ace_le16_writedata(void *addr, u32 val)
+{
+	out_be16(addr, val);
+}
+
+static struct reg_ops ace_ops = {
+	.read8	=	ace_le16_read8,
+	.read16 = 	ace_le16_read16,
+	.read32 = 	ace_le16_read32,
+	.readdata = 	ace_le16_readdata,
+	.write16 = 	ace_le16_write16,
+	.write32 = 	ace_le16_write32,
+	.writedata = 	ace_le16_writedata
+} ;
+
 #else /* Big endian 16-bit regs */
-#define ace_reg_read8(ace, reg) in_8(ace->baseaddr + reg)
-#define ace_reg_read16(ace, reg) in_be16(ace->baseaddr + reg)
-#define ace_reg_readdata(ace, reg) in_le16(ace->baseaddr + reg)
-#define ace_reg_read32(ace, reg) ((in_be16(ace->baseaddr + reg+2) << 16) | \
-                                  (in_be16(ace->baseaddr + reg)))
-#define ace_reg_write16(ace, reg, val) out_be16(ace->baseaddr + reg, val)
-#define ace_reg_writedata(ace, reg, val) out_le16(ace->baseaddr + reg, val)
-#define ace_reg_write32(ace, reg, val) { \
-                           out_be16(ace->baseaddr + reg+2, (val) >> 16); \
-                           out_be16(ace->baseaddr + reg, val); \
-                       }
+static u8 ace_be16_read8(void *addr)
+{
+	return in_8(addr);
+}
+
+static u16 ace_be16_read16(void *addr)
+{
+	return in_be16(addr);
+}
+
+static u32 ace_be16_read32(void *addr)
+{
+	return ((in_be16(addr+2) << 16) | (in_be16(addr)));
+}
+
+static u32 ace_be16_readdata(void *addr)
+{
+	return in_le16(addr);
+}
+
+static void ace_be16_write16(void *addr, u16 val)
+{
+	out_be16(addr, val);
+}
+
+static void ace_be16_write32(void *addr, u32 val)
+{
+	out_be16(addr+2,(val) >> 16); \
+	out_be16(addr, val);
+}
+
+static void ace_be16_writedata(void *addr, u32 val)
+{
+	out_le16(addr, val);
+}
+
+static struct reg_ops ace_ops = {
+	.read8	=	ace_be16_read8,
+	.read16 = 	ace_be16_read16,
+	.read32 = 	ace_be16_read32,
+	.readdata = 	ace_be16_readdata,
+	.write16 = 	ace_be16_write16,
+	.write32 = 	ace_be16_write32,
+	.writedata = 	ace_be16_writedata
+} ;
+
 #endif
 
 struct ace_device {
@@ -222,6 +315,9 @@
 	int bus_width;  /* 0 := 8 bit; 1 := 16 bit */
 	int lock_count;
 
+	/* Register access ops */
+	struct reg_ops *ops;
+
 	/* Block device data structures */
 	spinlock_t lock;
 	struct device *dev;
@@ -995,6 +1091,8 @@
 	ace->id = dev->id;
 	ace->irq = NO_IRQ;
 
+	ace->ops=&ace_ops;
+
 	for (i = 0; i < dev->num_resources; i++) {
 		if (dev->resource[i].flags & IORESOURCE_MEM)
 			ace->physaddr = dev->resource[i].start;

--------------010408050508000108090909--
