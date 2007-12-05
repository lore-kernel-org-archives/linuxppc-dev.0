Return-Path: <jacmet@gmail.com>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.187])
	by ozlabs.org (Postfix) with ESMTP id CB200DDDF8
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 23:21:13 +1100 (EST)
Received: by mu-out-0910.google.com with SMTP id w1so745297mue
	for <linuxppc-dev@ozlabs.org>; Wed, 05 Dec 2007 04:21:06 -0800 (PST)
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Subject: Re: [PATCH] [XILINX][HWICAP] Xilinx Internal Configuration Access
	Port device driver.
References: <20071204235725.61AD6A08071@mail81-dub.bigfish.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 05 Dec 2007 13:20:47 +0100
In-Reply-To: <20071204235725.61AD6A08071@mail81-dub.bigfish.com> (Stephen
	Neuendorffer's message of "Tue\, 4 Dec 2007 15\:57\:15 -0800")
Message-ID: <871wa1xrhc.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Stephen" == Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> writes:

Hi,

 Stephen> Supports static platform_device and static device tree configuration.
 Stephen> This is a standalone driver that does not depend on EDK generated
 Stephen> files.  However, it is also somewhat different in functionality from
 Stephen> the standard EDK driver.

 Stephen> 1) The EDK driver doesn't support readback, which this driver does.
 Stephen> 2) The EDK driver supports fine granularity reading and writing, which
 Stephen> this driver does not.  The fine granularity support is heavily
 Stephen> architecture independent, which makes it difficult to make the driver
 Stephen> forward compatible.  The fine granularity support is also complex and
 Stephen> probably better handled in user space anyway.

 Stephen> Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
 Stephen> ---

 Stephen> Grant,

 Stephen> No comments last time... It would be nice if this merged
 Stephen> with 2.6.25, I think.

 Stephen> Steve

I never used the icap stuff, but here goes ..

 Stephen>  drivers/char/Kconfig                       |    5 +
 Stephen>  drivers/char/Makefile                      |    1 +
 Stephen>  drivers/char/xilinx_hwicap/Makefile        |    7 +
 Stephen>  drivers/char/xilinx_hwicap/xhwicap_srp.c   |  414 ++++++++++++++++++++
 Stephen>  drivers/char/xilinx_hwicap/xilinx_hwicap.c |  565 ++++++++++++++++++++++++++++
 Stephen>  drivers/char/xilinx_hwicap/xilinx_hwicap.h |  539 ++++++++++++++++++++++++++
 Stephen>  6 files changed, 1531 insertions(+), 0 deletions(-)
 Stephen>  create mode 100644 drivers/char/xilinx_hwicap/Makefile
 Stephen>  create mode 100644 drivers/char/xilinx_hwicap/xhwicap_srp.c
 Stephen>  create mode 100644 drivers/char/xilinx_hwicap/xilinx_hwicap.c
 Stephen>  create mode 100644 drivers/char/xilinx_hwicap/xilinx_hwicap.h

> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index bf18d75..72295cc 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -573,6 +573,11 @@ config HVC_DRIVER
>  	  It will automatically be selected if one of the back-end console drivers
>  	  is selected.

Please don't put the HWICAP option in the middle of the HVC options.

> +config XILINX_HWICAP
> +	tristate "Xilinx OPB HWICAP Support"
> +	depends on XILINX_VIRTEX
> +	help
> +	This option enables support for Xilinx Internal Configuration Access Port (ICAP) driver.

Line too long.

>  
>  config HVC_CONSOLE
>  	bool "pSeries Hypervisor Virtual Console support"
> diff --git a/drivers/char/Makefile b/drivers/char/Makefile
> index 07304d5..8cfcbb0 100644
> --- a/drivers/char/Makefile
> +++ b/drivers/char/Makefile
> @@ -76,6 +76,7 @@ obj-$(CONFIG_EFI_RTC)		+= efirtc.o
>  obj-$(CONFIG_SGI_DS1286)	+= ds1286.o
>  obj-$(CONFIG_SGI_IP27_RTC)	+= ip27-rtc.o
>  obj-$(CONFIG_DS1302)		+= ds1302.o
> +obj-$(CONFIG_XILINX_HWICAP)	+= xilinx_hwicap/
>  ifeq ($(CONFIG_GENERIC_NVRAM),y)
>    obj-$(CONFIG_NVRAM)	+= generic_nvram.o
>  else
> diff --git a/drivers/char/xilinx_hwicap/Makefile b/drivers/char/xilinx_hwicap/Makefile
> new file mode 100644
> index 0000000..818f4e1
> --- /dev/null
> +++ b/drivers/char/xilinx_hwicap/Makefile
> @@ -0,0 +1,7 @@
> +#
> +# Makefile for the Xilinx OPB hwicap driver
> +#
> +
> +obj-$(CONFIG_XILINX_HWICAP) += xilinx_hwicap_m.o 
> + 
> +xilinx_hwicap_m-y := xilinx_hwicap.o xhwicap_srp.o

Those files are both quite small, couldn't you merge them and get rid
of the global symbols and the xilinx_hwicap directory?

> diff --git a/drivers/char/xilinx_hwicap/xhwicap_srp.c b/drivers/char/xilinx_hwicap/xhwicap_srp.c
> new file mode 100644
> index 0000000..388eefe
> --- /dev/null
> +++ b/drivers/char/xilinx_hwicap/xhwicap_srp.c
> @@ -0,0 +1,414 @@
> +/*****************************************************************************
> + *
> + *     Author: Xilinx, Inc.
> + *
> + *     This program is free software; you can redistribute it and/or modify it
> + *     under the terms of the GNU General Public License as published by the
> + *     Free Software Foundation; either version 2 of the License, or (at your
> + *     option) any later version.
> + *
> + *     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
> + *     AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND
> + *     SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,
> + *     OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,
> + *     APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION
> + *     THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,
> + *     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE
> + *     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY
> + *     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
> + *     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
> + *     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
> + *     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
> + *     FOR A PARTICULAR PURPOSE.
> + *
> + *     Xilinx products are not intended for use in life support appliances,
> + *     devices, or systems. Use in such applications is expressly prohibited.
> + *
> + *     (c) Copyright 2003-2007 Xilinx Inc.
> + *     All rights reserved.
> + *
> + *     You should have received a copy of the GNU General Public License along
> + *     with this program; if not, write to the Free Software Foundation, Inc.,
> + *     675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + * ****************************************************************************/

Could you please you a smaller / standard GPL header instead?

> +
> +#include "xilinx_hwicap.h"
> +
> +#define XHI_BUFFER_START 0
> +
> +/****************************************************************************/
> +/**
> + *
> + * Stores data in the storage buffer at the specified address.
> + *
> + * @param    InstancePtr - a pointer to the XHwIcap instance to be worked on.
> + *
> + * @param    Address - bram word address
> + *
> + * @param    Data - data to be stored at address
> + *
> + * @return   None.
> + *
> + * @note     None.
> + *
> +*****************************************************************************/

Please use std kerneldoc format.

> +void XHwIcap_StorageBufferWrite(struct xhwicap_drvdata *InstancePtr,
> +				u32 Address, u32 Data)

No CamelCase, Uppercase parameters.

