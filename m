Date: Mon, 13 Aug 2001 13:07:50 -0700 (PDT)
Message-Id: <200108132007.NAA04723@krakatoa.gigabitnetworks.com>
From: James F Dougherty <jfd@GigabitNetworks.COM>
To: mlocke@mvista.com
Subject: Re: PCI IDE Adapter for PPC/Linux
Cc: dmj+@andrew.cmu.edu, linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks Matt,

Turning on/off the UDMA feature doesn't seem to have any affect.

Earlier, Ben sent out an email regarding the IDE controller setup
which merits some investigation. Perhaps this is why it is not
working, also, I cannot see any dev entries under /dev/ide/
despite the fact that there is a 100GB WDC ATA disk on the other
end of the adapter .

What else should I look at? Also, assuming this is a brand new
drive (without any partitions on it), should I boot the disk under
DOS and run fdisk to set up an initial MBR?

Why can't I simply run fdisk on /dev/hda and set this up? -- because
there is no /dev/hda or /dev/ide/xx devices showing up with
devfsd running!

Also, how come it is not running in Native mode? Does anyone know what
the changes are to the pdc driver to enable this?

BTW, I would gladly pay MVista for support, If I had the budget for
this sort of thing ... unfortunately, I don't at this point in time :-(


Thoughts?

				Thanks,
				-James


>
>The Promise Ultra-66 is known to work on several ppc platforms in
>hhl-2.4.2.  Do you have the DMA options turned on in the kernel?
>
>btw, if you are a MV customer contact support as this something we
>support on the walnut and several other ppc platforms.
>
>
>James F Dougherty wrote:
>
>> (LOL) .... I have the Promise Ultra-66..... since it's
>> not working, this is what prompted me to look for an
>> alternative ..
>>
>> I have ported MontaVista HHL (Linux 2.4.2) to
>> a custom processor board, and have been
>> trying to run fdisk to setup a mountable root
>> drive.
>>
>> Kernel is 2.4.2, with the Promise driver compiled in.
>> I boot up, and it finds the card, and sometimes hdb
>> is showing up in DMA mode ...
>>
>>
>> pty: 256 Unix98 ptys configured
>> block: queued sectors max/low 41386kB/13795kB, 128 slots per queue
>> RAMDISK driver initialized: 16 RAM disks of 524288K size 1024 blocksize
>> Uniform Multi-Platform E-IDE driver Revision: 6.31
>> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
>> PDC20262: IDE controller on PCI bus 00 dev 70
>> PDC20262: chipset revision 1
>> PDC20262: not 100% native mode: will probe irqs later
>> PDC20262: ROM enabled at 0x000d0000
>> PDC20262: (U)DMA Burst Bit DISABLED Primary PCI Mode Secondary PCI Mode.
>> PDC20262: FORCING BURST BIT 0x00 -> 0x01 ACTIVE
>>     ide0: BM-DMA at 0xbfff00-0xbfff07, BIOS settings: hda:pio, hdb:pio
>>     ide1: BM-DMA at 0xbfff08-0xbfff0f, BIOS settings: hdc:pio, hdd:pio
>> udf: registering filesystem
>> loop: loaded (max 8 devices)
>> Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI
>> enabled
>>
>>
>> mousse-(8):[11:29pm]: [/proc/ide>cat drivers
>> ide-cdrom version 4.59
>> ide-disk version 1.10
>> mousse-(9):[11:29pm]: [/proc/ide>cat pdc202xx
>>
>>                                 PDC20262 Chipset.
>> ------------------------------- General Status ---------------------------------
>> Burst Mode                           : enabled
>> Host Mode                            : Tri-Stated
>> Bus Clocking                         : 100 External
>> IO pad select                        : 10 mA
>> Status Polling Period                : 15
>> Interrupt Check Status Polling Delay : 15
>> --------------- Primary Channel ---------------- Secondary Channel -------------
>>                 disabled                         disabled
>> 66 Clocking     enabled                          enabled
>>            Mode MASTER                      Mode MASTER
>>                 Error                            Error
>> --------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
>> DMA enabled:    yes              yes             yes               yes
>> DMA Mode:       NOTSET           NOTSET          NOTSET            NOTSET
>> PIO Mode:       NOTSET            NOTSET           NOTSET            NOTSET
>> mousse-(10):[11:29pm]: [/proc/ide>
>>
>>
>> Now, when I run fdisk .... it either cannot find the device (when
>> compiled kernel with INCLUDE_DEVFS
>>
>> mousse-(17):[11:31pm]: [/>devfsd /dev
>> Started device management daemon for /dev
>> mousse-(18):[11:31pm]: [/>fdisk /dev/hda
>> modprobe: Can't locate module /dev/hda
>> modprobe: Can't locate module /dev/hda
>>
>> Unable to open /dev/hda
>> mousse-(19):[11:31pm]: [/>fdisk /dev/hdb
>> modprobe: Can't locate module /dev/hdb
>> modprobe: Can't locate module /dev/hdb
>>
>> Unable to open /dev/hdb
>> mousse-(20):[11:31pm]: [/>
>>
>> Or, when I run with a standard dev filesystem and the device
>> files created with scripts/MAKEDEV.ide it gives me an error,
>> cant find module block-3 blah blah blah...
>>
>>
>> Any ideas?
>>
>>
>>
>>
>>
>>
>>
>>>
>>> A good shot is always the Promise cards.  I know at least the 66 used
>>> to work, and I'm reasonably sure the 100 does.  You'll need 2.4 for it
>>> though, and no booting off it.
>>>
>>> On Sun, Aug 12, 2001 at 11:49:14PM -0700, James F Dougherty wrote:
>>>
>>>> I guess my question is which drivers run in native mode
>>>> (e.g. do not require an x86 ROM BIOS).
>>>>
>>>>
>>>>> Anyone have any suggestions for a PCI IDE card to
>>>>> use for PPC/Linux? Something one could buy down
>>>>> at a Frye's would be great.
>>>>>
>>>>>
>>>>> Many thanks in advance.
>>>>> 				-James
>>>>>
>>>>>
>>>>>
>>>>
>>>>
>>>>
>>> --
>>> Daniel Jacobowitz                           Carnegie Mellon University
>>> MontaVista Software                         Debian GNU/Linux Developer
>>>
>>>
>>
>>
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
