Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 84F03DDE40
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 06:10:13 +1100 (EST)
Message-ID: <474B1A11.90806@harris.com>
Date: Mon, 26 Nov 2007 14:10:09 -0500
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: Sequoia EMAC only works if u-boot initializes it?
References: <474AED67.4020006@harris.com> <200711261720.26629.sr@denx.de>
In-Reply-To: <200711261720.26629.sr@denx.de>
Content-Type: multipart/mixed; boundary="------------030607000401020603000702"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------030607000401020603000702
Content-Type: multipart/alternative;
 boundary="------------000608010105090609050807"


--------------000608010105090609050807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've attached a copy of my bootlog.  I added in one patch to enable 
rgmii but that didn't fix it. 
(http://ozlabs.org/pipermail/linuxppc-dev/2007-October/043435.html)

I am curious why the new emac driver is enabled in the DENX tree but not 
in the upstream trees.  Has DENX successfully used this driver on the 
Sequoia board?  Am I trying something that is known not to work?

I'm interested in helping in whatever way I can.  I need ARCH=powerpc to 
use the current Xenomai patches, and I need both EMACs so I can evaluate 
bonding (for high-availability).

    Thanks,
    Steve


Stefan Roese wrote:
> On Monday 26 November 2007, Steven A. Falco wrote:
>   
>> I have noticed odd behavior on a Sequoia board.  Kernel is built from
>> DENX git, ARCH=powerpc, 2.6.23.1.
>>
>> Sequence that works:
>> 1) In u-boot, do "dhcp" (this initializes the PHY)
>> 2) Boot linux from flash
>> 3) ifconfig eth0 192.168.0.101 netmask 255.255.255.0 up
>> Ethernet is now functional, and I can ping the Sequoia (and it can ping
>> my host)
>>
>> Sequence that does not work:
>> 1) Boot linux from flash without letting u-boot touch eth0
>> 2) ifconfig eth0 192.168.0.101 netmask 255.255.255.0 up
>> Ethernet appears to come up, but it is not functional.  I.e. I get
>> "eth0: link is up, 100 FDX, pause enabled" but I cannot ping the board,
>> and the board cannot ping my host.
>>     
>
> Do you have a 100MBit connection? Or Gbit? Could you please send the complete 
> bootlog.
>
>   
>> So, the kernel appears to be missing some initialization that u-boot
>> provides.
>>
>> However, eth1 is more strange.  U-boot can use it (via "setenv ethact
>> ppc_4xx_eth1;dhcp"), however, the kernel cannot use it, whether or not
>> u-boot first initializes it.
>>
>> If anyone has suggestions on where to look, I'd appreciate it.  I'm
>> going to look at the PHY register settings and see if there are any
>> clues there...
>>     
>
> Again it would be interesting to see the bootlog here.
>
> Best regards,
> Stefan
>
> =====================================================================
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
> =====================================================================
>
>   

--------------000608010105090609050807
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<tt>I've attached a copy of my bootlog.&nbsp; I added in one patch to enable
rgmii</tt><tt> but that didn't fix it.</tt><tt>
(<a class="moz-txt-link-freetext" href="http://ozlabs.org/pipermail/linuxppc-dev/2007-October/043435.html">http://ozlabs.org/pipermail/linuxppc-dev/2007-October/043435.html</a>)<br>
<br>
I am curious why the new emac driver is enabled in the DENX tree but
not in the upstream trees.&nbsp; Has DENX successfully used this driver on
the Sequoia board?&nbsp; Am I trying something that is known not to work?<br>
<br>
I'm interested in helping in whatever way I can.&nbsp; I need ARCH=powerpc
to use the current Xenomai patches, and I need both EMACs so I can
evaluate bonding (for high-availability).<br>
<br>
&nbsp;&nbsp;&nbsp; Thanks,<br>
&nbsp;&nbsp;&nbsp; Steve<br>
<br>
</tt><br>
Stefan Roese wrote:
<blockquote cite="mid:200711261720.26629.sr@denx.de" type="cite">
  <pre wrap="">On Monday 26 November 2007, Steven A. Falco wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I have noticed odd behavior on a Sequoia board.  Kernel is built from
DENX git, ARCH=powerpc, 2.6.23.1.

Sequence that works:
1) In u-boot, do "dhcp" (this initializes the PHY)
2) Boot linux from flash
3) ifconfig eth0 192.168.0.101 netmask 255.255.255.0 up
Ethernet is now functional, and I can ping the Sequoia (and it can ping
my host)

