Return-Path: <felix@embedded-sol.com>
Received: from sh78.surpasshosting.com (sh78.surpasshosting.com [72.29.64.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3535FB6F0C
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Apr 2011 23:45:11 +1000 (EST)
Message-ID: <4DA30613.3090400@embedded-sol.com>
Date: Mon, 11 Apr 2011 16:45:55 +0300
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
Subject: Re: Problem with mini-PCI-E slot on P2020RDB
References: <4B27FEE3.80001@embedded-sol.com>	<4B28A7C3.6040209@embedded-sol.com>	<0949C49693EF1A47A54B0F0113CDB4A6076776@zin33exm23.fsl.freescale.net>	<4B28CBC4.4010501@embedded-sol.com>	<0949C49693EF1A47A54B0F0113CDB4A6076791@zin33exm23.fsl.freescale.net>	<4B29DC2B.8090405@embedded-sol.com>	<0949C49693EF1A47A54B0F0113CDB4A60767E8@zin33exm23.fsl.freescale.net>	<4B29F23A.9070001@embedded-sol.com>	<0949C49693EF1A47A54B0F0113CDB4A60767F0@zin33exm23.fsl.freescale.net>	<EBE3ECA5-AC1B-4E1C-A0DA-89260D0F03F6@kernel.crashing.org>	<4B2A946E.4040907@embedded-sol.com>	<BANLkTimf8uwgew3YPcNxdNj+4XamPhbxbQ@mail.gmail.com>	<071A08F2C6A57E4E94D980ECA553F87416D42F@039-SN1MPN1-004.039d.mgd.msft.net>
	<BANLkTi=QHOPTiuu2uXr1AcCXrpL3AT4cUw@mail.gmail.com>
	<071A08F2C6A57E4E94D980ECA553F87416F971@039-SN1MPN1-004.039d.mgd.msft.net>
	<4DA2BE49.9000003@embedded-sol.com>
	<071A08F2C6A57E4E94D980ECA553F87416FC1F@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <071A08F2C6A57E4E94D980ECA553F87416FC1F@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: multipart/mixed; boundary="------------070701090307090403000506"
Cc: Mahajan Vivek-B08308 <B08308@freescale.com>,
	Aggrwal Poonam-B10812 <B10812@freescale.com>,
	Leon Woestenberg <leon.woestenberg@gmail.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Gupta Maneesh-B18878 <B18878@freescale.com>,
	Fabian Bertholm <fabeisageek@googlemail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070701090307090403000506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Prabhakar,

On 04/11/2011 02:09 PM, Kushwaha Prabhakar-B32579 wrote:
> Hi,
>
> Yes. It wil be applicable for all revisions.
>
> Regards,
> Prabhakar
>

I'm sure this is applicable to all revisions, but it doesn't necessarily
makes things work. The problem I've reported back in 2009 still
exists on P2020RDB revC, even if I use the latest u-boot and kernel
and make device tree changes that you've suggested.
I've attached the boot log.

On the other hand, on P1020RDB revD with the same kernel, ath9k
driver loads fine and interrupts are arriving. However this only works
with u-boot-2010.12. If I upgrade to  u-boot-2011.03 loading ath9k
hangs the board. I'll report this separately on u-boot mailing list.

I would summarize this problem as follows. P10xx/P20xx RDB boards
prior to revD have hardware flaw. Using mini PCI-E cards that rely on
legacy interrupts is not possible on such boards. The problem was
fixed in board revision D. To use legacy interrupts one has to modify
pci-e nodes in device tree and add "interrupt-map-mask" and
"interrupt-map" properties.

Do you agree with this analysis ?

Felix.




>> -----Original Message-----
>> From: Felix Radensky [mailto:felix@embedded-sol.com]
>> Sent: Monday, April 11, 2011 2:10 PM
>> To: Kushwaha Prabhakar-B32579
>> Cc: Fabian Bertholm; Leon Woestenberg; linuxppc-dev@ozlabs.org; Mahajan
>> Vivek-B08308; Aggrwal Poonam-B10812; Gupta Maneesh-B18878
>> Subject: Re: Problem with mini-PCI-E slot on P2020RDB
>>
>> Hi,
>>
>> Assuming I have all patches in place, will this problem be resolved on
>> earlier board revisions (before rev D) ?
>>
>> Felix.
>>
>> On 04/11/2011 12:06 PM, Kushwaha Prabhakar-B32579 wrote:
>>> Hi Fabe,
>>>
>>> Yes .. P1020/P1011 RDB has same issue as of P2020RDB.
>>>
>>> It was because of some missing patches at u-boot and Linux.
>>>
>>> U-boot patch : It is already present in open source. Please use latest
>>> code base Linux patch : I am in process of posting in open source.
>> Please make mentioned changes of IDSEL.
>>> --Prabhakar
>>>
>>>> -----Original Message-----
>>>> From: Fabian Bertholm [mailto:fabeisageek@googlemail.com]
>>>> Sent: Monday, April 11, 2011 1:53 PM
>>>> To: Kushwaha Prabhakar-B32579
>>>> Cc: Leon Woestenberg; linuxppc-dev@ozlabs.org; Mahajan Vivek-B08308;
>>>> Felix Radensky; Aggrwal Poonam-B10812; Gupta Maneesh-B18878
>>>> Subject: Re: Problem with mini-PCI-E slot on P2020RDB
>>>>
>>>> Hello Kushwaha Prabhakar,
>>>>
>>>> Our impression is that there is the same issue on the P1020/P1011 RDB.
>>>> Can you confirm this?
>>>>
>>>> Best Regards,
>>>> Fabe
>>>>
>>>>
>>>> 2011/4/8 Kushwaha Prabhakar-B32579<B32579@freescale.com>:
>>>>>> -----Original Message-----
>>>>>> From: Leon Woestenberg [mailto:leon.woestenberg@gmail.com]
>>>>>> Sent: Thursday, April 07, 2011 10:50 PM
>>>>>> To: linuxppc-dev@ozlabs.org
>>>>>> Cc: Kumar Gala; Mahajan Vivek-B08308; Aggrwal Poonam-B10812; Felix
>>>>>> Radensky; Kushwaha Prabhakar-B32579
>>>>>> Subject: Re: Problem with mini-PCI-E slot on P2020RDB
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> On Thu, Dec 17, 2009 at 9:28 PM, Felix Radensky
>>>>>> <felix@embedded-sol.com>
>>>>>> wrote:
>>>>>>> Kumar Gala wrote:
>>>>>>>> On Dec 17, 2009, at 2:59 AM, Mahajan Vivek-B08308 wrote:
>>>>>>>>>> Thanks a lot. If I understand you correctly, the only way I can
>>>>>>>>>> get ath9k driver to work on this board using legacy interrupts
>>>>>>>>>> is to wait for a hardware fix. Right ?
>>>>>>>>>>
>>>>>>>>> Correct
>>>>>>>> I'm confused.  What's the issue with IRQ0 on the P2020RDB?  Is it
>>>>>>>> used for another purpose?
>>>>>>> There's a problem with IRQ0 with respect to mini-PCI-E slot. I
>>>>>>> have Atheros wireless card plugged into it. ath9k wireless driver
>>>>>>> for this card uses legacy PCI-E interrupts, and I get "irq 16:
>>>>>>> nobody
>>>> cared"
>>>>>>> message when driver executes request_irq(). Vivek has come to a
>>>>>>> conclusion that the problem is related to incorrect IRQ0 routing
>>>>>>> for mini-PCI-E slot on P2020RDB.
>>>>>>>
>>>>>> I would like to understand this issue better, as I seem to be
>>>>>> running into something similar, and it puts my board design on hold.
>>>>>>
>>>>>> Can someone (from Freescale) explain what happens if a PCI Express
>>>>>> end point on the mini-PCIe slot raises a legacy interrupt, and
>>>>>> where this goes wrong?
>>>>>>
>>>>>>   From what document or source code file can I conclude that the
>>>>>> PCIe legacy interrupt is shared with IRQ0?
>>>>>>
>>>>>>
>>>>>> I found this:
>>>>>>
>>>>>> P1020E/P2020E RDB System Errata, Last Update: 2/15/2010:
>>>>>> Problem:IRQ0 held low
>>>>>> Fix: Add 4.7K pull-up (to 3.3.V) for RTC_INT_N.
>>>>>> See R420 in Rev D schematic.
>>>>>> Add 4.7K pull-up (to 3.3.V) for MCU_INT_N.
>>>>>> See R423 in Rev D schematic.
>>>>>>
>>>>>>
>>>>> Hello Leon,
>>>>>
>>>>>    Yes you are right, PCIe leagacy interrupt is shared with IRQ0. For
>>>> Atheros issue.
>>>>>    Can you please try followings, Meanwhile I will try to dig into it.
>>>>>
>>>>> http://old.nabble.com/Problem-with-mini-PCI-E-slot-on-P2020RDB-td268
>>>>> 02
>>>>> 038.html
>>>>>
>>>>> Regarding sata_sil24, Please see my e-mail on Linux-ide for correct
>>>> IDSEL value.
>>>>> Please first try IDSEL value mentioned in email on Linux-ide. Then
>>>>> try
>>>> this URL..
>>>>> --Prabhakar
>>>>>
>>>>> _______________________________________________
>>>>> Linuxppc-dev mailing list
>>>>> Linuxppc-dev@lists.ozlabs.org
>>>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>>>>
>

--------------070701090307090403000506
Content-Type: text/plain;
 name="bootlog.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="bootlog.txt"

U-Boot 2011.03 (Apr 11 2011 - 13:57:51)

CPU0:  P2020E, Version: 1.0, (0x80ea0010)
Core:  E500, Version: 4.0, (0x80211040)
Clock Configuration:
       CPU0:1200 MHz, CPU1:1200 MHz,
       CCB:600  MHz,
       DDR:400  MHz (800 MT/s data rate) (Asynchronous), LBC:37.500 MHz
L1:    D-cache 32 kB enabled
       I-cache 32 kB enabled
Board: P2020RDB RevC
I2C:   ready
DRAM:  Configuring DDR for 800 MT/s data rate
DDR: 1 GiB (DDR2, 64-bit, CL=6, ECC off)
Flash: 16 MiB
L2:    512 KB enabled
NAND:  32 MiB
MMC:  FSL_ESDHC: 0
EEPROM: Invalid ID (ff ff ff ff)
PCIe1: Root Complex of Slot 2, x1, regs @ 0xffe0a000
  01:00.0     - 168c:002a - Network controller
PCIe1: Bus 00 - 01
PCIe2: Root Complex of Slot 1, no link, regs @ 0xffe09000
PCIe2: Bus 02 - 02
In:    serial
Out:   serial
Err:   serial
Net:   eTSEC3 is in sgmii mode.
uploading VSC7385 microcode from ef000000
eTSEC1: No support for PHY id ffffffff; assuming generic
eTSEC1, eTSEC2, eTSEC3
Hit any key to stop autoboot:  0
Speed: 1000, full duplex
Using eTSEC1 device
TFTP from server 10.0.0.10; our IP address is 10.0.0.30
Filename 'p2020rdb/uImage'.
Load address: 0x1000000
Loading: #################################################################
         #################################################################
         #################################################################
         ##########
done
Bytes transferred = 2997778 (2dbe12 hex)
Speed: 1000, full duplex
Using eTSEC1 device
TFTP from server 10.0.0.10; our IP address is 10.0.0.30
Filename 'p2020rdb/p2020rdb.dtb'.
Load address: 0xc00000
Loading: #
done
Bytes transferred = 11229 (2bdd hex)
WARNING: adjusting available memory to 30000000
## Booting kernel from Legacy Image at 01000000 ...
   Image Name:   Linux-2.6.38.2
   Created:      2011-04-11  11:19:15 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    2997714 Bytes = 2.9 MiB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at 00c00000
   Booting using the fdt blob at 0xc00000
   Uncompressing Kernel Image ... OK
   Loading Device Tree to 00ffa000, end 00fffbdc ... OK
Using P2020 RDB machine description
Memory CAM mapping: 256/256/256 Mb, residual: 256Mb
Linux version 2.6.38.2 (felix@felix.lan) (gcc version 4.2.2) #1 Mon Apr 11 14:18:40 IDT 2011
bootconsole [udbg0] enabled
setup_arch: bootmem
mpc85xx_rdb_setup_arch()
Found FSL PCI host bridge at 0x00000000ffe09000. Firmware bus number: 0->0
PCI host bridge /pcie@ffe09000  ranges:
 MEM 0x00000000a0000000..0x00000000bfffffff -> 0x00000000a0000000
  IO 0x00000000ffc30000..0x00000000ffc3ffff -> 0x0000000000000000
/pcie@ffe09000: PCICSRBAR @ 0xfff00000
Found FSL PCI host bridge at 0x00000000ffe0a000. Firmware bus number: 0->1
PCI host bridge /pcie@ffe0a000  ranges:
 MEM 0x00000000c0000000..0x00000000dfffffff -> 0x00000000c0000000
  IO 0x00000000ffc20000..0x00000000ffc2ffff -> 0x0000000000000000
/pcie@ffe0a000: PCICSRBAR @ 0xfff00000
MPC85xx RDB board from Freescale Semiconductor
arch: exit
Zone PFN ranges:
  DMA      0x00000000 -> 0x00030000
  Normal   empty
  HighMem  0x00030000 -> 0x00040000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00040000
MMU: Allocated 1088 bytes of context maps for 255 contexts
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
Kernel command line: root=/dev/nfs rw nfsroot=10.0.0.10:/opt/eldk/4.2/ppc_85xxDP ip=10.0.0.30:10.0.0.10::255.0.0.0:P2020RDB:eth0:off console=ttyS0,115200 ra0
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1033304k/1048576k available (5816k kernel code, 15272k reserved, 184k data, 148k bss, 200k init)
Kernel virtual memory layout:
  * 0xfffcf000..0xfffff000  : fixmap
  * 0xffc00000..0xffe00000  : highmem PTEs
  * 0xffbda000..0xffc00000  : early ioremap
  * 0xf1000000..0xffbda000  : vmalloc & ioremap
SLUB: Genslabs=15, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:512 nr_irqs:512 16
mpic: Setting up MPIC " OpenPIC  " version 1.2 at ffe40000, max 2 CPUs
mpic: ISU size: 256, shift: 8, mask: ff
mpic: Initializing for 256 sources
clocksource: timebase mult[3555555] shift[22] registered
Console: colour dummy device 80x25
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
NET: Registered protocol family 16
            
PCI: Probing PCI hardware
pci 0000:00:00.0: ignoring class b20 (doesn't match header type 01)
pci 0000:00:00.0: PCI bridge to [bus 01-ff]
pci 0001:02:00.0: ignoring class b20 (doesn't match header type 01)
pci 0001:02:00.0: PCI bridge to [bus 03-ff]
PCI: Cannot allocate resource region 0 of device 0001:03:00.0, will remap
pci 0000:00:00.0: PCI bridge to [bus 01-01]
pci 0000:00:00.0:   bridge window [io  0xffbed000-0xffbfcfff]
pci 0000:00:00.0:   bridge window [mem 0xa0000000-0xbfffffff]
pci 0000:00:00.0:   bridge window [mem pref disabled]
pci 0000:00:00.0: enabling device (0106 -> 0107)
pci 0001:03:00.0: BAR 0: assigned [mem 0xc0000000-0xc000ffff 64bit]
pci 0001:03:00.0: BAR 0: set to [mem 0xc0000000-0xc000ffff 64bit] (PCI address [0xc0000000-0xc000ffff])
pci 0001:02:00.0: PCI bridge to [bus 03-03]
pci 0001:02:00.0:   bridge window [io  0xffbdb000-0xffbeafff]
pci 0001:02:00.0:   bridge window [mem 0xc0000000-0xdfffffff]
pci 0001:02:00.0:   bridge window [mem pref disabled]
pci 0001:02:00.0: enabling device (0106 -> 0107)
bio: create slab <bio-0> at 0
vgaarb: loaded
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Freescale Elo / Elo Plus DMA driver
Advanced Linux Sound Architecture Driver Version 1.0.23.
cfg80211: Calling CRDA to update world regulatory domain
Switching to clocksource timebase
Switched to NOHz mode on CPU #0
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
UDP hash table entries: 512 (order: 1, 8192 bytes)
UDP-Lite hash table entries: 512 (order: 1, 8192 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
of:fsl-elo-dma ffe0c300.dma: #0 (fsl,eloplus-dma-channel), irq 76
of:fsl-elo-dma ffe0c300.dma: #1 (fsl,eloplus-dma-channel), irq 77
of:fsl-elo-dma ffe0c300.dma: #2 (fsl,eloplus-dma-channel), irq 78
of:fsl-elo-dma ffe0c300.dma: #3 (fsl,eloplus-dma-channel), irq 79
of:fsl-elo-dma ffe21300.dma: #0 (fsl,eloplus-dma-channel), irq 21
of:fsl-elo-dma ffe21300.dma: #1 (fsl,eloplus-dma-channel), irq 22
of:fsl-elo-dma ffe21300.dma: #2 (fsl,eloplus-dma-channel), irq 23
of:fsl-elo-dma ffe21300.dma: #3 (fsl,eloplus-dma-channel), irq 24
audit: initializing netlink socket (disabled)
type=2000 audit(0.224:1): initialized
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.30 [Flags: R/O].
msgmni has been set to 1506
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
Freescale DIU driver
Serial: 8250/16550 driver, 2 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0xffe04500 (irq = 42) is a 16550A
console [ttyS0] enabled, bootconsole disabled
console [ttyS0] enabled, bootconsole disabled
serial8250.0: ttyS1 at MMIO 0xffe04600 (irq = 42) is a 16550A
Generic non-volatile memory driver v1.1
brd: module loaded
loop: module loaded
nbd: registered device at major 43
st: Version 20101219, fixed bufsize 32768, s/g segs 256
Fixed MDIO Bus: probed
eth0: Gianfar Ethernet Controller Version 1.2, 00:04:9f:ec:a1:02
eth0: Running with NAPI enabled
eth0: RX BD ring size for Q[0]: 256
eth0: TX BD ring size for Q[0]: 256
eth1: Gianfar Ethernet Controller Version 1.2, 00:04:9f:ec:a1:11
eth1: Running with NAPI enabled
eth1: RX BD ring size for Q[0]: 256
eth1: TX BD ring size for Q[0]: 256
eth2: Gianfar Ethernet Controller Version 1.2, 00:04:9f:ec:a1:01
eth2: Running with NAPI enabled
eth2: RX BD ring size for Q[0]: 256
eth2: TX BD ring size for Q[0]: 256
Freescale PowerQUICC MII Bus: probed
Freescale PowerQUICC MII Bus: probed
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
/soc@ffe00000/usb@22000: Invalid 'dr_mode' property, fallback to host mode
fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
fsl-ehci fsl-ehci.0: irq 28, io mem 0xffe22000
fsl-ehci fsl-ehci.0: USB 2.0 started, EHCI 1.00
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
of:mpc-i2c ffe03000.i2c: timeout 1000000 us
of:mpc-i2c ffe03100.i2c: timeout 1000000 us
EDAC MC: Ver: 2.1.0 Apr 11 2011
of:talitos ffe30000.crypto: hwrng
of:talitos ffe30000.crypto: authenc-hmac-sha1-cbc-aes-talitos
of:talitos ffe30000.crypto: authenc-hmac-sha1-cbc-3des-talitos
of:talitos ffe30000.crypto: authenc-hmac-sha256-cbc-aes-talitos
of:talitos ffe30000.crypto: authenc-hmac-sha256-cbc-3des-talitos
of:talitos ffe30000.crypto: authenc-hmac-md5-cbc-aes-talitos
of:talitos ffe30000.crypto: authenc-hmac-md5-cbc-3des-talitos
of:talitos ffe30000.crypto: cbc-aes-talitos
of:talitos ffe30000.crypto: cbc-3des-talitos
of:talitos ffe30000.crypto: md5-talitos
of:talitos ffe30000.crypto: sha1-talitos
of:talitos ffe30000.crypto: sha224-talitos
of:talitos ffe30000.crypto: sha256-talitos
of:talitos ffe30000.crypto: sha384-talitos
of:talitos ffe30000.crypto: sha512-talitos
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
ALSA device list:
  No soundcards found.
IPv4 over IPv4 tunneling driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
lib80211: common routines for IEEE802.11 drivers
Registering the dns_resolver key type
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
ADDRCONF(NETDEV_UP): eth0: link is not ready
IP-Config: Complete:
     device=eth0, addr=10.0.0.30, mask=255.0.0.0, gw=255.255.255.255,
     host=P2020RDB, domain=, nis-domain=(none),
     bootserver=10.0.0.10, rootserver=10.0.0.10, rootpath=
PHY: 0:01 - Link is Up - 1000/Full
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
VFS: Mounted root (nfs filesystem) on device 0:13.
Freeing unused kernel memory: 200k init
INIT: version 2.86 booting
                Welcome to DENX Embedded Linux Environment
                Press 'I' to enter interactive startup.
Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of our search for an access method.
Setting clock : Thu Jan  1 01:00:03 CET 1970 [  OK  ]
Building the cache [  OK  ]
Setting hostname P2020RDB:  [  OK  ]
Your system appears to have shut down uncleanly
Checking filesystems
Checking all file systems.
[  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling /etc/fstab swaps:  [  OK  ]
INIT: Entering runlevel: 3
Entering non-interactive startup
Bringing up loopback interface:  [  OK  ]
Starting system logger: [  OK  ]
Starting kernel logger: [  OK  ]
Starting rpcbind: [  OK  ]
Mounting NFS filesystems:  [  OK  ]
Mounting other filesystems:  [  OK  ]
Starting xinetd: [  OK  ]
Starting dropbear:  [  OK  ]

DENX ELDK version 4.2 build 2008-04-01
Linux 2.6.38.2 on a ppc

P2020RDB login: root
Last login: Thu Jan  1 01:00:15 on ttyS0
-bash-3.2# modprobe ath9k
irq 16: nobody cared (try booting with the "irqpoll" option)
Call Trace:
[efff1f50] [c0007370] show_stack+0x3c/0x17c (unreliable)
[efff1f90] [c0072200] __report_bad_irq+0x38/0xcc
[efff1fb0] [c007244c] note_interrupt+0x1b8/0x228
[efff1fe0] [c0073548] handle_fasteoi_irq+0x9c/0x114
[efff1ff0] [c000cb98] call_handle_irq+0x18/0x28
[ef4adbe0] [c0005130] do_IRQ+0xa4/0x140
[ef4adc10] [c000e420] ret_from_except+0x0/0x18
--- Exception: 501 at __setup_irq+0x1a4/0x33c
    LR = __setup_irq+0x338/0x33c
[ef4adcf0] [c0071684] request_threaded_irq+0xbc/0x138
[ef4add20] [f171fcf8] ath_pci_probe+0x218/0x364 [ath9k]
[ef4adda0] [c01e0508] local_pci_probe+0x24/0x34
[ef4addb0] [c01e0798] pci_device_probe+0x84/0xc4
[ef4adde0] [c021fe04] driver_probe_device+0x150/0x1b4
[ef4ade00] [c022011c] __driver_attach+0xa4/0xa8
[ef4ade20] [c021ed38] bus_for_each_dev+0x60/0x9c
[ef4ade50] [c021fb4c] driver_attach+0x24/0x34
[ef4ade60] [c021f8d4] bus_add_driver+0x1c0/0x284
[ef4ade90] [c0220380] driver_register+0x70/0x168
[ef4adeb0] [c01e0a88] __pci_register_driver+0x4c/0xd4
[ef4aded0] [f171f998] ath_pci_init+0x28/0x38 [ath9k]
[ef4adee0] [f172804c] ath9k_init+0x4c/0xb0 [ath9k]
[ef4adef0] [c0001ef8] do_one_initcall+0x16c/0x1b8
[ef4adf20] [c006a328] sys_init_module+0xd4/0x1e4
[ef4adf40] [c000ddcc] ret_from_syscall+0x0/0x3c
--- Exception: c01 at 0xff690b0
    LR = 0x10003420
handlers:
[<f171698c>] (ath_isr+0x0/0x210 [ath9k])
Disabling IRQ #16

--------------070701090307090403000506--
