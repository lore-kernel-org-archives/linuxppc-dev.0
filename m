Date: Tue, 14 Aug 2001 00:40:40 -0700 (PDT)
From: James F Dougherty <jfd@GigabitNetworks.COM>
Message-Id: <200108140740.AAA05496@krakatoa.gigabitnetworks.com>
To: jfd@broadcom.com, mlocke@mvista.com
Subject: Re: PCI IDE Adapter for PPC/Linux
Cc: dmj+@andrew.cmu.edu, linuxppc-dev@lists.linuxppc.org,
	jfd@krakatoa.gigabitnetworks.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ok, so I took the Promise card out of the test system today, and put
it into my Windows box. I tried to install the drivers, and use a drive,
but Windows crashed! I took the card back to Frye's and got a
new one... it immediately detected the drive, but now, it hangs ..

PDC20262: IDE controller on PCI bus 00 dev 70
PDC20262: chipset revision 1
PDC20262: not 100% native mode: will probe irqs later
PDC20262: ROM enabled at 0x000d0000
PDC20262: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
PDC20262: FORCING BURST BIT 0x00 -> 0x01 ACTIVE
    ide0: BM-DMA at 0xbfff00-0xbfff07, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xbfff08-0xbfff0f, BIOS settings: hdc:pio, hdd:pio
hda: probing with STATUS(0x50) instead of ALTSTATUS(0xff)
hda: WDC WD300AB-00BVA0, ATA DISK drive
hdb: probing with STATUS(0x00) instead of ALTSTATUS(0xff)
hdb: probing with STATUS(0x01) instead of ALTSTATUS(0xff)

Still, this is excellent progress! I cannot believe the crap you buy at
Frye's, even when there aren't white return stickers on them!

Anyhow, I am getting interrupts, I guess the thing todo at this point
is check the PCI bus for I/O & DMA on an analyzer, I cannot see why the
system would hang at this point unless there was a H/W problem with
this board. I will have to look into it... there may not be the right
resistors stuff on this board or something with the bus loading..

