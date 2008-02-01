Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound2-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 32198DDDDB
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 16:02:35 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C8648F.A2858A7F"
Subject: RE: [PATCH] [POWERPC] Xilinx: hwicap driver
Date: Thu, 31 Jan 2008 21:01:28 -0800
References: <1201805233-15112-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1201827769-7439-1-git-send-email-stephen.neuendorffer@xilinx.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>,
	<linuxppc-dev@ozlabs.org>, <grant.likely@secretlab.ca>, <jacmet@sunsite.dk>
Message-Id: <20080201050228.7A6E117C0053@mail145-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C8648F.A2858A7F
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Nevermind... I posted this too fast and screwed up the spinlocks.

-----Original Message-----
From: Stephen Neuendorffer [mailto:stephen.neuendorffer@xilinx.com]
Sent: Thu 1/31/2008 5:02 PM
To: linuxppc-dev@ozlabs.org; grant.likely@secretlab.ca; =
jacmet@sunsite.dk
Cc: Stephen Neuendorffer
Subject: [PATCH] [POWERPC] Xilinx: hwicap driver
=20
This includes code for new fifo-based xps_hwicap in addition to the
older opb_hwicap, which has a significantly different interface.  The
common code between the two drivers is largely shared.

Significant differences exists between this driver and what is
supported in the EDK drivers.  In particular, most of the
architecture-specific code for reconfiguring individual FPGA resources
has been removed.  This functionality is likely better provided in a
user-space support library.  In addition, read and write access is
supported.  In addition, although the xps_hwicap cores support
interrupt-driver mode, this driver only supports polled operation, in
order to make the code simpler, and since the interrupt processing
overhead is likely to slow down the throughput under Linux.

Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

Fixed to add spinlocks, and a few style issues.
---
 drivers/char/Kconfig                       |    7 +
 drivers/char/Makefile                      |    1 +
 drivers/char/xilinx_hwicap/Makefile        |    7 +
 drivers/char/xilinx_hwicap/buffer_icap.c   |  380 ++++++++++++
 drivers/char/xilinx_hwicap/buffer_icap.h   |   57 ++
 drivers/char/xilinx_hwicap/fifo_icap.c     |  381 ++++++++++++
 drivers/char/xilinx_hwicap/fifo_icap.h     |   62 ++
 drivers/char/xilinx_hwicap/xilinx_hwicap.c |  912 =
++++++++++++++++++++++++++++
 drivers/char/xilinx_hwicap/xilinx_hwicap.h |  193 ++++++
 9 files changed, 2000 insertions(+), 0 deletions(-)
 create mode 100644 drivers/char/xilinx_hwicap/Makefile
 create mode 100644 drivers/char/xilinx_hwicap/buffer_icap.c
 create mode 100644 drivers/char/xilinx_hwicap/buffer_icap.h
 create mode 100644 drivers/char/xilinx_hwicap/fifo_icap.c
 create mode 100644 drivers/char/xilinx_hwicap/fifo_icap.h
 create mode 100644 drivers/char/xilinx_hwicap/xilinx_hwicap.c
 create mode 100644 drivers/char/xilinx_hwicap/xilinx_hwicap.h

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index ef1ed5d..157ae2a 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -831,6 +831,13 @@ config DTLK
 	  To compile this driver as a module, choose M here: the
 	  module will be called dtlk.
=20
+config XILINX_HWICAP
+	tristate "Xilinx HWICAP Support"
+	depends on XILINX_VIRTEX
+	help
+	  This option enables support for Xilinx Internal Configuration
+	  Access Port (ICAP) driver.
+
 config R3964
 	tristate "Siemens R3964 line discipline"
 	---help---
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 07304d5..3a278a0 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_EFI_RTC)		+=3D efirtc.o
 obj-$(CONFIG_SGI_DS1286)	+=3D ds1286.o
 obj-$(CONFIG_SGI_IP27_RTC)	+=3D ip27-rtc.o
 obj-$(CONFIG_DS1302)		+=3D ds1302.o
+obj-$(CONFIG_XILINX_HWICAP)    +=3D xilinx_hwicap/
 ifeq ($(CONFIG_GENERIC_NVRAM),y)
   obj-$(CONFIG_NVRAM)	+=3D generic_nvram.o
 else
