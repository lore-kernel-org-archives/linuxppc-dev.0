Return-Path: <robertlazarski@gmail.com>
Received: from rn-out-0102.google.com (rn-out-0910.google.com [64.233.170.187])
	by ozlabs.org (Postfix) with ESMTP id 857DADDEF6
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Nov 2007 03:32:06 +1100 (EST)
Received: by rn-out-0102.google.com with SMTP id e25so138039rng
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 08 Nov 2007 08:32:04 -0800 (PST)
Message-ID: <f87675ee0711080832g75c748adjc4f35aa73aefe202@mail.gmail.com>
Date: Thu, 8 Nov 2007 11:32:02 -0500
From: "robert lazarski" <robertlazarski@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Problems booting custom kernel and device tree on custom 85xx board
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I finished the main part of porting u-boot 1.3 rc3 to our custon 8548
board and am now trying to boot our 2.6.22 kernel and device tree:

=> bootm 1000000 - c00000
## Booting image at 01000000 ...
   Image Name:   Linux-2.6.22.2
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1302607 Bytes =  1.2 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x1FF9DD50 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF00
bd address  = 0x1FF9DFB0
memstart    = 0x00000000
memsize     = 0x20000000
flashstart  = 0xF8000000
flashsize   = 0x08000000
flashoffset = 0x00000000
sramstart   = 0x00000000
sramsize    = 0x00000000
immr_base   = 0xE0000000
bootflags   = 0xE4013F80
intfreq     = 888.888 MHz
busfreq     = 355.555 MHz
ethaddr     = 00:E0:0C:00:00:FD
eth1addr    = 00:E0:0C:00:01:FD
eth2addr    = 00:E0:0C:00:02:FD
eth3addr    = 00:E0:0C:00:03:FD
IP addr     = 10.101.43.142
baudrate    = 115200 bps
Skipping initrd
   Booting using the fdt at 0xc00000
No initrd
## device tree at 0x00C00000 ... 0x00C00CD3 (len=3284=0xCD4)
   Loading Device Tree to 007fd000, end 007fdcd3 ... OK
## Transferring control to Linux (at address 00000000) ...

Where it hangs. I configured early serial output in the kernel, and
looking at the buffers after a soft reset we see:

grep __log_buf System.map
c029f424 b __log_buf

