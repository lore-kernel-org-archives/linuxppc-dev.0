Date: Wed, 18 Jul 2001 21:45:52 -0400
From: Simon Piette <simonp@Sat.QC.CA>
To: linuxppc-dev@lists.linuxppc.org
Subject: Video acceleration on IMSTT with bk (and Ben's) 2.4.7-pre6 kernel
Message-ID: <20010718214552.C9041@Weber.Sat.QC.CA>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I just compiled 2.4.7pre6 from Ben's tree, and another one from bk, with
the same results. It compiled without any problems, but I can't have
accelerated video. I use "video=imsttfb:vmode:17,cmode:16 video=ofonly"
as kernel args to have a working unaccelerated video. Without ofonly, I
get some blue dots forming a very distortioned screen of what should be
there (linux logo and kernel verbosity). Without the imsttfb part, it
won't work after the initial boot screen: it stops after

pmac_init(): exit
id_mach(): done
MMU: enter
MMU: hw init
hash: enter
hash: find peice
hash: patch
hash: clone
MMU: mapin
MMU: setio
MMU: exit
setup_arch: enter
setup_arch: bootmem
arch: exit

Here is some details:

Umax J700/180 192 MB RAM using BootX 1.2.2 (Ben's one)
IMS TwinTurbo 128 2M PCI
Kernel config at: http://www.generation.net/~spiette/linuxppc/config.txt
lspci -vv:
[...]
00:0e.0 Display controller: Integrated Micro Solutions Inc. IMS9129
[Twin turbo 128] (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 8 max, 32 set
        Interrupt: pin A routed to IRQ 24
        Region 0: Memory at 82000000 (32-bit, prefetchable) [size=16M]
        Expansion ROM at 80900000 [disabled] [size=64K]

First boot screen:
Welcome to Linux, kernel 2.4.7
started at:     0x00000000
linked at:      0xc0000000
frambuffer at:  0x82000020 (phys) 0x82000020 (log)
[...]

Relevant dmesg output:
Linux version 2.4.7-pre6 (simonp@bing.dyndns.org) (gcc version 2.95.3
20010312 ( prerelease/franzo/20010312)) #1 Tue Jul 17 14:35:46 EDT 2001
Cache coherency enabled for bandit/PSX at 00000000
Found Bandit PCI host bridge at 0xf2000000. Firmware bus number: 0->1
[...]
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Cannot allocate resource region 2 of PCI bridge 1
PCI: resource is 80000000..8fffffff (200), parent c029a068
PCI:00:0e.0: Resource 0: 82000000-82ffffff (f=1208)
[...]
MacOS display is /bandit/IMS,tt128mb
Using unsupported 1024x768 IMS,tt128mb at 82000020, depth=16, pitch=2048
Console: switching to colour frame buffer device 128x48
fb0: Open Firmware frame buffer device on /bandit/IMS,tt128mb
[...]

What could be wrong?

Cheers,

Simon Piette


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