Sequence that does not work:
1) Boot linux from flash without letting u-boot touch eth0
2) ifconfig eth0 192.168.0.101 netmask 255.255.255.0 up
Ethernet appears to come up, but it is not functional.  I.e. I get
"eth0: link is up, 100 FDX, pause enabled" but I cannot ping the board,
and the board cannot ping my host.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Do you have a 100MBit connection? Or Gbit? Could you please send the complete 
bootlog.

  </pre>
  <blockquote type="cite">
    <pre wrap="">So, the kernel appears to be missing some initialization that u-boot
provides.

However, eth1 is more strange.  U-boot can use it (via "setenv ethact
ppc_4xx_eth1;dhcp"), however, the kernel cannot use it, whether or not
u-boot first initializes it.

If anyone has suggestions on where to look, I'd appreciate it.  I'm
going to look at the PHY register settings and see if there are any
clues there...
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Again it would be interesting to see the bootlog here.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk &amp; Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: <a class="moz-txt-link-abbreviated" href="mailto:office@denx.de">office@denx.de</a>
=====================================================================

  </pre>
</blockquote>
</body>
</html>

--------------000608010105090609050807--

--------------030607000401020603000702
Content-Type: text/plain;
 name="broke"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="broke"

=> run saf
## Booting image at fc000000 ...
   Image Name:   Linux-2.6.23.1-gb68e890e-dirty
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1623086 Bytes =  1.5 MB
   Load Address: 00400000
   Entry Point:  004003e0
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at fc2c0000 ...
   Image Name:   Sequoia Ramdisk RCD-05
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    1169588 Bytes =  1.1 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Loading Ramdisk to 0fe0d000, end 0ff2a8b4 ... OK
CPU clock-frequency <- 0x27bc86ae (667MHz)
CPU timebase-frequency <- 0x27bc86ae (667MHz)
/plb: clock-frequency <- 9ef21ab (167MHz)
/plb/opb: clock-frequency <- 4f790d5 (83MHz)
/plb/opb/ebc: clock-frequency <- 34fb5e3 (56MHz)
/plb/opb/serial@ef600300: clock-frequency <- a8c000 (11MHz)
/plb/opb/serial@ef600400: clock-frequency <- a8c000 (11MHz)
/plb/opb/serial@ef600500: clock-frequency <- a8c000 (11MHz)
/plb/opb/serial@ef600600: clock-frequency <- a8c000 (11MHz)
Memory <- <0x0 0x0 0x10000000> (256MB)
ENET0: local-mac-address <- 00:10:ec:00:e2:85
ENET1: local-mac-address <- 00:10:ec:80:e2:85

zImage starting: loaded at 0x00400000 (sp: 0x0ff2b568)
Allocating 0x39068c bytes for kernel ...
gunzipping (0x00000000 <- 0x0040c000:0x0076e178)...done 0x34aaac bytes
Using loader supplied ramdisk at 0xfe0d000-0xff2a8b4
initrd head: 0x1f8b0808

Linux/PowerPC load: root=/dev/ram rw console=ttyS0,115200
Finalizing device tree... flat tree at 0x77b3a0
Using Sequoia machine description
Linux version 2.6.23.1-gb68e890e-dirty (sfalco@saf.cs.myharris.net) (gcc version 4.0.0 (DENX ELDK 4.1 4.0.0)) #8 Mon Nov 26 13:05:59 EST 2007
Found initrd at 0xcfe0d000:0xcff2a8b4
Zone PFN ranges:
  DMA             0 ->    65536
  Normal      65536 ->    65536
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->    65536
Built 1 zonelists in Zone order.  Total pages: 65024
Kernel command line: root=/dev/ram rw console=ttyS0,115200
UIC0 (32 IRQ sources) at DCR 0xc0
UIC1 (32 IRQ sources) at DCR 0xd0
UIC2 (32 IRQ sources) at DCR 0xe0
PID hash table entries: 1024 (order: 10, 4096 bytes)
I-pipe 2.0-03: pipeline enabled.
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 254772k/262144k available (3192k kernel code, 7064k reserved, 160k data, 277k bss, 136k init)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing PCI hardware
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 1142k freed
I-pipe: Domain Xenomai registered.
Xenomai: hal/powerpc started.
Xenomai: real-time nucleus v2.4-rc6 (Bells Of Lal) loaded.
Xenomai: starting native API services.
Xenomai: starting POSIX services.
Xenomai: starting RTDM services.
JFFS2 version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
1ef600300.serial: ttyS0 at MMIO 0x1ef600300 (irq = 16) is a 16550A
console [ttyS0] enabled
1ef600400.serial: ttyS1 at MMIO 0x1ef600400 (irq = 17) is a 16550A
1ef600500.serial: ttyS2 at MMIO 0x1ef600500 (irq = 18) is a 16550A
1ef600600.serial: ttyS3 at MMIO 0x1ef600600 (irq = 19) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 35000K size 1024 blocksize
PPC 4xx OCP EMAC driver, version 3.54
MAL v2 /plb/mcmal, 4 TX channels, 4 RX channels
ZMII /plb/opb/emac-zmii@ef600d00 initialized
RGMII standard /plb/opb/emac-rgmii@ef601000 initialized
/plb/opb/emac-rgmii@ef601000: input 0 in RGMII mode
eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:10:ec:00:e2:85
eth0: found Generic MII PHY (0x00)
/plb/opb/emac-rgmii@ef601000: input 1 in RGMII mode
eth1: EMAC-1 /plb/opb/ethernet@ef600f00, MAC 00:10:ec:80:e2:85
eth1: found Generic MII PHY (0x01)
physmap-flash 1fc000000.nor_flash: Device tree uses obsolete "direct-mapped" flash binding
1fc000000.nor_flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
1fc000000.nor_flash: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
cmdlinepart partition parsing not available
RedBoot partition parsing not available
physmap-flash 1fc000000.nor_flash: Device tree uses obsolete partition map binding
Creating 5 MTD partitions on "1fc000000.nor_flash":
0x00000000-0x002c0000 : "kernel"
0x002c0000-0x00400000 : "root"
0x00400000-0x03f60000 : "usr"
0x03f60000-0x03fa0000 : "env"
0x03fa0000-0x04000000 : "u-boot"
NDFC NAND Driver initialized. Chip-Rev: 0x00000110
NAND device: Manufacturer ID: 0x20, Chip ID: 0x75 (ST Micro NAND 32MiB 3,3V 8-bit)
Scanning device for bad blocks
Number of partitions 1
Creating 1 MTD partitions on "NAND 32MiB 3,3V 8-bit":
0x00000000-0x02000000 : "content"
usbmon: debugfs is not available
ppc-of-ehci e0000300.ehci: OF EHCI
ppc-of-ehci e0000300.ehci: new USB bus registered, assigned bus number 1
ppc-of-ehci e0000300.ehci: irq 32, io mem 0xe0000300
ppc-of-ehci e0000300.ehci: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
ether gadget: using random self ethernet address
ether gadget: using random host ethernet address
usb0: Ethernet Gadget, version: May Day 2005
usb0: using musbhsfc_udc, OUT ep2 IN ep1 STATUS ep3
usb0: MAC da:82:03:7c:d0:81
usb0: HOST MAC 5a:a1:bf:a5:ae:d5
usb0: RNDIS ready
musbhsfc_udc: registered gadget driver 'ether'
i2c /dev entries driver
IBM IIC driver v2.1
ibm-iic(/plb/opb/i2c@ef600700): using standard (100 kHz) mode
ibm-iic(/plb/opb/i2c@ef600800): using standard (100 kHz) mode
ad7414 0-0048: chip found, driver version 0.1
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 136k init
AMCC Startup utility launched.

Please press Enter to activate this console.


BusyBox v1.2.1 (2007.06.08-14:45+0000) Built-in shell (ash)
Enter 'help' for a list of built-in commands.

~ # ifconfig eth0 192.168.0.101 netmask 255.255.255.0 ueth0: link is up, 100 FDX, pause enabled
p
~ # ifconfig
eth0      Link encap:Ethernet  HWaddr 00:10:EC:00:E2:85
          inet addr:192.168.0.101  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:3 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:180 (180.0 B)  TX bytes:126 (126.0 B)
          Interrupt:26

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

~ # ping 192.168.0.1
PING 192.168.0.1 (192.168.0.1): 56 data bytes

--- 192.168.0.1 ping statistics ---
4 packets transmitted, 0 packets received, 100% packet loss
~ # ifconfig
eth0      Link encap:Ethernet  HWaddr 00:10:EC:00:E2:85
          inet addr:192.168.0.101  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:3 errors:0 dropped:0 overruns:0 frame:0
          TX packets:8 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:180 (180.0 B)  TX bytes:336 (336.0 B)
          Interrupt:26

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:3 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:336 (336.0 B)  TX bytes:336 (336.0 B)

~ #

--------------030607000401020603000702--
