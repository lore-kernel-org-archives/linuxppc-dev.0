Message-ID: <3DF4AE6E.5020103@motorola.com>
Date: Mon, 09 Dec 2002 14:53:34 +0000
From: John Traill <john.traill@motorola.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: PCI Resource Allocation.
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm porting linux to a development platform with its VIA Southbridge connected to the secondary bus of a PCI bridge.

I've made the following quick hacks to get as far as I have but would now like to get some pointers as to the "right way".

1. The 4k IO space window for the bridge setup isn't enough for all the VIA IO memory space so I've bumped this up to 64K.

2. Because the VIA is on the "wrong side of the bridge" the isa_io_base has effectively been changed to 0xfebf0000.
Again I've made a quick hack to my platform setup.c to reflect this and the kernel now Oops's as per the included debug
capture.


If anyone could give me some pointers as to the right way to approach this I would be most obliged ? Is there any way to
   "pin" the VIA to a known address ( 0xfe000000 ) as adding devices onto my primary PCI bus will change the
isa_io_base. Also are there any known issues with PCI-PCI bridging and ppc etc ...


Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.20-pre8 (johnt@sapporo) (gcc version 3.0.4) #24 Mon Dec 9 11:18:22 GMT 2002
Motorola Test Platform
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/nfs rw console=ttyS0 ip=dhcp
OpenPIC Version 1.2 (1 CPUs and 8 IRQ sources) at fdfd0000
time_init: decrementer frequency = 24.751442 MHz
Calibrating delay loop... 164.65 BogoMIPS
Memory: 63272k available (1052k kernel code, 340k data, 92k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Scanning bus 00
Found 00:00 [1057/0006] 000600 00
PCI:00:00.0 Resource 0 [00000000-ffffffff] is unassigned
PCI:00:00.0 Resource 1 [00000000-00000fff] is unassigned
PCI:00:00.0 Resource 2 [00000000-ffffffff] is unassigned
Found 00:88 [10e3/0513] 000604 01
Fixups for bus 00
Scanning behind PCI bridge 00:11.0, config 010100, pass 0
Scanning bus 01
Found 01:10 [1106/0686] 000601 00
Found 01:11 [1106/0571] 000101 00
Fixup res 0 (101) of dev 01:02.1: bffff8 -> fff8
Fixup res 1 (101) of dev 01:02.1: bffff4 -> fff4
Fixup res 2 (101) of dev 01:02.1: bfffe8 -> ffe8
Fixup res 3 (101) of dev 01:02.1: bfffe4 -> ffe4
Fixup res 4 (101) of dev 01:02.1: bfffd0 -> ffd0
Found 01:12 [1106/3038] 000c03 00
Fixup res 4 (101) of dev 01:02.2: bfffa0 -> ffa0
Found 01:13 [1106/3038] 000c03 00
Fixup res 4 (101) of dev 01:02.3: bfff80 -> ff80
Found 01:14 [1106/3057] 000000 00
Found 01:15 [1106/3058] 000401 00
Fixup res 0 (101) of dev 01:02.5: bffe00 -> fe00
Fixup res 1 (101) of dev 01:02.5: bffdfc -> fdfc
Fixup res 2 (101) of dev 01:02.5: bffdf8 -> fdf8
Found 01:16 [1106/3068] 000780 00
Fixup res 0 (101) of dev 01:02.6: bffc00 -> fc00
Fixups for bus 01
Bus scan for 01 returning with max=01
Scanning behind PCI bridge 00:11.0, config 010100, pass 1
Bus scan for 00 returning with max=01
PCI: bridge rsrc 80000000..fcffffff (200), parent c0124d48
PCI: bridge rsrc 0..ffff (101), parent c0184038
PCI: Cannot allocate resource region 0 of PCI bridge 1
PCI: bridge rsrc bfe00000..bfefffff (200), parent c0184054
PCI: bridge rsrc bfd00000..bfdfffff (1201), parent c0184054
PCI:00:11.0: Resource 0: bffff000-bfffffff (f=200)
PCI:01:02.1: Resource 0: 0000fff8-0000ffff (f=101)
PCI: Cannot allocate resource region 0 of device 01:02.1
PCI:01:02.1: Resource 1: 0000fff4-0000fff7 (f=101)
PCI: Cannot allocate resource region 1 of device 01:02.1
PCI:01:02.1: Resource 2: 0000ffe8-0000ffef (f=101)
PCI: Cannot allocate resource region 2 of device 01:02.1
PCI:01:02.1: Resource 3: 0000ffe4-0000ffe7 (f=101)
PCI: Cannot allocate resource region 3 of device 01:02.1
PCI:01:02.1: Resource 4: 0000ffd0-0000ffdf (f=101)
PCI: Cannot allocate resource region 4 of device 01:02.1
PCI:01:02.2: Resource 4: 0000ffa0-0000ffbf (f=101)
PCI: Cannot allocate resource region 4 of device 01:02.2
PCI:01:02.3: Resource 4: 0000ff80-0000ff9f (f=101)
PCI: Cannot allocate resource region 4 of device 01:02.3
PCI:01:02.5: Resource 0: 0000fe00-0000feff (f=101)
PCI: Cannot allocate resource region 0 of device 01:02.5
PCI:01:02.5: Resource 1: 0000fdfc-0000fdff (f=101)
PCI: Cannot allocate resource region 1 of device 01:02.5
PCI:01:02.5: Resource 2: 0000fdf8-0000fdfb (f=101)
PCI: Cannot allocate resource region 2 of device 01:02.5
PCI:01:02.6: Resource 0: 0000fc00-0000fcff (f=101)
PCI: Cannot allocate resource region 0 of device 01:02.6
Oops: kernel access of bad area, sig: 11
NIP: C01382D4 XER: 00000000 LR: C000D058 SP: C0261F50 REGS: c0261ea0 TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000008, DSISR: 22000000
TASK = c0260000[1] 'swapper' Last syscall: -1
last math 00000000 last altivec 00000000
GPR00: 00000000 C0261F50 C0260000 C024A640 00001032 C0261F78 00000F38 00000000
GPR08: FEC00000 00001000 00160000 C024A6D4 24002022 20122F04 03FE6000 03F3FC18
GPR16: 00000000 00000001 007FFF00 FFFFFFFF 003FF000 00000000 00000000 C0130000
GPR24: C024A64C C024A640 C0184000 007FFF26 C024A6C0 C0150000 00000000 C0249400
Call backtrace:
C00A9874 C000D058 C0138574 C01459B8 C01365DC C0003AC8 C0008298
Kernel panic: Attempted to kill init!
  <0>Rebooting in 180 seconds..



--

Regards, John


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
