From: Jim Thompson <jim@musenki.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15459.39315.24099.290943@gargle.gargle.HOWL>
Date: Fri, 8 Feb 2002 03:25:39 -0600
To: linuxppc-embedded@lists.linuxppc.org
Cc: ppcboot-users@lists.sourceforge.net, Wolfgang Denk <wd@denx.de>
Subject: serial ports on 8245
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm having some trouble booting linux with MPC8245-based boards and
the 8245/8241 onchip serial ports.

(I submitted the patches to Wolfgang earlier today to support the
8245's on-chip serial ports in ppcboot. These work fine (downloading
srecords, etc.))

All the below is for the Sandpoint, but we've got custom hardware
(sans any off-chip serial ports) as the real target.

    PPCBoot 1.1.5 (Feb  7 2002 - 23:48:47)

    CPU:   MPC8245 Revision 16.20 at 249.999 MHz: 16 kB I-Cache 16 kB D-Cache
    Board: Sandpoint 8245 Unity ##Test not implemented yet##
    DRAM:  64 MB
    FLASH:  2 MB
    PCI:    scanning bus0 ...
      bus dev fn venID devID class  rev MBAR0    MBAR1    IPIN ILINE
      00  00  00 1057  0006  060000 11  00000008 00000000 01   00
      00  0b  00 10ad  0565  060100 10  00000000 00000000 00   00
      00  0f  00 8086  1030  020000 08  80000000 80000001 01   00
    In:    serial
    Out:   serial
    Err:   serial
    Hit any key to stop autoboot:  0
    eth: Intel i82559 PCI EtherExpressPro @0x80000000(bus=0, device=15, func=0)
    ARP broadcast 1
    TFTP from server 192.168.0.8; our IP address is 192.168.0.42
    Filename 'linux'.
    Load address: 0x100000
    Loading: #################################################################
	     ##############################################################
    done
    Bytes transferred = 648678 (9e5e6 hex)
    Automatic boot of image at addr 0x00100000 ...
    ## Booting image at 00100000 ...
       Image Name:   Sandpoint 2.4.18-pre7 (test)
       Image Type:   PowerPC Linux Kernel Image (gzip compressed)
       Data Size:    648614 Bytes = 633 kB = 0 MB
       Load Address: 00000000
       Entry Point:  00000000
       Verifying Checksum ... OK
       Uncompressing Kernel Image ... OK
    id mach(): doneMMU:enterMMU:hwinitMMU:mapinMMU:setioMMU:exitsetup_arch: entersetup_arch:bootmemmpc10x:enter

Yes, clocks_in_mhz is unset, and this is a 2.4.18 kernel (basically
the montavista 2_4_devel tree.)

A bit of probing around (well-placed  ppc_md_progress() calls) shows
that the serial port is fine until this call at the end of mpc10x_bridge_init()

                /* Set base addr of the 8240/107 EUMB.  */
                early_write_config_dword(hose,
                                         0,
                                         PCI_DEVFN(0,0),
                                         MPC10X_CFG_EUMBBAR,
                                         phys_eumb_base);


After which the serial port goes away.  Not suprising when you
understand that (EUMBBAR+0x4500) is the address of the first on-chip
serial port, and its getting changed from where we set it in PPCBoot.

Check this:

    include/asm-ppc/mpc10x.h"
    #define MPC10X_EUMB_SIZE                0x00100000 /* Total EUMB size (1MB) */
    [...]
    extern unsigned long                    ioremap_base;
    #define MPC10X_MAPA_EUMB_BASE           (ioremap_base - MPC10X_EUMB_SIZE)
    #define MPC10X_MAPB_EUMB_BASE           MPC10X_MAPA_EUMB_BASE

and

    arch/ppc/mm/init.c:
    #ifdef CONFIG_HIGHMEM
	    ioremap_base = PKMAP_BASE;
    #else
	    ioremap_base = 0xfc000000UL;    /* for now, could be 0xfffff000 */
    #endif /* CONFIG_HIGHMEM */

So config reg 0x78 (EUMBBAR) gets set of 0xfc000000 - 0x00100000, or 0xfbf00000.
ppcboot sets EUMMBAR to 0xfc000000 on every 824x-based board except the CU824:

    ppcboot/include/config_CU824.h:#define CFG_EUMB_ADDR          0xFCE00000
    ppcboot/include/config_MOUSSE.h:#define CFG_EUMB_ADDR         0xFC000000
    ppcboot/include/config_MUSENKI.h:#define CFG_EUMB_ADDR        0xFC000000
    ppcboot/include/config_Sandpoint8240.h:#define CFG_EUMB_ADDR  0xFC000000
    ppcboot/include/config_Sandpoint8245.h:#define CFG_EUMB_ADDR  0xFC000000

I've got some additional bits in arch/ppc/platforms/sandpoint_serial.h:
p
    #define DUART0  0xfc004500
    #define DUART_BASE_BAUD ( 100000000 / 16 )	/* bus_clock() / 16 */

    #define STD_SERIAL_PORT_DFNS \
	    { 0, DUART_BASE_BAUD, DUART0, 21, STD_COM_FLAGS, /* ttyS2 */      \
		    iomem_base: (u8 *)DUART0,                                 \
		    io_type: SERIAL_IO_MEM },                                 \
	    { 0, BASE_BAUD, SANDPOINT_SERIAL_0, 4, STD_COM_FLAGS, /* ttyS0 */ \
		    iomem_base: (u8 *)SANDPOINT_SERIAL_0,                     \
		    io_type: SERIAL_IO_MEM },                                 \
	    { 0, BASE_BAUD, SANDPOINT_SERIAL_1, 3, STD_COM_FLAGS, /* ttyS1 */ \
		    iomem_base: (u8 *)SANDPOINT_SERIAL_1,                     \
		    io_type: SERIAL_IO_MEM },                                 \


So, after all that, here is my question.

How do I deal with the fact that EUMBBAR is going to get changed?
The structure that gets filled in by STD_SERIAL_PORT_DFNS wants a const
for the address (DUART/0xfc004500 above), but EUMBBAR gets changes
from 0xfc000000 to 0xfbf00000.

Should I just relocate EUMBBAR in ppcboot?  Or are there better ways
to work around this issue?  (Or am I confused?)

Thanks in advance,

Jim


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