> +{
> +	/* Write data to storage buffer. */
> +	XHwIcap_mSetBram(InstancePtr->baseAddress, Address, Data);
> +}
> +
> +/****************************************************************************/
> +/**
> + *
> + * Read data from the specified address in the storage buffer..
> + *
> + * @param    InstancePtr - a pointer to the XHwIcap instance to be worked on.
> + *
> + * @param    Address - bram word address
> + *
> + * @return   Data.
> + *
> + * @note     None.
> + *
> +*****************************************************************************/
> +u32 XHwIcap_StorageBufferRead(struct xhwicap_drvdata *InstancePtr, u32 Address)
> +{
> +	u32 Data;
> +
> +	/* Read data from address. Multiply Address by 4 since 4 bytes per
> +	 * word.*/
> +	Data = XHwIcap_mGetBram(InstancePtr->baseAddress, Address);
> +	return Data;
> +
> +}
> +
> +/****************************************************************************/
> +/**
> + *
> + * Reads bytes from the device (ICAP) and puts it in the storage buffer.
> + *
> + * @param    InstancePtr - a pointer to the XHwIcap instance to be worked on.
> + *
> + * @param    Offset - The storage buffer start address.
> + *
> + * @param    NumInts - The number of words (32 bit) to read from the
> + *           device (ICAP).
> + *
> + *@return    int - 0 or -EBUSY or -EINVAL
> + *
> + * @note     None.
> + *
> +*****************************************************************************/
> +int XHwIcap_DeviceRead(struct xhwicap_drvdata *InstancePtr, u32 Offset,
> +		       u32 NumInts)
> +{
> +
> +	s32 Retries = 0;
> +
> +	if (XHwIcap_mGetDoneReg(InstancePtr->baseAddress) == XHI_NOT_FINISHED) {
> +		return -EBUSY;
> +	}

No curly brackets around single statement. In general, please run the
patch through checkpatch.pl and fixup stuff.

> +
> +	if ((Offset + NumInts) <= XHI_MAX_BUFFER_INTS) {
> +		/* setSize NumInts*4 to get bytes. */
> +		XHwIcap_mSetSizeReg((InstancePtr->baseAddress), (NumInts << 2));
> +		XHwIcap_mSetOffsetReg((InstancePtr->baseAddress), Offset);
> +		XHwIcap_mSetRncReg((InstancePtr->baseAddress), XHI_READBACK);
> +
> +		while (XHwIcap_mGetDoneReg(InstancePtr->baseAddress) ==
> +		       XHI_NOT_FINISHED) {
> +			Retries++;
> +			if (Retries > XHI_MAX_RETRIES) {
> +				return -EBUSY;
> +			}
> +		}
> +	} else {
> +		return -EINVAL;
> +	}
> +	return 0;
> +
> +};
> +
> +/****************************************************************************/
> +/**
> + *
> + * Writes bytes from the storage buffer and puts it in the device (ICAP).
> + *
> + * @param    InstancePtr - a pointer to the XHwIcap instance to be worked on.
> + *
> + * @param    Offset - The storage buffer start address.
> + *
> + * @param    NumInts - The number of words (32 bit) to read from the
> + *           device (ICAP).
> + *
> + *@return    int - 0 or -EBUSY or -EINVAL
> + *
> + * @note     None.
> + *
> +*****************************************************************************/
> +int XHwIcap_DeviceWrite(struct xhwicap_drvdata *InstancePtr, u32 Offset,
> +			u32 NumInts)
> +{
> +
> +	s32 Retries = 0;
> +
> +	if (XHwIcap_mGetDoneReg(InstancePtr->baseAddress) == XHI_NOT_FINISHED) {
> +		return -EBUSY;
> +	}
> +
> +	if ((Offset + NumInts) <= XHI_MAX_BUFFER_INTS) {
> +		/* setSize NumInts*4 to get bytes.  */
> +		XHwIcap_mSetSizeReg((InstancePtr->baseAddress), NumInts << 2);
> +		XHwIcap_mSetOffsetReg((InstancePtr->baseAddress), Offset);
> +		XHwIcap_mSetRncReg((InstancePtr->baseAddress), XHI_CONFIGURE);
> +
> +		while (XHwIcap_mGetDoneReg(InstancePtr->baseAddress) ==
> +		       XHI_NOT_FINISHED) {
> +			Retries++;
> +			if (Retries > XHI_MAX_RETRIES) {
> +				return -EBUSY;
> +			}
> +		}
> +	} else {
> +		return -EINVAL;
> +	}
> +	return 0;
> +
> +};
> +
> +/****************************************************************************/
> +/**
> + *
> + * Sends a DESYNC command to the ICAP port.
> + *
> + * @param    InstancePtr - a pointer to the XHwIcap instance to be worked on.
> + *
> + *@return    int - 0 or -EBUSY or -EINVAL
> + *
> + * @note     None.
> + *
> +*****************************************************************************/
> +int XHwIcap_CommandDesync(struct xhwicap_drvdata *InstancePtr)
> +{
> +	int status;
> +
> +	XHwIcap_StorageBufferWrite(InstancePtr, 0,
> +				   (XHwIcap_Type1Write(XHI_CMD) | 1));
> +	XHwIcap_StorageBufferWrite(InstancePtr, 1, XHI_CMD_DESYNCH);
> +	XHwIcap_StorageBufferWrite(InstancePtr, 2, XHI_NOOP_PACKET);
> +	XHwIcap_StorageBufferWrite(InstancePtr, 3, XHI_NOOP_PACKET);
> +
> +	/* send four words */
> +	status = XHwIcap_DeviceWrite(InstancePtr, 0, 4);
> +	if (status) {
> +		return status;
> +	}
> +
> +	return 0;
> +}
> +
> +/****************************************************************************/
> +/**
> + *
> + * Sends a CAPTURE command to the ICAP port.  This command caputres all
> + * of the flip flop states so they will be available during readback.
> + * One can use this command instead of enabling the CAPTURE block in the
> + * design.
> + *
> + * @param    InstancePtr - a pointer to the XHwIcap instance to be worked on.
> + *
> + * @return    int - 0 or -EBUSY or -EINVAL
> + *
> + * @note     None.
> + *
> +*****************************************************************************/
> +int XHwIcap_CommandCapture(struct xhwicap_drvdata *InstancePtr)
> +{
> +	int status;
> +
> +	/* DUMMY and SYNC */
> +	XHwIcap_StorageBufferWrite(InstancePtr, 0, XHI_DUMMY_PACKET);
> +	XHwIcap_StorageBufferWrite(InstancePtr, 1, XHI_SYNC_PACKET);
> +	XHwIcap_StorageBufferWrite(InstancePtr, 2,
> +				   (XHwIcap_Type1Write(XHI_CMD) | 1));
> +	XHwIcap_StorageBufferWrite(InstancePtr, 3, XHI_CMD_GCAPTURE);
> +	XHwIcap_StorageBufferWrite(InstancePtr, 4, XHI_DUMMY_PACKET);
> +	XHwIcap_StorageBufferWrite(InstancePtr, 5, XHI_DUMMY_PACKET);
> +
> +	/* send six words */
> +	status = XHwIcap_DeviceWrite(InstancePtr, 0, 6);
> +	if (status) {		/* send six words */
> +		return status;
> +	}
> +
> +	return 0;
> +}
> +
> +/****************************************************************************/
> +/**
> + *
> + * This function returns the value of the specified configuration
> + * register.
> + *
> + * @param    InstancePtr - a pointer to the XHwIcap instance to be worked
> + * on.
> + *
> + * @param    ConfigReg  - A constant which represents the configuration
> + * register value to be returned. Constants specified in xhwicap_i.h.  Examples:
> + * XHI_IDCODE, XHI_FLR.
> + *
> + * @return   The value of the specified configuration register.
> + *
> + *
> +*****************************************************************************/
> +
> +u32 XHwIcap_GetConfigReg(struct xhwicap_drvdata *InstancePtr, u32 ConfigReg)
> +{
> +	u32 Packet;
> +	int status;
> +
> +	/* Write bitstream to bram */
> +	Packet = XHwIcap_Type1Read(ConfigReg) | 1;
> +	XHwIcap_StorageBufferWrite(InstancePtr, 0, XHI_DUMMY_PACKET);
> +	XHwIcap_StorageBufferWrite(InstancePtr, 1, XHI_SYNC_PACKET);
> +	XHwIcap_StorageBufferWrite(InstancePtr, 2, Packet);
> +	XHwIcap_StorageBufferWrite(InstancePtr, 3, XHI_NOOP_PACKET);
> +	XHwIcap_StorageBufferWrite(InstancePtr, 4, XHI_NOOP_PACKET);
> +
> +	/* Transfer Bitstream from Bram to ICAP */
> +	status = XHwIcap_DeviceWrite(InstancePtr, 0, 5);
> +	if (status) {
> +		return status;
> +	}
> +
> +	/* Now readback one word into bram position
> +	 * XHI_EX_BITSTREAM_LENGTH*/
> +	status = XHwIcap_DeviceRead(InstancePtr, 5, 1);
> +	if (status) {
> +		return status;
> +	}
> +
> +	/* Return the Register value */
> +	return XHwIcap_StorageBufferRead(InstancePtr, 5);
> +}
> +
> +/****************************************************************************
> + *
> + * Loads a partial bitstream from system memory.
> + *
> + * @param    InstancePtr - a pointer to the XHwIcap instance to be worked on.
> + *
> + * @param    Data - Address of the data representing the partial bitstream
> + *
> + * @param    Size - the size of the partial bitstream in 32 bit words.
> + *
> + * @return   0, -EFBIG or -EINVAL.
> + *
> + * @note     None.
> + *
> +*****************************************************************************/
> +int XHwIcap_SetConfiguration(struct xhwicap_drvdata *InstancePtr, u32 *Data,
> +			     u32 Size)
> +{
> +	int status;
> +	s32 BufferCount = 0;
> +	s32 NumWrites = 0;
> +	bool Dirty = 0;
> +	u32 I;
> +
> +	/* Loop through all the data */
> +	for (I = 0, BufferCount = 0; I < Size; I++) {
> +
> +		/* Copy data to bram */
> +		XHwIcap_StorageBufferWrite(InstancePtr, BufferCount, Data[I]);
> +		Dirty = 1;
> +
> +		if (BufferCount == XHI_MAX_BUFFER_INTS - 1) {
> +			/* Write data to ICAP */
> +			status = XHwIcap_DeviceWrite(InstancePtr, XHI_BUFFER_START,
> +						XHI_MAX_BUFFER_INTS);
> +			if (status != 0) {
> +				/* abort. */
> +				XHwIcap_mReset(InstancePtr->baseAddress);					return status;
> +			}
> +
> +			BufferCount = 0;
> +			NumWrites++;
> +			Dirty = 0;
> +		} else {
> +			BufferCount++;
> +		}
> +	}
> +
> +	/* Write unwritten data to ICAP */
> +	if (Dirty) {
> +		/* Write data to ICAP */
> +		status = XHwIcap_DeviceWrite(InstancePtr, XHI_BUFFER_START,
> +					     BufferCount);
> +		if (status != 0) {
> +			/* abort. */
> +			XHwIcap_mReset(InstancePtr->baseAddress);
> +		}
> +		return status;
> +	}
> +
> +	return 0;
> +};
> +
> +/****************************************************************************
> + *
> + * Reads Configuration Data from the device.
> + *
> + * @param    InstancePtr - a pointer to the XHwIcap instance to be worked on.
> + *
> + * @param    Data - Address of the data representing the partial bitstream
> + *
> + * @param    Size - the size of the partial bitstream in 32 bit words.
> + *
> + * @return   0, -EFBIG or -EINVAL.
> + *
> + * @note     None.
> + *
> +*****************************************************************************/
> +int XHwIcap_GetConfiguration(struct xhwicap_drvdata *InstancePtr, u32 *Data,
> +			     u32 Size)
> +{
> +	int status;
> +	s32 BufferCount = 0;
> +	s32 NumReads = 0;
> +	u32 I;
> +
> +	/* Loop through all the data */
> +	for (I = 0, BufferCount = XHI_MAX_BUFFER_INTS; I < Size; I++) {
> +		if (BufferCount == XHI_MAX_BUFFER_INTS) {
> +			u32 intsRemaining = Size - I;
> +			u32 intsToRead =
> +			    intsRemaining <
> +			    XHI_MAX_BUFFER_INTS ? intsRemaining :
> +			    XHI_MAX_BUFFER_INTS;
> +
> +			/* Read data from ICAP */
> +
> +			status =
> +			    XHwIcap_DeviceRead(InstancePtr, XHI_BUFFER_START,
> +					       intsToRead);
> +			if (status != 0) {
> +				/* abort. */
> +				XHwIcap_mReset(InstancePtr->baseAddress);
> +				return status;
> +			}
> +
> +			BufferCount = 0;
> +			NumReads++;
> +		}
> +
> +		/* Copy data from bram */
> +		Data[I] = XHwIcap_StorageBufferRead(InstancePtr, BufferCount);
> +		BufferCount++;
> +	}
> +
> +	return 0;
> +};
> diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
> new file mode 100644
> index 0000000..d42538e
> --- /dev/null
> +++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
> @@ -0,0 +1,565 @@
> +/*****************************************************************************
> + *
> + *     Author: Xilinx, Inc.
> + *
> + *     This program is free software; you can redistribute it and/or modify it
> + *     under the terms of the GNU General Public License as published by the
> + *     Free Software Foundation; either version 2 of the License, or (at your
> + *     option) any later version.
> + *
> + *     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
> + *     AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND
> + *     SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,
> + *     OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,
> + *     APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION
> + *     THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,
> + *     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE
> + *     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY
> + *     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
> + *     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
> + *     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
> + *     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
> + *     FOR A PARTICULAR PURPOSE.
> + *
> + *     Xilinx products are not intended for use in life support appliances,
> + *     devices, or systems. Use in such applications is expressly prohibited.
> + *
> + *     (c) Copyright 2002 Xilinx Inc., Systems Engineering Group
> + *     (c) Copyright 2004 Xilinx Inc., Systems Engineering Group
> + *     (c) Copyright 2007 Xilinx Inc.
> + *     All rights reserved.
> + *
> + *     You should have received a copy of the GNU General Public License along
> + *     with this program; if not, write to the Free Software Foundation, Inc.,
> + *     675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + *****************************************************************************/
> +
> +/*
> + * xilinx_hwicap.c
> + *
> + * This is the code behind /dev/xilinx_icap/'x' -- it allows a user-space
> + * application to use the Xilinx ICAP subsystem.
> + *
> + * A /dev/xilinx_icap/'x' device node represents an arbitrary device
> + * on port 'x'.  The following operations are possible:
> + *
> + * open		do nothing, set up default IEEE 1284 protocol to be COMPAT
> + * release	release port and unregister device (if necessary)
> + * write        Write a bitstream to the configuration processor.
> + * read         Read a data stream from the configuration processor.
> + *
> + * Note that in order to use the read interface, it is first necessary
> + * to write a request packet to the write interface.  i.e., it is not
> + * possible to simply readback the bitstream (or any configuration
> + * bits) from a device without specifically requesting them first.
> + * The code to craft such packets is intended to be part of the
> + * user-space application code that uses this device.  The simplest
> + * way to use this interface is simply:
> + *
> + * cp foo.bit /dev/xilinx_icap
> + *
> + * Note that unless foo.bit is an appropriately constructed partial
> + * bitstream, this has a high likelyhood of overwriting the design
> + * currently programmed in the FPGA.
> + */
> +
> +#include <linux/version.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/ioport.h>
> +#include <linux/interrupt.h>
> +#include <linux/fcntl.h>
> +#include <linux/init.h>
> +#include <linux/poll.h>
> +#include <linux/proc_fs.h>
> +#include <linux/spinlock.h>
> +#include <linux/sysctl.h>
> +#include <linux/version.h>
> +#include <linux/fs.h>
> +#include <linux/cdev.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/io.h>
> +#include <asm/uaccess.h>
> +#include <asm/system.h>
> +
> +#ifdef CONFIG_OF
> +/* For open firmware. */
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#endif
> +
> +#include "xilinx_hwicap.h"
> +
> +#define DRIVER_NAME "xilinx_icap"
> +
> +#define XHWICAP_REGS   (0x10000)
> +
> +/* dynamically allocate device number */
> +static int xhwicap_major = 0;
> +static int xhwicap_minor = 0;
> +static int xhwicap_no_minors = 4;
> +module_param(xhwicap_major, int, S_IRUGO);
> +module_param(xhwicap_minor, int, S_IRUGO);
> +module_param(xhwicap_no_minors, int, S_IRUGO);

