From: Jim Thompson <jim@musenki.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15445.41682.631919.431117@gargle.gargle.HOWL>
Date: Mon, 28 Jan 2002 13:13:22 -0600
To: linuxppc-embedded@lists.linuxppc.org
Cc: mgreer@mvista.com
Subject: early kernel serial port fun (not)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm working at getting the on-board serial port(s) on a MPC8245
working on a Sandpoint X3 platform.

Things boot just fine when using the 'normal' UARTs (on the Sandpoint
motherboard.)

I've got the on-chip serial ports enabled in ppcboot.  I tftp my
kernel in, and boot it, but things seem to go wrong soon after the
text pages are mapped.

The on-chip serial port is at 0xfc004500 (the 2nd one is at
0xfc004600).

## Booting image at 00100000 ...
   Image Name:   sandpoint 2.4.14 test
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    648565 Bytes = 633 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
id mach(): doneMMU:enterMMU:hw initMMU:mapinMMU:setioMMU:exitMMU

Obviously, I've set 'CONFIG_SERIAL_TEXT_DEBUG' to get even this.

Below is the hacked sandpoint_serial.h  (I'll make it pretty after it
works.)

Does anyone have clue to offer here?

Thanks,
Jim

(p.s. for those of you wondering why the on-X3 serial ports aren't
 good enough, I have an 8245 board that uses the on-chip ones. The
 next step is to get linux running on the musenki board, thus the
 experimentation on 'known/working' hardware.)


/*
 * include/asm-ppc/sandpoint_serial.h
 *
 * Definitions for Motorola SPS Sandpoint Test Platform
 *
 * Author: Mark A. Greer
 *         mgreer@mvista.com
 *
 * Copyright 2001 MontaVista Software Inc.
 *
 * This program is free software; you can redistribute  it and/or modify it
 * under  the terms of  the GNU General  Public License as published by the
 * Free Software Foundation;  either version 2 of the  License, or (at your
 * option) any later version.
 */

#ifndef __ASMPPC_SANDPOINT_SERIAL_H
#define __ASMPPC_SANDPOINT_SERIAL_H

#include <linux/config.h>

#if 0 /* normal serial port support */
#define SANDPOINT_SERIAL_0		0xfe0003f8
#define SANDPOINT_SERIAL_1		0xfe0002f8

#ifdef CONFIG_SERIAL_MANY_PORTS
#define RS_TABLE_SIZE  64
#else
#define RS_TABLE_SIZE  2
#endif

/* Rate for the 1.8432 Mhz clock for the onboard serial chip */
#define BASE_BAUD ( 1843200 / 16 )

#ifdef CONFIG_SERIAL_DETECT_IRQ
#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF|ASYNC_SKIP_TEST|ASYNC_AUTO_IRQ)
#else
#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF|ASYNC_SKIP_TEST)
#endif

#define STD_SERIAL_PORT_DFNS \
        { 0, BASE_BAUD, SANDPOINT_SERIAL_0, 4, STD_COM_FLAGS, /* ttyS0 */ \
		iomem_base: (u8 *)SANDPOINT_SERIAL_0,			  \
		io_type: SERIAL_IO_MEM },				  \
        { 0, BASE_BAUD, SANDPOINT_SERIAL_1, 3, STD_COM_FLAGS, /* ttyS1 */ \
		iomem_base: (u8 *)SANDPOINT_SERIAL_1,			  \
		io_type: SERIAL_IO_MEM },

#else /* use on-chip DUART */

#define RS_TABLE_SIZE 1
#define BASE_BAUD ( 100000000 / 16 )
#define STD_COM_FLAGS ( ASYNC_BOOT_AUTOCONF|ASYNC_SKIP_TEST )
#define DUART0 0xfc004500
#define STD_SERIAL_PORT_DFNS \
        { 0, BASE_BAUD, DUART0, 21, STD_COM_FLAGS, /* ttyS0 */ \
		iomem_base: (u8 *)DUART0,		  \
		io_type: SERIAL_IO_MEM },

#endif

#define SERIAL_PORT_DFNS \
        STD_SERIAL_PORT_DFNS

#endif /* __ASMPPC_SANDPOINT_SERIAL_H */


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
