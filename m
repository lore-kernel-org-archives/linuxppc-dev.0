Message-Id: <scb46c71.007@mx.amx.com>
Date: Wed, 10 Apr 2002 16:46:31 -0500
From: "Chuck Partridge" <Chuck_Partridge@amx.com>
To: <gallen@arlut.utexas.edu>, <jim@musenki.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: MPC8245 Internal Duart and Linux
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I have followed Jim and Greg's thread on LinuxPPC.org linuxppc-embedded about the 8245 DUARTs under Linux and have a few questions.

I am also trying to get the 8245's internal DUART working under Linux (MVL 2.4.17) and have encountered a problem.

Here's what I've done. (Almost exactly what Greg says  on  http://lists.linuxppc.org/linuxppc-embedded/200202/msg00056.html )

1. In PPCBoot I set the EUMBBAR to 0xfc000000
2. In my $(PLATFORM).map_io function I call io_block_mapping(0xfc000000,0xfc000000,0x04000000,_PAGE_IO);
to map the  EUMB area and the 8245 internal MPC107 PCI IO space.
3. Call mpc10x_bridge_init() with 0xfc000000 instead of MPC10X_MAPB_EUMB_BASE as the last parameter.

I can access the internal DUART and get debug (ppc_md.progress) and printk up until the IDE driver tries to probe the IO ports in the IDE controller.  Once that happens, it hangs.  I'm also guessing this is the first "real" IO access in the boot process, but that's just a guess.

I first tried this kernel port using a 16550 UART built into the ALI South Bridge that is on my board.  That boots complete and runs fine.
If I change my debug port (i.e. progress) routines to the ALI 16550, but use the 8245 DUART as my console, it runs farther in the boot process and gets past the IDE probe, but eventually hangs also.

It appears to me it has something to do with IO mappings, or some issue along that line, but I'm at a loss at what to look at next.
I had a similar hang in PPCBoot on another board when I tried to access RCS2 when no BAT had been mapped to 0x70000000.  Even the BDI reacts the same way (all memory reads as 0, even the internal registers like EUMBBAR), but that shouldn't be an issue since the MMU is fully running and handling page faults, etc (as opposed to PPCBoot which only has the BATs on).
.
Any ideas on where to look next??

I've tried io_block_mapping(0xf0000000,0xf0000000,0x10000000,_PAGE_IO);  as Greg said and had the same result.

Also my $(PLATFORM)_serial.h looks like:

/*
 * arch/ppc/platforms/amx2275_serial.h
 *
 * Definitions for AMX2275
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

#ifndef __ASMPPC_AMX2275_SERIAL_H
#define __ASMPPC_AMX2275_SERIAL_H

#include <linux/config.h>

#define AMX2275_SERIAL_0      0xfe0003f8
#define AMX2275_SERIAL_1      0xfe0002f8
#define AMX2275_SERIAL_2      0xfc004500
#define AMX2275_SERIAL_3      0xfc004600

#ifdef CONFIG_SERIAL_MANY_PORTS
#define RS_TABLE_SIZE  64
#else
#define RS_TABLE_SIZE  4
#endif

#define AMX2275_DEBUG_PORT 0

/* Rate for the 1.8432 Mhz clock for the onboard serial chip */
#define BASE_BAUD ( 1843200 / 16 )
#define BASE_BAUD_8245_DUART (100000000 / 16)

#ifdef CONFIG_SERIAL_DETECT_IRQ
#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF|ASYNC_SKIP_TEST|ASYNC_AUTO_IRQ)
#else
#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF|ASYNC_SKIP_TEST)
#endif

#define STD_SERIAL_PORT_DFNS                                            \
        { 0, BASE_BAUD, AMX2275_SERIAL_0, 4, STD_COM_FLAGS, /* ttyS0 */ \
        iomem_base: (u8 *)AMX2275_SERIAL_0,                             \
        io_type: SERIAL_IO_MEM },                                       \
        { 0, BASE_BAUD, AMX2275_SERIAL_1, 3, STD_COM_FLAGS, /* ttyS1 */ \
        iomem_base: (u8 *)AMX2275_SERIAL_1,                             \
        io_type: SERIAL_IO_MEM },                                       \
        { 0, BASE_BAUD_8245_DUART, AMX2275_SERIAL_2, 9, STD_COM_FLAGS, /* ttyS2 */ \
        iomem_base: (u8 *)AMX2275_SERIAL_2,                             \
        io_type: SERIAL_IO_MEM },                                       \
        { 0, BASE_BAUD_8245_DUART, AMX2275_SERIAL_3, 9, STD_COM_FLAGS, /* ttyS3 */ \
        iomem_base: (u8 *)AMX2275_SERIAL_3,                             \
        io_type: SERIAL_IO_MEM },


#define SERIAL_PORT_DFNS \
        STD_SERIAL_PORT_DFNS

#endif /* __ASMPPC_AMX2275_SERIAL_H */

Thanks,

Chuck Partridge
Manager - Hardware/Firmware Engineering
AMX Corp.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