Why don't you request official major/minor numbers?
(Documentation/devices.txt)

> +
> +static struct class *icap_class;
> +
> +int xhwicap_initialize_xhwicap(struct xhwicap_drvdata *drvdata)
> +{
> +
> +	u32 DeviceIdCode;
> +	u32 Packet;
> +	int Status;
> +
> +	dev_dbg(drvdata->dev, "Reset...\n");
> +
> +	/* Abort any current transaction, to make sure we have the ICAP in */
> +	/* a good state. */
> +	XHwIcap_mReset(drvdata->baseAddress);
> +
> +	/* Read the IDCODE from ICAP if specified. */
> +	{
> +		dev_dbg(drvdata->dev, "Reading IDCODE...\n");
> +
> +		/* Write bitstream to bram */
> +		Packet = XHwIcap_Type1Read(XHI_IDCODE) | 1;
> +		XHwIcap_StorageBufferWrite(drvdata, 0, XHI_DUMMY_PACKET);
> +		XHwIcap_StorageBufferWrite(drvdata, 1, XHI_SYNC_PACKET);
> +		XHwIcap_StorageBufferWrite(drvdata, 2, Packet);
> +		XHwIcap_StorageBufferWrite(drvdata, 3, XHI_NOOP_PACKET);
> +		XHwIcap_StorageBufferWrite(drvdata, 4, XHI_NOOP_PACKET);
> +
> +		/* Transfer Bitstream from Bram to ICAP */
> +		Status = XHwIcap_DeviceWrite(drvdata, 0, 5);
> +		if (Status) {
> +			return Status;
> +		}
> +
> +		/* Now readback one word into bram position
> +		 * XHI_EX_BITSTREAM_LENGTH*/
> +		Status = XHwIcap_DeviceRead(drvdata, 5, 1);
> +		if (Status) {
> +			return Status;
> +		}
> +
> +		/* Return the Register value */
> +		DeviceIdCode = XHwIcap_StorageBufferRead(drvdata, 5);
> +
> +		/* Mask out the version section of the DeviceIdCode */
> +		DeviceIdCode = DeviceIdCode & 0x0FFFFFFF;
> +
> +		dev_dbg(drvdata->dev, "Desync...\n");
> +		Status = XHwIcap_CommandDesync(drvdata);
> +
> +		if (Status) {
> +			return Status;
> +		}
> +	}
> +
> +	/* Abort any current transaction, to make sure we have the ICAP in */
> +	/* a good state. */
> +	XHwIcap_mReset(drvdata->baseAddress);
> +
> +	dev_info(drvdata->dev, "Device IDCODE = %x\n", DeviceIdCode);
> +
> +	return 0;
> +}
> +
> +static ssize_t
> +xhwicap_read(struct file *file, char *buf, size_t count, loff_t *ppos)
> +{
> +	struct xhwicap_drvdata *drvdata = file->private_data;
> +	ssize_t bytes_to_read = 0;
> +	u32 *kbuf;
> +	u32 words;
> +	u32 bytes_remaining;
> +	int Status;
> +
> +	if (drvdata->read_buffer_in_use) {
> +		/* If there are leftover bytes in the buffer, just */
> +		/* return them and don't try to read more from the */
> +		/* ICAP device. */
> +		bytes_to_read =
> +		    (count <
> +		     drvdata->read_buffer_in_use) ? count : drvdata->
> +		    read_buffer_in_use;
> +
> +		/* Return the data currently in the read buffer. */
> +		if (copy_to_user(buf, drvdata->read_buffer, bytes_to_read)) {
> +			return -EFAULT;
> +		}
> +		drvdata->read_buffer_in_use -= bytes_to_read;
> +		memcpy(drvdata->read_buffer + bytes_to_read,
> +		       drvdata->read_buffer, 4 - bytes_to_read);
> +	} else {
> +		/* Get new data from the ICAP, and return was was requested. */
> +		kbuf = (u32 *) get_zeroed_page(GFP_KERNEL);
> +		if (!kbuf)
> +			return -ENOMEM;
> +
> +		/* The ICAP device is only able to read complete */
> +		/* words.  If a number of bytes that do not correspond */
> +		/* to complete words is requested, then we read enough */
> +		/* words to get the required number of bytes, and then */
> +		/* save the remaining bytes for the next read. */
> +
> +		/* Determine the number of words to read, rounding up */
> +		/* if necessary. */
> +		words = ((count + 3) >> 2);
> +		bytes_to_read = words << 2;
> +
> +		if (bytes_to_read > PAGE_SIZE) {
> +			bytes_to_read = PAGE_SIZE;
> +		}
> +		/* Ensure we only read a complete number of words. */
> +		/* BUG: should be count & 3? */
> +		bytes_remaining = bytes_to_read & 3;
> +		bytes_to_read &= ~3;
> +		words = bytes_to_read >> 2;
> +
> +		Status = XHwIcap_GetConfiguration(drvdata, kbuf, words);
> +		/* If we didn't read correctly, then bail out. */
> +		if (Status) {
> +			free_page((unsigned long)kbuf);
> +			return -EFAULT;
> +		}
> +		/* If we fail to return the data to the user, then bail out. */
> +		if (copy_to_user(buf, kbuf, bytes_to_read)) {
> +			free_page((unsigned long)kbuf);
> +			return -EFAULT;
> +		}
> +		memcpy(kbuf, drvdata->read_buffer, bytes_remaining);
> +		drvdata->read_buffer_in_use = bytes_remaining;
> +		free_page((unsigned long)kbuf);
> +	}
> +	return bytes_to_read;
> +}
> +
> +static ssize_t xhwicap_write(struct file *file, const char *buf,
> +			     size_t count, loff_t *ppos)
> +{
> +	struct xhwicap_drvdata *drvdata = file->private_data;
> +	ssize_t written = 0;
> +	ssize_t left = count;
> +	u32 *kbuf;
> +	int len;
> +	int Status;
> +
> +	left += drvdata->write_buffer_in_use;
> +
> +	/* only write multiples of 4 bytes. */
> +	if (left < 4)
> +		return 0;
> +
> +	kbuf = (u32 *) __get_free_page(GFP_KERNEL);
> +	if (!kbuf)
> +		return -ENOMEM;
> +
> +	while (left > 3) {
> +		/* only write multiples of 4 bytes, so there might */
> +		/* be as many as 3 bytes left (at the end). */
> +		len = left;
> +
> +		if (len > PAGE_SIZE)
> +			len = PAGE_SIZE;
> +		len &= ~3;
> +
> +		if (drvdata->write_buffer_in_use) {
> +			memcpy(kbuf, drvdata->write_buffer,
> +			       drvdata->write_buffer_in_use);
> +			if (copy_from_user
> +			    ((((char *)kbuf) + (drvdata->write_buffer_in_use)),
> +			     buf + written,
> +			     len - (drvdata->write_buffer_in_use))) {
> +				free_page((unsigned long)kbuf);
> +				return -EFAULT;
> +			}
> +		} else {
> +			if (copy_from_user(kbuf, buf + written, len)) {
> +				free_page((unsigned long)kbuf);
> +				return -EFAULT;
> +			}
> +		}
> +
> +		Status = XHwIcap_SetConfiguration(drvdata, kbuf, len >> 2);
> +
> +		if (Status) {
> +			free_page((unsigned long)kbuf);
> +			return -EFAULT;
> +		}
> +		if (drvdata->write_buffer_in_use) {
> +			len -= drvdata->write_buffer_in_use;
> +			left -= drvdata->write_buffer_in_use;
> +			drvdata->write_buffer_in_use = 0;
> +		}
> +		written += len;
> +		left -= len;
> +	}
> +	if ((left > 0) && (left < 4)) {
> +		if (!copy_from_user(drvdata->write_buffer, buf + written, left)) {
> +			drvdata->write_buffer_in_use = left;
> +			written += left;
> +			left = 0;
> +		}
> +	}
> +
> +	free_page((unsigned long)kbuf);
> +	return written;
> +}
> +
> +static int xhwicap_open(struct inode *inode, struct file *file)
> +{
> +	struct xhwicap_drvdata *drvdata;
> +	int status;
> +
> +	drvdata = container_of(inode->i_cdev, struct xhwicap_drvdata, cdev);
> +
> +	status = xhwicap_initialize_xhwicap(drvdata);
> +	if (status) {
> +		dev_err(drvdata->dev, "Failed to open file");
> +		return -status;
> +	}
> +
> +	drvdata->flags = 0;
> +	file->private_data = drvdata;
> +	drvdata->write_buffer_in_use = 0;
> +	drvdata->read_buffer_in_use = 0;
> +
> +	return 0;
> +}
> +
> +static int xhwicap_release(struct inode *inode, struct file *file)
> +{
> +	struct xhwicap_drvdata *drvdata = file->private_data;
> +	int i;
> +	int Status;
> +
> +	if (drvdata->write_buffer_in_use) {
> +		/* Flush write buffer. */
> +		for (i = drvdata->write_buffer_in_use; i < 4; i++) {
> +			drvdata->write_buffer[i] = 0;
> +		}
> +		Status =
> +		    XHwIcap_SetConfiguration(drvdata,
> +					     (u32 *) drvdata->write_buffer, 1);
> +		if (Status) {
> +			return Status;
> +		}
> +	}
> +
> +	Status = XHwIcap_CommandDesync(drvdata);
> +	if (Status) {
> +		return Status;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct file_operations xhwicap_fops = {
> +	.owner = THIS_MODULE,
> +	.write = xhwicap_write,
> +	.read = xhwicap_read,
> +	.open = xhwicap_open,
> +	.release = xhwicap_release,
> +};
> +
> +static int __init xhwicap_drv_probe(struct device *dev)
> +{
> +	dev_t devt;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct xhwicap_drvdata *drvdata = NULL;
> +	struct resource *regs_res;
> +	int retval = 0;
> +
> +	if (!dev) {
> +		return -EINVAL;
> +	}
> +
> +	dev_info(dev, "Xilinx icap port driver\n");
> +
> +	devt = MKDEV(xhwicap_major, xhwicap_minor + pdev->id);
> +
> +	drvdata = kmalloc(sizeof(struct xhwicap_drvdata), GFP_KERNEL);
> +	if (!drvdata) {
> +		dev_err(dev, "Couldn't allocate device private record\n");
> +		return -ENOMEM;
> +	}
> +	memset((void *)drvdata, 0, sizeof(struct xhwicap_drvdata));
> +	dev_set_drvdata(dev, (void *)drvdata);
> +
> +	/* Map the control registers in */
> +	regs_res = platform_get_resource(to_platform_device(dev),
> +					 IORESOURCE_MEM, 0);
> +	if (!regs_res) {
> +		dev_err(dev, "Couldn't get registers resource\n");
> +		retval = -EFAULT;
> +		goto failed1;
> +	}
> +
> +	drvdata->mem_start = regs_res->start;
> +	drvdata->mem_end = regs_res->end;
> +	drvdata->mem_size = regs_res->end - regs_res->start + 1;
> +
> +	if (drvdata->mem_size < XHWICAP_REGS) {
> +		dev_err(dev, "Couldn't get registers resource\n");
> +		retval = -EFAULT;
> +		goto failed1;
> +	}
> +
> +	if (!request_mem_region(drvdata->mem_start, drvdata->mem_size, DRIVER_NAME)) {
> +		dev_err(dev, "Couldn't lock memory region at %p\n",
> +			(void *)regs_res->start);
> +		retval = -EBUSY;
> +		goto failed1;
> +	}
> +
> +	drvdata->devt = devt;
> +	drvdata->dev = dev;
> +	drvdata->baseAddress = ioremap(drvdata->mem_start, drvdata->mem_size);
> +	if (!drvdata->baseAddress) {
> +		dev_err(dev, "ioremap() failed\n");
> +		goto failed2;
> +	}
> +
> +	dev_info(dev, "ioremap %lx to %p with size %x\n",
> +		 (unsigned long int)drvdata->mem_start,
> +			drvdata->baseAddress, drvdata->mem_size);
> +
> +	cdev_init(&drvdata->cdev, &xhwicap_fops);
> +	drvdata->cdev.owner = THIS_MODULE;
> +	retval = cdev_add(&drvdata->cdev, devt, 1);
> +	if (retval) {
> +		dev_err(dev, "cdev_add() failed\n");
> +		goto failed3;
> +	}
> +	/*  devfs_mk_cdev(devt, S_IFCHR|S_IRUGO|S_IWUGO, DRIVER_NAME); */
> +	class_device_create(icap_class, NULL, devt, NULL, DRIVER_NAME);
> +	return 0;		/* success */
> +
> + failed3:
> +	iounmap(drvdata->baseAddress);
> +
> + failed2:
> +	release_mem_region(regs_res->start, drvdata->mem_size);
> +
> + failed1:
> +	kfree(drvdata);
> +
> +	return retval;
> +}
> +
> +static int __exit xhwicap_drv_remove(struct device *dev)
> +{
> +	struct xhwicap_drvdata *drvdata;
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	drvdata = (struct xhwicap_drvdata *)dev_get_drvdata(dev);
> +
> +	class_device_destroy(icap_class, drvdata->devt);
> +	cdev_del(&drvdata->cdev);
> +	iounmap(drvdata->baseAddress);
> +	release_mem_region(drvdata->mem_start, drvdata->mem_size);
> +	kfree(drvdata);
> +	dev_set_drvdata(dev, NULL);
> +
> +	return 0;		/* success */
> +}
> +
> +static struct device_driver xhwicap_module_driver = {
> +	.name = DRIVER_NAME,
> +	.bus = &platform_bus_type,
> +
> +	.probe = xhwicap_drv_probe,
> +	.remove = xhwicap_drv_remove,
> +};

Please use struct platform_driver instead.
> +
> +static int __init xhwicap_module_init(void)
> +{
> +	dev_t devt;
> +	int retval;
> +
> +	icap_class = class_create(THIS_MODULE, "xilinx_config");

What's that for?

> +
> +	if (xhwicap_major) {
> +		devt = MKDEV(xhwicap_major, xhwicap_minor);
> +		retval = register_chrdev_region(devt, xhwicap_no_minors,
> +						DRIVER_NAME);
> +	} else {
> +		retval =
> +		    alloc_chrdev_region(&devt, xhwicap_minor, xhwicap_no_minors,
> +					DRIVER_NAME);
> +		xhwicap_major = MAJOR(devt);
> +	}
> +	if (retval < 0) {
> +		xhwicap_major = 0;
> +		return retval;
> +	}
> +
> +	retval = driver_register(&xhwicap_module_driver);
> +
> +	if (retval) {
> +		unregister_chrdev_region(devt, xhwicap_no_minors);
> +	}
> +
> +	return retval;
> +}
> +
> +static void __exit xhwicap_module_cleanup(void)
> +{
> +	dev_t devt = MKDEV(xhwicap_major, xhwicap_minor);
> +
> +	class_destroy(icap_class);
> +
> +	driver_unregister(&xhwicap_module_driver);
> +
> +	unregister_chrdev_region(devt, xhwicap_no_minors);
> +}
> +
> +module_init(xhwicap_module_init);
> +module_exit(xhwicap_module_cleanup);
> +
> +#ifdef CONFIG_OF
> +
> +static int __init xilinx_hwicap_of_init(void)
> +{
> +	struct device_node *np;
> +	unsigned int i;
> +	struct platform_device *pdev;
> +	int ret;
> +
> +	for (np = NULL, i = 0;
> +	     (np = of_find_compatible_node(np, NULL, "xlnx,opb-hwicap")) != NULL;
> +	     i++) {
> +		struct resource r;
> +
> +		memset(&r, 0, sizeof(r));
> +
> +		ret = of_address_to_resource(np, 0, &r);
> +		if (ret)
> +			goto err;
> +		pdev =
> +		    platform_device_register_simple(DRIVER_NAME, i, &r, 1);
> +
> +		if (IS_ERR(pdev)) {
> +			ret = PTR_ERR(pdev);
> +			goto err;
> +		}
> +	}
> +
> +	return 0;
> +err:
> +	return ret;
> +}
> +
> +module_init(xilinx_hwicap_of_init);
> +
> +#endif
> +
> +MODULE_AUTHOR("Xilinx, Inc; Xilinx Research Labs Group");
> +MODULE_DESCRIPTION("Xilinx ICAP Port Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.h b/drivers/char/xilinx_hwicap/xilinx_hwicap.h
> new file mode 100644
> index 0000000..80e3fe0
> --- /dev/null
> +++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.h
> @@ -0,0 +1,539 @@
> +/*****************************************************************************
> + *
> + *     Author: Xilinx, Inc.
> + *
> + *     This program is free software; you can redistribute it and/or modify it
> + *     under the terms of the GNU General Public License as published by the
> + *     Free Software Foundation; either version 2 of the License, or (at your
> + *     option) any later version.
> + *
> + *     XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
> + *     AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND
> + *     SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,
> + *     OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,
> + *     APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION
> + *     THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,
> + *     AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE
> + *     FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY
> + *     WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
> + *     IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
> + *     REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
> + *     INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
> + *     FOR A PARTICULAR PURPOSE.
> + *
> + *     Xilinx products are not intended for use in life support appliances,
> + *     devices, or systems. Use in such applications is expressly prohibited.
> + *
> + *     (c) Copyright 2003-2007 Xilinx Inc.
> + *     All rights reserved.
> + *
> + *     You should have received a copy of the GNU General Public License along
> + *     with this program; if not, write to the Free Software Foundation, Inc.,
> + *     675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + *****************************************************************************/
> +
> +#ifndef XILINX_HWICAP_H_	/* prevent circular inclusions */
> +#define XILINX_HWICAP_H_	/* by using protection macros */
> +
> +#include <linux/types.h>
> +#include <linux/cdev.h>
> +#include <linux/version.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/io.h>
> +
> +struct xhwicap_drvdata {
> +	u32 flags;
> +	u32 write_buffer_in_use;  /* Always in [0,3] */
> +	u8 write_buffer[4];
> +	u32 read_buffer_in_use;	  /* Always in [0,3] */
> +	u8 read_buffer[4];
> +	u32 mem_start;		  /* phys. address of the control registers */
> +	u32 mem_end;		  /* phys. address of the control registers */
> +	u32 mem_size;
> +	void __iomem *baseAddress;/* virt. address of the control registers */
> +
> +	struct device *dev;
> +	struct cdev cdev;	/* Char device structure */
> +	dev_t devt;
> +};
> +
> +/***************************** Include Files ********************************/
> +
> +#define virtex2 0
> +#define virtex4 1
> +
> +#ifdef CONFIG_XILINX_VIRTEX_4_FX
> +#define XHI_FAMILY virtex4
> +#else
> +#define XHI_FAMILY virtex2
> +#endif

So having a single kernel with v2p/v4 support is not an option?

> +
> +/************************** Constant Definitions ****************************/
> +
> +#define XHI_PAD_FRAMES              0x1
> +
> +/* Mask for calculating configuration packet headers */
> +#define XHI_WORD_COUNT_MASK_TYPE_1  0x7FFUL
> +#define XHI_WORD_COUNT_MASK_TYPE_2  0x1FFFFFUL
> +#define XHI_TYPE_MASK               0x7
> +#define XHI_REGISTER_MASK           0xF
> +#define XHI_OP_MASK                 0x3
> +
> +#define XHI_TYPE_SHIFT              29
> +#define XHI_REGISTER_SHIFT          13
> +#define XHI_OP_SHIFT                27
> +
> +#define XHI_TYPE_1                  1
> +#define XHI_TYPE_2                  2
> +#define XHI_OP_WRITE                2
> +#define XHI_OP_READ                 1
> +
> +/* Address Block Types */
> +#define XHI_FAR_CLB_BLOCK           0
> +#define XHI_FAR_BRAM_BLOCK          1
> +#define XHI_FAR_BRAM_INT_BLOCK      2
> +
> +/* Addresses of the Configuration Registers */
> +#define XHI_CRC                     0
> +#define XHI_FAR                     1
> +#define XHI_FDRI                    2
> +#define XHI_FDRO                    3
> +#define XHI_CMD                     4
> +#define XHI_CTL                     5
> +#define XHI_MASK                    6
> +#define XHI_STAT                    7
> +#define XHI_LOUT                    8
> +#define XHI_COR                     9
> +#define XHI_MFWR                    10
> +
> +#if XHI_FAMILY == virtex4
> +
> +#define XHI_CBC                     11
> +#define XHI_IDCODE                  12
> +#define XHI_AXSS                    13
> +#define XHI_NUM_REGISTERS           14
> +
> +#else
> +
> +#define XHI_FLR                     11
> +#define XHI_KEY                     12
> +#define XHI_CBC                     13
> +#define XHI_IDCODE                  14
> +#define XHI_NUM_REGISTERS           15
> +
> +#endif
> +
> +/* Configuration Commands */
> +#define XHI_CMD_NULL                0
> +#define XHI_CMD_WCFG                1
> +#define XHI_CMD_MFW                 2
> +#define XHI_CMD_DGHIGH              3
> +#define XHI_CMD_RCFG                4
> +#define XHI_CMD_START               5
> +#define XHI_CMD_RCAP                6
> +#define XHI_CMD_RCRC                7
> +#define XHI_CMD_AGHIGH              8
> +#define XHI_CMD_SWITCH              9
> +#define XHI_CMD_GRESTORE            10
> +#define XHI_CMD_SHUTDOWN            11
> +#define XHI_CMD_GCAPTURE            12
> +#define XHI_CMD_DESYNCH             13
> +
> +/* Packet constants */
> +#define XHI_SYNC_PACKET             0xAA995566UL
> +#define XHI_DUMMY_PACKET            0xFFFFFFFFUL
> +#define XHI_NOOP_PACKET             (XHI_TYPE_1 << XHI_TYPE_SHIFT)
> +#define XHI_TYPE_2_READ ((XHI_TYPE_2 << XHI_TYPE_SHIFT) | \
> +			(XHI_OP_READ << XHI_OP_SHIFT))
> +
> +#define XHI_TYPE_2_WRITE ((XHI_TYPE_2 << XHI_TYPE_SHIFT) | \
> +			(XHI_OP_WRITE << XHI_OP_SHIFT))
> +
> +#define XHI_TYPE2_CNT_MASK          0x07FFFFFF
> +
> +#define XHI_TYPE_1_PACKET_MAX_WORDS 2047UL
> +#define XHI_TYPE_1_HEADER_BYTES     4
> +#define XHI_TYPE_2_HEADER_BYTES     8
> +
> +/* Indicates how many bytes will fit in a buffer. (1 BRAM) */
> +#define XHI_MAX_BUFFER_BYTES        2048
> +#define XHI_MAX_BUFFER_INTS         512
> +
> +/* Number of frames in different tile types */
> +#if XHI_FAMILY == virtex4
> +
> +#define XHI_GCLK_FRAMES             3
> +#define XHI_IOB_FRAMES              30
> +#define XHI_DSP_FRAMES              21
> +#define XHI_CLB_FRAMES              22
> +#define XHI_BRAM_FRAMES             64
> +#define XHI_BRAM_INT_FRAMES         20
> +
> +#else
> +
> +#define XHI_GCLK_FRAMES             4
> +#define XHI_IOB_FRAMES              4
> +#define XHI_IOI_FRAMES              22
> +#define XHI_CLB_FRAMES              22
> +#define XHI_BRAM_FRAMES             64
> +#define XHI_BRAM_INT_FRAMES         22
> +
> +#endif
> +
> +/* Device Resources */
> +#define CLB                         0
> +#define DSP                         1
> +#define BRAM                        2
> +#define BRAM_INT                    3
> +#define IOB                         4
> +#define IOI                         5
> +#define CLK                         6
> +#define MGT                         7
> +
> +#define BLOCKTYPE0                  0
> +#define BLOCKTYPE1                  1
> +#define BLOCKTYPE2                  2
> +
> +/* The number of words reserved for the header in the storage buffer. */
> +/* MAY CHANGE FOR V4 */
> +#define XHI_HEADER_BUFFER_WORDS     20
> +#define XHI_HEADER_BUFFER_BYTES     (XHI_HEADER_BUFFER_WORDS << 2)
> +
> +/* CLB major frames start at 3 for the first column (since we are using
> + * column numbers that start at 1, when the column is added to this offset,
> + * that first one will be 3 as required. */
> +#define XHI_CLB_MAJOR_FRAME_OFFSET  2
> +
> +/* File access and error constants */
> +#define XHI_DEVICE_READ_ERROR       -1
> +#define XHI_DEVICE_WRITE_ERROR      -2
> +#define XHI_BUFFER_OVERFLOW_ERROR   -3
> +
> +#define XHI_DEVICE_READ             0x1
> +#define XHI_DEVICE_WRITE            0x0
> +
> +/* Constants for checking transfer status */
> +#define XHI_CYCLE_DONE              0
> +#define XHI_CYCLE_EXECUTING         1
> +
> +/* Constant to use for CRC check when CRC has been disabled */
> +#define XHI_DISABLED_AUTO_CRC       0x0000DEFCUL
> +
> +/* Major Row Offset */
> +#define XHI_CLB_MAJOR_ROW_OFFSET 96+(32*XHI_HEADER_BUFFER_WORDS)-1
> +
> +/* Number of times to poll the done regsiter */
> +#define XHI_MAX_RETRIES     1000
> +
> +/************************** Constant Definitions ****************************/
> +
> +/* XHwIcap register offsets */
> +
> +/* Size of transfer, read & write */
> +#define XHI_SIZE_REG_OFFSET        0x800L
> +/* Offset into bram, read & write */
> +#define XHI_BRAM_OFFSET_REG_OFFSET 0x804L
> +/* Read not Configure, direction of transfer.  Write only */
> +#define XHI_RNC_REG_OFFSET         0x808L
> +/* Indicates transfer complete. Read only */
> +#define XHI_STATUS_REG_OFFSET      0x80CL
> +
> +/* Constants for setting the RNC register */
> +#define XHI_CONFIGURE              0x0UL
> +#define XHI_READBACK               0x1UL
> +
> +/* Constants for the Done register */
> +#define XHI_NOT_FINISHED           0x0UL
> +#define XHI_FINISHED               0x1UL
> +
> +/**************************** Type Definitions ******************************/
> +
> +/***************** Macros (Inline Functions) Definitions ********************/
> +
> +/****************************************************************************/
> +/**
> +*
> +* Get the contents of the size register.
> +*
> +* The size register holds the number of 32 bit words to transfer between
> +* bram and the icap (or icap to bram).
> +*
> +* @param    BaseAddress is the  base address of the device
> +*
> +* @return   A 32-bit value representing the contents of the size
> +* register.
> +*
> +* @note
> +*
> +* u32 XHwIcap_mGetSizeReg(u32 BaseAddress);
> +*
> +*****************************************************************************/
> +#define XHwIcap_mGetSizeReg(BaseAddress) \
> +    (in_be32((u32 *)((BaseAddress) + XHI_SIZE_REG_OFFSET)))
> +
> +/****************************************************************************/

Why not a single getter with a offset/register parameter instead of
all these? And use inline functions instead of macros.

> +/**
> +*
> +* Get the contents of the bram offset register.
> +*
> +* The bram offset register holds the starting bram address to transfer
> +* data from during configuration or write data to during readback.
> +*
> +* @param    BaseAddress is the  base address of the device
> +*
> +* @return   A 32-bit value representing the contents of the bram offset
> +* register.
> +*
> +* @note
> +*
> +* u32 XHwIcap_mGetOffsetReg(u32 BaseAddress);
> +*
> +*****************************************************************************/
> +#define XHwIcap_mGetOffsetReg(BaseAddress) \
> +    (in_be32((u32 *)((BaseAddress + XHI_BRAM_OFFSET_REG_OFFSET))))
> +
> +/****************************************************************************/
> +/**
> +*
> +* Get the contents of the done register.
> +*
> +* The done register is set to zero during configuration or readback.
> +* When the current configuration or readback completes the done register
> +* is set to one.
> +*
> +* @param    BaseAddress is the base address of the device
> +*
> +* @return   A 32-bit value with bit 1 representing done or not
> +*
> +* @note
> +*
> +* u32 XHwIcap_mGetDoneReg(u32 BaseAddress);
> +*
> +*****************************************************************************/
> +
> +#define XHwIcap_mGetDoneReg(BaseAddress) \
> +    (in_be32((u32 *)((BaseAddress + XHI_STATUS_REG_OFFSET))) & 1)
> +
> +/****************************************************************************/
> +/**
> +*
> +* Get the contents of the status register.
> +*
> +* The status register contains the ICAP status and the done bit.
> +*
> +* D8 - cfgerr
> +* D7 - dalign
> +* D6 - rip
> +* D5 - in_abort_l
> +* D4 - Always 1
> +* D3 - Always 1
> +* D2 - Always 1
> +* D1 - Always 1
> +* D0 - Done bit
> +*
> +* @param    BaseAddress is the base address of the device
> +*
> +* @return   A 32-bit value representing the contents of the status register
> +*
> +* @note
> +*
> +* u32 XHwIcap_mGetStatusReg(u32 BaseAddress);
> +*
> +*****************************************************************************/
> +
> +#define XHwIcap_mGetStatusReg(BaseAddress) \
> +    (in_be32((u32 *)((BaseAddress + XHI_STATUS_REG_OFFSET))))
> +
> +#define XHwIcap_mReset(BaseAddress) \
> +    (out_be32((u32 *)((BaseAddress + XHI_STATUS_REG_OFFSET)), 0xFEFE))
> +
> +/****************************************************************************/
> +/**
> +* Reads data from the storage buffer bram.
> +*
> +* A bram is used as a configuration memory cache.  One frame of data can
> +* be stored in this "storage buffer".
> +*
> +* @param    BaseAddress - contains the base address of the component.
> +*
> +* @param    Offset - The offset into which the data should be read.
> +*
> +* @return   The value of the specified offset in the bram.
> +*
> +* @note
> +*
> +* u32 XHwIcap_mGetBram(u32 BaseAddress, u32 Offset);
> +*
> +*****************************************************************************/
> +#define XHwIcap_mGetBram(BaseAddress, Offset) \
> +    (in_be32((u32 *)((BaseAddress+(Offset<<2)))))
> +
> +/****************************************************************************/
> +/**
> +* Set the size register.
> +*
> +* The size register holds the number of 8 bit bytes to transfer between
> +* bram and the icap (or icap to bram).
> +*
> +* @param    BaseAddress - contains the base address of the device.
> +*
> +* @param    Data - The size in bytes.
> +*
> +* @return   None.
> +*
> +* @note
> +*
> +* void XHwIcap_mSetSizeReg(u32 BaseAddress, u32 Data);
> +*
> +*****************************************************************************/
> +#define XHwIcap_mSetSizeReg(BaseAddress, Data) \
> +    (out_be32((u32 *)((BaseAddress) + XHI_SIZE_REG_OFFSET), (Data)))
> +
> +/****************************************************************************/
> +/**
> +* Set the bram offset register.
> +*
> +* The bram offset register holds the starting bram address to transfer
> +* data from during configuration or write data to during readback.
> +*
> +* @param    BaseAddress contains the base address of the device.
> +*
> +* @param    Data is the value to be written to the data register.
> +*
> +* @return   None.
> +*
> +* @note
> +*
> +* void XHwIcap_mSetOffsetReg(u32 BaseAddress, u32 Data);
> +*
> +*****************************************************************************/
> +#define XHwIcap_mSetOffsetReg(BaseAddress, Data) \
> +    (out_be32((u32 *)((BaseAddress) + XHI_BRAM_OFFSET_REG_OFFSET), (Data)))
> +
> +/****************************************************************************/
> +/**
> +* Set the RNC (Readback not Configure) register.
> +*
> +* The RNC register determines the direction of the data transfer.  It
> +* controls whether a configuration or readback take place.  Writing to
> +* this register initiates the transfer.  A value of 1 initiates a
> +* readback while writing a value of 0 initiates a configuration.
> +*
> +* @param    BaseAddress contains the base address of the device.
> +*
> +* @param    Data is the value to be written to the data register.
> +*
> +* @return   None.
> +*
> +* @note
> +*
> +* void XHwIcap_mSetRncReg(u32 BaseAddress, u32 Data);
> +*
> +*****************************************************************************/
> +#define XHwIcap_mSetRncReg(BaseAddress, Data) \
> +    (out_be32((u32 *)((BaseAddress) + XHI_RNC_REG_OFFSET), (Data)))
> +
> +/****************************************************************************/
> +/**
> +* Write data to the storage buffer bram.
> +*
> +* A bram is used as a configuration memory cache.  One frame of data can
> +* be stored in this "storage buffer".
> +*
> +* @param    BaseAddress - contains the base address of the component.
> +*
> +* @param    Offset - The offset into which the data should be written.
> +*
> +* @param    Data - The value to be written to the bram offset.
> +*
> +* @return   None.
> +*
> +* @note
> +*
> +* void XHwIcap_mSetBram(u32 BaseAddress, u32 Offset, u32 Data);
> +*
> +*****************************************************************************/
> +#define XHwIcap_mSetBram(BaseAddress, Offset, Data) \
> +    (out_be32((u32 *)((BaseAddress+(Offset<<2))), (Data)))
> +
> +/****************************************************************************/
> +/**
> +*
> +* Generates a Type 1 packet header that reads back the requested configuration
> +* register.
> +*
> +* @param    Register is the address of the register to be read back.
> +*           Register constants are defined in this file.
> +*
> +* @return   Type 1 packet header to read the specified register
> +*
> +* @note     None.
> +*
> +*****************************************************************************/
> +#define XHwIcap_Type1Read(Register) \
> +    ((XHI_TYPE_1 << XHI_TYPE_SHIFT) | (Register << XHI_REGISTER_SHIFT) | \
> +    (XHI_OP_READ << XHI_OP_SHIFT))
> +
> +/****************************************************************************/
> +/**
> +*
> +* Generates a Type 1 packet header that writes to the requested
> +* configuration register.
> +*
> +* @param    Register is the address of the register to be written to.
> +*           Register constants are defined in this file.
> +*
> +* @return   Type 1 packet header to write the specified register
> +*
> +* @note     None.
> +*
> +*****************************************************************************/
> +#define XHwIcap_Type1Write(Register) \
> +    ((XHI_TYPE_1 << XHI_TYPE_SHIFT) | (Register << XHI_REGISTER_SHIFT) | \
> +    (XHI_OP_WRITE << XHI_OP_SHIFT))
> +
> +/************************** Function Prototypes *****************************/
> +
> +/* These functions are the ones defined in the lower level
> + * Self-Reconfiguration Platform (SRP) API.
> + */
> +
> +/* Initializes a XHwIcap instance.. */
> +int XHwIcap_Initialize(struct xhwicap_drvdata *InstancePtr, u16 DeviceId,
> +		       u32 DeviceIdCode);
> +
> +/* Reads integers from the device into the storage buffer. */
> +int XHwIcap_DeviceRead(struct xhwicap_drvdata *InstancePtr, u32 Offset,
> +		       u32 NumInts);
> +
> +/* Writes integers to the device from the storage buffer. */
> +int XHwIcap_DeviceWrite(struct xhwicap_drvdata *InstancePtr, u32 Offset,
> +			u32 NumInts);
> +
> +/* Writes word to the storage buffer. */
> +void XHwIcap_StorageBufferWrite(struct xhwicap_drvdata *InstancePtr,
> +				u32 Address, u32 Data);
> +
> +/* Reads word from the storage buffer. */
> +u32 XHwIcap_StorageBufferRead(struct xhwicap_drvdata *InstancePtr, u32 Address);
> +
> +/* Loads a partial bitstream from system memory. */
> +int XHwIcap_SetConfiguration(struct xhwicap_drvdata *InstancePtr, u32 *Data,
> +			     u32 Size);
> +
> +/* Loads a partial bitstream from system memory. */
> +int XHwIcap_GetConfiguration(struct xhwicap_drvdata *InstancePtr, u32 *Data,
> +			     u32 Size);
> +
> +/* Sends a DESYNC command to the ICAP */
> +int XHwIcap_CommandDesync(struct xhwicap_drvdata *InstancePtr);
> +
> +/* Sends a CAPTURE command to the ICAP */
> +int XHwIcap_CommandCapture(struct xhwicap_drvdata *InstancePtr);
> +
> +/* Returns the value of the specified configuration register */
> +u32 XHwIcap_GetConfigReg(struct xhwicap_drvdata *InstancePtr, u32 ConfigReg);
> +
> +#endif
> -- 
> 1.5.3.4-dirty
> 
-- 
Bye, Peter Korsgaard
