Date: Sat, 8 Jul 2000 20:57:43 -0700 (PDT)
From: Forwarded SuSE Mail <suse@linux-ide.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Michel Lanners <mlan@cpu.lu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Crash in IDE code
In-Reply-To: <Pine.LNX.4.10.10007081406230.833-100000@cassiopeia.home>
Message-ID: <Pine.LNX.4.10.10007082054410.2423-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks Geert,

We both know that I should have known better.
Regardless if PPC has an issue, you will.
This I need to flag this better.

This adds a whole new wrinkle in the total rework of the TASK commands.

Cheers,

Andre Hedrick
The Linux ATA/IDE guy

On 8 Jul 2000, Geert Uytterhoeven wrote:

> On Sat, 8 Jul 2000, Michel Lanners wrote:
> > I've taken the time to disassemble the code part where it crashes. It's
> > in drivers/ide/ide.c, in this code inlined from ide_intr():
> >
> > static inline int drive_is_ready (ide_drive_t *drive)
> > {
> >         if (drive->waiting_for_dma)
> >                 return HWIF(drive)->dmaproc(ide_dma_test_irq, drive);
> > #if 0
> >         udelay(1);      /* need to guarantee 400ns since last command was issued */
> > #endif
> > //      if (GET_STAT() & BUSY_STAT)     /* Note: this may clear a pending IRQ!! */
> >         if (IN_BYTE(IDE_ALTSTATUS_REG) & BUSY_STAT)
> >             ^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> >                 return 0;       /* drive busy:  definitely not interrupting */
> >         return 1;               /* drive ready: *might* be interrupting */
> > }
> >
> > The crashing part is marked above; it's the IN_BYTE which tries to read
> > from addr. 0 :-(
> >
> > Above code translates to this:
> >
> > IN_BYTE( (((ide_hwif_t *)((drive)->hwif))->io_ports[IDE_CONTROL_OFFSET]) )
>
> Yep, ALTSTATUS == CONTROL
>
> > So, io_ports[IDE_CONTROL_OFFSET] is obviously zero; it's suposed to be
> > in GPR11 in the oops above. One point where it is explicitly set to zero
> > is in ide_pmac.c:
> >
> >         if (ix >= MAX_HWIFS) {
> >                 /* Probably a PCI interface... */
> >                 for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; ++i)
> >                         hw->io_ports[i] = data_port + i - IDE_DATA_OFFSET;
> >                 /* XXX is this right? */
> >                 hw->io_ports[IDE_CONTROL_OFFSET] = 0;
> >
> > So, question is: is it right to zero hw->io_ports[IDE_CONTROL_OFFSET]?
> > Should I compile without PMac IDE support, since my box has no 'native'
> > IDE? Or should the test above in drive_is_ready() be protected against a
> > NULL pointer, like most other occurences are?
>
> It's indeed true that some hardware doesn't have the CONTROL/ALTSTATUS
> register. I don't know about the PowerMac, but I know about the Amiga
> IDE-doublers[*]. So there _must_ be a test for a non-zero register offset
> prior to the usage of CONTROL/ALTSTATUS. Hence this is a bug.
>
> Gr{oetje,eeting}s,
>
> 						Geert
>
> [*] IDE-doublers are actually something that can be used on most IDE
>     interfaces. IDE defines 2 banks of 8 registers to access the drive. From
>     the second bank, only one register is actually used (CONTROL/ALTSTATUS).
>     Since CONTROL/ALTSTATUS is not vital to the functionality of the IDE
>     interface, the second bank of registers can be sacrificed and one IDE chain
>     that supports 2 devices can be `split' into 2 chains supporting 2x2 devices
>     using only a few diodes (schematic available on request). Then accessing
>     the first bank of registers will still access the first bank of registers
>     on the first chain, while accessing the second bank of registers will
>     access the first bank of registers on the second chain.
>     Driver: see the IDE-doubler option in drivers/ide/gayle.c.
> --
> Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
