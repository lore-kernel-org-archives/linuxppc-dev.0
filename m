Message-Id: <200007072338.BAA00757@piglet.grunz.lu>
Date: Sat, 8 Jul 2000 01:38:16 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Crash in IDE code
To: linuxppc-dev@lists.linuxppc.org, andre@suse.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

My current devel kernel (Paul's rsync, 2.4.0-test1-ac21) crashes with my
Promise U/66 when trying to read the partition table:

hda: Maxtor 91024D4, ATA DISK drive
ide0 at 0xf77fe470-0xf77fe477,0x000 on irq 23
hda: UDMA 2 drive0 0x004ff3f4 0x004123f4
hda: 19746720 sectors (10110 MB) w/512KiB Cache, CHS=19590/16/63, UDMA(33)
Partition check:
 hda:NIP: C00B8C4C XER: C000BE6F LR: C00B8BB4 REGS: c01a7d90 TRAP: 0300
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c01a6000[0] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: 00000000 C01A7E40 C01A6000 00000000 00001032 C01A7EC0 00800000 00000000
GPR08: C022E860 C023B02C C01AA410 00000000 95939E39 DEADBEEF 003F0000 DEADBEEF
GPR16: 00000000 DEADBEEF DEADBEEF DEADBEEF 00001032 001A7EB0 00000000 C0004B84
GPR24: C00058A4 0000FFFE 40000000 C023B02C C01A53E0 C00C34A4 C05FC4A0 C023B094
Call backtrace:
C0034480 C00057D4 C0005928 C0004B84 0000FFFE C0005E20 C0005E38
C01C27D8 000036C0
Kernel panic: kernel access of bad area pc c00b8c4c lr c00b8bb4 address 0 tsk swapper/0
In interrupt handler - not syncing

I've taken the time to disassemble the code part where it crashes. It's
in drivers/ide/ide.c, in this code inlined from ide_intr():

static inline int drive_is_ready (ide_drive_t *drive)
{
        if (drive->waiting_for_dma)
                return HWIF(drive)->dmaproc(ide_dma_test_irq, drive);
#if 0
        udelay(1);      /* need to guarantee 400ns since last command was issued */
#endif
//      if (GET_STAT() & BUSY_STAT)     /* Note: this may clear a pending IRQ!! */
        if (IN_BYTE(IDE_ALTSTATUS_REG) & BUSY_STAT)
            ^^^^^^^^^^^^^^^^^^^^^^^^^^

                return 0;       /* drive busy:  definitely not interrupting */
        return 1;               /* drive ready: *might* be interrupting */
}

The crashing part is marked above; it's the IN_BYTE which tries to read
from addr. 0 :-(

Above code translates to this:

IN_BYTE( (((ide_hwif_t *)((drive)->hwif))->io_ports[IDE_CONTROL_OFFSET]) )

So, io_ports[IDE_CONTROL_OFFSET] is obviously zero; it's suposed to be
in GPR11 in the oops above. One point where it is explicitly set to zero
is in ide_pmac.c:

        if (ix >= MAX_HWIFS) {
                /* Probably a PCI interface... */
                for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; ++i)
                        hw->io_ports[i] = data_port + i - IDE_DATA_OFFSET;
                /* XXX is this right? */
                hw->io_ports[IDE_CONTROL_OFFSET] = 0;

So, question is: is it right to zero hw->io_ports[IDE_CONTROL_OFFSET]?
Should I compile without PMac IDE support, since my box has no 'native'
IDE? Or should the test above in drive_is_ready() be protected against a
NULL pointer, like most other occurences are?


Thanks for any help


Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
