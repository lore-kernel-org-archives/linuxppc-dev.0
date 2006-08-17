Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id D904B67B59
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 09:03:27 +1000 (EST)
Date: Fri, 18 Aug 2006 01:03:47 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: linux1394-devel@lists.sourceforge.net
Subject: Broken Firewire 400/SCSI on ppc Powerbook5,8
Message-ID: <20060817230347.GC3440@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Stefan Richter <stefanr@s5r6.in-berlin.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All

Short version first:

The SCSI/FW routines seem to work like a charm with a LSILogic Model/
SYM13FW500-Disk on my old Macintosh titanium-IV laptop, with exactly
the same relatively fresh git-kernel that does not work on the
PowerBook5,8.  That is I compiled the kernel on the Apple Powerbook5,8
and installed it on both machines.


SCSI/FW didn't work ever on the new PowerBook5,8.

I'll give you first some error messages for the failing FW disk,
and at the end of this mail you'll find links to technical
documentation for the 2 failng machines (Powerbook5,8 and FW board/disk)

First I load the drivers with this little script:

------------------------------------------
#!/bin/sh -x
/bin/sh -n /home/shorty/scripts/scsi.start.sh && \

modprobe raw1394 && \
modprobe ieee1394 disable_irm=0 disable_nodemgr=1 && \
modprobe ohci1394 && \
modprobe eth1394 && \
modprobe sbp2 max_speed=3 workarounds=0x1 serialize_io=0 && \
sleep 4 && \
chown root.shorty /dev/raw1394
-------------------------------------------

After doing the latter:

-------------------------------
$ sh kernel-factory/git.08102006/linux-2.6/scripts/ver_linux 
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux debby1-6 2.6.18-rc4-060811-dirty #1 Fri Aug 11 00:16:22 CEST 2006 ppc GNU/
Linux
 
Gnu C                  4.1.2
Gnu make               3.81
binutils               2.17
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
pcmcia-cs              3.2.8
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.97
udev                   093
Modules Loaded         sbp2 eth1394 ohci1394 raw1394 ieee1394 bluetooth radeon d
rm nfs nfsd exportfs lockd nfs_acl sunrpc ipv6 therm_adt746x sr_mod cpufreq_powe
rsave cpufreq_performance scsi_mod apm_emu joydev usblp appletouch usbhid snd_ao
a_codec_onyx snd_aoa_fabric_layout snd_aoa pcmcia firmware_class evdev snd_aoa_i
2sbus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd ide_cd ohci
_hcd yenta_socket sungem sungem_phy cdrom ehci_hcd usbcore rsrc_nonstatic pcmcia
_core pmac_zilog serial_core soundcore snd_aoa_soundbus uninorth_agp agpgart i2c
_powermac
------------------------------


After loading the drivers above the failing kernel says this about the
via FW attached disk:

