Message-Id: <200205272214.g4RMEOP02787@panix3.panix.com>
To: Matt Porter <porter@cox.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: P2P bridge (DEC 21154) initialization on MCP750
References: <200205250114.g4P1ELi08721@panix1.panix.com>
	<20020524200953.A21781@home.com>
From: Rajappa Iyer <rsi@panix.com>
Date: 27 May 2002 18:14:24 -0400
Reply-To: rsi@panix.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt Porter <porter@cox.net> writes:

> On Fri, May 24, 2002 at 09:14:21PM -0400, Rajappa Iyer wrote:
> >
> > I'm having problems with the PCI-PCI bridge (DEC 21154) on the MCP750
> > and would appreciate any words of wisdom.  Basically, this bridge does
> > not get initialized and therefore no devices are probed on the
> > secondary bus.

> Use _devel and start with the pplus port.  'make pplus_config'

Thanks.  This did improve the situation somewhat in that the P2P
bridge is now initialized properly, but the devices beyond it are
still not probed.   Incidentally, I had to work with 2.5.x, since the
2.4 devel kernel was, for some reason, unbearably slow.

Here's the dmesg.  Does it set off any alarm bells?

Thanks,
Rajappa


Total memory = 64MB; using 128kB for hash table (at c01e0000)
Linux version 2.5.8-pre3 (rsi@pluto) (gcc version 2.95.2 19991024 (release)) #4
Mon May 27 15:00:44 PDT 2002
PowerPlus port (C) 2001 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 ip=172.19.217.210:172.19.216.101:172.19.
216.3:255.255.254.0 nfsroot=172.19.216.101:/usr/exports/mcp750,rw
OpenPIC Version 1.3 (2 CPUs and 16 IRQ sources) at effdd000
OpenPIC timer frequency is 8.333848 MHz
time_init: decrementer frequency = 16.667080 MHz
Calibrating delay loop... 465.30 BogoMIPS
Memory: 62776k available (1208k kernel code, 548k data, 96k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
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
PCI: bridge rsrc 0..fffffff (100), parent c016a298
PCI: reparented dma1 [0..1f] under PCI host bridge
PCI: reparented 8259 (master) [20..21] under PCI host bridge
PCI: reparented timer [40..5f] under PCI host bridge
PCI: reparented dma page reg [80..8f] under PCI host bridge
PCI: reparented 8259 (slave) [a0..a1] under PCI host bridge
PCI: reparented dma2 [c0..df] under PCI host bridge
PCI: reparented 8259 edge control [4d0..4d1] under PCI host bridge
PCI: bridge rsrc c0000000..fdffffff (200), parent c016a2b4
PCI: bridge rsrc fffe000..fffefff (101), parent c01df034
PCI: bridge rsrc fce00000..fcefffff (200), parent c01df050
PCI: bridge rsrc fcd00000..fcdfffff (1201), parent c01df050
PCI:00:00.0: Resource 1: fcfc0000-fcffffff (f=200)
PCI:00:0b.1: Resource 4: 0000cc00-0000cc0f (f=101)
PCI:00:0b.2: Resource 4: 0fffffe0-0fffffff (f=101)
PCI:00:0e.0: Resource 0: 0fffff00-0fffff7f (f=101)
PCI:00:0e.0: Resource 1: fcfbff80-fcfbffff (f=200)
Activating ISA DMA hang workarounds.
[...]


--
<rsi@panix.com> a.k.a. Rajappa Iyer.
	They also surf who stand in the waves.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
