From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Fri, 14 Mar 2003 23:32:06 -0700
To: linuxppc-dev@lists.linuxppc.org
Subject: patch: add gt64260 I2C read function to bootwrapper
Message-ID: <20030315063206.GA10327@rover.farnsworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This patch adds a polled read-only I2C driver for the gt64260
that can be used by board-specific bootwrapper code.

Thanks,
-Dale

include/asm-ppc/gt64260_defs.h:
Add definitions for the I2C registers.

arch/ppc/boot/simple/gt64260_iic.c:
Add gt64260_iic_read() for reading I2C devices.

===== include/asm-ppc/gt64260_defs.h 1.11 vs edited =====
--- 1.11/include/asm-ppc/gt64260_defs.h	Fri Feb 28 10:31:00 2003
+++ edited/include/asm-ppc/gt64260_defs.h	Fri Mar 14 18:16:45 2003
@@ -1108,7 +1108,31 @@
  *****************************************************************************
  */

-/* FIXME: fill in */
+#define GT64260_I2C_ADDR				0xc000
+#define GT64260_I2C_EX_ADDR				0xc010
+#define GT64260_I2C_DATA				0xc004
+#define GT64260_I2C_CONTROL				0xc008
+#define GT64260_I2C_STATUS				0xc00c
+#define GT64260_I2C_BAUD_RATE				0xc00c
+#define GT64260_I2C_RESET				0xc01c
+
+#define GT64260_I2C_ACK_BIT				(1<<2)
+#define GT64260_I2C_IFLG_BIT				(1<<3)
+#define GT64260_I2C_STOP_BIT				(1<<4)
+#define GT64260_I2C_START_BIT				(1<<5)
+#define GT64260_I2C_ENABLE_BIT				(1<<6)
+#define GT64260_I2C_INT_ENABLE_BIT			(1<<7)
+
+#define GT64260_I2C_DATA_READ_BIT			0x01
+
+#define GT64260_I2C_STATUS_SENT_START			0x08
+#define GT64260_I2C_STATUS_RESENT_START			0x10
+#define GT64260_I2C_STATUS_WRITE_ADDR_ACK		0x18
+#define GT64260_I2C_STATUS_WRITE_ACK			0x28
+#define GT64260_I2C_STATUS_READ_ADDR_ACK		0x40
+#define GT64260_I2C_STATUS_READ_ACK			0x50
+#define GT64260_I2C_STATUS_READ_NO_ACK			0x58
+#define GT64260_I2C_STATUS_IDLE				0xf8


 /*
===== arch/ppc/boot/simple/gt64260_iic.c null vs new =====
--- null/arch/ppc/boot/simple/gt64260_iic.c	1969-12-31 17:00:00.000000000 -0700
+++ new/arch/ppc/boot/simple/gt64260_iic.c	2003-03-14 18:44:50.000000000 -0700
@@ -0,0 +1,186 @@
+/*
+ * BK Id: %F% %I% %G% %U% %#%
+ */
+/*
+ * arch/ppc/boot/simple/gt64260_iic.c
+ *
+ * Bootloader version of the i2c driver for the GT64260[A].
+ *
+ * Author: Dale Farnsworth <dfarnsworth@mvista.com>
+ *
+ * 2003 (c) MontaVista, Software, Inc.  This file is licensed under the terms
+ * of the GNU General Public License version 2.  This program is licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <asm/gt64260_defs.h>
+
+
+extern void udelay(long);
+
+#ifdef	CONFIG_GT64260_NEW_BASE
+static u32	gt64260_base = CONFIG_GT64260_NEW_REG_BASE;
+#else
+static u32	gt64260_base = CONFIG_GT64260_ORIG_REG_BASE;
+#endif
+
+inline unsigned
+gt64260_in_le32(volatile unsigned *addr)
+{
+	unsigned ret;
+
+	__asm__ __volatile__("lwbrx %0,0,%1; eieio" : "=r" (ret) :
+				     "r" (addr), "m" (*addr));
+	return ret;
+}
+
+inline void
+gt64260_out_le32(volatile unsigned *addr, int val)
+{
+	__asm__ __volatile__("stwbrx %1,0,%2; eieio" : "=m" (*addr) :
+				     "r" (val), "r" (addr));
+}
+
+#define GT64260_REG_READ(offs)						\
+	(gt64260_in_le32((volatile uint *)(gt64260_base + (offs))))
+#define GT64260_REG_WRITE(offs, d)					\
+        (gt64260_out_le32((volatile uint *)(gt64260_base + (offs)), (int)(d)))
+
+#define READ_ADDR()		(GT64260_REG_READ(GT64260_I2C_ADDR) & 0xff)
+#define READ_EX_ADDR()		(GT64260_REG_READ(GT64260_I2C_EX_ADDR) & 0xff)
+#define READ_DATA()		(GT64260_REG_READ(GT64260_I2C_DATA) & 0xff)
+#define READ_CONTROL()		(GT64260_REG_READ(GT64260_I2C_CONTROL) & 0xff)
+#define READ_STATUS()		(GT64260_REG_READ(GT64260_I2C_STATUS) & 0xff)
+
+#define WRITE_ADDR(d)		GT64260_REG_WRITE(GT64260_I2C_ADDR, (d))
+#define WRITE_EX_ADDR(d)	GT64260_REG_WRITE(GT64260_I2C_EX_ADDR, (d))
+#define WRITE_DATA(d)		GT64260_REG_WRITE(GT64260_I2C_DATA, (d))
+#define WRITE_CONTROL(d)	GT64260_REG_WRITE(GT64260_I2C_CONTROL, (d))
+#define WRITE_BAUD_RATE(d)	GT64260_REG_WRITE(GT64260_I2C_BAUD_RATE, (d))
+#define WRITE_RESET(d)		GT64260_REG_WRITE(GT64260_I2C_RESET, (d))
+
+static int
+wait_for_status(int wanted)
+{
+	int i;
+	int status;
+
+	for (i=0; i<1000; i++) {	/* the highest I've seen is 20 */
+		udelay(10);
+		status = READ_STATUS();
+		if (status == wanted)
+			return status;
+	}
+	return -status;
+}
+
+static int
+iic_control(int control, int status)
+{
+    	WRITE_CONTROL(control);
+	return wait_for_status(status);
+}
+
+static int
+iic_read_byte(int control, int status)
+{
+    	WRITE_CONTROL(control);
+	if (wait_for_status(status) < 0)
+		return -1;
+	return READ_DATA();
+}
+
+static int
+iic_write_byte(int data, int control, int status)
+{
+	WRITE_DATA(data & 0xff);
+    	WRITE_CONTROL(control);
+	return wait_for_status(status);
+}
+
+int
+gt64260_iic_read(uint devaddr, u8 *buf, uint offset, uint count)
+{
+	int i;
+	int data;
+	int control;
+	int status;
+
+	/*
+	 * send start
+	 */
+	control = GT64260_I2C_START_BIT|GT64260_I2C_ENABLE_BIT;
+	status = GT64260_I2C_STATUS_SENT_START;
+	if (iic_control(control, status) < 0)
+		return -1;
+
+	/*
+	 * select device for writing
+	 */
+	data = devaddr & ~GT64260_I2C_DATA_READ_BIT;
+	control = GT64260_I2C_ENABLE_BIT;
+	status = GT64260_I2C_STATUS_WRITE_ADDR_ACK;
+	if (iic_write_byte(data, control, status) < 0)
+		return -1;
+
+	/*
+	 * send offset of data
+	 */
+	control = GT64260_I2C_ENABLE_BIT;
+	status = GT64260_I2C_STATUS_WRITE_ACK;
+	if (iic_write_byte(offset >> 8, control, status) < 0)
+		return -1;
+	if (iic_write_byte(offset, control, status) < 0)
+		return -1;
+
+	/*
+	 * resend start
+	 */
+	control = GT64260_I2C_START_BIT|GT64260_I2C_ENABLE_BIT;
+	status = GT64260_I2C_STATUS_RESENT_START;
+	if (iic_control(control, status) < 0)
+		return -1;
+
+	/*
+	 * select device for reading
+	 */
+	data = devaddr | GT64260_I2C_DATA_READ_BIT;
+	control = GT64260_I2C_ENABLE_BIT;
+	status = GT64260_I2C_STATUS_READ_ADDR_ACK;
+	if (iic_write_byte(data, control, status) < 0)
+		return -1;
+
+	/*
+	 * read all but last byte of data
+	 */
+	for (i=1; i<count; i++) {
+		control = GT64260_I2C_ACK_BIT|GT64260_I2C_ENABLE_BIT;
+		status = GT64260_I2C_STATUS_READ_ACK;
+		data = iic_read_byte(control, status);
+		if (data < 0)
+			return -1;
+		*buf++ = data;
+	}
+
+	/*
+	 * read last byte of data
+	 */
+	control = GT64260_I2C_ENABLE_BIT;
+	status = GT64260_I2C_STATUS_READ_NO_ACK;
+	data = iic_read_byte(control, status);
+	if (data < 0)
+		return -1;
+	*buf++ = data;
+
+	/*
+	 * send stop
+	 */
+	control = GT64260_I2C_STOP_BIT|GT64260_I2C_ENABLE_BIT;
+	status = GT64260_I2C_STATUS_IDLE;
+	if (iic_control(control, status) < 0)
+		return -1;
+
+	return count;
+}

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