-----------------------------------
Aug 18 00:24:03 debby1-6 kernel: [38907.611119] ieee1394: Initialized config rom entry `ip1394'
Aug 18 00:24:03 debby1-6 kernel: [38907.628475] ieee1394: raw1394: /dev/raw1394 device initialized
Aug 18 00:24:03 debby1-6 kernel: [38907.692766] PM: Adding info for ieee1394:fw-host0
Aug 18 00:24:03 debby1-6 kernel: [38907.764726] ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[40]  MMIO=[f5000000-f50007ff]  Max Packet=[4096]  IR/IT contexts=[8/8]
Aug 18 00:24:03 debby1-6 kernel: [38907.912614] eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
Aug 18 00:24:04 debby1-6 kernel: [38909.170610] ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
Aug 18 00:24:05 debby1-6 kernel: [38910.425599] ieee1394: Error parsing configrom for node 0-00:1023
Aug 18 00:24:05 debby1-6 kernel: [38910.425992] PM: Adding info for ieee1394:001451fffe3148be
Aug 18 00:24:05 debby1-6 kernel: [38910.426064] ieee1394: Host added: ID:BUS[0-02:1023]  GUID[001451fffe3148be]
Aug 18 00:24:05 debby1-6 kernel: [38910.426209] PM: Adding info for ieee1394:001451fffe3148be-0
-----------------------------------

And gscanbus says this for:
"Unknown
Linux - ohci1394":

--------------------------
SelfID Info
-----------
Physical ID: 2
Link active: Yes
Gap Count: 63
PHY Speed: Unknown
PHY Delay: <=144ns
IRM Capable: Yes
Power Class: -1W
Port 0: Not connected
Port 1: Connected to child node
Port 2: Not connected
Init. reset: Yes

CSR ROM Info
------------
GUID: 0x001451FFFE3148BE
Node Capabilities: 0x000083C0
Vendor ID: 0x00001451
Unit Spec ID: 0x0000005E
Unit SW Version: 0x00000001
Model ID: 0x00000000
Nr. Textual Leafes: 1

Vendor: Unknown
Textual Leafes: 
Linux - ohci1394

AV/C Subunits
-------------
N/A

-------------------------


And this for "S400 unknown":

---------------------------------
SelfID Info
-----------
Physical ID: 1
Link active: No
Gap Count: 63
PHY Speed: S400
PHY Delay: <=144ns
IRM Capable: No
Power Class: -1W
Port 0: Connected to parent node
Port 1: Not connected
Port 2: Connected to child node
Init. reset: No

CSR ROM Info
------------
GUID: 0x0000000000000000
Node Capabilities: 0x00000000
Vendor ID: 0x00000000
Unit Spec ID: 0x00000000
Unit SW Version: 0x00000000
Model ID: 0x00000000
Nr. Textual Leafes: 0

Vendor: (null)
Textual Leafes: 

AV/C Subunits
-------------
N/A

-----------------------------------


I haven't enabled for the current kernel IEEE1394_VERBOSEDEBUG. I
could recompile it and enable this option if necessary, to provide
more verbose kernel logs.

As to the documentation for the 2 machines, where all this is
happening, first the computer, then the FW board/disk:


*** 1:

The computer:

$ cat /proc/cpuinfo 
processor       : 0
cpu             : 7447A, altivec supported
clock           : 1666.666000MHz
revision        : 0.5 (pvr 8003 0105)
bogomips        : 33.15
timebase        : 8320000
platform        : PowerMac
machine         : PowerBook5,8
motherboard     : PowerBook5,8 MacRISC3 Power Macintosh 
detected as     : 287 (PowerBook G4 15")
pmac flags      : 00000019
L2 cache        : 512K unified
pmac-generation : NewWorld

Some Apple technical documentation for the Firewire 400/800 ports is here:
http://developer.apple.com/documentation/Hardware/Developer_Notes/Macintosh_CPUs-G4/15inchPowerBookG4/3Input-Output/chapter_4_section_3.html#//apple_ref/doc/uid/TP40003165-CH207-TPXREF105

Start page - if the link above is only a temporary one - seems being
here: 

http://developer.apple.com/documentation/Hardware/Developer_Notes/Macintosh_CPUs-G4/15inchPowerBookG4/index.html


*** 2:

The Firewire disk/board:

I don't have reasonable technical docs for the FW board. Here's a
picture of the package for the disk enclosure, with some technical data:
http://www.geocities.com/wolfgangpfeiffer/scsi.case.specs.jpg

This seems to be the board for the disk, inside the enclosure:
Vendor: LSILogic  Model: SYM13FW500-Disk   Rev: 1.00

I have pictures for the board here:

Disk on the board, top side:
http://wolfgangpfeiffer.com/scsi.top.jpg

Bottomside, with wirings:
http://wolfgangpfeiffer.com/scsi.focussed.flash.jpg
[444 KB]

Similar:
http://www.wolfgangpfeiffer.com/scsi.disk.2.scaled.jpg
[276 KB]

Wirings side again:
http://www.wolfgangpfeiffer.com/scsi.focussed.flash.jpg
[444 KB]


Please let me know if you need more information

Thanks for your time.

Wolfgang

-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