diff --git a/drivers/char/xilinx_hwicap/Makefile =
b/drivers/char/xilinx_hwicap/Makefile
new file mode 100644
index 0000000..5491cbc
--- /dev/null
+++ b/drivers/char/xilinx_hwicap/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for the Xilinx OPB hwicap driver
+#
+
+obj-$(CONFIG_XILINX_HWICAP) +=3D xilinx_hwicap_m.o=20
+=20
+xilinx_hwicap_m-y :=3D xilinx_hwicap.o fifo_icap.o buffer_icap.o
diff --git a/drivers/char/xilinx_hwicap/buffer_icap.c =
b/drivers/char/xilinx_hwicap/buffer_icap.c
new file mode 100644
index 0000000..dfea2bd
--- /dev/null
+++ b/drivers/char/xilinx_hwicap/buffer_icap.c
@@ -0,0 +1,380 @@
+/***********************************************************************=
******
+ *
+ *     Author: Xilinx, Inc.
+ *
+ *     This program is free software; you can redistribute it and/or =
modify it
+ *     under the terms of the GNU General Public License as published =
by the
+ *     Free Software Foundation; either version 2 of the License, or =
(at your
+ *     option) any later version.
+ *
+ *     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
+ *     AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND
+ *     SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,
+ *     OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,
+ *     APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION
+ *     THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF =
INFRINGEMENT,
+ *     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE
+ *     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY
+ *     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
+ *     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
+ *     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
+ *     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ *     FOR A PARTICULAR PURPOSE.
+ *
+ *     Xilinx products are not intended for use in life support =
appliances,
+ *     devices, or systems. Use in such applications is expressly =
prohibited.
+ *
+ *     (c) Copyright 2003-2008 Xilinx Inc.
+ *     All rights reserved.
+ *
+ *     You should have received a copy of the GNU General Public =
License along
+ *     with this program; if not, write to the Free Software =
Foundation, Inc.,
+ *     675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ =
*************************************************************************=
****/
+
+#include "buffer_icap.h"
+
+/* Indicates how many bytes will fit in a buffer. (1 BRAM) */
+#define XHI_MAX_BUFFER_BYTES        2048
+#define XHI_MAX_BUFFER_INTS         (XHI_MAX_BUFFER_BYTES >> 2)
+
+/* File access and error constants */
+#define XHI_DEVICE_READ_ERROR       -1
+#define XHI_DEVICE_WRITE_ERROR      -2
+#define XHI_BUFFER_OVERFLOW_ERROR   -3
+
+#define XHI_DEVICE_READ             0x1
+#define XHI_DEVICE_WRITE            0x0
+
+/* Constants for checking transfer status */
+#define XHI_CYCLE_DONE              0
+#define XHI_CYCLE_EXECUTING         1
+
+/* buffer_icap register offsets */
+
+/* Size of transfer, read & write */
+#define XHI_SIZE_REG_OFFSET        0x800L
+/* offset into bram, read & write */
+#define XHI_BRAM_OFFSET_REG_OFFSET 0x804L
+/* Read not Configure, direction of transfer.  Write only */
+#define XHI_RNC_REG_OFFSET         0x808L
+/* Indicates transfer complete. Read only */
+#define XHI_STATUS_REG_OFFSET      0x80CL
+
+/* Constants for setting the RNC register */
+#define XHI_CONFIGURE              0x0UL
+#define XHI_READBACK               0x1UL
+
+/* Constants for the Done register */
+#define XHI_NOT_FINISHED           0x0UL
+#define XHI_FINISHED               0x1UL
+
+#define XHI_BUFFER_START 0
+
+/**
+ * buffer_icap_get_status: Get the contents of the status register.
+ * @parameter base_address: is the base address of the device
+ *
+ * The status register contains the ICAP status and the done bit.
+ *
+ * D8 - cfgerr
+ * D7 - dalign
+ * D6 - rip
+ * D5 - in_abort_l
+ * D4 - Always 1
+ * D3 - Always 1
+ * D2 - Always 1
+ * D1 - Always 1
+ * D0 - Done bit
+ **/
+static inline u32 buffer_icap_get_status(void __iomem *base_address)
+{
+	return in_be32(base_address + XHI_STATUS_REG_OFFSET);
+}
+
+/**
+ * buffer_icap_get_bram: Reads data from the storage buffer bram.
+ * @parameter base_address: contains the base address of the component.
+ * @parameter offset: The word offset from which the data should be =
read.
+ *
+ * A bram is used as a configuration memory cache.  One frame of data =
can
+ * be stored in this "storage buffer".
+ **/
+static inline u32 buffer_icap_get_bram(void __iomem *base_address,
+		u32 offset)
+{
+	return in_be32(base_address + (offset << 2));
+}
+
+/**
+ * buffer_icap_busy: Return true if the icap device is busy
+ * @parameter base_address: is the base address of the device
+ *
+ * The queries the low order bit of the status register, which
+ * indicates whether the current configuration or readback operation
+ * has completed.
+ **/
+static inline bool buffer_icap_busy(void __iomem *base_address)
+{
+	return (buffer_icap_get_status(base_address) & 1) =3D=3D =
XHI_NOT_FINISHED;
+}
+
+/**
+ * buffer_icap_busy: Return true if the icap device is not busy
+ * @parameter base_address: is the base address of the device
+ *
+ * The queries the low order bit of the status register, which
+ * indicates whether the current configuration or readback operation
+ * has completed.
+ **/
+static inline bool buffer_icap_done(void __iomem *base_address)
+{
+	return (buffer_icap_get_status(base_address) & 1) =3D=3D XHI_FINISHED;
+}
+
+/**
+ * buffer_icap_set_size: Set the size register.
+ * @parameter base_address: is the base address of the device
+ * @parameter data: The size in bytes.
+ *
+ * The size register holds the number of 8 bit bytes to transfer =
between
+ * bram and the icap (or icap to bram).
+ **/
+static inline void buffer_icap_set_size(void __iomem *base_address,
+		u32 data)
+{
+	out_be32(base_address + XHI_SIZE_REG_OFFSET, data);
+}
+
+/**
+ * buffer_icap_mSetoffsetReg: Set the bram offset register.
+ * @parameter base_address: contains the base address of the device.
+ * @parameter data: is the value to be written to the data register.
+ *
+ * The bram offset register holds the starting bram address to transfer
+ * data from during configuration or write data to during readback.
+ **/
+static inline void buffer_icap_set_offset(void __iomem *base_address,
+		u32 data)
+{
+	out_be32(base_address + XHI_BRAM_OFFSET_REG_OFFSET, data);
+}
+
+/**
+ * buffer_icap_set_rnc: Set the RNC (Readback not Configure) register.
+ * @parameter base_address: contains the base address of the device.
+ * @parameter data: is the value to be written to the data register.
+ *
+ * The RNC register determines the direction of the data transfer.  It
+ * controls whether a configuration or readback take place.  Writing to
+ * this register initiates the transfer.  A value of 1 initiates a
+ * readback while writing a value of 0 initiates a configuration.
+ **/
+static inline void buffer_icap_set_rnc(void __iomem *base_address,
+		u32 data)
+{
+	out_be32(base_address + XHI_RNC_REG_OFFSET, data);
+}
+
+/**
+ * buffer_icap_set_bram: Write data to the storage buffer bram.
+ * @parameter base_address: contains the base address of the component.
+ * @parameter offset: The word offset at which the data should be =
written.
+ * @parameter data: The value to be written to the bram offset.
+ *
+ * A bram is used as a configuration memory cache.  One frame of data =
can
+ * be stored in this "storage buffer".
+ **/
+static inline void buffer_icap_set_bram(void __iomem *base_address,
+		u32 offset, u32 data)
+{
+	out_be32(base_address + (offset << 2), data);
+}
+
+/**
+ * buffer_icap_device_read: Transfer bytes from ICAP to the storage =
buffer.
+ * @parameter drvdata: a pointer to the drvdata.
+ * @parameter offset: The storage buffer start address.
+ * @parameter count: The number of words (32 bit) to read from the
+ *           device (ICAP).
+ **/
+static int buffer_icap_device_read(struct hwicap_drvdata *drvdata,
+		u32 offset, u32 count)
+{
+
+	s32 retries =3D 0;
+	void __iomem *base_address =3D drvdata->base_address;
+
+	if (buffer_icap_busy(base_address))
+		return -EBUSY;
+
+	if ((offset + count) > XHI_MAX_BUFFER_INTS)
+		return -EINVAL;
+
+	/* setSize count*4 to get bytes. */
+	buffer_icap_set_size(base_address, (count << 2));
+	buffer_icap_set_offset(base_address, offset);
+	buffer_icap_set_rnc(base_address, XHI_READBACK);
+
+	while (buffer_icap_busy(base_address)) {
+		retries++;
+		if (retries > XHI_MAX_RETRIES)
+			return -EBUSY;
+	}
+	return 0;
+
+};
+
+/**
+ * buffer_icap_device_write: Transfer bytes from ICAP to the storage =
buffer.
+ * @parameter drvdata: a pointer to the drvdata.
+ * @parameter offset: The storage buffer start address.
+ * @parameter count: The number of words (32 bit) to read from the
+ *           device (ICAP).
+ **/
+static int buffer_icap_device_write(struct hwicap_drvdata *drvdata,
+		u32 offset, u32 count)
+{
+
+	s32 retries =3D 0;
+	void __iomem *base_address =3D drvdata->base_address;
+
+	if (buffer_icap_busy(base_address))
+		return -EBUSY;
+
+	if ((offset + count) > XHI_MAX_BUFFER_INTS)
+		return -EINVAL;
+
+	/* setSize count*4 to get bytes. */
+	buffer_icap_set_size(base_address, count << 2);
+	buffer_icap_set_offset(base_address, offset);
+	buffer_icap_set_rnc(base_address, XHI_CONFIGURE);
+
+	while (buffer_icap_busy(base_address)) {
+		retries++;
+		if (retries > XHI_MAX_RETRIES)
+			return -EBUSY;
+	}
+	return 0;
+
+};
+
+/**
+ * buffer_icap_reset: Reset the logic of the icap device.
+ * @parameter drvdata: a pointer to the drvdata.
+ *
+ * Writing to the status register resets the ICAP logic in an internal
+ * version of the core.  For the version of the core published in EDK,
+ * this is a noop.
+ **/
+void buffer_icap_reset(struct hwicap_drvdata *drvdata)
+{
+    out_be32(drvdata->base_address + XHI_STATUS_REG_OFFSET, 0xFEFE);
+}
+
+/**
+ * buffer_icap_set_configuration: Load a partial bitstream from system =
memory.
+ * @parameter drvdata: a pointer to the drvdata.
+ * @parameter data: Kernel address of the partial bitstream.
+ * @parameter size: the size of the partial bitstream in 32 bit words.
+ **/
+int buffer_icap_set_configuration(struct hwicap_drvdata *drvdata, u32 =
*data,
+			     u32 size)
+{
+	int status;
+	s32 buffer_count =3D 0;
+	s32 num_writes =3D 0;
+	bool dirty =3D 0;
+	u32 i;
+	void __iomem *base_address =3D drvdata->base_address;
+
+	/* Loop through all the data */
+	for (i =3D 0, buffer_count =3D 0; i < size; i++) {
+
+		/* Copy data to bram */
+		buffer_icap_set_bram(base_address, buffer_count, data[i]);
+		dirty =3D 1;
+
+		if (buffer_count < XHI_MAX_BUFFER_INTS - 1) {
+			buffer_count++;
+			continue;
+		}
+
+		/* Write data to ICAP */
+		status =3D buffer_icap_device_write(
+				drvdata,
+				XHI_BUFFER_START,
+				XHI_MAX_BUFFER_INTS);
+		if (status !=3D 0) {
+			/* abort. */
+			buffer_icap_reset(drvdata);
+			return status;
+		}
+
+		buffer_count =3D 0;
+		num_writes++;
+		dirty =3D 0;
+	}
+
+	/* Write unwritten data to ICAP */
+	if (dirty) {
+		/* Write data to ICAP */
+		status =3D buffer_icap_device_write(drvdata, XHI_BUFFER_START,
+					     buffer_count);
+		if (status !=3D 0) {
+			/* abort. */
+			buffer_icap_reset(drvdata);
+		}
+		return status;
+	}
+
+	return 0;
+};
+
+/**
+ * buffer_icap_get_configuration: Read configuration data from the =
device.
+ * @parameter drvdata: a pointer to the drvdata.
+ * @parameter data: Address of the data representing the partial =
bitstream
+ * @parameter size: the size of the partial bitstream in 32 bit words.
+ **/
+int buffer_icap_get_configuration(struct hwicap_drvdata *drvdata, u32 =
*data,
+			     u32 size)
+{
+	int status;
+	s32 buffer_count =3D 0;
+	s32 read_count =3D 0;
+	u32 i;
+	void __iomem *base_address =3D drvdata->base_address;
+
+	/* Loop through all the data */
+	for (i =3D 0, buffer_count =3D XHI_MAX_BUFFER_INTS; i < size; i++) {
+		if (buffer_count =3D=3D XHI_MAX_BUFFER_INTS) {
+			u32 words_remaining =3D size - i;
+			u32 words_to_read =3D
+				words_remaining <
+				XHI_MAX_BUFFER_INTS ? words_remaining :
+				XHI_MAX_BUFFER_INTS;
+
+			/* Read data from ICAP */
+			status =3D buffer_icap_device_read(
+					drvdata,
+					XHI_BUFFER_START,
+					words_to_read);
+			if (status !=3D 0) {
+				/* abort. */
+				buffer_icap_reset(drvdata);
+				return status;
+			}
+
+			buffer_count =3D 0;
+			read_count++;
+		}
+
+		/* Copy data from bram */
+		data[i] =3D buffer_icap_get_bram(base_address, buffer_count);
+		buffer_count++;
+	}
+
+	return 0;
+};
diff --git a/drivers/char/xilinx_hwicap/buffer_icap.h =
b/drivers/char/xilinx_hwicap/buffer_icap.h
new file mode 100644
index 0000000..0318495
--- /dev/null
+++ b/drivers/char/xilinx_hwicap/buffer_icap.h
@@ -0,0 +1,57 @@
+/***********************************************************************=
******
+ *
+ *     Author: Xilinx, Inc.
+ *
+ *     This program is free software; you can redistribute it and/or =
modify it
+ *     under the terms of the GNU General Public License as published =
by the
+ *     Free Software Foundation; either version 2 of the License, or =
(at your
+ *     option) any later version.
+ *
+ *     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
+ *     AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND
+ *     SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,
+ *     OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,
+ *     APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION
+ *     THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF =
INFRINGEMENT,
+ *     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE
+ *     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY
+ *     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
+ *     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
+ *     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
+ *     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ *     FOR A PARTICULAR PURPOSE.
+ *
+ *     Xilinx products are not intended for use in life support =
appliances,
+ *     devices, or systems. Use in such applications is expressly =
prohibited.
+ *
+ *     (c) Copyright 2003-2008 Xilinx Inc.
+ *     All rights reserved.
+ *
+ *     You should have received a copy of the GNU General Public =
License along
+ *     with this program; if not, write to the Free Software =
Foundation, Inc.,
+ *     675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ =
*************************************************************************=
****/
+
+#ifndef XILINX_BUFFER_ICAP_H_	/* prevent circular inclusions */
+#define XILINX_BUFFER_ICAP_H_	/* by using protection macros */
+
+#include <linux/types.h>
+#include <linux/cdev.h>
+#include <linux/version.h>
+#include <linux/platform_device.h>
+
+#include <asm/io.h>
+#include "xilinx_hwicap.h"
+
+void buffer_icap_reset(struct hwicap_drvdata *drvdata);
+
+/* Loads a partial bitstream from system memory. */
+int buffer_icap_set_configuration(struct hwicap_drvdata *drvdata, u32 =
*data,
+			     u32 Size);
+
+/* Loads a partial bitstream from system memory. */
+int buffer_icap_get_configuration(struct hwicap_drvdata *drvdata, u32 =
*data,
+			     u32 Size);
+
+#endif
diff --git a/drivers/char/xilinx_hwicap/fifo_icap.c =
b/drivers/char/xilinx_hwicap/fifo_icap.c
new file mode 100644
index 0000000..0988314
--- /dev/null
+++ b/drivers/char/xilinx_hwicap/fifo_icap.c
@@ -0,0 +1,381 @@
+/***********************************************************************=
******
+ *
+ *     Author: Xilinx, Inc.
+ *
+ *     This program is free software; you can redistribute it and/or =
modify it
+ *     under the terms of the GNU General Public License as published =
by the
+ *     Free Software Foundation; either version 2 of the License, or =
(at your
+ *     option) any later version.
+ *
+ *     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
+ *     AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND
+ *     SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,
+ *     OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,
+ *     APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION
+ *     THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF =
INFRINGEMENT,
+ *     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE
+ *     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY
+ *     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
+ *     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
+ *     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
+ *     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ *     FOR A PARTICULAR PURPOSE.
+ *
+ *     Xilinx products are not intended for use in life support =
appliances,
+ *     devices, or systems. Use in such applications is expressly =
prohibited.
+ *
+ *     (c) Copyright 2007-2008 Xilinx Inc.
+ *     All rights reserved.
+ *
+ *     You should have received a copy of the GNU General Public =
License along
+ *     with this program; if not, write to the Free Software =
Foundation, Inc.,
+ *     675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ =
*************************************************************************=
****/
+
+#include "fifo_icap.h"
+
+/* Register offsets for the XHwIcap device. */
+#define XHI_GIER_OFFSET	0x1C  /* Device Global Interrupt Enable Reg */
+#define XHI_IPISR_OFFSET 0x20  /* Interrupt Status Register */
+#define XHI_IPIER_OFFSET 0x28  /* Interrupt Enable Register */
+#define XHI_WF_OFFSET 0x100 /* Write FIFO */
+#define XHI_RF_OFFSET 0x104 /* Read FIFO */
+#define XHI_SZ_OFFSET 0x108 /* Size Register */
+#define XHI_CR_OFFSET 0x10C /* Control Register */
+#define XHI_SR_OFFSET 0x110 /* Status Register */
+#define XHI_WFV_OFFSET 0x114 /* Write FIFO Vacancy Register */
+#define XHI_RFO_OFFSET 0x118 /* Read FIFO Occupancy Register */
+
+/* Device Global Interrupt Enable Register (GIER) bit definitions */
+
+#define XHI_GIER_GIE_MASK 0x80000000 /* Global Interrupt enable Mask */
+
+/**
+ * HwIcap Device Interrupt Status/Enable Registers
+ *
+ * Interrupt Status Register (IPISR) : This register holds the
+ * interrupt status flags for the device. These bits are toggle on
+ * write.
+ *
+ * Interrupt Enable Register (IPIER) : This register is used to enable
+ * interrupt sources for the device.
+ * Writing a '1' to a bit enables the corresponding interrupt.
+ * Writing a '0' to a bit disables the corresponding interrupt.
+ *
+ * IPISR/IPIER registers have the same bit definitions and are only =
defined
+ * once.
+ */
+#define XHI_IPIXR_RFULL_MASK 0x00000008 /* Read FIFO Full */
+#define XHI_IPIXR_WEMPTY_MASK 0x00000004 /* Write FIFO Empty */
+#define XHI_IPIXR_RDP_MASK 0x00000002 /* Read FIFO half full */
+#define XHI_IPIXR_WRP_MASK 0x00000001 /* Write FIFO half full */
+#define XHI_IPIXR_ALL_MASK 0x0000000F /* Mask of all interrupts */
+
+/* Control Register (CR) */
+#define XHI_CR_SW_RESET_MASK 0x00000008 /* SW Reset Mask */
+#define XHI_CR_FIFO_CLR_MASK 0x00000004 /* FIFO Clear Mask */
+#define XHI_CR_READ_MASK 0x00000002 /* Read from ICAP to FIFO */
+#define XHI_CR_WRITE_MASK 0x00000001 /* Write from FIFO to ICAP */
+
+/* Status Register (SR) */
+#define XHI_SR_CFGERR_N_MASK 0x00000100 /* Config Error Mask */
+#define XHI_SR_DALIGN_MASK 0x00000080 /* Data Alignment Mask */
+#define XHI_SR_RIP_MASK 0x00000040 /* Read back Mask */
+#define XHI_SR_IN_ABORT_N_MASK 0x00000020 /* Select Map Abort Mask */
+#define XHI_SR_DONE_MASK 0x00000001 /* Done bit Mask  */
+
+
+#define XHI_WFO_MAX_VACANCY 1024 /* Max Write FIFO Vacancy, in words */
+#define XHI_RFO_MAX_OCCUPANCY 256 /* Max Read FIFO Occupancy, in words =
*/
+/* The maximum amount we can request from fifo_icap_get_configuration
+   at once, in bytes. */
+#define XHI_MAX_READ_TRANSACTION_WORDS 0xFFF
+
+
+/**
+ * fifo_icap_fifo_write: Write data to the write FIFO.
+ * @parameter drvdata: a pointer to the drvdata.
+ * @parameter data: the 32-bit value to be written to the FIFO.
+ *
+ * This function will silently fail if the fifo is full.
+ **/
+static inline void fifo_icap_fifo_write(struct hwicap_drvdata *drvdata,
+		u32 data)
+{
+	dev_dbg(drvdata->dev, "fifo_write: %x\n", data);
+	out_be32(drvdata->base_address + XHI_WF_OFFSET, data);
+}
+
+/**
+ * fifo_icap_fifo_read: Read data from the Read FIFO.
+ * @parameter drvdata: a pointer to the drvdata.
+ *
+ * This function will silently fail if the fifo is empty.
+ **/
+static inline u32 fifo_icap_fifo_read(struct hwicap_drvdata *drvdata)
+{
+	u32 data =3D in_be32(drvdata->base_address + XHI_RF_OFFSET);
+	dev_dbg(drvdata->dev, "fifo_read: %x\n", data);
+	return data;
+}
+
+/**
+ * fifo_icap_set_read_size: Set the the size register.
+ * @parameter drvdata: a pointer to the drvdata.
+ * @parameter data: the size of the following read transaction, in =
words.
+ **/
+static inline void fifo_icap_set_read_size(struct hwicap_drvdata =
*drvdata,
+		u32 data)
+{
+	out_be32(drvdata->base_address + XHI_SZ_OFFSET, data);
+}
+
+/**
+ * fifo_icap_start_config: Initiate a configuration (write) to the =
device.
+ * @parameter drvdata: a pointer to the drvdata.
+ **/
+static inline void fifo_icap_start_config(struct hwicap_drvdata =
*drvdata)
+{
+	out_be32(drvdata->base_address + XHI_CR_OFFSET, XHI_CR_WRITE_MASK);
+	dev_dbg(drvdata->dev, "configuration started\n");
+}
+
+/**
+ * fifo_icap_start_readback: Initiate a readback from the device.
+ * @parameter drvdata: a pointer to the drvdata.
+ **/
+static inline void fifo_icap_start_readback(struct hwicap_drvdata =
*drvdata)
+{
+	out_be32(drvdata->base_address + XHI_CR_OFFSET, XHI_CR_READ_MASK);
+	dev_dbg(drvdata->dev, "readback started\n");
+}
+
+/**
+ * fifo_icap_busy: Return true if the ICAP is still processing a =
transaction.
+ * @parameter drvdata: a pointer to the drvdata.
+ **/
+static inline u32 fifo_icap_busy(struct hwicap_drvdata *drvdata)
+{
+	u32 status =3D in_be32(drvdata->base_address + XHI_SR_OFFSET);
+	dev_dbg(drvdata->dev, "Getting status =3D %x\n", status);
+	return (status & XHI_SR_DONE_MASK) ? 0 : 1;
+}
+
+/**
+ * fifo_icap_write_fifo_vacancy: Query the write fifo available space.
+ * @parameter drvdata: a pointer to the drvdata.
+ *
+ * Return the number of words that can be safely pushed into the write =
fifo.
+ **/
+static inline u32 fifo_icap_write_fifo_vacancy(
+		struct hwicap_drvdata *drvdata)
+{
+	return in_be32(drvdata->base_address + XHI_WFV_OFFSET);
+}
+
+/**
+ * fifo_icap_read_fifo_occupancy: Query the read fifo available data.
+ * @parameter drvdata: a pointer to the drvdata.
+ *
+ * Return the number of words that can be safely read from the read =
fifo.
+ **/
+static inline u32 fifo_icap_read_fifo_occupancy(
+		struct hwicap_drvdata *drvdata)
+{
+	return in_be32(drvdata->base_address + XHI_RFO_OFFSET);
+}
+
+/**
+ * fifo_icap_set_configuration: Send configuration data to the ICAP.
+ * @parameter drvdata: a pointer to the drvdata.
+ * @parameter frame_buffer: a pointer to the data to be written to the
+ *		ICAP device.
+ * @parameter num_words: the number of words (32 bit) to write to the =
ICAP
+ *		device.
+
+ * This function writes the given user data to the Write FIFO in
+ * polled mode and starts the transfer of the data to
+ * the ICAP device.
+ **/
+int fifo_icap_set_configuration(struct hwicap_drvdata *drvdata,
+		u32 *frame_buffer, u32 num_words)
+{
+
+	u32 write_fifo_vacancy =3D 0;
+	u32 retries =3D 0;
+	u32 remaining_words;
+
+	dev_dbg(drvdata->dev, "fifo_set_configuration\n");
+
+	/*
+	 * Check if the ICAP device is Busy with the last Read/Write
+	 */
+	if (fifo_icap_busy(drvdata))
+		return -EBUSY;
+
+	/*
+	 * Set up the buffer pointer and the words to be transferred.
+	 */
+	remaining_words =3D num_words;
+
+	while (remaining_words > 0) {
+		/*
+		 * Wait until we have some data in the fifo.
+		 */
+		while (write_fifo_vacancy =3D=3D 0) {
+			write_fifo_vacancy =3D
+				fifo_icap_write_fifo_vacancy(drvdata);
+			retries++;
+			if (retries > XHI_MAX_RETRIES)
+				return -EIO;
+		}
+
+		/*
+		 * Write data into the Write FIFO.
+		 */
+		while ((write_fifo_vacancy !=3D 0) &&
+				(remaining_words > 0)) {
+			fifo_icap_fifo_write(drvdata, *frame_buffer);
+
+			remaining_words--;
+			write_fifo_vacancy--;
+			frame_buffer++;
+		}
+		/* Start pushing whatever is in the FIFO into the ICAP. */
+		fifo_icap_start_config(drvdata);
+	}
+
+	/* Wait until the write has finished. */
+	while (fifo_icap_busy(drvdata)) {
+		retries++;
+		if (retries > XHI_MAX_RETRIES)
+			break;
+	}
+
+	dev_dbg(drvdata->dev, "done fifo_set_configuration\n");
+
+	/*
+	 * If the requested number of words have not been read from
+	 * the device then indicate failure.
+	 */
+	if (remaining_words !=3D 0)
+		return -EIO;
+
+	return 0;
+}
+
+/**
+ * fifo_icap_get_configuration: Read configuration data from the =
device.
+ * @parameter drvdata: a pointer to the drvdata.
+ * @parameter data: Address of the data representing the partial =
bitstream
+ * @parameter size: the size of the partial bitstream in 32 bit words.
+ *
+ * This function reads the specified number of words from the ICAP =
device in
+ * the polled mode.
+ */
+int fifo_icap_get_configuration(struct hwicap_drvdata *drvdata,
+		u32 *frame_buffer, u32 num_words)
+{
+
+	u32 read_fifo_occupancy =3D 0;
+	u32 retries =3D 0;
+	u32 *data =3D frame_buffer;
+	u32 remaining_words;
+	u32 words_to_read;
+
+	dev_dbg(drvdata->dev, "fifo_get_configuration\n");
+
+	/*
+	 * Check if the ICAP device is Busy with the last Write/Read
+	 */
+	if (fifo_icap_busy(drvdata))
+		return -EBUSY;
+
+	remaining_words =3D num_words;
+
+	while (remaining_words > 0) {
+		words_to_read =3D remaining_words;
+		/* The hardware has a limit on the number of words
+		   that can be read at one time.  */
+		if (words_to_read > XHI_MAX_READ_TRANSACTION_WORDS)
+			words_to_read =3D XHI_MAX_READ_TRANSACTION_WORDS;
+
+		remaining_words -=3D words_to_read;
+
+		fifo_icap_set_read_size(drvdata, words_to_read);
+		fifo_icap_start_readback(drvdata);
+
+		while (words_to_read > 0) {
+			/* Wait until we have some data in the fifo. */
+			while (read_fifo_occupancy =3D=3D 0) {
+				read_fifo_occupancy =3D
+					fifo_icap_read_fifo_occupancy(drvdata);
+				retries++;
+				if (retries > XHI_MAX_RETRIES)
+					return -EIO;
+			}
+
+			if (read_fifo_occupancy > words_to_read)
+				read_fifo_occupancy =3D words_to_read;
+
+			words_to_read -=3D read_fifo_occupancy;
+
+			/* Read the data from the Read FIFO. */
+			while (read_fifo_occupancy !=3D 0) {
+				*data++ =3D fifo_icap_fifo_read(drvdata);
+				read_fifo_occupancy--;
+			}
+		}
+	}
+
+	dev_dbg(drvdata->dev, "done fifo_get_configuration\n");
+
+	return 0;
+}
+
+/**
+ * buffer_icap_reset: Reset the logic of the icap device.
+ * @parameter drvdata: a pointer to the drvdata.
+ *
+ * This function forces the software reset of the complete HWICAP =
device.
+ * All the registers will return to the default value and the FIFO is =
also
+ * flushed as a part of this software reset.
+ */
+void fifo_icap_reset(struct hwicap_drvdata *drvdata)
+{
+	u32 reg_data;
+	/*
+	 * Reset the device by setting/clearing the RESET bit in the
+	 * Control Register.
+	 */
+	reg_data =3D in_be32(drvdata->base_address + XHI_CR_OFFSET);
+
+	out_be32(drvdata->base_address + XHI_CR_OFFSET,
+				reg_data | XHI_CR_SW_RESET_MASK);
+
+	out_be32(drvdata->base_address + XHI_CR_OFFSET,
+				reg_data & (~XHI_CR_SW_RESET_MASK));
+
+}
+
+/**
+ * fifo_icap_flush_fifo: This function flushes the FIFOs in the device.
+ * @parameter drvdata: a pointer to the drvdata.
+ */
+void fifo_icap_flush_fifo(struct hwicap_drvdata *drvdata)
+{
+	u32 reg_data;
+	/*
+	 * Flush the FIFO by setting/clearing the FIFO Clear bit in the
+	 * Control Register.
+	 */
+	reg_data =3D in_be32(drvdata->base_address + XHI_CR_OFFSET);
+
+	out_be32(drvdata->base_address + XHI_CR_OFFSET,
+				reg_data | XHI_CR_FIFO_CLR_MASK);
+
+	out_be32(drvdata->base_address + XHI_CR_OFFSET,
+				reg_data & (~XHI_CR_FIFO_CLR_MASK));
+}
+
diff --git a/drivers/char/xilinx_hwicap/fifo_icap.h =
b/drivers/char/xilinx_hwicap/fifo_icap.h
new file mode 100644
index 0000000..4d3068d
--- /dev/null
+++ b/drivers/char/xilinx_hwicap/fifo_icap.h
@@ -0,0 +1,62 @@
+/***********************************************************************=
******
+ *
+ *     Author: Xilinx, Inc.
+ *
+ *     This program is free software; you can redistribute it and/or =
modify it
+ *     under the terms of the GNU General Public License as published =
by the
+ *     Free Software Foundation; either version 2 of the License, or =
(at your
+ *     option) any later version.
+ *
+ *     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
+ *     AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND
+ *     SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,
+ *     OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,
+ *     APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION
+ *     THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF =
INFRINGEMENT,
+ *     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE
+ *     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY
+ *     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
+ *     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
+ *     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
+ *     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ *     FOR A PARTICULAR PURPOSE.
+ *
+ *     Xilinx products are not intended for use in life support =
appliances,
+ *     devices, or systems. Use in such applications is expressly =
prohibited.
+ *
+ *     (c) Copyright 2007-2008 Xilinx Inc.
+ *     All rights reserved.
+ *
+ *     You should have received a copy of the GNU General Public =
License along
+ *     with this program; if not, write to the Free Software =
Foundation, Inc.,
+ *     675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ =
*************************************************************************=
****/
+
+#ifndef XILINX_FIFO_ICAP_H_	/* prevent circular inclusions */
+#define XILINX_FIFO_ICAP_H_	/* by using protection macros */
+
+#include <linux/types.h>
+#include <linux/cdev.h>
+#include <linux/version.h>
+#include <linux/platform_device.h>
+
+#include <asm/io.h>
+#include "xilinx_hwicap.h"
+
+/* Reads integers from the device into the storage buffer. */
+int fifo_icap_get_configuration(
+		struct hwicap_drvdata *drvdata,
+		u32 *FrameBuffer,
+		u32 NumWords);
+
+/* Writes integers to the device from the storage buffer. */
+int fifo_icap_set_configuration(
+		struct hwicap_drvdata *drvdata,
+		u32 *FrameBuffer,
+		u32 NumWords);
+
+void fifo_icap_reset(struct hwicap_drvdata *drvdata);
+void fifo_icap_flush_fifo(struct hwicap_drvdata *drvdata);
+
+#endif
diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c =
b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
new file mode 100644
index 0000000..a55e6e1
--- /dev/null
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
@@ -0,0 +1,912 @@
+/***********************************************************************=
******
+ *
+ *     Author: Xilinx, Inc.
+ *
+ *     This program is free software; you can redistribute it and/or =
modify it
+ *     under the terms of the GNU General Public License as published =
by the
+ *     Free Software Foundation; either version 2 of the License, or =
(at your
+ *     option) any later version.
+ *
+ *     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
+ *     AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND
+ *     SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,
+ *     OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,
+ *     APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION
+ *     THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF =
INFRINGEMENT,
+ *     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE
+ *     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY
+ *     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
+ *     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
+ *     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
+ *     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ *     FOR A PARTICULAR PURPOSE.
+ *
+ *     Xilinx products are not intended for use in life support =
appliances,
+ *     devices, or systems. Use in such applications is expressly =
prohibited.
+ *
+ *     (c) Copyright 2002 Xilinx Inc., Systems Engineering Group
+ *     (c) Copyright 2004 Xilinx Inc., Systems Engineering Group
+ *     (c) Copyright 2007-2008 Xilinx Inc.
+ *     All rights reserved.
+ *
+ *     You should have received a copy of the GNU General Public =
License along
+ *     with this program; if not, write to the Free Software =
Foundation, Inc.,
+ *     675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ =
*************************************************************************=
****/
+
+/*
+ * This is the code behind /dev/xilinx_icap -- it allows a user-space
+ * application to use the Xilinx ICAP subsystem.
+ *
+ * The following operations are possible:
+ *
+ * open		open the port and initialize for access.
+ * release	release port
+ * write        Write a bitstream to the configuration processor.
+ * read         Read a data stream from the configuration processor.
+ *
+ * After being opened, the port is initialized and accessed to avoid a
+ * corrupted first read which may occur with some hardware.  The port
+ * is left in a desynched state, requiring that a synch sequence be
+ * transmitted before any valid configuration data.  A user will have
+ * exclusive access to the device while it remains open, and the state
+ * of the ICAP cannot be guaranteed after the device is closed.  Note
+ * that a complete reset of the core and the state of the ICAP cannot
+ * be performed on many versions of the cores, hence users of this
+ * device should avoid making inconsistent accesses to the device.  In
+ * particular, accessing the read interface, without first generating
+ * a write containing a readback packet can leave the ICAP in an
+ * inaccessible state.
+ *
+ * Note that in order to use the read interface, it is first necessary
+ * to write a request packet to the write interface.  i.e., it is not
+ * possible to simply readback the bitstream (or any configuration
+ * bits) from a device without specifically requesting them first.
+ * The code to craft such packets is intended to be part of the
+ * user-space application code that uses this device.  The simplest
+ * way to use this interface is simply:
+ *
+ * cp foo.bit /dev/xilinx_icap
+ *
+ * Note that unless foo.bit is an appropriately constructed partial
+ * bitstream, this has a high likelyhood of overwriting the design
+ * currently programmed in the FPGA.
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/ioport.h>
+#include <linux/interrupt.h>
+#include <linux/fcntl.h>
+#include <linux/init.h>
+#include <linux/poll.h>
+#include <linux/proc_fs.h>
+#include <linux/spinlock.h>
+#include <linux/sysctl.h>
+#include <linux/version.h>
+#include <linux/fs.h>
+#include <linux/cdev.h>
+#include <linux/platform_device.h>
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+
+#ifdef CONFIG_OF
+/* For open firmware. */
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#endif
+
+#include "xilinx_hwicap.h"
+#include "buffer_icap.h"
+#include "fifo_icap.h"
+
+#define DRIVER_NAME "xilinx_icap"
+
+#define HWICAP_REGS   (0x10000)
+
+/* dynamically allocate device number */
+static int xhwicap_major;
+static int xhwicap_minor;
+#define HWICAP_DEVICES 1
+
+module_param(xhwicap_major, int, S_IRUGO);
+module_param(xhwicap_minor, int, S_IRUGO);
+
+/* An array, which is set to true when the device is registered. */
+static bool probed_devices[HWICAP_DEVICES];
+
+static spinlock_t hwicap_spinlock =3D SPIN_LOCK_UNLOCKED;
+
+static struct class *icap_class;
+
+#define UNIMPLEMENTED 0xFFFF
+
+static const struct config_registers v2_config_registers =3D {
+	.CRC =3D 0,
+	.FAR =3D 1,
+	.FDRI =3D 2,
+	.FDRO =3D 3,
+	.CMD =3D 4,
+	.CTL =3D 5,
+	.MASK =3D 6,
+	.STAT =3D 7,
+	.LOUT =3D 8,
+	.COR =3D 9,
+	.MFWR =3D 10,
+	.FLR =3D 11,
+	.KEY =3D 12,
+	.CBC =3D 13,
+	.IDCODE =3D 14,
+	.AXSS =3D UNIMPLEMENTED,
+	.C0R_1 =3D UNIMPLEMENTED,
+	.CSOB =3D UNIMPLEMENTED,
+	.WBSTAR =3D UNIMPLEMENTED,
+	.TIMER =3D UNIMPLEMENTED,
+	.BOOTSTS =3D UNIMPLEMENTED,
+	.CTL_1 =3D UNIMPLEMENTED,
+};
+
+static const struct config_registers v4_config_registers =3D {
+	.CRC =3D 0,
+	.FAR =3D 1,
+	.FDRI =3D 2,
+	.FDRO =3D 3,
+	.CMD =3D 4,
+	.CTL =3D 5,
+	.MASK =3D 6,
+	.STAT =3D 7,
+	.LOUT =3D 8,
+	.COR =3D 9,
+	.MFWR =3D 10,
+	.FLR =3D UNIMPLEMENTED,
+	.KEY =3D UNIMPLEMENTED,
+	.CBC =3D 11,
+	.IDCODE =3D 12,
+	.AXSS =3D 13,
+	.C0R_1 =3D UNIMPLEMENTED,
+	.CSOB =3D UNIMPLEMENTED,
+	.WBSTAR =3D UNIMPLEMENTED,
+	.TIMER =3D UNIMPLEMENTED,
+	.BOOTSTS =3D UNIMPLEMENTED,
+	.CTL_1 =3D UNIMPLEMENTED,
+};
+static const struct config_registers v5_config_registers =3D {
+	.CRC =3D 0,
+	.FAR =3D 1,
+	.FDRI =3D 2,
+	.FDRO =3D 3,
+	.CMD =3D 4,
+	.CTL =3D 5,
+	.MASK =3D 6,
+	.STAT =3D 7,
+	.LOUT =3D 8,
+	.COR =3D 9,
+	.MFWR =3D 10,
+	.FLR =3D UNIMPLEMENTED,
+	.KEY =3D UNIMPLEMENTED,
+	.CBC =3D 11,
+	.IDCODE =3D 12,
+	.AXSS =3D 13,
+	.C0R_1 =3D 14,
+	.CSOB =3D 15,
+	.WBSTAR =3D 16,
+	.TIMER =3D 17,
+	.BOOTSTS =3D 18,
+	.CTL_1 =3D 19,
+};
+
+/**
+ * hwicap_command_desync: Send a DESYNC command to the ICAP port.
+ * @parameter drvdata: a pointer to the drvdata.
+ *
+ * This command desynchronizes the ICAP After this command, a
+ * bitstream containing a NULL packet, followed by a SYNCH packet is
+ * required before the ICAP will recognize commands.
+ */
+int hwicap_command_desync(struct hwicap_drvdata *drvdata)
+{
+	u32 buffer[4];
+	u32 index =3D 0;
+
+	/*
+	 * Create the data to be written to the ICAP.
+	 */
+	buffer[index++] =3D hwicap_type_1_write(drvdata->config_regs->CMD) | =
1;
+	buffer[index++] =3D XHI_CMD_DESYNCH;
+	buffer[index++] =3D XHI_NOOP_PACKET;
+	buffer[index++] =3D XHI_NOOP_PACKET;
+
+	/*
+	 * Write the data to the FIFO and intiate the transfer of data present
+	 * in the FIFO to the ICAP device.
+	 */
+	return drvdata->config->set_configuration(drvdata,
+			&buffer[0], index);
+}
+
+/**
+ * hwicap_command_capture: Send a CAPTURE command to the ICAP port.
+ * @parameter drvdata: a pointer to the drvdata.
+ *
+ * This command captures all of the flip flop states so they will be
+ * available during readback.  One can use this command instead of
+ * enabling the CAPTURE block in the design.
+ */
+int hwicap_command_capture(struct hwicap_drvdata *drvdata)
+{
+	u32 buffer[7];
+	u32 index =3D 0;
+
+	/*
+	 * Create the data to be written to the ICAP.
+	 */
+	buffer[index++] =3D XHI_DUMMY_PACKET;
+	buffer[index++] =3D XHI_SYNC_PACKET;
+	buffer[index++] =3D XHI_NOOP_PACKET;
+	buffer[index++] =3D hwicap_type_1_write(drvdata->config_regs->CMD) | =
1;
+	buffer[index++] =3D XHI_CMD_GCAPTURE;
+	buffer[index++] =3D XHI_DUMMY_PACKET;
+	buffer[index++] =3D XHI_DUMMY_PACKET;
+
+	/*
+	 * Write the data to the FIFO and intiate the transfer of data
+	 * present in the FIFO to the ICAP device.
+	 */
+	return drvdata->config->set_configuration(drvdata,
+			&buffer[0], index);
+
+}
+
+/**
+ * hwicap_get_configuration_register: Query a configuration register.
+ * @parameter drvdata: a pointer to the drvdata.
+ * @parameter reg: a constant which represents the configuration
+ *		register value to be returned.
+ * 		Examples:  XHI_IDCODE, XHI_FLR.
+ * @parameter RegData: returns the value of the register.
+ *
+ * Sends a query packet to the ICAP and then receives the response.
+ * The icap is left in Synched state.
+ */
+int hwicap_get_configuration_register(struct hwicap_drvdata *drvdata,
+		u32 reg, u32 *RegData)
+{
+	int status;
+	u32 buffer[6];
+	u32 index =3D 0;
+
+	/*
+	 * Create the data to be written to the ICAP.
+	 */
+	buffer[index++] =3D XHI_DUMMY_PACKET;
+	buffer[index++] =3D XHI_SYNC_PACKET;
+	buffer[index++] =3D XHI_NOOP_PACKET;
+	buffer[index++] =3D hwicap_type_1_read(reg) | 1;
+	buffer[index++] =3D XHI_NOOP_PACKET;
+	buffer[index++] =3D XHI_NOOP_PACKET;
+
+	/*
+	 * Write the data to the FIFO and intiate the transfer of data present
+	 * in the FIFO to the ICAP device.
+	 */
+	status =3D drvdata->config->set_configuration(drvdata,
+			&buffer[0], index);
+	if (status)
+		return status;
+
+	/*
+	 * Read the configuration register
+	 */
+	status =3D drvdata->config->get_configuration(drvdata, RegData, 1);
+	if (status)
+		return status;
+
+	return 0;
+}
+
+int hwicap_initialize_hwicap(struct hwicap_drvdata *drvdata)
+{
+	int status;
+	u32 idcode;
+
+	dev_dbg(drvdata->dev, "initializing\n");
+
+	/* Abort any current transaction, to make sure we have the
+	 * ICAP in a good state. */
+	dev_dbg(drvdata->dev, "Reset...\n");
+	drvdata->config->reset(drvdata);
+
+	dev_dbg(drvdata->dev, "Desync...\n");
+	status =3D hwicap_command_desync(drvdata);
+	if (status)
+		return status;
+
+	/* Attempt to read the IDCODE from ICAP.  This
+	 * may not be returned correctly, due to the design of the
+	 * hardware.
+	 */
+	dev_dbg(drvdata->dev, "Reading IDCODE...\n");
+	status =3D hwicap_get_configuration_register(
+			drvdata, drvdata->config_regs->IDCODE, &idcode);
+	dev_dbg(drvdata->dev, "IDCODE =3D %x\n", idcode);
+	if (status)
+		return status;
+
+	dev_dbg(drvdata->dev, "Desync...\n");
+	status =3D hwicap_command_desync(drvdata);
+	if (status)
+		return status;
+
+	return 0;
+}
+
+static ssize_t
+hwicap_read(struct file *file, char *buf, size_t count, loff_t *ppos)
+{
+	struct hwicap_drvdata *drvdata =3D file->private_data;
+	ssize_t bytes_to_read =3D 0;
+	u32 *kbuf;
+	u32 words;
+	u32 bytes_remaining;
+	int status;
+
+        spin_lock(&hwicap_spinlock);
+	if (drvdata->is_accessing)
+		return -EBUSY;
+	drvdata->is_accessing =3D 1;
+        spin_unlock(&hwicap_spinlock);
+
+	if (drvdata->read_buffer_in_use) {
+		/* If there are leftover bytes in the buffer, just */
+		/* return them and don't try to read more from the */
+		/* ICAP device. */
+		bytes_to_read =3D
+			(count < drvdata->read_buffer_in_use) ? count :
+			drvdata->read_buffer_in_use;
+
+		/* Return the data currently in the read buffer. */
+		if (copy_to_user(buf, drvdata->read_buffer, bytes_to_read)) {
+			status =3D -EFAULT;
+			goto error;
+		}
+		drvdata->read_buffer_in_use -=3D bytes_to_read;
+		memcpy(drvdata->read_buffer + bytes_to_read,
+				drvdata->read_buffer, 4 - bytes_to_read);
+	} else {
+		/* Get new data from the ICAP, and return was was requested. */
+		kbuf =3D (u32 *) get_zeroed_page(GFP_KERNEL);
+		if (!kbuf) {
+			status =3D -ENOMEM;
+			goto error;
+		}
+
+		/* The ICAP device is only able to read complete */
+		/* words.  If a number of bytes that do not correspond */
+		/* to complete words is requested, then we read enough */
+		/* words to get the required number of bytes, and then */
+		/* save the remaining bytes for the next read. */
+
+		/* Determine the number of words to read, rounding up */
+		/* if necessary. */
+		words =3D ((count + 3) >> 2);
+		bytes_to_read =3D words << 2;
+
+		if (bytes_to_read > PAGE_SIZE)
+			bytes_to_read =3D PAGE_SIZE;
+
+		/* Ensure we only read a complete number of words. */
+		bytes_remaining =3D bytes_to_read & 3;
+		bytes_to_read &=3D ~3;
+		words =3D bytes_to_read >> 2;
+
+		status =3D drvdata->config->get_configuration(drvdata,
+				kbuf, words);
+
+		/* If we didn't read correctly, then bail out. */
+		if (status) {
+			free_page((unsigned long)kbuf);
+			goto error;
+		}
+
+		/* If we fail to return the data to the user, then bail out. */
+		if (copy_to_user(buf, kbuf, bytes_to_read)) {
+			free_page((unsigned long)kbuf);
+			status =3D -EFAULT;
+			goto error;
+		}
+		memcpy(kbuf, drvdata->read_buffer, bytes_remaining);
+		drvdata->read_buffer_in_use =3D bytes_remaining;
+		free_page((unsigned long)kbuf);
+	}
+	status =3D bytes_to_read;
+ error:
+        spin_lock(&hwicap_spinlock);
+	drvdata->is_accessing =3D 0;
+        spin_unlock(&hwicap_spinlock);
+	return status;
+}
+
+static ssize_t
+hwicap_write(struct file *file, const char *buf,
+		size_t count, loff_t *ppos)
+{
+	struct hwicap_drvdata *drvdata =3D file->private_data;
+	ssize_t written =3D 0;
+	ssize_t left =3D count;
+	u32 *kbuf;
+	ssize_t len;
+	ssize_t status;
+
+        spin_lock(&hwicap_spinlock);
+	if (drvdata->is_accessing)
+		return -EBUSY;
+	drvdata->is_accessing =3D 1;
+        spin_unlock(&hwicap_spinlock);
+
+	left +=3D drvdata->write_buffer_in_use;
+
+	/* Only write multiples of 4 bytes. */
+	if (left < 4) {
+		status =3D 0;
+		goto error;
+	}
+
+	kbuf =3D (u32 *) __get_free_page(GFP_KERNEL);
+	if (!kbuf) {
+		status =3D -ENOMEM;
+		goto error;
+	}
+
+	while (left > 3) {
+		/* only write multiples of 4 bytes, so there might */
+		/* be as many as 3 bytes left (at the end). */
+		len =3D left;
+
+		if (len > PAGE_SIZE)
+			len =3D PAGE_SIZE;
+		len &=3D ~3;
+
+		if (drvdata->write_buffer_in_use) {
+			memcpy(kbuf, drvdata->write_buffer,
+					drvdata->write_buffer_in_use);
+			if (copy_from_user(
+			    (((char *)kbuf) + (drvdata->write_buffer_in_use)),
+			    buf + written,
+			    len - (drvdata->write_buffer_in_use))) {
+				free_page((unsigned long)kbuf);
+				status =3D -EFAULT;
+				goto error;
+			}
+		} else {
+			if (copy_from_user(kbuf, buf + written, len)) {
+				free_page((unsigned long)kbuf);
+				status =3D -EFAULT;
+				goto error;
+			}
+		}
+
+		status =3D drvdata->config->set_configuration(drvdata,
+				kbuf, len >> 2);
+
+		if (status) {
+			free_page((unsigned long)kbuf);
+			status =3D -EFAULT;
+			goto error;
+		}
+		if (drvdata->write_buffer_in_use) {
+			len -=3D drvdata->write_buffer_in_use;
+			left -=3D drvdata->write_buffer_in_use;
+			drvdata->write_buffer_in_use =3D 0;
+		}
+		written +=3D len;
+		left -=3D len;
+	}
+	if ((left > 0) && (left < 4)) {
+		if (!copy_from_user(drvdata->write_buffer,
+						buf + written, left)) {
+			drvdata->write_buffer_in_use =3D left;
+			written +=3D left;
+			left =3D 0;
+		}
+	}
+
+	free_page((unsigned long)kbuf);
+	status =3D written;
+ error:
+        spin_lock(&hwicap_spinlock);
+	drvdata->is_accessing =3D 0;
+        spin_unlock(&hwicap_spinlock);
+	return status;
+}
+
+static int hwicap_open(struct inode *inode, struct file *file)
+{
+	struct hwicap_drvdata *drvdata;
+	int status;
+
+	drvdata =3D container_of(inode->i_cdev, struct hwicap_drvdata, cdev);
+
+        spin_lock(&hwicap_spinlock);
+	if (drvdata->is_open)
+		return -EBUSY;
+	drvdata->is_open =3D 1;
+	drvdata->is_accessing =3D 0;
+        spin_unlock(&hwicap_spinlock);
+
+	status =3D hwicap_initialize_hwicap(drvdata);
+	if (status) {
+		dev_err(drvdata->dev, "Failed to open file");
+		return status;
+	}
+
+	file->private_data =3D drvdata;
+	drvdata->write_buffer_in_use =3D 0;
+	drvdata->read_buffer_in_use =3D 0;
+
+	return 0;
+}
+
+static int hwicap_release(struct inode *inode, struct file *file)
+{
+	struct hwicap_drvdata *drvdata =3D file->private_data;
+	int i;
+	int status =3D 0;
+
+	if (drvdata->write_buffer_in_use) {
+		/* Flush write buffer. */
+		for (i =3D drvdata->write_buffer_in_use; i < 4; i++)
+			drvdata->write_buffer[i] =3D 0;
+
+		status =3D drvdata->config->set_configuration(drvdata,
+				(u32 *) drvdata->write_buffer, 1);
+		if (status)
+			goto error;
+	}
+
+	status =3D hwicap_command_desync(drvdata);
+	if (status)
+		goto error;
+
+ error:
+        spin_lock(&hwicap_spinlock);
+	drvdata->is_open =3D 0;
+        spin_unlock(&hwicap_spinlock);
+	return status;
+}
+
+static struct file_operations hwicap_fops =3D {
+	.owner =3D THIS_MODULE,
+	.write =3D hwicap_write,
+	.read =3D hwicap_read,
+	.open =3D hwicap_open,
+	.release =3D hwicap_release,
+};
+
+static int __devinit hwicap_setup(struct device *dev, int id,
+		const struct resource *regs_res,
+		const struct hwicap_driver_config *config,
+		const struct config_registers *config_regs)
+{
+	dev_t devt;
+	struct hwicap_drvdata *drvdata =3D NULL;
+	int retval =3D 0;
+
+	dev_info(dev, "Xilinx icap port driver\n");
+
+	if (id < 0) {
+		for (id =3D 0; id < HWICAP_DEVICES; id++)
+			if (!probed_devices[id])
+				break;
+	}
+	if (id < 0 || id >=3D HWICAP_DEVICES) {
+		dev_err(dev, "%s%i too large\n", DRIVER_NAME, id);
+		return -EINVAL;
+	}
+	if (probed_devices[id]) {
+		dev_err(dev, "cannot assign to %s%i; it is already in use\n",
+			DRIVER_NAME, id);
+		return -EBUSY;
+	}
+
+	probed_devices[id] =3D 1;
+
+	devt =3D MKDEV(xhwicap_major, xhwicap_minor + id);
+
+	drvdata =3D kmalloc(sizeof(struct hwicap_drvdata), GFP_KERNEL);
+	if (!drvdata) {
+		dev_err(dev, "Couldn't allocate device private record\n");
+		return -ENOMEM;
+	}
+	memset((void *)drvdata, 0, sizeof(struct hwicap_drvdata));
+	dev_set_drvdata(dev, (void *)drvdata);
+
+	if (!regs_res) {
+		dev_err(dev, "Couldn't get registers resource\n");
+		retval =3D -EFAULT;
+		goto failed1;
+	}
+
+	drvdata->mem_start =3D regs_res->start;
+	drvdata->mem_end =3D regs_res->end;
+	drvdata->mem_size =3D regs_res->end - regs_res->start + 1;
+
+	if (!request_mem_region(drvdata->mem_start,
+					drvdata->mem_size, DRIVER_NAME)) {
+		dev_err(dev, "Couldn't lock memory region at %p\n",
+			(void *)regs_res->start);
+		retval =3D -EBUSY;
+		goto failed1;
+	}
+
+	drvdata->devt =3D devt;
+	drvdata->dev =3D dev;
+	drvdata->base_address =3D ioremap(drvdata->mem_start, =
drvdata->mem_size);
+	if (!drvdata->base_address) {
+		dev_err(dev, "ioremap() failed\n");
+		goto failed2;
+	}
+
+	drvdata->config =3D config;
+	drvdata->config_regs =3D config_regs;
+
+        spin_lock(&hwicap_spinlock);
+	drvdata->is_open =3D 0;
+	drvdata->is_accessing =3D 0;
+        spin_unlock(&hwicap_spinlock);
+
+	dev_info(dev, "ioremap %lx to %p with size %x\n",
+		 (unsigned long int)drvdata->mem_start,
+			drvdata->base_address, drvdata->mem_size);
+
+	cdev_init(&drvdata->cdev, &hwicap_fops);
+	drvdata->cdev.owner =3D THIS_MODULE;
+	retval =3D cdev_add(&drvdata->cdev, devt, 1);
+	if (retval) {
+		dev_err(dev, "cdev_add() failed\n");
+		goto failed3;
+	}
+	/*  devfs_mk_cdev(devt, S_IFCHR|S_IRUGO|S_IWUGO, DRIVER_NAME); */
+	class_device_create(icap_class, NULL, devt, NULL, DRIVER_NAME);
+	return 0;		/* success */
+
+ failed3:
+	iounmap(drvdata->base_address);
+
+ failed2:
+	release_mem_region(regs_res->start, drvdata->mem_size);
+
+ failed1:
+	kfree(drvdata);
+
+	return retval;
+}
+
+static struct hwicap_driver_config buffer_icap_config =3D {
+	.get_configuration =3D buffer_icap_get_configuration,
+	.set_configuration =3D buffer_icap_set_configuration,
+	.reset =3D buffer_icap_reset,
+};
+
+static struct hwicap_driver_config fifo_icap_config =3D {
+	.get_configuration =3D fifo_icap_get_configuration,
+	.set_configuration =3D fifo_icap_set_configuration,
+	.reset =3D fifo_icap_reset,
+};
+
+static int __devexit hwicap_remove(struct device *dev)
+{
+	struct hwicap_drvdata *drvdata;
+
+	drvdata =3D (struct hwicap_drvdata *)dev_get_drvdata(dev);
+
+	if (!drvdata)
+            return 0;
+       =20
+        class_device_destroy(icap_class, drvdata->devt);
+        cdev_del(&drvdata->cdev);
+        iounmap(drvdata->base_address);
+        release_mem_region(drvdata->mem_start, drvdata->mem_size);
+        kfree(drvdata);
+        dev_set_drvdata(dev, NULL);
+        probed_devices[MINOR(dev->devt)-xhwicap_minor] =3D 0;
+=09
+	return 0;		/* success */
+}
+
+static int __devinit hwicap_drv_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	const struct config_registers *regs;
+	const char *family;
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	/* It's most likely that we're using V4, if the family is not
+	   specified */
+	regs =3D &v4_config_registers;
+	family =3D pdev->dev.platform_data;
+
+	if (family) {
+		if (!strcmp(family, "virtex2p")) {
+			regs =3D &v2_config_registers;
+		} else if (!strcmp(family, "virtex4")) {
+			regs =3D &v4_config_registers;
+		} else if (!strcmp(family, "virtex5")) {
+			regs =3D &v5_config_registers;
+		}
+	}
+
+	return hwicap_setup(&pdev->dev, pdev->id, res,
+			&buffer_icap_config, regs);
+}
+
+static int __devexit hwicap_drv_remove(struct platform_device *pdev)
+{
+	return hwicap_remove(&pdev->dev);
+}
+
+static struct platform_driver hwicap_platform_driver =3D {
+	.probe =3D hwicap_drv_probe,
+	.remove =3D hwicap_drv_remove,
+	.driver =3D {
+		.owner =3D THIS_MODULE,
+		.name =3D DRIVER_NAME,
+	},
+};
+
+/* =
---------------------------------------------------------------------
+ * OF bus binding
+ */
+
+#if defined(CONFIG_OF)
+static int __devinit
+hwicap_of_probe(struct of_device *op, const struct of_device_id *match)
+{
+	struct resource res;
+	const unsigned int *id;
+	const char *family;
+	int rc;
+	const struct hwicap_driver_config *config =3D match->data;
+	const struct config_registers *regs;
+
+	dev_dbg(&op->dev, "hwicap_of_probe(%p, %p)\n", op, match);
+
+	rc =3D of_address_to_resource(op->node, 0, &res);
+	if (rc) {
+		dev_err(&op->dev, "invalid address\n");
+		return rc;
+	}
+
+	id =3D of_get_property(op->node, "port-number", NULL);
+
+	/* It's most likely that we're using V4, if the family is not
+	   specified */
+	regs =3D &v4_config_registers;
+	family =3D of_get_property(op->node, "xlnx,family", NULL);
+
+	if (family) {
+		if (!strcmp(family, "virtex2p")) {
+			regs =3D &v2_config_registers;
+		} else if (!strcmp(family, "virtex4")) {
+			regs =3D &v4_config_registers;
+		} else if (!strcmp(family, "virtex5")) {
+			regs =3D &v5_config_registers;
+		}
+	}
+	return hwicap_setup(&op->dev, id ? *id : -1, &res, config,
+			regs);
+}
+
+static int __devexit hwicap_of_remove(struct of_device *op)
+{
+	return hwicap_remove(&op->dev);
+}
+
+/* Match table for of_platform binding */
+static const struct of_device_id __devinit hwicap_of_match[] =3D {
+	{ .compatible =3D "xlnx,opb-hwicap-1.00.b", .data =3D =
&buffer_icap_config},
+	{ .compatible =3D "xlnx,xps-hwicap-1.00.a", .data =3D =
&fifo_icap_config},
+	{},
+};
+MODULE_DEVICE_TABLE(of, hwicap_of_match);
+
+static struct of_platform_driver hwicap_of_driver =3D {
+	.owner =3D THIS_MODULE,
+	.name =3D DRIVER_NAME,
+	.match_table =3D hwicap_of_match,
+	.probe =3D hwicap_of_probe,
+	.remove =3D __devexit_p(hwicap_of_remove),
+	.driver =3D {
+		.name =3D DRIVER_NAME,
+	},
+};
+
+/* Registration helpers to keep the number of #ifdefs to a minimum */
+static inline int __devinit hwicap_of_register(void)
+{
+	pr_debug("hwicap: calling of_register_platform_driver()\n");
+	return of_register_platform_driver(&hwicap_of_driver);
+}
+
+static inline void __devexit hwicap_of_unregister(void)
+{
+	of_unregister_platform_driver(&hwicap_of_driver);
+}
+#else /* CONFIG_OF */
+/* CONFIG_OF not enabled; do nothing helpers */
+static inline int __devinit hwicap_of_register(void) { return 0; }
+static inline void __devexit hwicap_of_unregister(void) { }
+#endif /* CONFIG_OF */
+
+static int __devinit hwicap_module_init(void)
+{
+	dev_t devt;
+	int retval;
+
+	icap_class =3D class_create(THIS_MODULE, "xilinx_config");
+
+	if (xhwicap_major) {
+		devt =3D MKDEV(xhwicap_major, xhwicap_minor);
+		retval =3D register_chrdev_region(
+				devt,
+				HWICAP_DEVICES,
+				DRIVER_NAME);
+		if (retval < 0)
+			return retval;
+	} else {
+		retval =3D alloc_chrdev_region(&devt,
+				xhwicap_minor,
+				HWICAP_DEVICES,
+				DRIVER_NAME);
+		if (retval < 0)
+			return retval;
+		xhwicap_major =3D MAJOR(devt);
+	}
+
+	retval =3D platform_driver_register(&hwicap_platform_driver);
+
+	if (retval)
+		goto failed1;
+
+	retval =3D hwicap_of_register();
+
+	if (retval)
+		goto failed2;
+
+	return retval;
+
+ failed2:
+	platform_driver_unregister(&hwicap_platform_driver);
+
+ failed1:
+	unregister_chrdev_region(devt, HWICAP_DEVICES);
+
+	return retval;
+}
+
+static void __devexit hwicap_module_cleanup(void)
+{
+	dev_t devt =3D MKDEV(xhwicap_major, xhwicap_minor);
+
+	class_destroy(icap_class);
+
+	platform_driver_unregister(&hwicap_platform_driver);
+
+	hwicap_of_unregister();
+
+	unregister_chrdev_region(devt, HWICAP_DEVICES);
+}
+
+module_init(hwicap_module_init);
+module_exit(hwicap_module_cleanup);
+
+MODULE_AUTHOR("Xilinx, Inc; Xilinx Research Labs Group");
+MODULE_DESCRIPTION("Xilinx ICAP Port Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.h =
b/drivers/char/xilinx_hwicap/xilinx_hwicap.h
new file mode 100644
index 0000000..b6b47d0
--- /dev/null
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.h
@@ -0,0 +1,193 @@
+/***********************************************************************=
******
+ *
+ *     Author: Xilinx, Inc.
+ *
+ *     This program is free software; you can redistribute it and/or =
modify it
+ *     under the terms of the GNU General Public License as published =
by the
+ *     Free Software Foundation; either version 2 of the License, or =
(at your
+ *     option) any later version.
+ *
+ *     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
+ *     AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND
+ *     SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,
+ *     OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,
+ *     APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION
+ *     THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF =
INFRINGEMENT,
+ *     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE
+ *     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY
+ *     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
+ *     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
+ *     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
+ *     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
+ *     FOR A PARTICULAR PURPOSE.
+ *
+ *     Xilinx products are not intended for use in life support =
appliances,
+ *     devices, or systems. Use in such applications is expressly =
prohibited.
+ *
+ *     (c) Copyright 2003-2007 Xilinx Inc.
+ *     All rights reserved.
+ *
+ *     You should have received a copy of the GNU General Public =
License along
+ *     with this program; if not, write to the Free Software =
Foundation, Inc.,
+ *     675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ =
*************************************************************************=
****/
+
+#ifndef XILINX_HWICAP_H_	/* prevent circular inclusions */
+#define XILINX_HWICAP_H_	/* by using protection macros */
+
+#include <linux/types.h>
+#include <linux/cdev.h>
+#include <linux/version.h>
+#include <linux/platform_device.h>
+
+#include <asm/io.h>
+
+struct hwicap_drvdata {
+	u32 write_buffer_in_use;  /* Always in [0,3] */
+	u8 write_buffer[4];
+	u32 read_buffer_in_use;	  /* Always in [0,3] */
+	u8 read_buffer[4];
+	u32 mem_start;		  /* phys. address of the control registers */
+	u32 mem_end;		  /* phys. address of the control registers */
+	u32 mem_size;
+	void __iomem *base_address;/* virt. address of the control registers =
*/
+
+	struct device *dev;
+	struct cdev cdev;	/* Char device structure */
+	dev_t devt;
+
+	const struct hwicap_driver_config *config;
+	const struct config_registers *config_regs;
+	void *private_data;
+	bool is_open;
+	bool is_accessing;
+};
+
+struct hwicap_driver_config {
+	int (*get_configuration)(struct hwicap_drvdata *drvdata, u32 *data,
+			u32 size);
+	int (*set_configuration)(struct hwicap_drvdata *drvdata, u32 *data,
+			u32 size);
+	void (*reset)(struct hwicap_drvdata *drvdata);
+};
+
+/* Number of times to poll the done regsiter */
+#define XHI_MAX_RETRIES     10
+
+/************ Constant Definitions *************/
+
+#define XHI_PAD_FRAMES              0x1
+
+/* Mask for calculating configuration packet headers */
+#define XHI_WORD_COUNT_MASK_TYPE_1  0x7FFUL
+#define XHI_WORD_COUNT_MASK_TYPE_2  0x1FFFFFUL
+#define XHI_TYPE_MASK               0x7
+#define XHI_REGISTER_MASK           0xF
+#define XHI_OP_MASK                 0x3
+
+#define XHI_TYPE_SHIFT              29
+#define XHI_REGISTER_SHIFT          13
+#define XHI_OP_SHIFT                27
+
+#define XHI_TYPE_1                  1
+#define XHI_TYPE_2                  2
+#define XHI_OP_WRITE                2
+#define XHI_OP_READ                 1
+
+/* Address Block Types */
+#define XHI_FAR_CLB_BLOCK           0
+#define XHI_FAR_BRAM_BLOCK          1
+#define XHI_FAR_BRAM_INT_BLOCK      2
+
+struct config_registers {
+	u32 CRC;
+	u32 FAR;
+	u32 FDRI;
+	u32 FDRO;
+	u32 CMD;
+	u32 CTL;
+	u32 MASK;
+	u32 STAT;
+	u32 LOUT;
+	u32 COR;
+	u32 MFWR;
+	u32 FLR;
+	u32 KEY;
+	u32 CBC;
+	u32 IDCODE;
+	u32 AXSS;
+	u32 C0R_1;
+	u32 CSOB;
+	u32 WBSTAR;
+	u32 TIMER;
+	u32 BOOTSTS;
+	u32 CTL_1;
+};
+
+/* Configuration Commands */
+#define XHI_CMD_NULL                0
+#define XHI_CMD_WCFG                1
+#define XHI_CMD_MFW                 2
+#define XHI_CMD_DGHIGH              3
+#define XHI_CMD_RCFG                4
+#define XHI_CMD_START               5
+#define XHI_CMD_RCAP                6
+#define XHI_CMD_RCRC                7
+#define XHI_CMD_AGHIGH              8
+#define XHI_CMD_SWITCH              9
+#define XHI_CMD_GRESTORE            10
+#define XHI_CMD_SHUTDOWN            11
+#define XHI_CMD_GCAPTURE            12
+#define XHI_CMD_DESYNCH             13
+#define XHI_CMD_IPROG               15 /* Only in Virtex5 */
+#define XHI_CMD_CRCC                16 /* Only in Virtex5 */
+#define XHI_CMD_LTIMER              17 /* Only in Virtex5 */
+
+/* Packet constants */
+#define XHI_SYNC_PACKET             0xAA995566UL
+#define XHI_DUMMY_PACKET            0xFFFFFFFFUL
+#define XHI_NOOP_PACKET             (XHI_TYPE_1 << XHI_TYPE_SHIFT)
+#define XHI_TYPE_2_READ ((XHI_TYPE_2 << XHI_TYPE_SHIFT) | \
+			(XHI_OP_READ << XHI_OP_SHIFT))
+
+#define XHI_TYPE_2_WRITE ((XHI_TYPE_2 << XHI_TYPE_SHIFT) | \
+			(XHI_OP_WRITE << XHI_OP_SHIFT))
+
+#define XHI_TYPE2_CNT_MASK          0x07FFFFFF
+
+#define XHI_TYPE_1_PACKET_MAX_WORDS 2047UL
+#define XHI_TYPE_1_HEADER_BYTES     4
+#define XHI_TYPE_2_HEADER_BYTES     8
+
+/* Constant to use for CRC check when CRC has been disabled */
+#define XHI_DISABLED_AUTO_CRC       0x0000DEFCUL
+
+/**
+ * hwicap_type_1_read: Generates a Type 1 read packet header.
+ * @parameter: Register is the address of the register to be read back.
+ *
+ * Generates a Type 1 read packet header, which is used to indirectly
+ * read registers in the configuration logic.  This packet must then
+ * be sent through the icap device, and a return packet received with
+ * the information.
+ **/
+static inline u32 hwicap_type_1_read(u32 Register)
+{
+	return (XHI_TYPE_1 << XHI_TYPE_SHIFT) |
+		(Register << XHI_REGISTER_SHIFT) |
+		(XHI_OP_READ << XHI_OP_SHIFT);
+}
+
+/**
+ * hwicap_type_1_write: Generates a Type 1 write packet header
+ * @parameter: Register is the address of the register to be read back.
+ **/
+static inline u32 hwicap_type_1_write(u32 Register)
+{
+	return (XHI_TYPE_1 << XHI_TYPE_SHIFT) |
+		(Register << XHI_REGISTER_SHIFT) |
+		(XHI_OP_WRITE << XHI_OP_SHIFT);
+}
+
+#endif
--=20
1.5.3.4-dirty




