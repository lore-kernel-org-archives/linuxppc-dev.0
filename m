Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 87AF8679F2
	for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2006 01:47:18 +1000 (EST)
Received: from localhost.localdomain (shorty@debby1-6 [127.0.0.1])
	by ; ; connection timed out;
	no servers could be reached (8.13.6/8.13.6/Debian-1) with ESMTP id
	k4AFnVnk006676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 17:49:31 +0200
Received: (from shorty@localhost)
	by localhost.localdomain (8.13.6/8.13.6/Submit) id k4AFnUbi006675
	for linuxppc-dev@ozlabs.org; Wed, 10 May 2006 17:49:30 +0200
Date: Wed, 10 May 2006 17:49:30 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Alubook 5,8: No sound with 2.6.17-rc3-g5528e568-dirty
Message-ID: <20060510154930.GD3878@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All

First a *Thanks* to all those, here or elsewhere, who spend their time
on the development of usable software for PPC Linux: I don't think I
ever would have bought the latest alu Powerbook with the option that
this machine will be an MacOSX-only one ... :)

As to the reason why I came here: 
As I can't be sure whether the issue announced in the subject line is
really a kernel issue I put some sound relevant config files in a
tarball (~ 12 KB) to my homepage:

wolfgangpfeiffer.com/alsa.configs.tar.gz

In the tarball above you'll find
these local /etc/ dirs with all files below them: 
alsa  modprobe.d   modutils

and these single files, also from /etc/ here:
modules  modules.conf pbbuttonsd.conf

The kernel config
http://wolfgangpfeiffer.com/config-2.6.17-rc3-g5528e568-dirty.txt

(Geocities, which my site actually is hosted by, does not allow
uploading the file without the file type suffix, IIRC ...)

The kernel, made with non-edited (except the kernel .config), as I hope,
git sources, and with the 'make-kpkg' Debian package:

$ cat /proc/version 
Linux version 2.6.17-rc3-g5528e568-dirty (root@debby1-6) (gcc version
4.1.1 20060428 (prerelease) (Debian 4.1.0-2)) #1 Sun May 7 23:51:15
CEST 2006

OS is Debian/unstable.

Machine:

$ cat /proc/cpuinfo
processor       : 0
cpu             : 7447A, altivec supported
clock           : 833.333000MHz
revision        : 0.5 (pvr 8003 0105)
bogomips        : 16.57
timebase        : 8320000
platform        : PowerMac
machine         : PowerBook5,8
motherboard     : PowerBook5,8 MacRISC3 Power Macintosh 
detected as     : 287 (PowerBook G4 15")
pmac flags      : 00000019
L2 cache        : 512K unified
pmac-generation : NewWorld


lspci -v:
---------------------
0000:00:0b.0 Host bridge: Apple Computer Inc.: Unknown device 0066
	Flags: bus master, 66MHz, medium devsel, latency 16
	Capabilities: [80] AGP version 1.0

0000:00:10.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility Radeon 9600 M10] (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc RV350 [Mobility Radeon 9600 M10]
	Flags: bus master, 66MHz, medium devsel, latency 255, IRQ 48
	Memory at b8000000 (32-bit, prefetchable) [size=128M]
	I/O ports at f0000400 [size=256]
	Memory at b0000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at f1000000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
	Capabilities: [50] Power Management version 2

0001:10:0b.0 Host bridge: Apple Computer Inc.: Unknown device 0067
	Flags: bus master, 66MHz, medium devsel, latency 16

0001:10:11.0 Network controller: Broadcom Corporation BCM4318 [AirForce One 54g] 802.11g Wireless LAN Controller (rev 02)
	Subsystem: Apple Computer Inc.: Unknown device 4318
	Flags: bus master, fast devsel, latency 16, IRQ 52
	Memory at a0004000 (32-bit, non-prefetchable) [size=8K]

0001:10:14.0 CardBus bridge: Texas Instruments PCI1510 PC card Cardbus Controller
	Flags: bus master, medium devsel, latency 168, IRQ 53
	Memory at a0003000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=10, secondary=11, subordinate=14, sec-latency=176
	Memory window 0: 90000000-9ffff000 (prefetchable)
	Memory window 1: f3000000-f33ff000
	I/O window 0: 00001000-000011ff
	I/O window 1: 00001400-000015ff
	16-bit legacy interface ports at 0001

0001:10:15.0 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation USB
	Flags: bus master, medium devsel, latency 16, IRQ 54
	Memory at a0002000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2

0001:10:15.1 USB Controller: NEC Corporation USB (rev 43) (prog-if 10 [OHCI])
	Subsystem: NEC Corporation USB
	Flags: bus master, medium devsel, latency 16, IRQ 54
	Memory at a0001000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [40] Power Management version 2

0001:10:15.2 USB Controller: NEC Corporation USB 2.0 (rev 04) (prog-if 20 [EHCI])
	Subsystem: NEC Corporation USB 2.0
	Flags: bus master, medium devsel, latency 16, IRQ 54
	Memory at a0000000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2

0001:10:17.0 ff00: Apple Computer Inc. KeyLargo/Intrepid Mac I/O
	Flags: bus master, medium devsel, latency 16
	Memory at 80000000 (32-bit, non-prefetchable) [size=512K]

0002:24:0b.0 Host bridge: Apple Computer Inc.: Unknown device 0068
	Flags: bus master, 66MHz, medium devsel, latency 16

0002:24:0d.0 ff00: Apple Computer Inc.: Unknown device 0069
	Flags: bus master, medium devsel, latency 32, IRQ 39
	Memory at f5004000 (32-bit, non-prefetchable) [size=16K]

0002:24:0e.0 FireWire (IEEE 1394): Apple Computer Inc.: Unknown device 006a (prog-if 10 [OHCI])
	Subsystem: Apple Computer Inc.: Unknown device 5811
	Flags: bus master, medium devsel, latency 64, IRQ 40
	Memory at f5000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2

0002:24:0f.0 Ethernet controller: Apple Computer Inc.: Unknown device 006b
	Flags: bus master, 66MHz, slow devsel, latency 16, IRQ 41
	Memory at f5200000 (32-bit, non-prefetchable) [size=2M]
	Expansion ROM at f5100000 [disabled] [size=1M]


---------------------


So with the settings from the files above I run 'alsaconf', and it
can't find any sound card:


x                                                          x          
x                                                          x          
x         No supported PnP or PCI card found.              x          
x                                                          x          
x  Would you like to probe legacy ISA sound cards/chips?   x          
x                                                          x          
x                                                          x          
x               <Yes>                  <No>                x          
x                                                          x          



Either answering No or Yes does not help to get sound.

KDE also is complaining. Something like:

---------------------
Sound server informational message:
Error while initializing the sound driver:
device: default can't be opened for playback (No such device)
The sound server will continue, using the null output device.
-----------------------


The alsapackages seem to be the latest ones I can get:

# apt-get install alsa-base alsa-utils alsaplayer-alsa alsaplayer-common alsaplayer-gtk
Reading package lists... Done
Building dependency tree... Done
alsa-base is already the newest version.
alsa-utils is already the newest version.
alsaplayer-alsa is already the newest version.
alsaplayer-common is already the newest version.
alsaplayer-gtk is already the newest version.
0 upgraded, 0 newly installed, 0 to remove and 322 not upgraded.

Please let me know in case you need more information ..

Best Regards
Wolfgang


-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
