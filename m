Message-Id: <200205281835.g4SIZKf09966@panix3.panix.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: P2P bridge (DEC 21154) initialization on MCP750
References: <200205250114.g4P1ELi08721@panix1.panix.com>
	<20020524200953.A21781@home.com>
	<200205272214.g4RMEOP02787@panix3.panix.com>
	<20020527164626.A1740@home.com>
From: Rajappa Iyer <rsi@panix.com>
Date: 28 May 2002 14:35:20 -0400
Reply-To: rsi@panix.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt Porter <porter@cox.net> writes:

> On Mon, May 27, 2002 at 06:14:24PM -0400, Rajappa Iyer wrote:

> > Thanks.  This did improve the situation somewhat in that the P2P
> > bridge is now initialized properly, but the devices beyond it are
> > still not probed.   Incidentally, I had to work with 2.5.x, since the
> > 2.4 devel kernel was, for some reason, unbearably slow.

> You're the first person to try one of these boards on 2.5 that I've
> heard of.  Can you explain what you mean by "unbearably slow" on
> _devel?  Please enable DEBUG in arch/ppc/kernel/pci.c and
> drivers/pci/pci.c and repost those kernel messages.

Sure, here it is.

What I mean by unbearably slow is that once init starts running, the
system just slows down to a complete crawl.  It takes about 2 minutes
for the login prompt to appear.  To run lspci -v took about 10 minutes
(I'm not exaggerating.)

Linux/PPC load: console=ttyS0,9600 ip=172.19.217.210:172.19.216.101:172.19.216.3
:255.255.254.0 nfsroot=172.19.216.101:/usr/exports/mcp750,rw
Uncompressing Linux...done.
Now booting the kernel
Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
Total memory = 64MB; using 128kB for hash table (at c01e0000)
Linux version 2.4.19-pre8 (rsi@pluto) (gcc version 2.95.2 19991024 (release)) #3
 Tue May 28 09:22:28 PDT 2002
PowerPlus port (C) 2001 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 ip=172.19.217.210:172.19.216.101:172.19.
216.3:255.255.254.0 nfsroot=172.19.216.101:/usr/exports/mcp750,rw
OpenPIC Version 1.3 (2 CPUs and 16 IRQ sources) at effdd000
OpenPIC timer frequency is 8.333848 MHz
time_init: decrementer frequency = 16.666738 MHz
Calibrating delay loop... 465.30 BogoMIPS
Memory: 62748k available (1180k kernel code, 468k data, 232k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Scanning bus 00
Found 00:00 [1057/4801] 000600 00
PCI:00:00.0 Resource 0 [00000000-ffffffff] is unassigned
Fixup res 1 (200) of dev 00:00.0: 3cfc0000 -> fcfc0000
Found 00:58 [1106/0586] 000601 00
Found 00:59 [1106/0571] 000101 00
Found 00:5a [1106/3038] 000c03 00
Found 00:5b [1106/3040] 000000 00
Found 00:70 [1011/0009] 000200 00
Fixup res 1 (200) of dev 00:0e.0: 3cfbff80 -> fcfbff80
PCI:00:0e.0 Resource 6 [fffc0000-ffffffff] is unassigned
Found 00:a0 [1011/0026] 000604 01
Fixups for bus 00
Scanning behind PCI bridge 00:14.0, config 010100, pass 0
Scanning bus 01
Fixups for bus 01
Bus scan for 01 returning with max=01
Scanning behind PCI bridge 00:14.0, config 010100, pass 1
Bus scan for 00 returning with max=01
Setting PCI interrupts for a "Mesquite cPCI (MCP750)"
PCI: bridge rsrc 0..fffffff (100), parent c0154f14
PCI: bridge rsrc c0000000..fdffffff (200), parent c0154f30
PCI: bridge rsrc fffe000..fffefff (101), parent c0207034
PCI: bridge rsrc fce00000..fcefffff (200), parent c0207050
PCI: bridge rsrc fcd00000..fcdfffff (1201), parent c0207050
PCI:00:00.0: Resource 1: fcfc0000-fcffffff (f=200)
PCI:00:0b.1: Resource 4: 0000cc00-0000cc0f (f=101)
PCI:00:0b.2: Resource 4: 0fffffe0-0fffffff (f=101)
PCI:00:0e.0: Resource 0: 0fffff00-0fffff7f (f=101)
PCI:00:0e.0: Resource 1: fcfbff80-fcfbffff (f=200)
Activating ISA DMA hang workarounds.
[...]

Output of lspci -v

00:00.0 Host bridge: Motorola Raven (rev 05)
        Flags: bus master, medium devsel, latency 0
        I/O ports at <unassigned> [disabled]
        Memory at fcfc0000 (32-bit, non-prefetchable) [size=256K]

00:0b.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (rev 41)
        Flags: bus master, stepping, medium devsel, latency 0

00:0b.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Flags: bus master, stepping, medium devsel, latency 0
        I/O ports at cc00 [size=16]

00:0b.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 02) (prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 128, IRQ 11
        I/O ports at fffffe0 [size=32]

00:0b.3 Non-VGA unclassified device: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
        Flags: medium devsel

00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [FasterNet] (rev 22)
        Flags: bus master, medium devsel, latency 128, IRQ 18
        I/O ports at fffff00 [size=128]
        Memory at fcfbff80 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=256K]

00:14.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, medium devsel, latency 128
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=128
        I/O behind bridge: 0fffe000-0fffefff
        Memory behind bridge: 3ce00000-3cefffff
        Prefetchable memory behind bridge: 000000003cd00000-000000003cd00000
        Capabilities: [dc] Power Management version 1

--
<rsi@panix.com> a.k.a. Rajappa Iyer.
	They also surf who stand in the waves.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