------_=_NextPart_001_01C8648F.A2858A7F
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7652.24">
<TITLE>RE: [PATCH] [POWERPC] Xilinx: hwicap driver</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->
<BR>

<P><FONT SIZE=3D2>Nevermind... I posted this too fast and screwed up the =
spinlocks.<BR>
<BR>
-----Original Message-----<BR>
From: Stephen Neuendorffer [<A =
HREF=3D"mailto:stephen.neuendorffer@xilinx.com">mailto:stephen.neuendorff=
er@xilinx.com</A>]<BR>
Sent: Thu 1/31/2008 5:02 PM<BR>
To: linuxppc-dev@ozlabs.org; grant.likely@secretlab.ca; =
jacmet@sunsite.dk<BR>
Cc: Stephen Neuendorffer<BR>
Subject: [PATCH] [POWERPC] Xilinx: hwicap driver<BR>
<BR>
This includes code for new fifo-based xps_hwicap in addition to the<BR>
older opb_hwicap, which has a significantly different interface.&nbsp; =
The<BR>
common code between the two drivers is largely shared.<BR>
<BR>
Significant differences exists between this driver and what is<BR>
supported in the EDK drivers.&nbsp; In particular, most of the<BR>
architecture-specific code for reconfiguring individual FPGA =
resources<BR>
has been removed.&nbsp; This functionality is likely better provided in =
a<BR>
user-space support library.&nbsp; In addition, read and write access =
is<BR>
supported.&nbsp; In addition, although the xps_hwicap cores support<BR>
interrupt-driver mode, this driver only supports polled operation, =
in<BR>
order to make the code simpler, and since the interrupt processing<BR>
overhead is likely to slow down the throughput under Linux.<BR>
<BR>
Signed-off-by: Stephen Neuendorffer =
&lt;stephen.neuendorffer@xilinx.com&gt;<BR>
<BR>
Fixed to add spinlocks, and a few style issues.<BR>
---<BR>
&nbsp;drivers/char/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp; 7 +<BR>
&nbsp;drivers/char/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; |&nbsp;&nbsp;&nbsp; 1 +<BR>
&nbsp;drivers/char/xilinx_hwicap/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; |&nbsp;&nbsp;&nbsp; 7 +<BR>
&nbsp;drivers/char/xilinx_hwicap/buffer_icap.c&nbsp;&nbsp; |&nbsp; 380 =
++++++++++++<BR>
&nbsp;drivers/char/xilinx_hwicap/buffer_icap.h&nbsp;&nbsp; |&nbsp;&nbsp; =
57 ++<BR>
&nbsp;drivers/char/xilinx_hwicap/fifo_icap.c&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp; 381 ++++++++++++<BR>
&nbsp;drivers/char/xilinx_hwicap/fifo_icap.h&nbsp;&nbsp;&nbsp;&nbsp; =
|&nbsp;&nbsp; 62 ++<BR>
&nbsp;drivers/char/xilinx_hwicap/xilinx_hwicap.c |&nbsp; 912 =
++++++++++++++++++++++++++++<BR>
&nbsp;drivers/char/xilinx_hwicap/xilinx_hwicap.h |&nbsp; 193 ++++++<BR>
&nbsp;9 files changed, 2000 insertions(+), 0 deletions(-)<BR>
&nbsp;create mode 100644 drivers/char/xilinx_hwicap/Makefile<BR>
&nbsp;create mode 100644 drivers/char/xilinx_hwicap/buffer_icap.c<BR>
&nbsp;create mode 100644 drivers/char/xilinx_hwicap/buffer_icap.h<BR>
&nbsp;create mode 100644 drivers/char/xilinx_hwicap/fifo_icap.c<BR>
&nbsp;create mode 100644 drivers/char/xilinx_hwicap/fifo_icap.h<BR>
&nbsp;create mode 100644 drivers/char/xilinx_hwicap/xilinx_hwicap.c<BR>
&nbsp;create mode 100644 drivers/char/xilinx_hwicap/xilinx_hwicap.h<BR>
<BR>
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig<BR>
index ef1ed5d..157ae2a 100644<BR>
--- a/drivers/char/Kconfig<BR>
+++ b/drivers/char/Kconfig<BR>
@@ -831,6 +831,13 @@ config DTLK<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; To compile this driver =
as a module, choose M here: the<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; module will be called =
dtlk.<BR>
<BR>
+config XILINX_HWICAP<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tristate &quot;Xilinx HWICAP =
Support&quot;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; depends on XILINX_VIRTEX<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; help<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; This option enables support =
for Xilinx Internal Configuration<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; Access Port (ICAP) =
driver.<BR>
+<BR>
&nbsp;config R3964<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tristate &quot;Siemens R3964 =
line discipline&quot;<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ---help---<BR>
diff --git a/drivers/char/Makefile b/drivers/char/Makefile<BR>
index 07304d5..3a278a0 100644<BR>
--- a/drivers/char/Makefile<BR>
+++ b/drivers/char/Makefile<BR>
@@ -76,6 +76,7 @@ obj-$(CONFIG_EFI_RTC) =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +=3D efirtc.o<BR>
&nbsp;obj-$(CONFIG_SGI_DS1286)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +=3D =
ds1286.o<BR>
&nbsp;obj-$(CONFIG_SGI_IP27_RTC)&nbsp;&nbsp;&nbsp;&nbsp; +=3D =
ip27-rtc.o<BR>
&nbsp;obj-$(CONFIG_DS1302)&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; +=3D ds1302.o<BR>
+obj-$(CONFIG_XILINX_HWICAP)&nbsp;&nbsp;&nbsp; +=3D xilinx_hwicap/<BR>
&nbsp;ifeq ($(CONFIG_GENERIC_NVRAM),y)<BR>
&nbsp;&nbsp; obj-$(CONFIG_NVRAM)&nbsp; +=3D generic_nvram.o<BR>
&nbsp;else<BR>
diff --git a/drivers/char/xilinx_hwicap/Makefile =
b/drivers/char/xilinx_hwicap/Makefile<BR>
new file mode 100644<BR>
index 0000000..5491cbc<BR>
--- /dev/null<BR>
+++ b/drivers/char/xilinx_hwicap/Makefile<BR>
@@ -0,0 +1,7 @@<BR>
+#<BR>
+# Makefile for the Xilinx OPB hwicap driver<BR>
+#<BR>
+<BR>
+obj-$(CONFIG_XILINX_HWICAP) +=3D xilinx_hwicap_m.o<BR>
+<BR>
+xilinx_hwicap_m-y :=3D xilinx_hwicap.o fifo_icap.o buffer_icap.o<BR>
diff --git a/drivers/char/xilinx_hwicap/buffer_icap.c =
b/drivers/char/xilinx_hwicap/buffer_icap.c<BR>
new file mode 100644<BR>
index 0000000..dfea2bd<BR>
--- /dev/null<BR>
+++ b/drivers/char/xilinx_hwicap/buffer_icap.c<BR>
@@ -0,0 +1,380 @@<BR>
+/***********************************************************************=
******<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; Author: Xilinx, Inc.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; This program is free software; you can =
redistribute it and/or modify it<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; under the terms of the GNU General Public =
License as published by the<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; Free Software Foundation; either version 2 =
of the License, or (at your<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; option) any later version.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; XILINX IS PROVIDING THIS DESIGN, CODE, OR =
INFORMATION &quot;AS IS&quot;<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; AS A COURTESY TO YOU, SOLELY FOR USE IN =
DEVELOPING PROGRAMS AND<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; SOLUTIONS FOR XILINX DEVICES.&nbsp; BY =
PROVIDING THIS DESIGN, CODE,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; OR INFORMATION AS ONE POSSIBLE =
IMPLEMENTATION OF THIS FEATURE,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; APPLICATION OR STANDARD, XILINX IS MAKING NO =
REPRESENTATION<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; THAT THIS IMPLEMENTATION IS FREE FROM ANY =
CLAIMS OF INFRINGEMENT,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; AND YOU ARE RESPONSIBLE FOR OBTAINING ANY =
RIGHTS YOU MAY REQUIRE<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; FOR YOUR IMPLEMENTATION.&nbsp; XILINX =
EXPRESSLY DISCLAIMS ANY<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; WARRANTY WHATSOEVER WITH RESPECT TO THE =
ADEQUACY OF THE<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO =
ANY WARRANTIES OR<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; REPRESENTATIONS THAT THIS IMPLEMENTATION IS =
FREE FROM CLAIMS OF<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; INFRINGEMENT, IMPLIED WARRANTIES OF =
MERCHANTABILITY AND FITNESS<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; FOR A PARTICULAR PURPOSE.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; Xilinx products are not intended for use in =
life support appliances,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; devices, or systems. Use in such =
applications is expressly prohibited.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; (c) Copyright 2003-2008 Xilinx Inc.<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; All rights reserved.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; You should have received a copy of the GNU =
General Public License along<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; with this program; if not, write to the Free =
Software Foundation, Inc.,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; 675 Mass Ave, Cambridge, MA 02139, USA.<BR>
+ *<BR>
+ =
*************************************************************************=
****/<BR>
+<BR>
+#include &quot;buffer_icap.h&quot;<BR>
+<BR>
+/* Indicates how many bytes will fit in a buffer. (1 BRAM) */<BR>
+#define XHI_MAX_BUFFER_BYTES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
2048<BR>
+#define =
XHI_MAX_BUFFER_INTS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(XHI_MAX_BUFFER_BYTES &gt;&gt; 2)<BR>
+<BR>
+/* File access and error constants */<BR>
+#define XHI_DEVICE_READ_ERROR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
-1<BR>
+#define XHI_DEVICE_WRITE_ERROR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -2<BR>
+#define XHI_BUFFER_OVERFLOW_ERROR&nbsp;&nbsp; -3<BR>
+<BR>
+#define =
XHI_DEVICE_READ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x1<BR>
+#define =
XHI_DEVICE_WRITE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x0<BR>
+<BR>
+/* Constants for checking transfer status */<BR>
+#define =
XHI_CYCLE_DONE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0<BR>
+#define =
XHI_CYCLE_EXECUTING&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1<BR>
+<BR>
+/* buffer_icap register offsets */<BR>
+<BR>
+/* Size of transfer, read &amp; write */<BR>
+#define XHI_SIZE_REG_OFFSET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x800L<BR>
+/* offset into bram, read &amp; write */<BR>
+#define XHI_BRAM_OFFSET_REG_OFFSET 0x804L<BR>
+/* Read not Configure, direction of transfer.&nbsp; Write only */<BR>
+#define =
XHI_RNC_REG_OFFSET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x808L<BR>
+/* Indicates transfer complete. Read only */<BR>
+#define XHI_STATUS_REG_OFFSET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x80CL<BR>
+<BR>
+/* Constants for setting the RNC register */<BR>
+#define =
XHI_CONFIGURE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 0x0UL<BR>
+#define =
XHI_READBACK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 0x1UL<BR>
+<BR>
+/* Constants for the Done register */<BR>
+#define =
XHI_NOT_FINISHED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; 0x0UL<BR>
+#define =
XHI_FINISHED&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; 0x1UL<BR>
+<BR>
+#define XHI_BUFFER_START 0<BR>
+<BR>
+/**<BR>
+ * buffer_icap_get_status: Get the contents of the status register.<BR>
+ * @parameter base_address: is the base address of the device<BR>
+ *<BR>
+ * The status register contains the ICAP status and the done bit.<BR>
+ *<BR>
+ * D8 - cfgerr<BR>
+ * D7 - dalign<BR>
+ * D6 - rip<BR>
+ * D5 - in_abort_l<BR>
+ * D4 - Always 1<BR>
+ * D3 - Always 1<BR>
+ * D2 - Always 1<BR>
+ * D1 - Always 1<BR>
+ * D0 - Done bit<BR>
+ **/<BR>
+static inline u32 buffer_icap_get_status(void __iomem =
*base_address)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return in_be32(base_address + =
XHI_STATUS_REG_OFFSET);<BR>
+}<BR>
+<BR>
+/**<BR>
+ * buffer_icap_get_bram: Reads data from the storage buffer bram.<BR>
+ * @parameter base_address: contains the base address of the =
component.<BR>
+ * @parameter offset: The word offset from which the data should be =
read.<BR>
+ *<BR>
+ * A bram is used as a configuration memory cache.&nbsp; One frame of =
data can<BR>
+ * be stored in this &quot;storage buffer&quot;.<BR>
+ **/<BR>
+static inline u32 buffer_icap_get_bram(void __iomem *base_address,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 offset)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return in_be32(base_address + =
(offset &lt;&lt; 2));<BR>
+}<BR>
+<BR>
+/**<BR>
+ * buffer_icap_busy: Return true if the icap device is busy<BR>
+ * @parameter base_address: is the base address of the device<BR>
+ *<BR>
+ * The queries the low order bit of the status register, which<BR>
+ * indicates whether the current configuration or readback =
operation<BR>
+ * has completed.<BR>
+ **/<BR>
+static inline bool buffer_icap_busy(void __iomem *base_address)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
(buffer_icap_get_status(base_address) &amp; 1) =3D=3D =
XHI_NOT_FINISHED;<BR>
+}<BR>
+<BR>
+/**<BR>
+ * buffer_icap_busy: Return true if the icap device is not busy<BR>
+ * @parameter base_address: is the base address of the device<BR>
+ *<BR>
+ * The queries the low order bit of the status register, which<BR>
+ * indicates whether the current configuration or readback =
operation<BR>
+ * has completed.<BR>
+ **/<BR>
+static inline bool buffer_icap_done(void __iomem *base_address)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
(buffer_icap_get_status(base_address) &amp; 1) =3D=3D XHI_FINISHED;<BR>
+}<BR>
+<BR>
+/**<BR>
+ * buffer_icap_set_size: Set the size register.<BR>
+ * @parameter base_address: is the base address of the device<BR>
+ * @parameter data: The size in bytes.<BR>
+ *<BR>
+ * The size register holds the number of 8 bit bytes to transfer =
between<BR>
+ * bram and the icap (or icap to bram).<BR>
+ **/<BR>
+static inline void buffer_icap_set_size(void __iomem *base_address,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 data)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out_be32(base_address + =
XHI_SIZE_REG_OFFSET, data);<BR>
+}<BR>
+<BR>
+/**<BR>
+ * buffer_icap_mSetoffsetReg: Set the bram offset register.<BR>
+ * @parameter base_address: contains the base address of the =
device.<BR>
+ * @parameter data: is the value to be written to the data =
register.<BR>
+ *<BR>
+ * The bram offset register holds the starting bram address to =
transfer<BR>
+ * data from during configuration or write data to during readback.<BR>
+ **/<BR>
+static inline void buffer_icap_set_offset(void __iomem =
*base_address,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 data)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out_be32(base_address + =
XHI_BRAM_OFFSET_REG_OFFSET, data);<BR>
+}<BR>
+<BR>
+/**<BR>
+ * buffer_icap_set_rnc: Set the RNC (Readback not Configure) =
register.<BR>
+ * @parameter base_address: contains the base address of the =
device.<BR>
+ * @parameter data: is the value to be written to the data =
register.<BR>
+ *<BR>
+ * The RNC register determines the direction of the data =
transfer.&nbsp; It<BR>
+ * controls whether a configuration or readback take place.&nbsp; =
Writing to<BR>
+ * this register initiates the transfer.&nbsp; A value of 1 initiates =
a<BR>
+ * readback while writing a value of 0 initiates a configuration.<BR>
+ **/<BR>
+static inline void buffer_icap_set_rnc(void __iomem *base_address,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 data)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out_be32(base_address + =
XHI_RNC_REG_OFFSET, data);<BR>
+}<BR>
+<BR>
+/**<BR>
+ * buffer_icap_set_bram: Write data to the storage buffer bram.<BR>
+ * @parameter base_address: contains the base address of the =
component.<BR>
+ * @parameter offset: The word offset at which the data should be =
written.<BR>
+ * @parameter data: The value to be written to the bram offset.<BR>
+ *<BR>
+ * A bram is used as a configuration memory cache.&nbsp; One frame of =
data can<BR>
+ * be stored in this &quot;storage buffer&quot;.<BR>
+ **/<BR>
+static inline void buffer_icap_set_bram(void __iomem *base_address,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 offset, u32 data)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out_be32(base_address + (offset =
&lt;&lt; 2), data);<BR>
+}<BR>
+<BR>
+/**<BR>
+ * buffer_icap_device_read: Transfer bytes from ICAP to the storage =
buffer.<BR>
+ * @parameter drvdata: a pointer to the drvdata.<BR>
+ * @parameter offset: The storage buffer start address.<BR>
+ * @parameter count: The number of words (32 bit) to read from the<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device =
(ICAP).<BR>
+ **/<BR>
+static int buffer_icap_device_read(struct hwicap_drvdata *drvdata,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 offset, u32 count)<BR>
+{<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s32 retries =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void __iomem *base_address =3D =
drvdata-&gt;base_address;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(buffer_icap_busy(base_address))<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EBUSY;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((offset + count) &gt; =
XHI_MAX_BUFFER_INTS)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* setSize count*4 to get bytes. =
*/<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_icap_set_size(base_address, =
(count &lt;&lt; 2));<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
buffer_icap_set_offset(base_address, offset);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_icap_set_rnc(base_address, =
XHI_READBACK);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while =
(buffer_icap_busy(base_address)) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retries++;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retries &gt; =
XHI_MAX_RETRIES)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EBUSY;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>
+<BR>
+};<BR>
+<BR>
+/**<BR>
+ * buffer_icap_device_write: Transfer bytes from ICAP to the storage =
buffer.<BR>
+ * @parameter drvdata: a pointer to the drvdata.<BR>
+ * @parameter offset: The storage buffer start address.<BR>
+ * @parameter count: The number of words (32 bit) to read from the<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device =
(ICAP).<BR>
+ **/<BR>
+static int buffer_icap_device_write(struct hwicap_drvdata *drvdata,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 offset, u32 count)<BR>
+{<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s32 retries =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void __iomem *base_address =3D =
drvdata-&gt;base_address;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(buffer_icap_busy(base_address))<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EBUSY;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((offset + count) &gt; =
XHI_MAX_BUFFER_INTS)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* setSize count*4 to get bytes. =
*/<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_icap_set_size(base_address, =
count &lt;&lt; 2);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
buffer_icap_set_offset(base_address, offset);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_icap_set_rnc(base_address, =
XHI_CONFIGURE);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while =
(buffer_icap_busy(base_address)) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retries++;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retries &gt; =
XHI_MAX_RETRIES)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EBUSY;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>
+<BR>
+};<BR>
+<BR>
+/**<BR>
+ * buffer_icap_reset: Reset the logic of the icap device.<BR>
+ * @parameter drvdata: a pointer to the drvdata.<BR>
+ *<BR>
+ * Writing to the status register resets the ICAP logic in an =
internal<BR>
+ * version of the core.&nbsp; For the version of the core published in =
EDK,<BR>
+ * this is a noop.<BR>
+ **/<BR>
+void buffer_icap_reset(struct hwicap_drvdata *drvdata)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp; out_be32(drvdata-&gt;base_address + =
XHI_STATUS_REG_OFFSET, 0xFEFE);<BR>
+}<BR>
+<BR>
+/**<BR>
+ * buffer_icap_set_configuration: Load a partial bitstream from system =
memory.<BR>
+ * @parameter drvdata: a pointer to the drvdata.<BR>
+ * @parameter data: Kernel address of the partial bitstream.<BR>
+ * @parameter size: the size of the partial bitstream in 32 bit =
words.<BR>
+ **/<BR>
+int buffer_icap_set_configuration(struct hwicap_drvdata *drvdata, u32 =
*data,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; u32 =
size)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int status;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s32 buffer_count =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s32 num_writes =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool dirty =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 i;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void __iomem *base_address =3D =
drvdata-&gt;base_address;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Loop through all the data =
*/<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0, buffer_count =3D 0; =
i &lt; size; i++) {<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Copy data to bram */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
buffer_icap_set_bram(base_address, buffer_count, data[i]);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dirty =3D 1;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (buffer_count &lt; =
XHI_MAX_BUFFER_INTS - 1) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_count++;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Write data to ICAP */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D =
buffer_icap_device_write(<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; XHI_BUFFER_START,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; XHI_MAX_BUFFER_INTS);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status !=3D 0) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* abort. */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
buffer_icap_reset(drvdata);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_count =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_writes++;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dirty =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Write unwritten data to ICAP =
*/<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dirty) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Write data to ICAP */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D =
buffer_icap_device_write(drvdata, XHI_BUFFER_START,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; =
buffer_count);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status !=3D 0) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* abort. */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
buffer_icap_reset(drvdata);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>
+};<BR>
+<BR>
+/**<BR>
+ * buffer_icap_get_configuration: Read configuration data from the =
device.<BR>
+ * @parameter drvdata: a pointer to the drvdata.<BR>
+ * @parameter data: Address of the data representing the partial =
bitstream<BR>
+ * @parameter size: the size of the partial bitstream in 32 bit =
words.<BR>
+ **/<BR>
+int buffer_icap_get_configuration(struct hwicap_drvdata *drvdata, u32 =
*data,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; u32 =
size)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int status;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s32 buffer_count =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s32 read_count =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 i;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void __iomem *base_address =3D =
drvdata-&gt;base_address;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Loop through all the data =
*/<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0, buffer_count =3D =
XHI_MAX_BUFFER_INTS; i &lt; size; i++) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (buffer_count =3D=3D =
XHI_MAX_BUFFER_INTS) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 words_remaining =3D size =
- i;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 words_to_read =3D<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; words_remaining &lt;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; XHI_MAX_BUFFER_INTS ? =
words_remaining :<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; XHI_MAX_BUFFER_INTS;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Read data from ICAP */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D =
buffer_icap_device_read(<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; XHI_BUFFER_START,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; words_to_read);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status !=3D 0) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* abort. */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
buffer_icap_reset(drvdata);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_count =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read_count++;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Copy data from bram */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; data[i] =3D =
buffer_icap_get_bram(base_address, buffer_count);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer_count++;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>
+};<BR>
diff --git a/drivers/char/xilinx_hwicap/buffer_icap.h =
b/drivers/char/xilinx_hwicap/buffer_icap.h<BR>
new file mode 100644<BR>
index 0000000..0318495<BR>
--- /dev/null<BR>
+++ b/drivers/char/xilinx_hwicap/buffer_icap.h<BR>
@@ -0,0 +1,57 @@<BR>
+/***********************************************************************=
******<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; Author: Xilinx, Inc.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; This program is free software; you can =
redistribute it and/or modify it<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; under the terms of the GNU General Public =
License as published by the<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; Free Software Foundation; either version 2 =
of the License, or (at your<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; option) any later version.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; XILINX IS PROVIDING THIS DESIGN, CODE, OR =
INFORMATION &quot;AS IS&quot;<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; AS A COURTESY TO YOU, SOLELY FOR USE IN =
DEVELOPING PROGRAMS AND<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; SOLUTIONS FOR XILINX DEVICES.&nbsp; BY =
PROVIDING THIS DESIGN, CODE,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; OR INFORMATION AS ONE POSSIBLE =
IMPLEMENTATION OF THIS FEATURE,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; APPLICATION OR STANDARD, XILINX IS MAKING NO =
REPRESENTATION<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; THAT THIS IMPLEMENTATION IS FREE FROM ANY =
CLAIMS OF INFRINGEMENT,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; AND YOU ARE RESPONSIBLE FOR OBTAINING ANY =
RIGHTS YOU MAY REQUIRE<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; FOR YOUR IMPLEMENTATION.&nbsp; XILINX =
EXPRESSLY DISCLAIMS ANY<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; WARRANTY WHATSOEVER WITH RESPECT TO THE =
ADEQUACY OF THE<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO =
ANY WARRANTIES OR<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; REPRESENTATIONS THAT THIS IMPLEMENTATION IS =
FREE FROM CLAIMS OF<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; INFRINGEMENT, IMPLIED WARRANTIES OF =
MERCHANTABILITY AND FITNESS<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; FOR A PARTICULAR PURPOSE.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; Xilinx products are not intended for use in =
life support appliances,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; devices, or systems. Use in such =
applications is expressly prohibited.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; (c) Copyright 2003-2008 Xilinx Inc.<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; All rights reserved.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; You should have received a copy of the GNU =
General Public License along<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; with this program; if not, write to the Free =
Software Foundation, Inc.,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; 675 Mass Ave, Cambridge, MA 02139, USA.<BR>
+ *<BR>
+ =
*************************************************************************=
****/<BR>
+<BR>
+#ifndef XILINX_BUFFER_ICAP_H_&nbsp; /* prevent circular inclusions =
*/<BR>
+#define XILINX_BUFFER_ICAP_H_&nbsp; /* by using protection macros =
*/<BR>
+<BR>
+#include &lt;linux/types.h&gt;<BR>
+#include &lt;linux/cdev.h&gt;<BR>
+#include &lt;linux/version.h&gt;<BR>
+#include &lt;linux/platform_device.h&gt;<BR>
+<BR>
+#include &lt;asm/io.h&gt;<BR>
+#include &quot;xilinx_hwicap.h&quot;<BR>
+<BR>
+void buffer_icap_reset(struct hwicap_drvdata *drvdata);<BR>
+<BR>
+/* Loads a partial bitstream from system memory. */<BR>
+int buffer_icap_set_configuration(struct hwicap_drvdata *drvdata, u32 =
*data,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; u32 =
Size);<BR>
+<BR>
+/* Loads a partial bitstream from system memory. */<BR>
+int buffer_icap_get_configuration(struct hwicap_drvdata *drvdata, u32 =
*data,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; u32 =
Size);<BR>
+<BR>
+#endif<BR>
diff --git a/drivers/char/xilinx_hwicap/fifo_icap.c =
b/drivers/char/xilinx_hwicap/fifo_icap.c<BR>
new file mode 100644<BR>
index 0000000..0988314<BR>
--- /dev/null<BR>
+++ b/drivers/char/xilinx_hwicap/fifo_icap.c<BR>
@@ -0,0 +1,381 @@<BR>
+/***********************************************************************=
******<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; Author: Xilinx, Inc.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; This program is free software; you can =
redistribute it and/or modify it<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; under the terms of the GNU General Public =
License as published by the<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; Free Software Foundation; either version 2 =
of the License, or (at your<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; option) any later version.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; XILINX IS PROVIDING THIS DESIGN, CODE, OR =
INFORMATION &quot;AS IS&quot;<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; AS A COURTESY TO YOU, SOLELY FOR USE IN =
DEVELOPING PROGRAMS AND<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; SOLUTIONS FOR XILINX DEVICES.&nbsp; BY =
PROVIDING THIS DESIGN, CODE,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; OR INFORMATION AS ONE POSSIBLE =
IMPLEMENTATION OF THIS FEATURE,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; APPLICATION OR STANDARD, XILINX IS MAKING NO =
REPRESENTATION<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; THAT THIS IMPLEMENTATION IS FREE FROM ANY =
CLAIMS OF INFRINGEMENT,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; AND YOU ARE RESPONSIBLE FOR OBTAINING ANY =
RIGHTS YOU MAY REQUIRE<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; FOR YOUR IMPLEMENTATION.&nbsp; XILINX =
EXPRESSLY DISCLAIMS ANY<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; WARRANTY WHATSOEVER WITH RESPECT TO THE =
ADEQUACY OF THE<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO =
ANY WARRANTIES OR<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; REPRESENTATIONS THAT THIS IMPLEMENTATION IS =
FREE FROM CLAIMS OF<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; INFRINGEMENT, IMPLIED WARRANTIES OF =
MERCHANTABILITY AND FITNESS<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; FOR A PARTICULAR PURPOSE.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; Xilinx products are not intended for use in =
life support appliances,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; devices, or systems. Use in such =
applications is expressly prohibited.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; (c) Copyright 2007-2008 Xilinx Inc.<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; All rights reserved.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; You should have received a copy of the GNU =
General Public License along<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; with this program; if not, write to the Free =
Software Foundation, Inc.,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; 675 Mass Ave, Cambridge, MA 02139, USA.<BR>
+ *<BR>
+ =
*************************************************************************=
****/<BR>
+<BR>
+#include &quot;fifo_icap.h&quot;<BR>
+<BR>
+/* Register offsets for the XHwIcap device. */<BR>
+#define XHI_GIER_OFFSET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x1C&nbsp; /* Device Global Interrupt Enable Reg */<BR>
+#define XHI_IPISR_OFFSET 0x20&nbsp; /* Interrupt Status Register */<BR>
+#define XHI_IPIER_OFFSET 0x28&nbsp; /* Interrupt Enable Register */<BR>
+#define XHI_WF_OFFSET 0x100 /* Write FIFO */<BR>
+#define XHI_RF_OFFSET 0x104 /* Read FIFO */<BR>
+#define XHI_SZ_OFFSET 0x108 /* Size Register */<BR>
+#define XHI_CR_OFFSET 0x10C /* Control Register */<BR>
+#define XHI_SR_OFFSET 0x110 /* Status Register */<BR>
+#define XHI_WFV_OFFSET 0x114 /* Write FIFO Vacancy Register */<BR>
+#define XHI_RFO_OFFSET 0x118 /* Read FIFO Occupancy Register */<BR>
+<BR>
+/* Device Global Interrupt Enable Register (GIER) bit definitions =
*/<BR>
+<BR>
+#define XHI_GIER_GIE_MASK 0x80000000 /* Global Interrupt enable Mask =
*/<BR>
+<BR>
+/**<BR>
+ * HwIcap Device Interrupt Status/Enable Registers<BR>
+ *<BR>
+ * Interrupt Status Register (IPISR) : This register holds the<BR>
+ * interrupt status flags for the device. These bits are toggle on<BR>
+ * write.<BR>
+ *<BR>
+ * Interrupt Enable Register (IPIER) : This register is used to =
enable<BR>
+ * interrupt sources for the device.<BR>
+ * Writing a '1' to a bit enables the corresponding interrupt.<BR>
+ * Writing a '0' to a bit disables the corresponding interrupt.<BR>
+ *<BR>
+ * IPISR/IPIER registers have the same bit definitions and are only =
defined<BR>
+ * once.<BR>
+ */<BR>
+#define XHI_IPIXR_RFULL_MASK 0x00000008 /* Read FIFO Full */<BR>
+#define XHI_IPIXR_WEMPTY_MASK 0x00000004 /* Write FIFO Empty */<BR>
+#define XHI_IPIXR_RDP_MASK 0x00000002 /* Read FIFO half full */<BR>
+#define XHI_IPIXR_WRP_MASK 0x00000001 /* Write FIFO half full */<BR>
+#define XHI_IPIXR_ALL_MASK 0x0000000F /* Mask of all interrupts */<BR>
+<BR>
+/* Control Register (CR) */<BR>
+#define XHI_CR_SW_RESET_MASK 0x00000008 /* SW Reset Mask */<BR>
+#define XHI_CR_FIFO_CLR_MASK 0x00000004 /* FIFO Clear Mask */<BR>
+#define XHI_CR_READ_MASK 0x00000002 /* Read from ICAP to FIFO */<BR>
+#define XHI_CR_WRITE_MASK 0x00000001 /* Write from FIFO to ICAP */<BR>
+<BR>
+/* Status Register (SR) */<BR>
+#define XHI_SR_CFGERR_N_MASK 0x00000100 /* Config Error Mask */<BR>
+#define XHI_SR_DALIGN_MASK 0x00000080 /* Data Alignment Mask */<BR>
+#define XHI_SR_RIP_MASK 0x00000040 /* Read back Mask */<BR>
+#define XHI_SR_IN_ABORT_N_MASK 0x00000020 /* Select Map Abort Mask =
*/<BR>
+#define XHI_SR_DONE_MASK 0x00000001 /* Done bit Mask&nbsp; */<BR>
+<BR>
+<BR>
+#define XHI_WFO_MAX_VACANCY 1024 /* Max Write FIFO Vacancy, in words =
*/<BR>
+#define XHI_RFO_MAX_OCCUPANCY 256 /* Max Read FIFO Occupancy, in words =
*/<BR>
+/* The maximum amount we can request from =
fifo_icap_get_configuration<BR>
+&nbsp;&nbsp; at once, in bytes. */<BR>
+#define XHI_MAX_READ_TRANSACTION_WORDS 0xFFF<BR>
+<BR>
+<BR>
+/**<BR>
+ * fifo_icap_fifo_write: Write data to the write FIFO.<BR>
+ * @parameter drvdata: a pointer to the drvdata.<BR>
+ * @parameter data: the 32-bit value to be written to the FIFO.<BR>
+ *<BR>
+ * This function will silently fail if the fifo is full.<BR>
+ **/<BR>
+static inline void fifo_icap_fifo_write(struct hwicap_drvdata =
*drvdata,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 data)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(drvdata-&gt;dev, =
&quot;fifo_write: %x\n&quot;, data);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out_be32(drvdata-&gt;base_address =
+ XHI_WF_OFFSET, data);<BR>
+}<BR>
+<BR>
+/**<BR>
+ * fifo_icap_fifo_read: Read data from the Read FIFO.<BR>
+ * @parameter drvdata: a pointer to the drvdata.<BR>
+ *<BR>
+ * This function will silently fail if the fifo is empty.<BR>
+ **/<BR>
+static inline u32 fifo_icap_fifo_read(struct hwicap_drvdata =
*drvdata)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 data =3D =
in_be32(drvdata-&gt;base_address + XHI_RF_OFFSET);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(drvdata-&gt;dev, =
&quot;fifo_read: %x\n&quot;, data);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return data;<BR>
+}<BR>
+<BR>
+/**<BR>
+ * fifo_icap_set_read_size: Set the the size register.<BR>
+ * @parameter drvdata: a pointer to the drvdata.<BR>
+ * @parameter data: the size of the following read transaction, in =
words.<BR>
+ **/<BR>
+static inline void fifo_icap_set_read_size(struct hwicap_drvdata =
*drvdata,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 data)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out_be32(drvdata-&gt;base_address =
+ XHI_SZ_OFFSET, data);<BR>
+}<BR>
+<BR>
+/**<BR>
+ * fifo_icap_start_config: Initiate a configuration (write) to the =
device.<BR>
+ * @parameter drvdata: a pointer to the drvdata.<BR>
+ **/<BR>
+static inline void fifo_icap_start_config(struct hwicap_drvdata =
*drvdata)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out_be32(drvdata-&gt;base_address =
+ XHI_CR_OFFSET, XHI_CR_WRITE_MASK);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(drvdata-&gt;dev, =
&quot;configuration started\n&quot;);<BR>
+}<BR>
+<BR>
+/**<BR>
+ * fifo_icap_start_readback: Initiate a readback from the device.<BR>
+ * @parameter drvdata: a pointer to the drvdata.<BR>
+ **/<BR>
+static inline void fifo_icap_start_readback(struct hwicap_drvdata =
*drvdata)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out_be32(drvdata-&gt;base_address =
+ XHI_CR_OFFSET, XHI_CR_READ_MASK);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(drvdata-&gt;dev, =
&quot;readback started\n&quot;);<BR>
+}<BR>
+<BR>
+/**<BR>
+ * fifo_icap_busy: Return true if the ICAP is still processing a =
transaction.<BR>
+ * @parameter drvdata: a pointer to the drvdata.<BR>
+ **/<BR>
+static inline u32 fifo_icap_busy(struct hwicap_drvdata *drvdata)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 status =3D =
in_be32(drvdata-&gt;base_address + XHI_SR_OFFSET);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(drvdata-&gt;dev, =
&quot;Getting status =3D %x\n&quot;, status);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (status &amp; =
XHI_SR_DONE_MASK) ? 0 : 1;<BR>
+}<BR>
+<BR>
+/**<BR>
+ * fifo_icap_write_fifo_vacancy: Query the write fifo available =
space.<BR>
+ * @parameter drvdata: a pointer to the drvdata.<BR>
+ *<BR>
+ * Return the number of words that can be safely pushed into the write =
fifo.<BR>
+ **/<BR>
+static inline u32 fifo_icap_write_fifo_vacancy(<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hwicap_drvdata =
*drvdata)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
in_be32(drvdata-&gt;base_address + XHI_WFV_OFFSET);<BR>
+}<BR>
+<BR>
+/**<BR>
+ * fifo_icap_read_fifo_occupancy: Query the read fifo available =
data.<BR>
+ * @parameter drvdata: a pointer to the drvdata.<BR>
+ *<BR>
+ * Return the number of words that can be safely read from the read =
fifo.<BR>
+ **/<BR>
+static inline u32 fifo_icap_read_fifo_occupancy(<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hwicap_drvdata =
*drvdata)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
in_be32(drvdata-&gt;base_address + XHI_RFO_OFFSET);<BR>
+}<BR>
+<BR>
+/**<BR>
+ * fifo_icap_set_configuration: Send configuration data to the =
ICAP.<BR>
+ * @parameter drvdata: a pointer to the drvdata.<BR>
+ * @parameter frame_buffer: a pointer to the data to be written to =
the<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
ICAP device.<BR>
+ * @parameter num_words: the number of words (32 bit) to write to the =
ICAP<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
device.<BR>
+<BR>
+ * This function writes the given user data to the Write FIFO in<BR>
+ * polled mode and starts the transfer of the data to<BR>
+ * the ICAP device.<BR>
+ **/<BR>
+int fifo_icap_set_configuration(struct hwicap_drvdata *drvdata,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *frame_buffer, u32 =
num_words)<BR>
+{<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 write_fifo_vacancy =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 retries =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 remaining_words;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(drvdata-&gt;dev, =
&quot;fifo_set_configuration\n&quot;);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Check if the ICAP device =
is Busy with the last Read/Write<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fifo_icap_busy(drvdata))<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EBUSY;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Set up the buffer pointer =
and the words to be transferred.<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remaining_words =3D num_words;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (remaining_words &gt; 0) =
{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Wait until we have =
some data in the fifo.<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (write_fifo_vacancy =
=3D=3D 0) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_fifo_vacancy =3D<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
fifo_icap_write_fifo_vacancy(drvdata);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retries++;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retries &gt; =
XHI_MAX_RETRIES)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EIO;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Write data into the =
Write FIFO.<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while ((write_fifo_vacancy =
!=3D 0) &amp;&amp;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (remaining_words &gt; 0)) =
{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fifo_icap_fifo_write(drvdata, =
*frame_buffer);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remaining_words--;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_fifo_vacancy--;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; frame_buffer++;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Start pushing whatever is =
in the FIFO into the ICAP. */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
fifo_icap_start_config(drvdata);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wait until the write has =
finished. */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (fifo_icap_busy(drvdata)) =
{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retries++;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retries &gt; =
XHI_MAX_RETRIES)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(drvdata-&gt;dev, =
&quot;done fifo_set_configuration\n&quot;);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * If the requested number of =
words have not been read from<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the device then indicate =
failure.<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (remaining_words !=3D 0)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EIO;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>
+}<BR>
+<BR>
+/**<BR>
+ * fifo_icap_get_configuration: Read configuration data from the =
device.<BR>
+ * @parameter drvdata: a pointer to the drvdata.<BR>
+ * @parameter data: Address of the data representing the partial =
bitstream<BR>
+ * @parameter size: the size of the partial bitstream in 32 bit =
words.<BR>
+ *<BR>
+ * This function reads the specified number of words from the ICAP =
device in<BR>
+ * the polled mode.<BR>
+ */<BR>
+int fifo_icap_get_configuration(struct hwicap_drvdata *drvdata,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *frame_buffer, u32 =
num_words)<BR>
+{<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 read_fifo_occupancy =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 retries =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *data =3D frame_buffer;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 remaining_words;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 words_to_read;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(drvdata-&gt;dev, =
&quot;fifo_get_configuration\n&quot;);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Check if the ICAP device =
is Busy with the last Write/Read<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fifo_icap_busy(drvdata))<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EBUSY;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remaining_words =3D num_words;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (remaining_words &gt; 0) =
{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; words_to_read =3D =
remaining_words;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The hardware has a limit =
on the number of words<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; that can be read =
at one time.&nbsp; */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (words_to_read &gt; =
XHI_MAX_READ_TRANSACTION_WORDS)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; words_to_read =3D =
XHI_MAX_READ_TRANSACTION_WORDS;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remaining_words -=3D =
words_to_read;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
fifo_icap_set_read_size(drvdata, words_to_read);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
fifo_icap_start_readback(drvdata);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (words_to_read &gt; 0) =
{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Wait until we have some =
data in the fifo. */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (read_fifo_occupancy =
=3D=3D 0) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read_fifo_occupancy =3D<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
fifo_icap_read_fifo_occupancy(drvdata);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retries++;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retries &gt; =
XHI_MAX_RETRIES)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EIO;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (read_fifo_occupancy &gt; =
words_to_read)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read_fifo_occupancy =3D =
words_to_read;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; words_to_read -=3D =
read_fifo_occupancy;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Read the data from the =
Read FIFO. */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (read_fifo_occupancy =
!=3D 0) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *data++ =3D =
fifo_icap_fifo_read(drvdata);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read_fifo_occupancy--;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(drvdata-&gt;dev, =
&quot;done fifo_get_configuration\n&quot;);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>
+}<BR>
+<BR>
+/**<BR>
+ * buffer_icap_reset: Reset the logic of the icap device.<BR>
+ * @parameter drvdata: a pointer to the drvdata.<BR>
+ *<BR>
+ * This function forces the software reset of the complete HWICAP =
device.<BR>
+ * All the registers will return to the default value and the FIFO is =
also<BR>
+ * flushed as a part of this software reset.<BR>
+ */<BR>
+void fifo_icap_reset(struct hwicap_drvdata *drvdata)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 reg_data;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Reset the device by =
setting/clearing the RESET bit in the<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Control Register.<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_data =3D =
in_be32(drvdata-&gt;base_address + XHI_CR_OFFSET);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out_be32(drvdata-&gt;base_address =
+ XHI_CR_OFFSET,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_data | =
XHI_CR_SW_RESET_MASK);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out_be32(drvdata-&gt;base_address =
+ XHI_CR_OFFSET,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_data &amp; =
(~XHI_CR_SW_RESET_MASK));<BR>
+<BR>
+}<BR>
+<BR>
+/**<BR>
+ * fifo_icap_flush_fifo: This function flushes the FIFOs in the =
device.<BR>
+ * @parameter drvdata: a pointer to the drvdata.<BR>
+ */<BR>
+void fifo_icap_flush_fifo(struct hwicap_drvdata *drvdata)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 reg_data;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Flush the FIFO by =
setting/clearing the FIFO Clear bit in the<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Control Register.<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_data =3D =
in_be32(drvdata-&gt;base_address + XHI_CR_OFFSET);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out_be32(drvdata-&gt;base_address =
+ XHI_CR_OFFSET,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_data | =
XHI_CR_FIFO_CLR_MASK);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; out_be32(drvdata-&gt;base_address =
+ XHI_CR_OFFSET,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg_data &amp; =
(~XHI_CR_FIFO_CLR_MASK));<BR>
+}<BR>
+<BR>
diff --git a/drivers/char/xilinx_hwicap/fifo_icap.h =
b/drivers/char/xilinx_hwicap/fifo_icap.h<BR>
new file mode 100644<BR>
index 0000000..4d3068d<BR>
--- /dev/null<BR>
+++ b/drivers/char/xilinx_hwicap/fifo_icap.h<BR>
@@ -0,0 +1,62 @@<BR>
+/***********************************************************************=
******<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; Author: Xilinx, Inc.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; This program is free software; you can =
redistribute it and/or modify it<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; under the terms of the GNU General Public =
License as published by the<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; Free Software Foundation; either version 2 =
of the License, or (at your<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; option) any later version.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; XILINX IS PROVIDING THIS DESIGN, CODE, OR =
INFORMATION &quot;AS IS&quot;<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; AS A COURTESY TO YOU, SOLELY FOR USE IN =
DEVELOPING PROGRAMS AND<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; SOLUTIONS FOR XILINX DEVICES.&nbsp; BY =
PROVIDING THIS DESIGN, CODE,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; OR INFORMATION AS ONE POSSIBLE =
IMPLEMENTATION OF THIS FEATURE,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; APPLICATION OR STANDARD, XILINX IS MAKING NO =
REPRESENTATION<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; THAT THIS IMPLEMENTATION IS FREE FROM ANY =
CLAIMS OF INFRINGEMENT,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; AND YOU ARE RESPONSIBLE FOR OBTAINING ANY =
RIGHTS YOU MAY REQUIRE<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; FOR YOUR IMPLEMENTATION.&nbsp; XILINX =
EXPRESSLY DISCLAIMS ANY<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; WARRANTY WHATSOEVER WITH RESPECT TO THE =
ADEQUACY OF THE<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO =
ANY WARRANTIES OR<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; REPRESENTATIONS THAT THIS IMPLEMENTATION IS =
FREE FROM CLAIMS OF<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; INFRINGEMENT, IMPLIED WARRANTIES OF =
MERCHANTABILITY AND FITNESS<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; FOR A PARTICULAR PURPOSE.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; Xilinx products are not intended for use in =
life support appliances,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; devices, or systems. Use in such =
applications is expressly prohibited.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; (c) Copyright 2007-2008 Xilinx Inc.<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; All rights reserved.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; You should have received a copy of the GNU =
General Public License along<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; with this program; if not, write to the Free =
Software Foundation, Inc.,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; 675 Mass Ave, Cambridge, MA 02139, USA.<BR>
+ *<BR>
+ =
*************************************************************************=
****/<BR>
+<BR>
+#ifndef XILINX_FIFO_ICAP_H_&nbsp;&nbsp;&nbsp; /* prevent circular =
inclusions */<BR>
+#define XILINX_FIFO_ICAP_H_&nbsp;&nbsp;&nbsp; /* by using protection =
macros */<BR>
+<BR>
+#include &lt;linux/types.h&gt;<BR>
+#include &lt;linux/cdev.h&gt;<BR>
+#include &lt;linux/version.h&gt;<BR>
+#include &lt;linux/platform_device.h&gt;<BR>
+<BR>
+#include &lt;asm/io.h&gt;<BR>
+#include &quot;xilinx_hwicap.h&quot;<BR>
+<BR>
+/* Reads integers from the device into the storage buffer. */<BR>
+int fifo_icap_get_configuration(<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hwicap_drvdata =
*drvdata,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *FrameBuffer,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 NumWords);<BR>
+<BR>
+/* Writes integers to the device from the storage buffer. */<BR>
+int fifo_icap_set_configuration(<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hwicap_drvdata =
*drvdata,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *FrameBuffer,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 NumWords);<BR>
+<BR>
+void fifo_icap_reset(struct hwicap_drvdata *drvdata);<BR>
+void fifo_icap_flush_fifo(struct hwicap_drvdata *drvdata);<BR>
+<BR>
+#endif<BR>
diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c =
b/drivers/char/xilinx_hwicap/xilinx_hwicap.c<BR>
new file mode 100644<BR>
index 0000000..a55e6e1<BR>
--- /dev/null<BR>
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c<BR>
@@ -0,0 +1,912 @@<BR>
+/***********************************************************************=
******<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; Author: Xilinx, Inc.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; This program is free software; you can =
redistribute it and/or modify it<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; under the terms of the GNU General Public =
License as published by the<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; Free Software Foundation; either version 2 =
of the License, or (at your<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; option) any later version.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; XILINX IS PROVIDING THIS DESIGN, CODE, OR =
INFORMATION &quot;AS IS&quot;<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; AS A COURTESY TO YOU, SOLELY FOR USE IN =
DEVELOPING PROGRAMS AND<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; SOLUTIONS FOR XILINX DEVICES.&nbsp; BY =
PROVIDING THIS DESIGN, CODE,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; OR INFORMATION AS ONE POSSIBLE =
IMPLEMENTATION OF THIS FEATURE,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; APPLICATION OR STANDARD, XILINX IS MAKING NO =
REPRESENTATION<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; THAT THIS IMPLEMENTATION IS FREE FROM ANY =
CLAIMS OF INFRINGEMENT,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; AND YOU ARE RESPONSIBLE FOR OBTAINING ANY =
RIGHTS YOU MAY REQUIRE<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; FOR YOUR IMPLEMENTATION.&nbsp; XILINX =
EXPRESSLY DISCLAIMS ANY<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; WARRANTY WHATSOEVER WITH RESPECT TO THE =
ADEQUACY OF THE<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO =
ANY WARRANTIES OR<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; REPRESENTATIONS THAT THIS IMPLEMENTATION IS =
FREE FROM CLAIMS OF<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; INFRINGEMENT, IMPLIED WARRANTIES OF =
MERCHANTABILITY AND FITNESS<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; FOR A PARTICULAR PURPOSE.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; Xilinx products are not intended for use in =
life support appliances,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; devices, or systems. Use in such =
applications is expressly prohibited.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; (c) Copyright 2002 Xilinx Inc., Systems =
Engineering Group<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; (c) Copyright 2004 Xilinx Inc., Systems =
Engineering Group<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; (c) Copyright 2007-2008 Xilinx Inc.<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; All rights reserved.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; You should have received a copy of the GNU =
General Public License along<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; with this program; if not, write to the Free =
Software Foundation, Inc.,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; 675 Mass Ave, Cambridge, MA 02139, USA.<BR>
+ *<BR>
+ =
*************************************************************************=
****/<BR>
+<BR>
+/*<BR>
+ * This is the code behind /dev/xilinx_icap -- it allows a =
user-space<BR>
+ * application to use the Xilinx ICAP subsystem.<BR>
+ *<BR>
+ * The following operations are possible:<BR>
+ *<BR>
+ * open&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; open the port and initialize =
for access.<BR>
+ * release&nbsp;&nbsp;&nbsp;&nbsp; release port<BR>
+ * write&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Write a bitstream to =
the configuration processor.<BR>
+ * read&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Read a data =
stream from the configuration processor.<BR>
+ *<BR>
+ * After being opened, the port is initialized and accessed to avoid =
a<BR>
+ * corrupted first read which may occur with some hardware.&nbsp; The =
port<BR>
+ * is left in a desynched state, requiring that a synch sequence be<BR>
+ * transmitted before any valid configuration data.&nbsp; A user will =
have<BR>
+ * exclusive access to the device while it remains open, and the =
state<BR>
+ * of the ICAP cannot be guaranteed after the device is closed.&nbsp; =
Note<BR>
+ * that a complete reset of the core and the state of the ICAP =
cannot<BR>
+ * be performed on many versions of the cores, hence users of this<BR>
+ * device should avoid making inconsistent accesses to the =
device.&nbsp; In<BR>
+ * particular, accessing the read interface, without first =
generating<BR>
+ * a write containing a readback packet can leave the ICAP in an<BR>
+ * inaccessible state.<BR>
+ *<BR>
+ * Note that in order to use the read interface, it is first =
necessary<BR>
+ * to write a request packet to the write interface.&nbsp; i.e., it is =
not<BR>
+ * possible to simply readback the bitstream (or any configuration<BR>
+ * bits) from a device without specifically requesting them first.<BR>
+ * The code to craft such packets is intended to be part of the<BR>
+ * user-space application code that uses this device.&nbsp; The =
simplest<BR>
+ * way to use this interface is simply:<BR>
+ *<BR>
+ * cp foo.bit /dev/xilinx_icap<BR>
+ *<BR>
+ * Note that unless foo.bit is an appropriately constructed partial<BR>
+ * bitstream, this has a high likelyhood of overwriting the design<BR>
+ * currently programmed in the FPGA.<BR>
+ */<BR>
+<BR>
+#include &lt;linux/version.h&gt;<BR>
+#include &lt;linux/module.h&gt;<BR>
+#include &lt;linux/kernel.h&gt;<BR>
+#include &lt;linux/types.h&gt;<BR>
+#include &lt;linux/ioport.h&gt;<BR>
+#include &lt;linux/interrupt.h&gt;<BR>
+#include &lt;linux/fcntl.h&gt;<BR>
+#include &lt;linux/init.h&gt;<BR>
+#include &lt;linux/poll.h&gt;<BR>
+#include &lt;linux/proc_fs.h&gt;<BR>
+#include &lt;linux/spinlock.h&gt;<BR>
+#include &lt;linux/sysctl.h&gt;<BR>
+#include &lt;linux/version.h&gt;<BR>
+#include &lt;linux/fs.h&gt;<BR>
+#include &lt;linux/cdev.h&gt;<BR>
+#include &lt;linux/platform_device.h&gt;<BR>
+<BR>
+#include &lt;asm/io.h&gt;<BR>
+#include &lt;asm/uaccess.h&gt;<BR>
+#include &lt;asm/system.h&gt;<BR>
+<BR>
+#ifdef CONFIG_OF<BR>
+/* For open firmware. */<BR>
+#include &lt;linux/of_device.h&gt;<BR>
+#include &lt;linux/of_platform.h&gt;<BR>
+#endif<BR>
+<BR>
+#include &quot;xilinx_hwicap.h&quot;<BR>
+#include &quot;buffer_icap.h&quot;<BR>
+#include &quot;fifo_icap.h&quot;<BR>
+<BR>
+#define DRIVER_NAME &quot;xilinx_icap&quot;<BR>
+<BR>
+#define HWICAP_REGS&nbsp;&nbsp; (0x10000)<BR>
+<BR>
+/* dynamically allocate device number */<BR>
+static int xhwicap_major;<BR>
+static int xhwicap_minor;<BR>
+#define HWICAP_DEVICES 1<BR>
+<BR>
+module_param(xhwicap_major, int, S_IRUGO);<BR>
+module_param(xhwicap_minor, int, S_IRUGO);<BR>
+<BR>
+/* An array, which is set to true when the device is registered. */<BR>
+static bool probed_devices[HWICAP_DEVICES];<BR>
+<BR>
+static spinlock_t hwicap_spinlock =3D SPIN_LOCK_UNLOCKED;<BR>
+<BR>
+static struct class *icap_class;<BR>
+<BR>
+#define UNIMPLEMENTED 0xFFFF<BR>
+<BR>
+static const struct config_registers v2_config_registers =3D {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .CRC =3D 0,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .FAR =3D 1,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .FDRI =3D 2,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .FDRO =3D 3,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .CMD =3D 4,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .CTL =3D 5,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .MASK =3D 6,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .STAT =3D 7,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .LOUT =3D 8,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .COR =3D 9,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .MFWR =3D 10,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .FLR =3D 11,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .KEY =3D 12,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .CBC =3D 13,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .IDCODE =3D 14,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .AXSS =3D UNIMPLEMENTED,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .C0R_1 =3D UNIMPLEMENTED,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .CSOB =3D UNIMPLEMENTED,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .WBSTAR =3D UNIMPLEMENTED,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .TIMER =3D UNIMPLEMENTED,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .BOOTSTS =3D UNIMPLEMENTED,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .CTL_1 =3D UNIMPLEMENTED,<BR>
+};<BR>
+<BR>
+static const struct config_registers v4_config_registers =3D {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .CRC =3D 0,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .FAR =3D 1,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .FDRI =3D 2,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .FDRO =3D 3,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .CMD =3D 4,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .CTL =3D 5,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .MASK =3D 6,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .STAT =3D 7,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .LOUT =3D 8,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .COR =3D 9,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .MFWR =3D 10,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .FLR =3D UNIMPLEMENTED,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .KEY =3D UNIMPLEMENTED,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .CBC =3D 11,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .IDCODE =3D 12,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .AXSS =3D 13,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .C0R_1 =3D UNIMPLEMENTED,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .CSOB =3D UNIMPLEMENTED,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .WBSTAR =3D UNIMPLEMENTED,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .TIMER =3D UNIMPLEMENTED,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .BOOTSTS =3D UNIMPLEMENTED,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .CTL_1 =3D UNIMPLEMENTED,<BR>
+};<BR>
+static const struct config_registers v5_config_registers =3D {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .CRC =3D 0,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .FAR =3D 1,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .FDRI =3D 2,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .FDRO =3D 3,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .CMD =3D 4,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .CTL =3D 5,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .MASK =3D 6,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .STAT =3D 7,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .LOUT =3D 8,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .COR =3D 9,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .MFWR =3D 10,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .FLR =3D UNIMPLEMENTED,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .KEY =3D UNIMPLEMENTED,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .CBC =3D 11,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .IDCODE =3D 12,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .AXSS =3D 13,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .C0R_1 =3D 14,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .CSOB =3D 15,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .WBSTAR =3D 16,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .TIMER =3D 17,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .BOOTSTS =3D 18,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .CTL_1 =3D 19,<BR>
+};<BR>
+<BR>
+/**<BR>
+ * hwicap_command_desync: Send a DESYNC command to the ICAP port.<BR>
+ * @parameter drvdata: a pointer to the drvdata.<BR>
+ *<BR>
+ * This command desynchronizes the ICAP After this command, a<BR>
+ * bitstream containing a NULL packet, followed by a SYNCH packet =
is<BR>
+ * required before the ICAP will recognize commands.<BR>
+ */<BR>
+int hwicap_command_desync(struct hwicap_drvdata *drvdata)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 buffer[4];<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 index =3D 0;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Create the data to be =
written to the ICAP.<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer[index++] =3D =
hwicap_type_1_write(drvdata-&gt;config_regs-&gt;CMD) | 1;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer[index++] =3D =
XHI_CMD_DESYNCH;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer[index++] =3D =
XHI_NOOP_PACKET;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer[index++] =3D =
XHI_NOOP_PACKET;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Write the data to the FIFO =
and intiate the transfer of data present<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * in the FIFO to the ICAP =
device.<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
drvdata-&gt;config-&gt;set_configuration(drvdata,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;buffer[0], index);<BR>
+}<BR>
+<BR>
+/**<BR>
+ * hwicap_command_capture: Send a CAPTURE command to the ICAP port.<BR>
+ * @parameter drvdata: a pointer to the drvdata.<BR>
+ *<BR>
+ * This command captures all of the flip flop states so they will =
be<BR>
+ * available during readback.&nbsp; One can use this command instead =
of<BR>
+ * enabling the CAPTURE block in the design.<BR>
+ */<BR>
+int hwicap_command_capture(struct hwicap_drvdata *drvdata)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 buffer[7];<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 index =3D 0;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Create the data to be =
written to the ICAP.<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer[index++] =3D =
XHI_DUMMY_PACKET;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer[index++] =3D =
XHI_SYNC_PACKET;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer[index++] =3D =
XHI_NOOP_PACKET;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer[index++] =3D =
hwicap_type_1_write(drvdata-&gt;config_regs-&gt;CMD) | 1;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer[index++] =3D =
XHI_CMD_GCAPTURE;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer[index++] =3D =
XHI_DUMMY_PACKET;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer[index++] =3D =
XHI_DUMMY_PACKET;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Write the data to the FIFO =
and intiate the transfer of data<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * present in the FIFO to the =
ICAP device.<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
drvdata-&gt;config-&gt;set_configuration(drvdata,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;buffer[0], index);<BR>
+<BR>
+}<BR>
+<BR>
+/**<BR>
+ * hwicap_get_configuration_register: Query a configuration =
register.<BR>
+ * @parameter drvdata: a pointer to the drvdata.<BR>
+ * @parameter reg: a constant which represents the configuration<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
register value to be returned.<BR>
+ * &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Examples:&nbsp; XHI_IDCODE, XHI_FLR.<BR>
+ * @parameter RegData: returns the value of the register.<BR>
+ *<BR>
+ * Sends a query packet to the ICAP and then receives the response.<BR>
+ * The icap is left in Synched state.<BR>
+ */<BR>
+int hwicap_get_configuration_register(struct hwicap_drvdata =
*drvdata,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 reg, u32 *RegData)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int status;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 buffer[6];<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 index =3D 0;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Create the data to be =
written to the ICAP.<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer[index++] =3D =
XHI_DUMMY_PACKET;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer[index++] =3D =
XHI_SYNC_PACKET;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer[index++] =3D =
XHI_NOOP_PACKET;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer[index++] =3D =
hwicap_type_1_read(reg) | 1;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer[index++] =3D =
XHI_NOOP_PACKET;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buffer[index++] =3D =
XHI_NOOP_PACKET;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Write the data to the FIFO =
and intiate the transfer of data present<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * in the FIFO to the ICAP =
device.<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D =
drvdata-&gt;config-&gt;set_configuration(drvdata,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;buffer[0], index);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Read the configuration =
register<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D =
drvdata-&gt;config-&gt;get_configuration(drvdata, RegData, 1);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>
+}<BR>
+<BR>
+int hwicap_initialize_hwicap(struct hwicap_drvdata *drvdata)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int status;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 idcode;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(drvdata-&gt;dev, =
&quot;initializing\n&quot;);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Abort any current transaction, =
to make sure we have the<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * ICAP in a good state. =
*/<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(drvdata-&gt;dev, =
&quot;Reset...\n&quot;);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
drvdata-&gt;config-&gt;reset(drvdata);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(drvdata-&gt;dev, =
&quot;Desync...\n&quot;);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D =
hwicap_command_desync(drvdata);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Attempt to read the IDCODE from =
ICAP.&nbsp; This<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * may not be returned =
correctly, due to the design of the<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * hardware.<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(drvdata-&gt;dev, =
&quot;Reading IDCODE...\n&quot;);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D =
hwicap_get_configuration_register(<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata, =
drvdata-&gt;config_regs-&gt;IDCODE, &amp;idcode);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(drvdata-&gt;dev, =
&quot;IDCODE =3D %x\n&quot;, idcode);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(drvdata-&gt;dev, =
&quot;Desync...\n&quot;);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D =
hwicap_command_desync(drvdata);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>
+}<BR>
+<BR>
+static ssize_t<BR>
+hwicap_read(struct file *file, char *buf, size_t count, loff_t =
*ppos)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hwicap_drvdata *drvdata =3D =
file-&gt;private_data;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t bytes_to_read =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *kbuf;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 words;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 bytes_remaining;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int status;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
spin_lock(&amp;hwicap_spinlock);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (drvdata-&gt;is_accessing)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EBUSY;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata-&gt;is_accessing =3D =
1;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
spin_unlock(&amp;hwicap_spinlock);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(drvdata-&gt;read_buffer_in_use) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If there are leftover =
bytes in the buffer, just */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* return them and don't try =
to read more from the */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* ICAP device. */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bytes_to_read =3D<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (count &lt; =
drvdata-&gt;read_buffer_in_use) ? count :<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
drvdata-&gt;read_buffer_in_use;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Return the data currently =
in the read buffer. */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (copy_to_user(buf, =
drvdata-&gt;read_buffer, bytes_to_read)) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D -EFAULT;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
drvdata-&gt;read_buffer_in_use -=3D bytes_to_read;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
memcpy(drvdata-&gt;read_buffer + bytes_to_read,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata-&gt;read_buffer, 4 - =
bytes_to_read);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Get new data from the =
ICAP, and return was was requested. */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kbuf =3D (u32 *) =
get_zeroed_page(GFP_KERNEL);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!kbuf) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D -ENOMEM;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The ICAP device is only =
able to read complete */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* words.&nbsp; If a number =
of bytes that do not correspond */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to complete words is =
requested, then we read enough */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* words to get the required =
number of bytes, and then */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* save the remaining bytes =
for the next read. */<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Determine the number of =
words to read, rounding up */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* if necessary. */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; words =3D ((count + 3) =
&gt;&gt; 2);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bytes_to_read =3D words =
&lt;&lt; 2;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bytes_to_read &gt; =
PAGE_SIZE)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bytes_to_read =3D =
PAGE_SIZE;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Ensure we only read a =
complete number of words. */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bytes_remaining =3D =
bytes_to_read &amp; 3;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bytes_to_read &amp;=3D =
~3;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; words =3D bytes_to_read =
&gt;&gt; 2;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D =
drvdata-&gt;config-&gt;get_configuration(drvdata,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kbuf, words);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If we didn't read =
correctly, then bail out. */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free_page((unsigned =
long)kbuf);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* If we fail to return the =
data to the user, then bail out. */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (copy_to_user(buf, kbuf, =
bytes_to_read)) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free_page((unsigned =
long)kbuf);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D -EFAULT;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(kbuf, =
drvdata-&gt;read_buffer, bytes_remaining);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
drvdata-&gt;read_buffer_in_use =3D bytes_remaining;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free_page((unsigned =
long)kbuf);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D bytes_to_read;<BR>
+ error:<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
spin_lock(&amp;hwicap_spinlock);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata-&gt;is_accessing =3D =
0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
spin_unlock(&amp;hwicap_spinlock);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<BR>
+}<BR>
+<BR>
+static ssize_t<BR>
+hwicap_write(struct file *file, const char *buf,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; size_t count, loff_t =
*ppos)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hwicap_drvdata *drvdata =3D =
file-&gt;private_data;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t written =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t left =3D count;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 *kbuf;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t len;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ssize_t status;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
spin_lock(&amp;hwicap_spinlock);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (drvdata-&gt;is_accessing)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EBUSY;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata-&gt;is_accessing =3D =
1;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
spin_unlock(&amp;hwicap_spinlock);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; left +=3D =
drvdata-&gt;write_buffer_in_use;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Only write multiples of 4 =
bytes. */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (left &lt; 4) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kbuf =3D (u32 *) =
__get_free_page(GFP_KERNEL);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!kbuf) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D -ENOMEM;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (left &gt; 3) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* only write multiples of 4 =
bytes, so there might */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* be as many as 3 bytes left =
(at the end). */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; len =3D left;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (len &gt; PAGE_SIZE)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; len =3D PAGE_SIZE;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; len &amp;=3D ~3;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(drvdata-&gt;write_buffer_in_use) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(kbuf, =
drvdata-&gt;write_buffer,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
drvdata-&gt;write_buffer_in_use);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (copy_from_user(<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; (((char =
*)kbuf) + (drvdata-&gt;write_buffer_in_use)),<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; buf + =
written,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; len - =
(drvdata-&gt;write_buffer_in_use))) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free_page((unsigned =
long)kbuf);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D -EFAULT;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (copy_from_user(kbuf, buf =
+ written, len)) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free_page((unsigned =
long)kbuf);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D -EFAULT;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D =
drvdata-&gt;config-&gt;set_configuration(drvdata,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kbuf, len &gt;&gt; 2);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free_page((unsigned =
long)kbuf);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D -EFAULT;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(drvdata-&gt;write_buffer_in_use) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; len -=3D =
drvdata-&gt;write_buffer_in_use;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; left -=3D =
drvdata-&gt;write_buffer_in_use;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
drvdata-&gt;write_buffer_in_use =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; written +=3D len;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; left -=3D len;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((left &gt; 0) &amp;&amp; (left =
&lt; 4)) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!copy_from_user(drvdata-&gt;write_buffer,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf + written, left)) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
drvdata-&gt;write_buffer_in_use =3D left;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; written +=3D left;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; left =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free_page((unsigned =
long)kbuf);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D written;<BR>
+ error:<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
spin_lock(&amp;hwicap_spinlock);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata-&gt;is_accessing =3D =
0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
spin_unlock(&amp;hwicap_spinlock);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<BR>
+}<BR>
+<BR>
+static int hwicap_open(struct inode *inode, struct file *file)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hwicap_drvdata =
*drvdata;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int status;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata =3D =
container_of(inode-&gt;i_cdev, struct hwicap_drvdata, cdev);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
spin_lock(&amp;hwicap_spinlock);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (drvdata-&gt;is_open)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EBUSY;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata-&gt;is_open =3D 1;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata-&gt;is_accessing =3D =
0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
spin_unlock(&amp;hwicap_spinlock);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D =
hwicap_initialize_hwicap(drvdata);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(drvdata-&gt;dev, =
&quot;Failed to open file&quot;);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; file-&gt;private_data =3D =
drvdata;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata-&gt;write_buffer_in_use =
=3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata-&gt;read_buffer_in_use =3D =
0;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<BR>
+}<BR>
+<BR>
+static int hwicap_release(struct inode *inode, struct file *file)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hwicap_drvdata *drvdata =3D =
file-&gt;private_data;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int status =3D 0;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(drvdata-&gt;write_buffer_in_use) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Flush write buffer. */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D =
drvdata-&gt;write_buffer_in_use; i &lt; 4; i++)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata-&gt;write_buffer[i] =
=3D 0;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D =
drvdata-&gt;config-&gt;set_configuration(drvdata,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (u32 *) =
drvdata-&gt;write_buffer, 1);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status =3D =
hwicap_command_desync(drvdata);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (status)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error;<BR>
+<BR>
+ error:<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
spin_lock(&amp;hwicap_spinlock);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata-&gt;is_open =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
spin_unlock(&amp;hwicap_spinlock);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return status;<BR>
+}<BR>
+<BR>
+static struct file_operations hwicap_fops =3D {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write =3D hwicap_write,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read =3D hwicap_read,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .open =3D hwicap_open,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .release =3D hwicap_release,<BR>
+};<BR>
+<BR>
+static int __devinit hwicap_setup(struct device *dev, int id,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct resource =
*regs_res,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct =
hwicap_driver_config *config,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct config_registers =
*config_regs)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_t devt;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hwicap_drvdata *drvdata =3D =
NULL;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval =3D 0;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(dev, &quot;Xilinx icap =
port driver\n&quot;);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (id &lt; 0) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (id =3D 0; id &lt; =
HWICAP_DEVICES; id++)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!probed_devices[id])<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (id &lt; 0 || id &gt;=3D =
HWICAP_DEVICES) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;%s%i too =
large\n&quot;, DRIVER_NAME, id);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (probed_devices[id]) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;cannot =
assign to %s%i; it is already in use\n&quot;,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRIVER_NAME, id);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EBUSY;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; probed_devices[id] =3D 1;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; devt =3D MKDEV(xhwicap_major, =
xhwicap_minor + id);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata =3D kmalloc(sizeof(struct =
hwicap_drvdata), GFP_KERNEL);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!drvdata) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;Couldn't =
allocate device private record\n&quot;);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset((void *)drvdata, 0, =
sizeof(struct hwicap_drvdata));<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_set_drvdata(dev, (void =
*)drvdata);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!regs_res) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;Couldn't =
get registers resource\n&quot;);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D -EFAULT;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed1;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata-&gt;mem_start =3D =
regs_res-&gt;start;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata-&gt;mem_end =3D =
regs_res-&gt;end;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata-&gt;mem_size =3D =
regs_res-&gt;end - regs_res-&gt;start + 1;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(!request_mem_region(drvdata-&gt;mem_start,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata-&gt;mem_size, =
DRIVER_NAME)) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;Couldn't =
lock memory region at %p\n&quot;,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (void =
*)regs_res-&gt;start);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D -EBUSY;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed1;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata-&gt;devt =3D devt;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata-&gt;dev =3D dev;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata-&gt;base_address =3D =
ioremap(drvdata-&gt;mem_start, drvdata-&gt;mem_size);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!drvdata-&gt;base_address) =
{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;ioremap() =
failed\n&quot;);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed2;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata-&gt;config =3D config;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata-&gt;config_regs =3D =
config_regs;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
spin_lock(&amp;hwicap_spinlock);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata-&gt;is_open =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata-&gt;is_accessing =3D =
0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
spin_unlock(&amp;hwicap_spinlock);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(dev, &quot;ioremap %lx to =
%p with size %x\n&quot;,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned long =
int)drvdata-&gt;mem_start,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata-&gt;base_address, =
drvdata-&gt;mem_size);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cdev_init(&amp;drvdata-&gt;cdev, =
&amp;hwicap_fops);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata-&gt;cdev.owner =3D =
THIS_MODULE;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D =
cdev_add(&amp;drvdata-&gt;cdev, devt, 1);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(dev, &quot;cdev_add() =
failed\n&quot;);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed3;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*&nbsp; devfs_mk_cdev(devt, =
S_IFCHR|S_IRUGO|S_IWUGO, DRIVER_NAME); */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; class_device_create(icap_class, =
NULL, devt, NULL, DRIVER_NAME);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
0;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* success */<BR>
+<BR>
+ failed3:<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
iounmap(drvdata-&gt;base_address);<BR>
+<BR>
+ failed2:<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
release_mem_region(regs_res-&gt;start, drvdata-&gt;mem_size);<BR>
+<BR>
+ failed1:<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(drvdata);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<BR>
+}<BR>
+<BR>
+static struct hwicap_driver_config buffer_icap_config =3D {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_configuration =3D =
buffer_icap_get_configuration,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_configuration =3D =
buffer_icap_set_configuration,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset =3D buffer_icap_reset,<BR>
+};<BR>
+<BR>
+static struct hwicap_driver_config fifo_icap_config =3D {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_configuration =3D =
fifo_icap_get_configuration,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_configuration =3D =
fifo_icap_set_configuration,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset =3D fifo_icap_reset,<BR>
+};<BR>
+<BR>
+static int __devexit hwicap_remove(struct device *dev)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct hwicap_drvdata =
*drvdata;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drvdata =3D (struct hwicap_drvdata =
*)dev_get_drvdata(dev);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!drvdata)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
class_device_destroy(icap_class, drvdata-&gt;devt);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
cdev_del(&amp;drvdata-&gt;cdev);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
iounmap(drvdata-&gt;base_address);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
release_mem_region(drvdata-&gt;mem_start, drvdata-&gt;mem_size);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(drvdata);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_set_drvdata(dev, =
NULL);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
probed_devices[MINOR(dev-&gt;devt)-xhwicap_minor] =3D 0;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
0;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* success */<BR>
+}<BR>
+<BR>
+static int __devinit hwicap_drv_probe(struct platform_device *pdev)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct resource *res;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct config_registers =
*regs;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *family;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; res =3D =
platform_get_resource(pdev, IORESOURCE_MEM, 0);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!res)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENODEV;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* It's most likely that we're =
using V4, if the family is not<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; specified */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regs =3D =
&amp;v4_config_registers;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; family =3D =
pdev-&gt;dev.platform_data;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (family) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!strcmp(family, =
&quot;virtex2p&quot;)) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regs =3D =
&amp;v2_config_registers;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (!strcmp(family, =
&quot;virtex4&quot;)) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regs =3D =
&amp;v4_config_registers;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (!strcmp(family, =
&quot;virtex5&quot;)) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regs =3D =
&amp;v5_config_registers;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
hwicap_setup(&amp;pdev-&gt;dev, pdev-&gt;id, res,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;buffer_icap_config, =
regs);<BR>
+}<BR>
+<BR>
+static int __devexit hwicap_drv_remove(struct platform_device =
*pdev)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
hwicap_remove(&amp;pdev-&gt;dev);<BR>
+}<BR>
+<BR>
+static struct platform_driver hwicap_platform_driver =3D {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .probe =3D hwicap_drv_probe,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .remove =3D hwicap_drv_remove,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .driver =3D {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D DRIVER_NAME,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<BR>
+};<BR>
+<BR>
+/* =
---------------------------------------------------------------------<BR>=

+ * OF bus binding<BR>
+ */<BR>
+<BR>
+#if defined(CONFIG_OF)<BR>
+static int __devinit<BR>
+hwicap_of_probe(struct of_device *op, const struct of_device_id =
*match)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct resource res;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const unsigned int *id;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const char *family;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int rc;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct hwicap_driver_config =
*config =3D match-&gt;data;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct config_registers =
*regs;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_dbg(&amp;op-&gt;dev, =
&quot;hwicap_of_probe(%p, %p)\n&quot;, op, match);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rc =3D =
of_address_to_resource(op-&gt;node, 0, &amp;res);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (rc) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(&amp;op-&gt;dev, =
&quot;invalid address\n&quot;);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return rc;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; id =3D =
of_get_property(op-&gt;node, &quot;port-number&quot;, NULL);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* It's most likely that we're =
using V4, if the family is not<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; specified */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regs =3D =
&amp;v4_config_registers;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; family =3D =
of_get_property(op-&gt;node, &quot;xlnx,family&quot;, NULL);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (family) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!strcmp(family, =
&quot;virtex2p&quot;)) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regs =3D =
&amp;v2_config_registers;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (!strcmp(family, =
&quot;virtex4&quot;)) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regs =3D =
&amp;v4_config_registers;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else if (!strcmp(family, =
&quot;virtex5&quot;)) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regs =3D =
&amp;v5_config_registers;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
hwicap_setup(&amp;op-&gt;dev, id ? *id : -1, &amp;res, config,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; regs);<BR>
+}<BR>
+<BR>
+static int __devexit hwicap_of_remove(struct of_device *op)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
hwicap_remove(&amp;op-&gt;dev);<BR>
+}<BR>
+<BR>
+/* Match table for of_platform binding */<BR>
+static const struct of_device_id __devinit hwicap_of_match[] =3D {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { .compatible =3D =
&quot;xlnx,opb-hwicap-1.00.b&quot;, .data =3D =
&amp;buffer_icap_config},<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { .compatible =3D =
&quot;xlnx,xps-hwicap-1.00.a&quot;, .data =3D =
&amp;fifo_icap_config},<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {},<BR>
+};<BR>
+MODULE_DEVICE_TABLE(of, hwicap_of_match);<BR>
+<BR>
+static struct of_platform_driver hwicap_of_driver =3D {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D DRIVER_NAME,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .match_table =3D =
hwicap_of_match,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .probe =3D hwicap_of_probe,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .remove =3D =
__devexit_p(hwicap_of_remove),<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .driver =3D {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .name =3D DRIVER_NAME,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; },<BR>
+};<BR>
+<BR>
+/* Registration helpers to keep the number of #ifdefs to a minimum =
*/<BR>
+static inline int __devinit hwicap_of_register(void)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;hwicap: calling =
of_register_platform_driver()\n&quot;);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
of_register_platform_driver(&amp;hwicap_of_driver);<BR>
+}<BR>
+<BR>
+static inline void __devexit hwicap_of_unregister(void)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
of_unregister_platform_driver(&amp;hwicap_of_driver);<BR>
+}<BR>
+#else /* CONFIG_OF */<BR>
+/* CONFIG_OF not enabled; do nothing helpers */<BR>
+static inline int __devinit hwicap_of_register(void) { return 0; }<BR>
+static inline void __devexit hwicap_of_unregister(void) { }<BR>
+#endif /* CONFIG_OF */<BR>
+<BR>
+static int __devinit hwicap_module_init(void)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_t devt;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retval;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; icap_class =3D =
class_create(THIS_MODULE, &quot;xilinx_config&quot;);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (xhwicap_major) {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; devt =3D MKDEV(xhwicap_major, =
xhwicap_minor);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D =
register_chrdev_region(<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; devt,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HWICAP_DEVICES,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRIVER_NAME);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval &lt; 0)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D =
alloc_chrdev_region(&amp;devt,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xhwicap_minor,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HWICAP_DEVICES,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRIVER_NAME);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval &lt; 0)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xhwicap_major =3D =
MAJOR(devt);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D =
platform_driver_register(&amp;hwicap_platform_driver);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed1;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retval =3D =
hwicap_of_register();<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (retval)<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto failed2;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<BR>
+<BR>
+ failed2:<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
platform_driver_unregister(&amp;hwicap_platform_driver);<BR>
+<BR>
+ failed1:<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unregister_chrdev_region(devt, =
HWICAP_DEVICES);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return retval;<BR>
+}<BR>
+<BR>
+static void __devexit hwicap_module_cleanup(void)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_t devt =3D =
MKDEV(xhwicap_major, xhwicap_minor);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; class_destroy(icap_class);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
platform_driver_unregister(&amp;hwicap_platform_driver);<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hwicap_of_unregister();<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unregister_chrdev_region(devt, =
HWICAP_DEVICES);<BR>
+}<BR>
+<BR>
+module_init(hwicap_module_init);<BR>
+module_exit(hwicap_module_cleanup);<BR>
+<BR>
+MODULE_AUTHOR(&quot;Xilinx, Inc; Xilinx Research Labs Group&quot;);<BR>
+MODULE_DESCRIPTION(&quot;Xilinx ICAP Port Driver&quot;);<BR>
+MODULE_LICENSE(&quot;GPL&quot;);<BR>
diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.h =
b/drivers/char/xilinx_hwicap/xilinx_hwicap.h<BR>
new file mode 100644<BR>
index 0000000..b6b47d0<BR>
--- /dev/null<BR>
+++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.h<BR>
@@ -0,0 +1,193 @@<BR>
+/***********************************************************************=
******<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; Author: Xilinx, Inc.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; This program is free software; you can =
redistribute it and/or modify it<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; under the terms of the GNU General Public =
License as published by the<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; Free Software Foundation; either version 2 =
of the License, or (at your<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; option) any later version.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; XILINX IS PROVIDING THIS DESIGN, CODE, OR =
INFORMATION &quot;AS IS&quot;<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; AS A COURTESY TO YOU, SOLELY FOR USE IN =
DEVELOPING PROGRAMS AND<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; SOLUTIONS FOR XILINX DEVICES.&nbsp; BY =
PROVIDING THIS DESIGN, CODE,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; OR INFORMATION AS ONE POSSIBLE =
IMPLEMENTATION OF THIS FEATURE,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; APPLICATION OR STANDARD, XILINX IS MAKING NO =
REPRESENTATION<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; THAT THIS IMPLEMENTATION IS FREE FROM ANY =
CLAIMS OF INFRINGEMENT,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; AND YOU ARE RESPONSIBLE FOR OBTAINING ANY =
RIGHTS YOU MAY REQUIRE<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; FOR YOUR IMPLEMENTATION.&nbsp; XILINX =
EXPRESSLY DISCLAIMS ANY<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; WARRANTY WHATSOEVER WITH RESPECT TO THE =
ADEQUACY OF THE<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO =
ANY WARRANTIES OR<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; REPRESENTATIONS THAT THIS IMPLEMENTATION IS =
FREE FROM CLAIMS OF<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; INFRINGEMENT, IMPLIED WARRANTIES OF =
MERCHANTABILITY AND FITNESS<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; FOR A PARTICULAR PURPOSE.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; Xilinx products are not intended for use in =
life support appliances,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; devices, or systems. Use in such =
applications is expressly prohibited.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; (c) Copyright 2003-2007 Xilinx Inc.<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; All rights reserved.<BR>
+ *<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; You should have received a copy of the GNU =
General Public License along<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; with this program; if not, write to the Free =
Software Foundation, Inc.,<BR>
+ *&nbsp;&nbsp;&nbsp;&nbsp; 675 Mass Ave, Cambridge, MA 02139, USA.<BR>
+ *<BR>
+ =
*************************************************************************=
****/<BR>
+<BR>
+#ifndef XILINX_HWICAP_H_&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* prevent =
circular inclusions */<BR>
+#define XILINX_HWICAP_H_&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* by =
using protection macros */<BR>
+<BR>
+#include &lt;linux/types.h&gt;<BR>
+#include &lt;linux/cdev.h&gt;<BR>
+#include &lt;linux/version.h&gt;<BR>
+#include &lt;linux/platform_device.h&gt;<BR>
+<BR>
+#include &lt;asm/io.h&gt;<BR>
+<BR>
+struct hwicap_drvdata {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 write_buffer_in_use;&nbsp; /* =
Always in [0,3] */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 write_buffer[4];<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 read_buffer_in_use; &nbsp; /* =
Always in [0,3] */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 read_buffer[4];<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 mem_start;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; /* phys. address of =
the control registers */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 mem_end;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; /* phys. address of =
the control registers */<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 mem_size;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void __iomem *base_address;/* =
virt. address of the control registers */<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct device *dev;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct cdev =
cdev;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Char device structure =
*/<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_t devt;<BR>
+<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct hwicap_driver_config =
*config;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct config_registers =
*config_regs;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *private_data;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_open;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool is_accessing;<BR>
+};<BR>
+<BR>
+struct hwicap_driver_config {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*get_configuration)(struct =
hwicap_drvdata *drvdata, u32 *data,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 size);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int (*set_configuration)(struct =
hwicap_drvdata *drvdata, u32 *data,<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 size);<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*reset)(struct =
hwicap_drvdata *drvdata);<BR>
+};<BR>
+<BR>
+/* Number of times to poll the done regsiter */<BR>
+#define XHI_MAX_RETRIES&nbsp;&nbsp;&nbsp;&nbsp; 10<BR>
+<BR>
+/************ Constant Definitions *************/<BR>
+<BR>
+#define =
XHI_PAD_FRAMES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x1<BR>
+<BR>
+/* Mask for calculating configuration packet headers */<BR>
+#define XHI_WORD_COUNT_MASK_TYPE_1&nbsp; 0x7FFUL<BR>
+#define XHI_WORD_COUNT_MASK_TYPE_2&nbsp; 0x1FFFFFUL<BR>
+#define =
XHI_TYPE_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 0x7<BR>
+#define =
XHI_REGISTER_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0xF<BR>
+#define =
XHI_OP_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3<BR>
+<BR>
+#define =
XHI_TYPE_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 29<BR>
+#define =
XHI_REGISTER_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
13<BR>
+#define =
XHI_OP_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 27<BR>
+<BR>
+#define =
XHI_TYPE_1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<BR>
+#define =
XHI_TYPE_2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<BR>
+#define =
XHI_OP_WRITE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<BR>
+#define =
XHI_OP_READ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<BR>
+<BR>
+/* Address Block Types */<BR>
+#define =
XHI_FAR_CLB_BLOCK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0<BR>
+#define =
XHI_FAR_BRAM_BLOCK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1<BR>
+#define XHI_FAR_BRAM_INT_BLOCK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<BR>
+<BR>
+struct config_registers {<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 CRC;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 FAR;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 FDRI;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 FDRO;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 CMD;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 CTL;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 MASK;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 STAT;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 LOUT;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 COR;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 MFWR;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 FLR;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 KEY;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 CBC;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 IDCODE;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 AXSS;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 C0R_1;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 CSOB;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 WBSTAR;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 TIMER;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 BOOTSTS;<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 CTL_1;<BR>
+};<BR>
+<BR>
+/* Configuration Commands */<BR>
+#define =
XHI_CMD_NULL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0<BR>
+#define =
XHI_CMD_WCFG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1<BR>
+#define =
XHI_CMD_MFW&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<BR>
+#define =
XHI_CMD_DGHIGH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 3<BR>
+#define =
XHI_CMD_RCFG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<BR>
+#define =
XHI_CMD_START&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 5<BR>
+#define =
XHI_CMD_RCAP&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 6<BR>
+#define =
XHI_CMD_RCRC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 7<BR>
+#define =
XHI_CMD_AGHIGH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 8<BR>
+#define =
XHI_CMD_SWITCH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 9<BR>
+#define =
XHI_CMD_GRESTORE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 10<BR>
+#define =
XHI_CMD_SHUTDOWN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 11<BR>
+#define =
XHI_CMD_GCAPTURE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 12<BR>
+#define =
XHI_CMD_DESYNCH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 13<BR>
+#define =
XHI_CMD_IPROG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 15 /* Only in Virtex5 */<BR>
+#define =
XHI_CMD_CRCC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 16 /* Only in Virtex5 */<BR>
+#define =
XHI_CMD_LTIMER&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 17 /* Only in Virtex5 */<BR>
+<BR>
+/* Packet constants */<BR>
+#define =
XHI_SYNC_PACKET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0xAA995566UL<BR>
+#define =
XHI_DUMMY_PACKET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0xFFFFFFFFUL<BR>
+#define =
XHI_NOOP_PACKET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; (XHI_TYPE_1 &lt;&lt; XHI_TYPE_SHIFT)<BR>
+#define XHI_TYPE_2_READ ((XHI_TYPE_2 &lt;&lt; XHI_TYPE_SHIFT) | \<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (XHI_OP_READ &lt;&lt; =
XHI_OP_SHIFT))<BR>
+<BR>
+#define XHI_TYPE_2_WRITE ((XHI_TYPE_2 &lt;&lt; XHI_TYPE_SHIFT) | \<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (XHI_OP_WRITE &lt;&lt; =
XHI_OP_SHIFT))<BR>
+<BR>
+#define =
XHI_TYPE2_CNT_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x07FFFFFF<BR>
+<BR>
+#define XHI_TYPE_1_PACKET_MAX_WORDS 2047UL<BR>
+#define XHI_TYPE_1_HEADER_BYTES&nbsp;&nbsp;&nbsp;&nbsp; 4<BR>
+#define XHI_TYPE_2_HEADER_BYTES&nbsp;&nbsp;&nbsp;&nbsp; 8<BR>
+<BR>
+/* Constant to use for CRC check when CRC has been disabled */<BR>
+#define XHI_DISABLED_AUTO_CRC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x0000DEFCUL<BR>
+<BR>
+/**<BR>
+ * hwicap_type_1_read: Generates a Type 1 read packet header.<BR>
+ * @parameter: Register is the address of the register to be read =
back.<BR>
+ *<BR>
+ * Generates a Type 1 read packet header, which is used to =
indirectly<BR>
+ * read registers in the configuration logic.&nbsp; This packet must =
then<BR>
+ * be sent through the icap device, and a return packet received =
with<BR>
+ * the information.<BR>
+ **/<BR>
+static inline u32 hwicap_type_1_read(u32 Register)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (XHI_TYPE_1 &lt;&lt; =
XHI_TYPE_SHIFT) |<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Register &lt;&lt; =
XHI_REGISTER_SHIFT) |<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (XHI_OP_READ &lt;&lt; =
XHI_OP_SHIFT);<BR>
+}<BR>
+<BR>
+/**<BR>
+ * hwicap_type_1_write: Generates a Type 1 write packet header<BR>
+ * @parameter: Register is the address of the register to be read =
back.<BR>
+ **/<BR>
+static inline u32 hwicap_type_1_write(u32 Register)<BR>
+{<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (XHI_TYPE_1 &lt;&lt; =
XHI_TYPE_SHIFT) |<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (Register &lt;&lt; =
XHI_REGISTER_SHIFT) |<BR>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (XHI_OP_WRITE &lt;&lt; =
XHI_OP_SHIFT);<BR>
+}<BR>
+<BR>
+#endif<BR>
--<BR>
1.5.3.4-dirty<BR>
<BR>
<BR>
<BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C8648F.A2858A7F--
