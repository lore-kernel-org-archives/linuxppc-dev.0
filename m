From: Dan Foster <dsf@frontiernet.net>
Message-Id: <199901291018.FAA33062@frontiernet.net>
Subject: iMac bootp/tftp?
To: linuxppc-dev@lists.linuxppc.org
Date: Fri, 29 Jan 1999 05:18:03 -0500 (EST)
Cc: dsf@frontiernet.net (Dan Foster)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Howdy!
	I'm curious - has anyone ever tried to bootp/tftp an install image?

I got an iMac - MPC750 w/Open Firmware 3.0.b2 (9/17/98), and a Rev B iMac.

	bootp/tftp server is a FreeBSD 2.2-ish box at 192.168.1.8; it also
is hooked up to the net (with a second, routable IP, of course). it's
nightfall.catbert.org. my iMac is imac.catbert.org, at 192.168.1.12.

	Nothing special. If I run bootpd by hand, I see that it succeeded...
the mac sends a broadcast message querying info, nightfall responds with
the Ethernet MAC->IP address, file to load, etc, and then sets up an ARP
entry for imac.

	At this point, when I'm in the multiboot menu... the 'Network disk'
icon pops up, so it saw that. I then click on it, and select the boot option.

	However, I don't see a single TFTP request. In fact, I see a single
very strange packet, and that's absolutely it. I'm hoping someone might be
able to suggest if it's due to any (obvious) misconfiguration on my part,
lack of support code in Open Firmware, or something else.

	The tcpdump output:

[0:0:0:0:0:0 is the iMac]

04:06:08.841268 0:0:0:0:0:0 > 0:0:0:0:0:0 null I (s=0,r=0,C) len=46
                         0000 0000 0000 0000 0000 0000 0000 0000
                         0000 0000 0000 0000 0000 0000 0000 0000
                         0000 0000 0000 0000 0000 0000 0000
04:06:09.536236 0:0:0:0:0:0 > 0:0:0:0:0:0 null I (s=0,r=0,C) len=46
                         0000 0000 0000 0000 0000 0000 0000 0000
                         0000 0000 0000 0000 0000 0000 0000 0000
                         0000 0000 0000 0000 0000 0000 0000
04:06:09.537299 arp who-has nightfall.catbert.org tell 0.0.0.0
04:06:09.537674 arp reply nightfall.catbert.org is-at 0:10:4b:2f:ed:d3
04:06:09.537951 0.0.0.0.1234 > nightfall.catbert.org.bootps: (request) xid:0x1026a S:nightfall.catbert.org [|bootp]
04:06:09.542643 nightfall.catbert.org.bootps > imac.catbert.org.bootpc: xid:0x1026a Y:imac.catbert.org S:nightfall.catbert.org [|bootp]
04:06:09.542885 arp who-has imac.catbert.org tell imac.catbert.org
04:06:11.542339 arp who-has nightfall.catbert.org tell imac.catbert.org
04:06:11.542393 arp reply nightfall.catbert.org is-at 0:10:4b:2f:ed:d3
04:06:11.542528 arp who-has nightfall.catbert.org tell imac.catbert.org
04:06:11.542547 arp reply nightfall.catbert.org is-at 0:10:4b:2f:ed:d3

[now nightfall appears in the menu list to boot off. next line is where
I click 'boot' or whatever it was]

04:06:27.714395 0:0:0:0:0:0 > 0:0:0:0:0:0 null I (s=0,r=0,C) len=46
                         0000 0000 0000 0000 0000 0000 0000 0000
                         0000 0000 0000 0000 0000 0000 0000 0000
                         0000 0000 0000 0000 0000 0000 0000

no further packets.

It seems kind of odd to me because by now it should know its IP address
and MAC address. If anything else would be relevant, please let me know.
I'm also more than willing to do any kind of poking around under the hood
(so to speak...ie in OF, whatever) as necessary.

Not to mention I've already defined client/server IPs in OF settings...

I'm just immensely curious because I see /packages/obp-tftp method, and
I think I once heard someone said they saw bootp/tftp packets ok on an iMac
but then failed to load the image for whatever reason. So I figure it has to
be doable, or at least, somehow possible to make it work.


-Dan

OF settings:

Partition: common
Signature: 0x70

little-endian?	false
real-mode?	false
auto-boot?	true
diag-switch?	false
fcode-debug?	false
oem-banner?	false
oem-logo?	false
use-nvramrc?	false
use-generic?	true
default-mac-address? false
real-base	-1
real-size	-1
load-base	0x800000
virt-base	-1
virt-size	-1
screen-#columns	100
screen-#rows	40
selftest-#megs	0
boot-device	/pci@800000000/mac-io@10/ide@20000/@0:5,\\:tbxi
boot-file
diag-device	floppy
diag-file	diags
input-device	keyboard
output-device	screen
mouse-device	mouse
oem-banner
oem-logo
nvramrc
boot-command	
forced-boot
fw-scsicfg
fw-boot-path
default-client-ip	192.168.1.12
default-server-ip	192.168.1.8
default-gateway-ip	192.168.1.8
boot-script
ASVP		0110??00463;

0 > dev / ls
ff833b70:  /cpus
ff833da0:	/PowerPC, 750@0
ff834098:		/l2-cache
ff8347b8:	/chosen
ff834908:	/memory@0
ff834ab8:	/openprom
ff834bb8:		/client-services
ff835cf0:	/rom@ff8000000
ff835e78:		/boot-rom@fff00000
ff835f88:		/macos
ff835fe8:	/options
ff836048:	/aliases
ff836588:	/packages
ff8365f0:		/deblocker
ff836e58:		/disk-label
ff8376c0:		/obp-tftp
ff83ce40:		/mac-parts
ff83dc68:		/mac-files
ff83ff70:		/hfs-plus-files
ff8443b0:		/fat-files
ff8460e0:		/iso-9660-files
ff846ce8:		/bootinfo-loader
ff848708:		/xcoff-loader
ff849120:		/pe-loader
ff849af8:		/elf-loader
ff84b128:		/usb-hid-class
ff84cd00:		/ata-disk
ff84dd58:		/atapi-disk
ff84ed80:		/bootpath-search
ff852a58:		/terminal-emulator
ff852af0:	/pseudo-hid
ff852b78:		/keyboard
ff852f80:		/mouse
ff8531c8:	/multiboot
ff861408:	/rtas
ff861608:	/pci@800000000
ff8625a8:		/mac-io@10
ff862e80:			/interrupt-controller@10
ff862fe8:			/scsi@10000
ff8653d0:				/disk
ff866300:				/tape
ff867620:			/escc-legacy@12000
ff867820:				/ch-a@12002
ff867998:				/ch-b@12000
ff867b10:			/escc@13000
ff867d18:				/ch-a@13020
ff868640:				/ch-b@13000
ff868f68:			/davbus@14000
ff869150:				/sound
ff86c380:			/fdc@15000
ff86d5c0:				/disk@0
ff86dcd0:			/via-cuda@16000
ff86f1d8:				/rtc
ff86f438:				/adb
ff86f550:					/keyboard@2
ff870140:					/mouse@3
ff870460:					/programmer-switch@0
ff870580:				/ide@20000
ff8721e0:					/disk
ff872798:				/ide@21000
ff8743f8:					/disk
ff8749b0:				/ethernet@11000
ff8778c8:				/nvram@60000
ff878c00:			/ATY,RagePro_C@12
ff87e0b0:			/usb@14
ff882e00:				/hub@1
ff882f70:					/keyboard@1
ff883290:					/mouse@2

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