=> md 29f424 200
0029f424: 3c363e55 73696e67 204d5043 38357878    <6>Using MPC85xx
0029f434: 20415455 4d206d61 6368696e 65206465     ATUM machine de
0029f444: 73637269 7074696f 6e0a3c36 3e4d656d    scription.<6>Mem
0029f454: 6f727920 43414d20 6d617070 696e673a    ory CAM mapping:
0029f464: 2043414d 303d3235 364d622c 2043414d     CAM0=256Mb, CAM
0029f474: 313d3235 364d622c 2043414d 323d304d    1=256Mb, CAM2=0M
0029f484: 62207265 73696475 616c3a20 304d620a    b residual: 0Mb.
0029f494: 3c353e4c 696e7578 20766572 73696f6e    <5>Linux version
0029f4a4: 20322e36 2e32322e 32202872 6f6f7440     2.6.22.2 (root@
0029f4b4: 6c696e75 782d726f 62657274 29202867    linux-robert) (g
0029f4c4: 63632076 65727369 6f6e2034 2e302e30    cc version 4.0.0
0029f4d4: 20284445 4e582045 4c444b20 342e3120     (DENX ELDK 4.1
0029f4e4: 342e302e 30292920 23312057 6564204e    4.0.0)) #1 Wed N
0029f4f4: 6f762037 2031363a 30393a34 30204553    ov 7 16:09:40 ES
0029f504: 54203230 30370a3c 373e466f 756e6420    T 2007.<7>Found
0029f514: 6c656761 63792073 65726961 6c20706f    legacy serial po
0029f524: 72742030 20666f72 202f736f 63383534    rt 0 for /soc854
0029f534: 38406530 30303030 30302f73 65726961    8@e0000000/seria
0029f544: 6c403435 30300a3c 373e2020 6d656d3d    l@4500.<7>  mem=
0029f554: 65303030 34353030 2c207461 6464723d    e0004500, taddr=
0029f564: 65303030 34353030 2c206972 713d302c    e0004500, irq=0,
0029f574: 20636c6b 3d333535 35353535 34302c20     clk=355555540,
0029f584: 73706565 643d300a 3c373e46 6f756e64    speed=0.<7>Found
0029f594: 206c6567 61637920 73657269 616c2070     legacy serial p
0029f5a4: 6f727420 3120666f 72202f73 6f633835    ort 1 for /soc85
0029f5b4: 34384065 30303030 3030302f 73657269    48@e0000000/seri
0029f5c4: 616c4034 3630300a 3c373e20 206d656d    al@4600.<7>  mem
0029f5d4: 3d653030 30343630 302c2074 61646472    =e0004600, taddr
0029f5e4: 3d653030 30343630 302c2069 72713d30    =e0004600, irq=0
0029f5f4: 2c20636c 6b3d3335 35353535 3534302c    , clk=355555540,
0029f604: 20737065 65643d30 0a3c373e 456e7465     speed=0.<7>Ente
0029f614: 72696e67 20616464 5f616374 6976655f    ring add_active_
0029f624: 72616e67 6528302c 20302c20 31333130    range(0, 0, 1310
0029f634: 37322920 3020656e 74726965 73206f66    72) 0 entries of
0029f644: 20323536 20757365 640a3c37 3e546f70     256 used.<7>Top
0029f654: 206f6620 52414d3a 20307832 30303030     of RAM: 0x20000
0029f664: 3030302c 20546f74 616c2052 414d3a20    000, Total RAM:
0029f674: 30783230 30303030 30300a3c 373e4d65    0x20000000.<7>Me
0029f684: 6d6f7279 20686f6c 65207369 7a653a20    mory hole size:
0029f694: 304d420a 3c343e5a 6f6e6520 50464e20    0MB.<4>Zone PFN
0029f6a4: 72616e67 65733a0a 3c343e20 20444d41    ranges:.<4>  DMA
0029f6b4: 20202020 20202020 20202020 2030202d                 0 -
0029f6c4: 3e202020 31333130 37320a3c 343e2020    >   131072.<4>
0029f6d4: 4e6f726d 616c2020 20202031 33313037    Normal     13107
0029f6e4: 32202d3e 20202031 33313037 320a3c34    2 ->   131072.<4
0029f6f4: 3e656172 6c795f6e 6f64655f 6d61705b    >early_node_map[
0029f704: 315d2061 63746976 65205046 4e207261    1] active PFN ra
0029f714: 6e676573 0a3c343e 20202020 303a2020    nges.<4>    0:
0029f724: 20202020 20203020 2d3e2020 20313331          0 ->   131
0029f734: 3037320a 3c373e4f 6e206e6f 64652030    072.<7>On node 0
0029f744: 20746f74 616c7061 6765733a 20313331     totalpages: 131
0029f754: 3037320a 3c373e20 20444d41 207a6f6e    072.<7>  DMA zon
0029f764: 653a2031 30323420 70616765 73207573    e: 1024 pages us
0029f774: 65642066 6f72206d 656d6d61 700a3c37    ed for memmap.<7
0029f784: 3e202044 4d41207a 6f6e653a 20302070    >  DMA zone: 0 p
0029f794: 61676573 20726573 65727665 640a3c37    ages reserved.<7
0029f7a4: 3e202044 4d41207a 6f6e653a 20313330    >  DMA zone: 130
0029f7b4: 30343820 70616765 732c204c 49464f20    048 pages, LIFO
0029f7c4: 62617463 683a3331 0a000000 00000000    batch:31
0029f7d4: 00000000 00000000 00000000 00000000    ................

I'm not sure where to start looking at this point. Device tree issues?
gdb and the kernel? Any suggestions?
Robert
