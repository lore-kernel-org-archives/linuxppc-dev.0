Message-ID: <39BE47E6.55EED616@vas-gmbh.de>
Date: Tue, 12 Sep 2000 17:12:38 +0200
From: Frank Przybylski <Frank.Przybylski@vas-gmbh.de>
MIME-Version: 1.0
To: clark@esteem.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: PCMCIA Port Data line assignment
References: <1.5.4.32.20000901180437.006994e4@pop.esteem.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Conn,

Please, be more specific which books do disagree?

If you take a lock inside the MPC860 Users Manual (860UM.pdf), you'll see for
the data line connections:

MPC_CE1B#  -> BUFFER_1OE#
MPC_RD/WR# -> BUFFER_1DIR
and connected via buffer
MPC_D7     -> PCMCIA_D0
.
.
MPC_D0     -> PCMCIA_D7

MPC_CE2B#  -> BUFFER_2OE#
MPC_RD/WR# -> BUFFER_2DIR
s.a.
MPC_D15    -> PCMCIA_D8
.
.
MPC_D8     -> PCMCIA_D15

This is how the FADS connects to PCMCIA, as you mentioned. This is true also for
TQM starter kit. I have a FlashDisk working on the PCMCIA-slot of an TQM STK8xxL
Rev. 004.
For I can handle partitions and data correctly on this Flashdisk, that means I
can exchange and plug them into a PC, I assume that everything regarding byte
and bit order is working fine. But this might also be corrected somewhere inside
the kernel. So I tried a trace of IDE/PCMCIA accesses, to ensure that the
physical connection gives the right ordering, without waste of processor time
for a lack of good enginearing. This trace is a little bit complicated, so don't
put your lawers on me if I missed something. In fact, I'm going to design a
board with the connection mentioned above.
I made the trace with the MPCBDM and added the lines beginning with '!'.

Maybe there's a problem, because programmers might determine byte order over
processor type (PPC, therefore I need to swap bytes), and thus come to the
conclusion to swap bytes from IDE also? I had no time to get a clear view about
byte order handling. I can see a lot of le16_to_cpu etc, but I haven't found one
while reading data from the IDE/PCMCIA. Maybe a pro can give us some light? I
guess, there's a pretty mess, regarding who has to call byte order handling.

I tried msdos and ext2 partitions and found no byte swapping. I found out
drive->slow  = 0 and drive->bswap = 0. It does 16 bit accesses, and no swaps.

hth (and doesn't take to long for this)
 Frank

------------------------------------------------
stack trace:
#0  0xc0006c3c in ide_insw () at time.c:330
! it's not from time.c but from arch/ppc/kernel/misc.S
! I guess this comes from -O ptimating
!0xc0006c3c <ide_insw>:          mtctr   r5
!0xc0006c40 <ide_insw+4>:        addi    r4,r4,-2
!0xc0006c44 <ide_insw+8>:        lhz     r5,0(r3)
!0xc0006c48 <ide_insw+12>:       eieio
!0xc0006c4c <ide_insw+16>:       sthu    r5,2(r4)
!0xc0006c50 <ide_insw+20>:       bdnz    0xc0006c44 <ide_insw+8>
!0xc0006c54 <ide_insw+24>:       blr

#1  0xc0008e9c in m8xx_ide_insw (port=3296780288, buf=0xc07b9000, ns=256)
    at m8xx_setup.c:326
!	ide_insw(port+_IO_BASE, buf, ns);

#2  0xc00a9bd0 in ide_input_data (drive=0xc480e000, buffer=0xc07b9000,
    wcount=256) at ide.c:352
!	insw(IDE_DATA_REG, buffer, wcount<<1);
!	ide_input_data(drive, buffer, wcount);
!	if (drive->bswap)
!		idedisk_bswap_data(buffer, wcount);
#3  0xc00b45cc in read_intr (drive=0xc0114fc8) at ide-disk.c:71
!	idedisk_input_data(drive, rq->buffer, nsect * SECTOR_WORDS);
#4  0xc00abd00 in ide_intr (irq=-1072607288, dev_id=0xc07b9000, regs=0x100)
    at ide.c:1433
!	handler(drive); #with handler  = (ide_handler_t *) 0xc00b4528 <read_intr>
!	start_next_request(hwgroup, hwif->irq);
#5  0xc00042d4 in ppc_irq_dispatch_handler (regs=0xc029fc70, irq=3)
    at irq.c:280
!	action->handler(irq, action->dev_id, regs); # with *action =
!   #{handler = 0xc00c1398 <cpm_interrupt>, flags = 0, mask = 0,
!   # name = 0xc00da138 "cpm", dev_id = 0x0, next = 0x0}
!	action = action->next;
#6  0xc00092d0 in m8xx_do_IRQ (regs=0xc0114f98, cpu=-1065644032, isfake=256)
    at ppc8xx_pic.c:106
!	ppc_irq_dispatch_handler( regs, irq );
#7  0xc0004388 in do_IRQ (regs=0xc480e000, isfake=256) at irq.c:296
!	ppc_md.do_IRQ(regs, cpu, isfake);
#8  0xc0002544 in ret_from_syscall ()
#9  0xc00ab708 in do_hwgroup_request (hwgroup=0xc0154a40) at ide.c:1207
#10 0xc00ab764 in do_ide0_request () at ide.c:1223
#11 0xc00a8514 in unplug_device (data=0xc480e000) at ll_rw_blk.c:170
#12 0xc001d704 in do_generic_file_read (filp=0xc06a9be0, ppos=0xc06a9bf8,
    desc=0x29fc60, actor=0xc001d9bc <file_read_actor>)
    at /router/Data2/LinuxPPC/usr/src/linux/include/linux/tqueue.h:119
#13 0xc001dab4 in generic_file_read (filp=0xc0110000,
    buf=0xc07b9000 "ng made.\n", count=256, ppos=0x3) at filemap.c:830
#14 0xc00573f8 in fat_file_read (filp=0xc480e000, buf=0xc07b9000 "ng made.\n",
    count=256, ppos=0x3) at file.c:331
#15 0xc0027a28 in sys_read (fd=12, buf=0x30012000 "ÿØÿá\016\026Exif",
    count=4096) at read_write.c:137
#16 0xc00022d8 in syscall_ret_1 ()
#17 0x7ffff888 in ?? ()
#18 <signal handler called>

--
===============================================================================
Frank Przybylski,VAS GmbH,Gotenstr.6,20097 Hamburg,GERMANY,TEL:+49-40-238568-14
   mailto:Frank.Przybylski@vas-gmbh.de , visit us at http://www.vas-gmbh.de
===============================================================================

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
