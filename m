Date: Mon, 10 Jul 2000 13:58:02 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Michael Lundkvist <ml@epact.se>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Problem with de4x5 on an MVME-2400
In-Reply-To: <qpg0pl7ab6.fsf@erbium.epact.se>
Message-ID: <Pine.HPX.4.10.10007101033450.21326-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 8 Jul 2000, Michael Lundkvist wrote:

>
> Gabriel Paubert <paubert@iram.es> writes:
>
> >
> > > I'll try 2.2.17pre10 tonight and see if I have more luck with that.
> >
> > Well, I'm going to put my patches for 2.2.16 in an untested directory
> > then...
> >
>
> Now I've tried every recent 2.2.x kernel I could get my hands on and
> none of them are stable during disk load except for the pre-built
> Debian 2.2.16pre5 that I can't find the source for.
>
> I also tried your 2.4.0test2 patch and after adding a call to
> ppc_generic_ide_fix_driveid as shown below I got it to boot. This is
> the best 2.4-kernel I've tried so far.

Good...

>
> In arch/ppc/kernel/prep_setup.c:
> void __prep
> prep_ide_fix_driveid(struct hd_driveid *id)
> {
>         ppc_generic_ide_fix_driveid(id);
> }
>
>
> But I have one quite big problem with it. The onboard network interface
> doesn't work.
>
> It initializes without problem and detects the 100Mbit/s carrier but
> it fails after a few seconds.
>
> I get the following errors:
> eth0: Setup frame timed out, status f0600004
> Unhandled interrupt 1, disabled
> Unhandled interrupt 1, disabled
> Unhandled interrupt 1, disabled
> eth0: media is 100Mb/s.
> Unhandled interrupt 1, disabled
> Unhandled interrupt 1, disabled
>
>
> Do you have any idea what this could be?

It looks like a problem with network interrupt routing. I don't know why
since it works on my 2600 which use the same interrupt for the de4x5.
Can't test on a 2400 for now, sorry...

What does 'cat /proc/interrupt' tell, as well as /proc/ioports and
/proc/iomem ?

In which PMC slot did you put the Ramix (upper or lower ?). IDE interfaces
have strange interrupt routing topologies (and give me a _sane_ interrupt
system, a la VME or even Z80, any day :-().

> Complete boot log at the end of the mail. Any more info you need?

Not for now...

>
> /Micke
>
> Residual-Data Located at: $0FF88000
>
> Model:                            (e2)
> Serial: MOT03AE1BA
> Processor/Bus frequencies (Hz): 450030400/100001944
> Time Base Divisor: 4000
> MS(0): START=4000, END=fcff, OFF=0, ATT=d2
> PS(0): START=0, END=3fff, OFF=0, ATT=8af3
> MS(1): START=fd00, END=fdff, OFF=300, ATT=d2
> PS(1): START=0, END=0, OFF=0, ATT=8a00
> MS(2): START=0, END=0, OFF=4000, ATT=2
> PS(2): START=0, END=0, OFF=0, ATT=8a00
> MS(3): START=fe00, END=febf, OFF=200, ATT=c0
> PS(3): START=0, END=0, OFF=0, ATT=8a00

Ok, reconfiguration of Hawk in CHRP mode.

> Allocation requirements: io=00002000, mem=00200000
> Allocated PCI resources:
> IO Port resources:
>    00000000 007fffff 00000100 (@0ff7f244)
>      00010000 00011fff 40000100 (@0fecc198)
>        00000000 0003ffff 20000101 (@0fecc0d4)
>        00010000 00010fff 40000101 (@0fecc888)
>        00011000 0001107f 40000101 (@0feccaf4)
>        00011080 0001108f 40000101 (@0feccdec)
>        00011090 0001109f 40000101 (@0fecc670)
>        000110a0 000110af 40000101 (@0fecc654)
>        000110b0 000110b7 40000101 (@0feccdb4)
>        000110b8 000110bf 40000101 (@0feccd7c)
>        000110c0 000110c7 40000101 (@0fecc61c)
>        000110c8 000110cf 40000101 (@0fecc5e4)
>        000110d0 000110d3 40000101 (@0feccdd0)
>        000110d4 000110d7 40000101 (@0feccd98)
>        000110d8 000110db 40000101 (@0fecc638)
>        000110dc 000110df 40000101 (@0fecc600)

Fine (although IDE is a mess with registers spread all over the place,
especially the WinBond)
> IO Memory resources:
>    40000000 fcffffff 00000200 (@0ff7f260)
>      fcf00000 fcffffff 40000200 (@0fecc1b4)
>        fcfbec00 fcfbefff 40000200 (@0feccb10)  <--- ? is is the 21143 ?
>        fcfbf000 fcfbffff 40000200 (@0fecc86c)
>        fcfc0000 fcffffff 40000200 (@0fecc0f0)
>      fce00000 fcefffff 40001200 (@0fecc1d0)
>        fcec0000 fcefffff 40007200 (@0feccb9c)
>
> Linux/PPC load: console=ttyS0 root=/dev/hda2
>
> Uncompressing the kernel...done
> Now building bootinfo...
> done
> Now booting...
> Kernel at 0x00000000, size=0x1cbf34
> Initrd at 0x0ff7eb5c, size=0x0
> Boot info 0x001cc000, size=0x5c
> Residual data at 0x001cd000
> PReP architecture
> Total memory = 256MB; using 1024kB for hash table (at c0200000)
> Linux version 2.4.0-test2 (root@etss140) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #5 Sat Jul 8 02:56:56 CEST 2000
> Boot arguments: console=ttyS0 root=/dev/hda2
> On node 0 totalpages: 65536
> zone(0): 65536 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: console=ttyS0 root=/dev/hda2
> OpenPIC Version 1.3 (2 CPUs and 17 IRQ sources) at fcfc0000
> OpenPIC timer frequency is 11 MHz
> time_init: decrementer frequency = 1499976540/60 (23MHz)
> Calibrating delay loop... 897.84 BogoMIPS
> Memory: 254388k available (1052k kernel code, 584k data, 204k init)
> 0000000,d0000000]

