Return-Path: <jonsmirl@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id EBE73DDE24
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Mar 2009 11:37:15 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1176449ywb.39
	for <linuxppc-dev@ozlabs.org>; Sun, 01 Mar 2009 16:37:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <fa686aa40903011447x1810f252m367d6c05cc567133@mail.gmail.com>
References: <1235575933-29691-1-git-send-email-w.sang@pengutronix.de>
	<fa686aa40902262131i6c75687foaf42daeb4fc7a3b7@mail.gmail.com>
	<20090301101815.GC23093@pengutronix.de>
	<fa686aa40903010648q238380acy34b58e04226d8014@mail.gmail.com>
	<9e4733910903010754q1b4d9fafy87668049653d5e21@mail.gmail.com>
	<fa686aa40903011447x1810f252m367d6c05cc567133@mail.gmail.com>
Date: Sun, 1 Mar 2009 19:37:13 -0500
Message-ID: <9e4733910903011637q246eb82al140e87242f695413@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mpc52xx: add Phytec phyCORE-MPC5200B-IO board
	(pcm032)
From: Jon Smirl <jonsmirl@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Just tried it on pcm030. If I uncomment the reg line the kernel won't
boot at all. I don't get any output.

        pci@f0000d00 {
		#interrupt-cells = <1>;
		#size-cells = <2>;
		#address-cells = <3>;
		device_type = "pci";
		compatible = "fsl,mpc5200b-pci","fsl,mpc5200-pci";
		/*reg = <0xf0000d00 0x100>; */
		interrupt-map-mask = <0xf800 0 0 7>;
		interrupt-map = <0xc000 0 0 1 &mpc5200_pic 0 0 3 // 1st slot
				 0xc000 0 0 2 &mpc5200_pic 1 1 3
				 0xc000 0 0 3 &mpc5200_pic 1 2 3
				 0xc000 0 0 4 &mpc5200_pic 1 3 3

				 0xc800 0 0 1 &mpc5200_pic 1 1 3 // 2nd slot
				 0xc800 0 0 2 &mpc5200_pic 1 2 3
				 0xc800 0 0 3 &mpc5200_pic 1 3 3
				 0xc800 0 0 4 &mpc5200_pic 0 0 3>;
		clock-frequency = <0>; // From boot loader
		interrupts = <2 8 0 2 9 0 2 10 0>;
		bus-range = <0 0>;
		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x20000000
			  0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
			  0x01000000 0 0x00000000 0xb0000000 0 0x01000000>;
	};

console log with reg commented out.

Using dspeak01 machine description
Linux version 2.6.29-rc6-efika (jonsmirl@terra) (gcc version 4.1.2)
#970 Sun Mar 1 19:28:25 EST 2009
console [udbg0] enabled
Can't get /pci@f0000d00 resources
port_config: old:558c10 new:559c76
Top of RAM: 0x4000000, Total RAM: 0x4000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA      0x00000000 -> 0x00004000
  Normal   0x00004000 -> 0x00004000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00004000