Total memory = 64MB; using 0kB for hash table (at 00000000)
Linux version 2.4.2_hhl20 (jfd@atlantis) (gcc version 2.95.2 19991024 (release))
#474 Tue Aug 14 00:09:19 PDT 2001
cpu0: MPC8240/KAHLUA : MOUSSE Platform : 64MB RAM: MPLD Rev.  1
Sandpoint port (C) 2000, 2001 MontaVista Software, Inc. (source@mvista.com)
IP PNP: 802.3 Ethernet Address=<0:0:10:20:30:44>
IP PNP: mousse: eth0 IP 209.128.93.138/255.255.255.0 gateway 209.128.93.129
server 209.128.93.133
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
time_init: decrementer frequency = 16.665920 MHz
time_init: MPC8240 PCI Bus frequency = 33.331840 MHz
Calibrating delay loop... 133.12 BogoMIPS
Memory: 62452k available (1324k kernel code, 496k data, 88k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
block: queued sectors max/low 41405kB/13801kB, 128 slots per queue
RAMDISK driver initialized: 16 RAM disks of 131072K size 1024 blocksize
loop: loaded (max 8 devices)
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI
enabled
ttyS00 at 0xffe08080 (irq = 4) is a ST16650
Linux Tulip driver version 0.9.13a (January 20, 2001)
eth0: Digital DS21143 Tulip rev 65 at 0xbfff80, EEPROM not present, 00:00:10:20
:30:44, IRQ 1.
eth0:  MII transceiver #0 config 3000 status 7829 advertising 01e1.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
VFS: Mounted root (nfs filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 88k init 4k openfirmware
INIT: version 2.78 booting
INIT: Entering runlevel: 2
eth0: Setting full-duplex based on MII#0 link partner capability of 45e1.


mousse login: root
Password:
PAM_unix[13]: (login) session opened for user root by LOGIN(uid=0)
Last login: Mon Aug 13 21:18:12 2001 on console

mousse-(1):[11:35pm]: [/root>mount -a
mousse-(2):[11:35pm]: [/root>cat /proc/interrupts
           CPU0
  1:       4571   MPC8240 EPIC   Level     eth0
  4:        595   MPC8240 EPIC   Level     serial
BAD:          0
mousse-(3):[11:35pm]: [/root>



>
> The fact that it works a walnut but not your board points to board
> specific problem.  Have you double checked IRQ routing?
>

It is getting PCI IRQ 3, I checked this in the sandpoint_setup file
where the IDE configuration is, all I had todo was change the PCI device
and vendor ID to promise (very nice :-) I also enabled a PIO printf in
do_IRQ() and I do see it getting called.

>
> The fact that it works a walnut but not your board points to board
> specific problem.  Have you double checked IRQ routing?
>

Well, when I disable IDE, my IRQ's work fine for the onboard Dec 21143
and the NS16552 .... I tested a BCM5701 NIC card with the PCI slot
though so I am at a loss ... perhaps the Calibrate delay is wrong?
If the IDE timing is off, it might for a toss. What about the bogomips
reading, does this look right for a 200Mhz Kahlua? I'm out of ideas...
thoughts?

>
> Where did you get your hhl-2.4.2 kernel?  Try using the one in our
> Journeyman Edition, available on our ftp site.  You can see the config
> options I turned on for using the Promise card in that kernel.

I did that, from your ftp site. I then modified it to run on the
Kahlua Mousse board (see also http://www.vooha.com/mousse.html).


>  >
>  > Why can't I simply run fdisk on /dev/hda and set this up? -- because
> there
>  >  is no /dev/hda or /dev/ide/xx devices showing up with devfsd
>  > running!

I love devfsd ----  I've  always loved devfsd ... (smiles) :-)

Oh yeah, I installed all of the software in ppc82xx_apps from
ftp.mvista.com in Journeyman under ppc from the cd distribution.
Still, when it boots up, it only runs a getty. It is not starting
the network nor is it mounting entries in fstab. Seems like none
of the rc scripts work ..


Anyhow, thanks Guys, more later ...
					-James



>  > Also, how come it is not running in Native mode? Does anyone know
>  > what the changes are to the pdc driver to enable this?
>  >
>  > BTW, I would gladly pay MVista for support, If I had the budget for this
>  >  sort of thing ... unfortunately, I don't at this point in time :-(
>
> np.
>
>  >
>  >
>  > Thoughts?
>  >
>  >
> 	Thanks, 				-James
>  >
>  >
>  >
>  >> The Promise Ultra-66 is known to work on several ppc platforms in
> hhl-2.4.2.
>  >>   Do you have the DMA options turned on in the kernel?
>  >>
>  >> btw, if you are a MV customer contact support as this something we
> support on the walnut and several other ppc platforms.
>  >>
>  >>
>  >> James F Dougherty wrote:
>  >>
>  >>
>  >>> (LOL) .... I have the Promise Ultra-66..... since it's
>  >>> not working, this is what prompted me to look for an
>  >>> alternative ..
>  >>>
>  >>> I have ported MontaVista HHL (Linux 2.4.2) to
>  >>> a custom processor board, and have been
>  >>> trying to run fdisk to setup a mountable root
>  >>> drive.
>  >>>
>  >>> Kernel is 2.4.2, with the Promise driver compiled in.
>  >>> I boot up, and it finds the card, and sometimes hdb
>  >>> is showing up in DMA mode ...
>  >>>
>  >>>
>  >>> pty: 256 Unix98 ptys configured
>  >>> block: queued sectors max/low 41386kB/13795kB, 128 slots per queue
>  >>> RAMDISK driver initialized: 16 RAM disks of 524288K size 1024 blocksize
>  >>> Uniform Multi-Platform E-IDE driver Revision: 6.31
>  >>> ide: Assuming 33MHz system bus speed for PIO modes; override with
> idebus=xx
>  >>> PDC20262: IDE controller on PCI bus 00 dev 70
>  >>> PDC20262: chipset revision 1
>  >>> PDC20262: not 100% native mode: will probe irqs later
>  >>> PDC20262: ROM enabled at 0x000d0000
>  >>> PDC20262: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI
> Mode.
>  >>> PDC20262: FORCING BURST BIT 0x00 -> 0x01 ACTIVE
>  >>>     ide0: BM-DMA at 0xbfff00-0xbfff07, BIOS settings: hda:pio, hdb:pio
>  >>>     ide1: BM-DMA at 0xbfff08-0xbfff0f, BIOS settings: hdc:pio, hdd:pio
>  >>> udf: registering filesystem
>  >>> loop: loaded (max 8 devices)
>  >>> Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ
> SERIAL_PCI
>  >>> enabled
>  >>>
>  >>>
>  >>> mousse-(8):[11:29pm]: [/proc/ide>cat drivers
>  >>> ide-cdrom version 4.59
>  >>> ide-disk version 1.10
>  >>> mousse-(9):[11:29pm]: [/proc/ide>cat pdc202xx
>  >>>
>  >>>                                 PDC20262 Chipset.
>  >>> ------------------------------- General Status
> ---------------------------------
>  >>> Burst Mode                           : enabled
>  >>> Host Mode                            : Tri-Stated
>  >>> Bus Clocking                         : 100 External
>  >>> IO pad select                        : 10 mA
>  >>> Status Polling Period                : 15
>  >>> Interrupt Check Status Polling Delay : 15
>  >>> --------------- Primary Channel ---------------- Secondary Channel
> -------------
>  >>>                 disabled                         disabled
>  >>> 66 Clocking     enabled                          enabled
>  >>>            Mode MASTER                      Mode MASTER
>  >>>                 Error                            Error
>  >>> --------------- drive0 --------- drive1 -------- drive0 ----------
> drive1 ------
>  >>> DMA enabled:    yes              yes             yes               yes
>  >>> DMA Mode:       NOTSET           NOTSET          NOTSET
> NOTSET
>  >>> PIO Mode:       NOTSET            NOTSET           NOTSET
>    NOTSET
>  >>> mousse-(10):[11:29pm]: [/proc/ide>
>  >>>
>  >>>
>  >>> Now, when I run fdisk .... it either cannot find the device (when
>  >>> compiled kernel with INCLUDE_DEVFS
>  >>>
>  >>> mousse-(17):[11:31pm]: [/>devfsd /dev
>  >>> Started device management daemon for /dev
>  >>> mousse-(18):[11:31pm]: [/>fdisk /dev/hda
>  >>> modprobe: Can't locate module /dev/hda
>  >>> modprobe: Can't locate module /dev/hda
>  >>>
>  >>> Unable to open /dev/hda
>  >>> mousse-(19):[11:31pm]: [/>fdisk /dev/hdb
>  >>> modprobe: Can't locate module /dev/hdb
>  >>> modprobe: Can't locate module /dev/hdb
>  >>>
>  >>> Unable to open /dev/hdb
>  >>> mousse-(20):[11:31pm]: [/>
>  >>>
>  >>> Or, when I run with a standard dev filesystem and the device
>  >>> files created with scripts/MAKEDEV.ide it gives me an error,
>  >>> cant find module block-3 blah blah blah...
>  >>>
>  >>>
>  >>> Any ideas?
>  >>>
>  >>>
>  >>>
>  >>>
>  >>>
>  >>>
>  >>>
>  >>>
>  >>>> A good shot is always the Promise cards.  I know at least the 66 used
>  >>>> to work, and I'm reasonably sure the 100 does.  You'll need 2.4 for it
>  >>>> though, and no booting off it.
>  >>>>
>  >>>> On Sun, Aug 12, 2001 at 11:49:14PM -0700, James F Dougherty wrote:
>  >>>>
>  >>>>
>  >>>>> I guess my question is which drivers run in native mode
>  >>>>> (e.g. do not require an x86 ROM BIOS).
>  >>>>>
>  >>>>>
>  >>>>>
>  >>>>>> Anyone have any suggestions for a PCI IDE card to
>  >>>>>> use for PPC/Linux? Something one could buy down
>  >>>>>> at a Frye's would be great.
>  >>>>>>
>  >>>>>>
>  >>>>>> Many thanks in advance.
>  >>>>>> 				-James
>  >>>>>>
>  >>>>>>
>  >>>>>>
>  >>>>>
>  >>>>>
>  >>>>>
>  >>>> --
>  >>>> Daniel Jacobowitz                           Carnegie Mellon University
>  >>>> MontaVista Software                         Debian GNU/Linux Developer
>  >>>>
>  >>>>
>  >>>
>  >>>
>  >>
>  >>
>
>
>
>  >> >> support on the walnut and several other ppc platforms.
>  >>
>  >>
>  >> James F Dougherty wrote:
>  >>
>  >>
>  >>> (LOL) .... I have the Promise Ultra-66..... since it's not
>  >>> working, this is what prompted me to look for an alternative ..
>  >>>
>  >>> I have ported MontaVista HHL (Linux 2.4.2) to a custom processor
>  >>>  board, and have been trying to run fdisk to setup a mountable
>  >>> root drive.
>  >>>
>  >>> Kernel is 2.4.2, with the Promise driver compiled in. I boot up,
>  >>>  and it finds the card, and sometimes hdb is showing up in DMA
>  >>> mode ...
>  >>>
>  >>>
>  >>> pty: 256 Unix98 ptys configured block: queued sectors max/low
>  >>> 41386kB/13795kB, 128 slots per queue RAMDISK driver
>  >>> initialized: 16 RAM disks of 524288K size 1024 blocksize Uniform
>  >>>  Multi-Platform E-IDE driver Revision: 6.31 ide: Assuming 33MHz
>  >>>  system bus speed for PIO modes; override with idebus=xx PDC20262:
>  >>>  IDE controller on PCI bus 00 dev 70 PDC20262: chipset revision
>  >>>  1 PDC20262: not 100% native mode: will probe irqs later PDC20262:
>  >>>  ROM enabled at 0x000d0000 PDC20262: (U)DMA Burst Bit DISABLED
>  >>> Primary PCI Mode Secondary PCI Mode. PDC20262: FORCING BURST
>  >>> BIT 0x00 -> 0x01 ACTIVE ide0: BM-DMA at 0xbfff00-0xbfff07, BIOS
>  >>>  settings: hda:pio, hdb:pio ide1: BM-DMA at 0xbfff08-0xbfff0f,
>  >>> BIOS settings: hdc:pio, hdd:pio udf: registering filesystem loop:
>  >>>  loaded (max 8 devices) Serial driver version 5.02 (2000-08-09)
>  >>>  with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
>  >>>
>  >>>
>  >>> mousse-(8):[11:29pm]: [/proc/ide>cat drivers ide-cdrom version
>  >>> 4.59 ide-disk version 1.10 mousse-(9):[11:29pm]: [/proc/ide>cat
>  >>>  pdc202xx
>  >>>
>  >>> PDC20262 Chipset. ------------------------------- General Status
>  >>>  --------------------------------- Burst Mode
>  >>>          : enabled Host Mode                            :
>  >>> Tri-Stated Bus Clocking                         : 100 External IO
>  >>>  pad select                        : 10 mA Status Polling
>  >>> Period                : 15 Interrupt Check Status Polling Delay
>  >>>  : 15 --------------- Primary Channel ----------------
>  >>> Secondary Channel ------------- disabled
>  >>>   disabled 66 Clocking     enabled
>  >>> enabled Mode MASTER                      Mode MASTER Error
>  >>>                        Error --------------- drive0 ---------
>  >>> drive1 -------- drive0 ---------- drive1 ------ DMA enabled:
>  >>>  yes              yes             yes               yes DMA
>  >>> Mode:       NOTSET           NOTSET          NOTSET
>  >>> NOTSET PIO Mode:       NOTSET            NOTSET
>  >>> NOTSET            NOTSET mousse-(10):[11:29pm]: [/proc/ide>
>  >>>
>  >>>
>  >>> Now, when I run fdisk .... it either cannot find the device (when
> compiled kernel with INCLUDE_DEVFS
>  >>>
>  >>> mousse-(17):[11:31pm]: [/>devfsd /dev
>  >>> Started device management daemon for /dev
>  >>> mousse-(18):[11:31pm]: [/>fdisk /dev/hda
>  >>> modprobe: Can't locate module /dev/hda
>  >>> modprobe: Can't locate module /dev/hda
>  >>>
>  >>> Unable to open /dev/hda
>  >>> mousse-(19):[11:31pm]: [/>fdisk /dev/hdb
>  >>> modprobe: Can't locate module /dev/hdb
>  >>> modprobe: Can't locate module /dev/hdb
>  >>>
>  >>> Unable to open /dev/hdb
>  >>> mousse-(20):[11:31pm]: [/>
>  >>>
>  >>> Or, when I run with a standard dev filesystem and the device
>  >>> files created with scripts/MAKEDEV.ide it gives me an error,
>  >>> cant find module block-3 blah blah blah...
>  >>>
>  >>>
>  >>> Any ideas?
>  >>>
>  >>>
>  >>>
>  >>>
>  >>>
>  >>>
>  >>>
>  >>>
>  >>>> A good shot is always the Promise cards.  I know at least the 66 used
>  >>>> to work, and I'm reasonably sure the 100 does.  You'll need 2.4 for it
>  >>>> though, and no booting off it.
>  >>>>
>  >>>> On Sun, Aug 12, 2001 at 11:49:14PM -0700, James F Dougherty wrote:
>  >>>>
>  >>>>
>  >>>>> I guess my question is which drivers run in native mode
>  >>>>> (e.g. do not require an x86 ROM BIOS).
>  >>>>>
>  >>>>>
>  >>>>>
>  >>>>>> Anyone have any suggestions for a PCI IDE card to
>  >>>>>> use for PPC/Linux? Something one could buy down
>  >>>>>> at a Frye's would be great.
>  >>>>>>
>  >>>>>>
>  >>>>>> Many thanks in advance.
>  >>>>>> 				-James
>  >>>>>>
>  >>>>>>
>  >>>>>>
>  >>>>>
>  >>>>>
>  >>>>>
>  >>>> --
>  >>>> Daniel Jacobowitz                           Carnegie Mellon University
>  >>>> MontaVista Software                         Debian GNU/Linux Developer
>  >>>>
>  >>>>
>  >>>
>  >>>
>  >>
>  >>
>
>
>
>  >>> >>> compiled kernel with INCLUDE_DEVFS
>  >>>
>  >>> mousse-(17):[11:31pm]: [/>devfsd /dev Started device management
>  >>> daemon for /dev mousse-(18):[11:31pm]: [/>fdisk /dev/hda modprobe:
>  >>>  Can't locate module /dev/hda modprobe: Can't locate module
>  >>> /dev/hda
>  >>>
>  >>> Unable to open /dev/hda mousse-(19):[11:31pm]: [/>fdisk /dev/hdb
> modprobe:
>  >>>  Can't locate module /dev/hdb modprobe: Can't locate module
>  >>> /dev/hdb
>  >>>
>  >>> Unable to open /dev/hdb mousse-(20):[11:31pm]: [/>
>  >>>
>  >>> Or, when I run with a standard dev filesystem and the device files
>  >>>  created with scripts/MAKEDEV.ide it gives me an error, cant
>  >>> find module block-3 blah blah blah...
>  >>>
>  >>>
>  >>> Any ideas?
>  >>>
>  >>>
>  >>>
>  >>>
>  >>>
>  >>>
>  >>>
>  >>>
>  >>>> A good shot is always the Promise cards.  I know at least the
>  >>>> 66 used to work, and I'm reasonably sure the 100 does.
>  >>>> You'll need 2.4 for it though, and no booting off it.
>  >>>>
>  >>>> On Sun, Aug 12, 2001 at 11:49:14PM -0700, James F Dougherty
>  >>>> wrote:
>  >>>>
>  >>>>
>  >>>>> I guess my question is which drivers run in native mode (e.g.
>  >>>>>  do not require an x86 ROM BIOS).
>  >>>>>
>  >>>>>
>  >>>>>
>  >>>>>> Anyone have any suggestions for a PCI IDE card to use for
>  >>>>>> PPC/Linux? Something one could buy down at a Frye's would
>  >>>>>>  be great.
>  >>>>>>
>  >>>>>>
>  >>>>>> Many thanks in advance. 				-James
>  >>>>>>
>  >>>>>>
>  >>>>>>
>  >>>>>
>  >>>>>
>  >>>>>
>  >>>> -- Daniel Jacobowitz                           Carnegie Mellon
>  >>>>  University MontaVista Software
>  >>>> Debian GNU/Linux Developer
>  >>>>
>  >>>>
>  >>>
>  >>>
>  >>
>  >>
>
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