Wow, my biggest machine has 32 Mb :-(

> Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
> Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
> Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
> kmem_create: Poisoning requested, but con given - bdev_cache
> Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
> kmem_create: Poisoning requested, but con given - inode_cache
> POSIX conformance testing by UNIFIX
> PCI: Probing PCI hardware
> Setting PCI interrupts for a "MVME 2400"
> Linux NET4.0 for Linux 2.3
> Based upon Swansea University Computer Society NET3.039
> kmem_create: Poisoning requested, but con given - skbuff_head_cache
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP, IGMP
> IP: routing cache hash table of 2048 buckets, 16Kbytes
> TCP: Hash tables configured (established 16384 bind 16384)
> Starting kswapd v1.6
> pty: 256 Unix98 ptys configured
> RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
> loop: registered device at major 7
> loop: enabling 8 loop devices
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> W82C105: ignored by ide_scan_pci_device() (uses own driver)
> CMD646: IDE controller on PCI bus 00 dev 80
> CMD646: chipset revision 7
> CMD646: chipset revision 0x07, UltraDMA Capable
> CMD646: 100% native mode on irq 25
> hda: IBM-DARA-206000, ATA DISK drive
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> ide0 at 0x110b8-0x110bf,0x110d6 on irq 25
> hda: 11733120 sectors (6007 MB) w/418KiB Cache, CHS=12416/15/63
> Partition check:
>  hda: hda1 hda2
> eth0: DC21143 at 0x11000 (PCI bus 0, device 14), h/w address 08:00:3e:2d:ce:9f,
>       and requires IRQ18 (provided by PCI BIOS).
> de4x5.c:V0.545 1999/11/28 davies@maniac.ultranet.com
> Serial driver version 5.01 (2000-05-29) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> rtc: I/O port 112 is not free.

Set CONFIG_RTC and/or CONFIG_NVRAM off. They don't work properly in any
case on this machine...

> Macintosh non-volatile memory driver v1.0
> kmem_create: Forcing size word alignment - nfs_fh
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 204k init 8k chrp 4k pmac 4k open firmware
> modprobe: modprobe: Can't open dependencies file /lib/modules/2.4.0-test2/modules.dep (No such file or directory)
> modprobe: modprobe: Can't open dependencies file /lib/modules/2.4.0-test2/modules.dep (No such file or directory)
>
> modprobe: modprobe: Can't open dependencies file /lib/modules/2.4.0-test2/modules.dep (No such file or directory)
>
> INIT: version 2.78 booting
> Activating swap...
> Adding Swap: 512148k swap-space (priority -1)
> Checking root file system...
> Parallelizing fsck version 1.18 (11-Nov-1999)
> /dev/hda2 was not cleanly unmounted, check forced.
> /dev/hda2: Deleted inode 622561 has zero dtime.  FIXED.
> /dev/hda2: 89226/670432 files (1.5% non-contiguous), 344310/1338592 blocks
> Calculating module dependencies... depmod: Can't open /lib/modules/2.4.0-test2/modules.dep for writing
> done.
> Loading modules:
> modprobe: Can't open dependencies file /lib/modules/2.4.0-test2/modules.dep (No such file or directory)
> Checking all file systems...
> Parallelizing fsck version 1.18 (11-Nov-1999)
> Setting kernel variables.
> Loading the saved-state of the serial devices...
> /dev/ttyS0 at 0x03f8 (irq = 4) is a 16550A
> Mounting local filesystems...
> not mounted anything
> Running dns-clean.
> Setting up IP spoofing protection: rp_filter.
> Configuring network interfaces: eth0: Setup frame timed out, status f0600004

Looks again like interrupts are not coming through, or are set edge
instead of level or whatever.

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