On node 0 totalpages: 16384
free_area_init_node: node 0, pgdat c0394ca0, node_mem_map c0402000
  DMA zone: 128 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 16256 pages, LIFO batch:3
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: rw debug root=/dev/nfs ip=dhcp
nfsroot=192.168.1.4:/home/OSELAS.BSP-Phytec-phyCORE-MPC5200B-tiny-6/root,v3,tcp
netconsole=6666@192.168.1.11/eth0,514@192.168.1.4/00:19:d1:e4:0f:8d
MPC52xx PIC is up and running!
PID hash table entries: 256 (order: 8, 1024 bytes)
time_init: decrementer frequency = 33.333333 MHz
time_init: processor frequency   = 399.999996 MHz
clocksource: timebase mult[7800001] shift[22] registered
clockevent: decrementer mult[888] shift[16] cpu[0]
Console: colour dummy device 80x25
console handover: boot [udbg0] -> real [tty0]
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 61048k/65536k available (3520k kernel code, 4428k reserved,
156k data, 122k bss, 168k init)
SLUB: Genslabs=12, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
Calibrating delay loop... 66.28 BogoMIPS (lpj=110848)
Mount-cache hash table entries: 512
net_namespace: 296 bytes
NET: Registered protocol family 16
PCI: Probing PCI hardware
DMA: MPC52xx BestComm driver
DMA: MPC52xx BestComm engine @f0001200 ok !
bio: create slab <bio-0> at 0
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
NET: Registered protocol family 1
audit: initializing netlink socket (disabled)
type=2000 audit(0.203:1): initialized
msgmni has been set to 119
alg: No test for stdrng (krng)
io scheduler noop registered
io scheduler deadline registered (default)
Generic non-volatile memory driver v1.1
Serial: MPC52xx PSC UART driver
f0002400.serial: ttyPSC0 at MMIO 0xf0002400 (irq = 131) is a MPC52xx PSC
f0002c00.serial: ttyPSC1 at MMIO 0xf0002c00 (irq = 132) is a MPC52xx PSC
brd: module loaded
loop: module loaded
mpc52xx MII bus: probed
eth0 (mpc52xx-fec): not using net_device_ops yet
net eth0: Using PHY at MDIO address 0
netconsole: local port 6666
netconsole: local IP 192.168.1.11
netconsole: interface eth0
netconsole: remote port 514
netconsole: remote IP 192.168.1.4
netconsole: remote ethernet address 00:19:d1:e4:0f:8d
netconsole: device eth0 not up yet, forcing it
net eth0: attached phy 0 to driver Generic PHY
netconsole: carrier detect appears untrustworthy, waiting 4 seconds
PHY: f0003000:00 - Link is Up - 100/Full
console [netcon0] enabled
netconsole: network logging started
ff000000.flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x0031
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
erase region 0: offset=0x0,size=0x20000,blocks=128
Searching for RedBoot partition table in ff000000.flash at offset 0xfe0000
No RedBoot partition table detected in ff000000.flash
Creating 6 MTD partitions on "ff000000.flash":
0x000000000000-0x000000040000 : "ubootl"
0x000000040000-0x000000200000 : "kernel"
0x000000200000-0x000000f00000 : "jffs2"
0x000000f00000-0x000000f40000 : "uboot"
0x000000f40000-0x000000f80000 : "oftree"
0x000000f80000-0x000001000000 : "space"
mpc52xx-spi f0000f00.spi: mode fault; is port_config correct?
mpc52xx-spi: probe of f0000f00.spi failed with error -5
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
ppc-of-ohci f0001000.usb: OF OHCI
ppc-of-ohci f0001000.usb: new USB bus registered, assigned bus number 1
ppc-of-ohci f0001000.usb: irq 134, io mem 0xf0001000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ir-gpt f0000670.ir0: ir_gpt_of_probe
input: GPT IR Receiver as /class/input/input0
evbug.c: Connected device: input0 (GPT IR Receiver at unknown)
ir-gpt f0000670.ir0: ir_gpt_of_probe irq=80
ir-gpt f0000670.ir0: ir_gpt_of_probe request irq rc=0
GPT IR Receiver driver
usbcore: registered new interface driver ir_mceusb2
rtc-pcf8563 1-0051: chip found, driver version 0.4.3
rtc-pcf8563 1-0051: rtc core: registered rtc-pcf8563 as rtc0
at24 1-0052: 4096 byte 24c32 EEPROM (writable)
usbcore: registered new interface driver usbhid
usbhid: v2.6:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.18a.
tas5504 0-001b: probing tas5504 i2c device
registering ASoC codec driver: /soc5200@f0000000/i2c@3d00/codec@1b
tas5504 0-001b: I2C device initialized
registering ASoC platform driver: /soc5200@f0000000/i2s@2200
looking for codec: /soc5200@f0000000/i2c@3d00/codec@1b
platform<-->codec match achieved; registering machine
ALSA device list:
  No soundcards found.
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
rtc-pcf8563 1-0051: low voltage detected, date/time is not reliable.
rtc-pcf8563 1-0051: retrieved date/time is not valid.
rtc-pcf8563 1-0051: hctosys: invalid date/time
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 192.168.1.1, my address is 192.168.1.11
IP-Config: Complete:
     device=eth0, addr=192.168.1.11, mask=255.255.255.0, gw=192.168.1.1,
     host=Phytec, domain=is-a-geek.net, nis-domain=(none),
     bootserver=192.168.1.1, rootserver=192.168.1.4, rootpath=
Looking up port of RPC 100003/3 on 192.168.1.4
Looking up port of RPC 100005/3 on 192.168.1.4
VFS: Mounted root (nfs filesystem) on device 0:15.
Freeing unused kernel memory: 168k init
rtc-pcf8563 1-0051: low voltage detected, date/time is not reliable.
rtc-pcf8563 1-0051: retrieved date/time is not valid.
IRQ 131/mpc52xx_psc_uart: IRQF_DISABLED is not guaranteed on shared IRQs


-- 
Jon Smirl
jonsmirl@gmail.com
