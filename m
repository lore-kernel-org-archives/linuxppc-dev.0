From: Jim Thompson <jim@musenki.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15540.51605.929116.525590@gargle.gargle.HOWL>
Date: Wed, 10 Apr 2002 18:24:05 -0500
To: "Chuck Partridge" <Chuck_Partridge@amx.com>
Cc: <gallen@arlut.utexas.edu>, <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC8245 Internal Duart and Linux
In-Reply-To: <scb46c71.008@mx.amx.com>
References: <scb46c71.008@mx.amx.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Chuck Partridge writes:
> Hello all,
>
> I have followed Jim and Greg's thread on LinuxPPC.org
> linuxppc-embedded about the 8245 DUARTs under Linux and have a few
> questions.
>
> I am also trying to get the 8245's internal DUART working under
> Linux (MVL 2.4.17) and have encountered a problem.
>
> Here's what I've done. (Almost exactly what Greg says on
> http://lists.linuxppc.org/linuxppc-embedded/200202/msg00056.html )
>
> 1. In PPCBoot I set the EUMBBAR to 0xfc000000
> 2. In my $(PLATFORM).map_io function I call io_block_mapping(0xfc000000,0xfc000000,0x04000000,_PAGE_IO);
> to map the  EUMB area and the 8245 internal MPC107 PCI IO space.
> 3. Call mpc10x_bridge_init() with 0xfc000000 instead of MPC10X_MAPB_EUMB_BASE as the last parameter.
>
> I can access the internal DUART and get debug (ppc_md.progress) and
> printk up until the IDE driver tries to probe the IO ports in the
> IDE controller.  Once that happens, it hangs.  I'm also guessing
> this is the first "real" IO access in the boot process, but that's
> just a guess.
>
> I first tried this kernel port using a 16550 UART built into the ALI
> South Bridge that is on my board.  That boots complete and runs
> fine.  If I change my debug port (i.e. progress) routines to the ALI
> 16550, but use the 8245 DUART as my console, it runs farther in the
> boot process and gets past the IDE probe, but eventually hangs also.
>
> It appears to me it has something to do with IO mappings, or some
> issue along that line, but I'm at a loss at what to look at next.  I
> had a similar hang in PPCBoot on another board when I tried to
> access RCS2 when no BAT had been mapped to 0x70000000.  Even the BDI
> reacts the same way (all memory reads as 0, even the internal
> registers like EUMBBAR), but that shouldn't be an issue since the
> MMU is fully running and handling page faults, etc (as opposed to
> PPCBoot which only has the BATs on).  .

> Any ideas on where to look next??
>
> I've tried io_block_mapping(0xf0000000,0xf0000000,0x10000000,_PAGE_IO);  as Greg said and had the same result.

I needed something like:
        /* Use BAT3 to map 0xf0000000 to end: 1-to-1, cache inhibit, guarded */
        mtspr(DBAT3U, 0xf0001fff);
        mtspr(DBAT3L, 0xf000002a);

Very, very early in in arch/ppc/platforms/<platform>_setup.c::platform_init()

You might want to use this instead, but its (as you can see) untested.

    #if 0
    /*
     * Set BAT 3 to map 0xf0000000 to end of physical memory space 1-1.
     */
    static __inline__ void
    musenki_set_bat(void)
    {
	    unsigned long   bat3u, bat3l;
	    static int      mapping_set = 0;

	    if (!mapping_set) {

		    __asm__ __volatile__(
		    " lis %0,0xf000\n \
		      ori %1,%0,0x002a\n \
		      ori %0,%0,0x1fff\n \
		      mtspr 0x21e,%0\n \
		      mtspr 0x21f,%1\n \
		      isync\n \
		      sync "
		      : "=r" (bat3u), "=r" (bat3l));

		    mapping_set = 1;
	    }

	    return;
    }
    #endif


in arch/ppc/platforms/<platform>_pci.c::<platform>_find_bridges():

        if (mpc10x_bridge_init(hose,
                               MPC10X_MEM_MAP_B,
                               MPC10X_MEM_MAP_B,
                               MPC10X_MAPB_EUMB_BASE) == 0) {


needs to be

        if (mpc10x_bridge_init(hose,
                               MPC10X_MEM_MAP_B,
                               MPC10X_MEM_MAP_B,
                               0xfc000000) == 0) {

or similar, because

    ./include/asm-ppc/mpc10x.h:#define      MPC10X_MAPA_EUMB_BASE   (ioremap_base - MPC10X_EUMB_SIZE)
    ./include/asm-ppc/mpc10x.h:#define      MPC10X_MAPB_EUMB_BASE   MPC10X_MAPA_EUMB_BAS

and

    ./arch/ppc/mm/init.c:   ioremap_base = 0xfe000000UL;    /* for now, could be 0xfffff000 */


>         { 0, BASE_BAUD_8245_DUART, AMX2275_SERIAL_2, 9, STD_COM_FLAGS, /* ttyS2 */ \
>         iomem_base: (u8 *)AMX2275_SERIAL_2,                             \
>         io_type: SERIAL_IO_MEM },                                       \
>         { 0, BASE_BAUD_8245_DUART, AMX2275_SERIAL_3, 9, STD_COM_FLAGS, /* ttyS3 */ \
>         iomem_base: (u8 *)AMX2275_SERIAL_3,                             \
>         io_type: SERIAL_IO_MEM },

needs to look more like:
#define STD_SERIAL_PORT_DFNS \
        { 0, BASE_BAUD, MUSENKI_SERIAL_0, 137, STD_COM_FLAGS, /* ttyS0 */       \
                iomem_base: (u8 *)MUSENKI_SERIAL_0,                             \
                io_type: SERIAL_IO_MEM },                                       \
        { 0, BASE_BAUD, MUSENKI_SERIAL_1, 138, STD_COM_FLAGS, /* ttyS1 */       \
                iomem_base: (u8 *)MUSENKI_SERIAL_1,                             \
                io_type: SERIAL_IO_MEM },


And you'll need something like this in arch/ppc/platforms/<platform>_setup.c::<platform>_init_IRQ()
        /* openpic_set_sources(0, 26, NULL); /* */
        openpic_set_sources(0, 138, NULL);
        openpic_init(1, 0, 0, -1);


IRQs for the two on-chip UARTs are 137 and 138.   You might have to
upgrade to 2.4.18 to get openpic_init() to not crash the kernel when
you have more than the stock number of sources.



--
"...the neurotic has problems, the psychotic has solutions." --Thomas Szasz


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
