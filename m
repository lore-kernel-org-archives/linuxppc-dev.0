Message-Id: <200205211830.g4LIU0l10956@panix1.panix.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Bridge initialization on MCP750
From: Rajappa Iyer <rsi@panix.com>
Date: 21 May 2002 14:30:00 -0400
Reply-To: rsi@panix.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm a newbie at this, so please bear with a potentially stupid
question:

When Linux boots up, it does not seem to initialize the P2P bridge
(21154).  Here's the relevant dmesg (with DEBUG turned on in
arch/ppc/kernel/pci.c) and the output of lspci.  I'm running
2.5.8-pre3 from the mvista.com rsync server.

I'm not able to see any devices downstream of the 21154.  If anyone
has words of wisdom about how to enable the P2P bridge, I'd greatly
appreciate hearing them.

Thanks,
Rajappa


Total memory = 64MB; using 128kB for hash table (at c0220000)
Linux version 2.5.8-pre3 (rsi@pluto) (gcc version 2.95.2 19991024
(release)) #7
Mon May 20 17:57:07 PDT 2002
PReP architecture
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600 \
ip=172.19.217.210:172.19.216.101:172.19. \
216.3:255.255.254.0 nfsroot=172.19.216.101:/usr/exports/mcp750,rw
OpenPIC Version 1.3 (2 CPUs and 16 IRQ sources) at effde000
OpenPIC timer frequency is 8.333848 MHz
time_init: decrementer frequency = 16.666950 MHz
Calibrating delay loop... 465.30 BogoMIPS
Memory: 62520k available (1240k kernel code, 628k data, 232k init, 0k highmem)
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
PCI:00:00.0 Resource 0 [00000000-ffffffff] is unassigned
Fixup res 1 (200) of dev 00:00.0: 3c000000 -> fc000000
Fixup res 1 (200) of dev 00:0e.0: 3bffff00 -> fbffff00
PCI:00:0e.0 Resource 6 [fffc0000-ffffffff] is unassigned
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
PCI: Unable to handle 64-bit address space for
Setting PCI interrupts for a "Mesquite cPCI (MCP750)"
PCI: bridge rsrc 0..ffffff (100), parent c01717bc
PCI: reparented dma1 [0..1f] under PCI host bridge
PCI: reparented 8259 (master) [20..21] under PCI host bridge
PCI: reparented timer [40..5f] under PCI host bridge
PCI: reparented dma page reg [80..8f] under PCI host bridge
PCI: reparented 8259 (slave) [a0..a1] under PCI host bridge
PCI: reparented dma2 [c0..df] under PCI host bridge
PCI: reparented 8259 edge control [4d0..4d1] under PCI host bridge
PCI: bridge rsrc 80000000..beffffff (200), parent c01717d8
PCI:00:00.0: Resource 1: fc000000-fc03ffff (f=200)
PCI: Cannot allocate resource region 1 of device 00:00.0
PCI:00:0b.1: Resource 0: 0000fff0-0000fff7 (f=101)
PCI:00:0b.1: Resource 1: 0000ffec-0000ffef (f=101)
PCI:00:0b.1: Resource 2: 0000ffe0-0000ffe7 (f=101)
PCI:00:0b.1: Resource 3: 0000ffdc-0000ffdf (f=101)
PCI:00:0b.1: Resource 4: 0000ffc0-0000ffcf (f=101)
PCI:00:0b.2: Resource 4: 0000ffa0-0000ffbf (f=101)
PCI:00:0e.0: Resource 0: 0fffff00-0fffff7f (f=101)
PCI: Cannot allocate resource region 0 of device 00:0e.0
PCI:00:0e.0: Resource 1: fbffff00-fbffff7f (f=200)
PCI: Cannot allocate resource region 1 of device 00:0e.0
PCI: moved device 00:0e.0 resource 0 (101) to 1000
PCI: moved device 00:0e.0 resource 1 (200) to c0000000
Activating ISA DMA hang workarounds.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
devfs: v1.13 (20020406) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
initialize_kbd: Keyboard reset failed, no ACK
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI en
abled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
block: 256 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
Linux Tulip driver version 1.1.12 (Mar 07, 2002)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip0:  MII transceiver #1 config 3000 status 7809 advertising 01e1.
eth0: Digital DS21140 Tulip rev 34 at 0x1000, 00:01:AF:02:A4:C0, IRQ 18.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
IP-Config: Complete:
      device=eth0, addr=172.19.217.210, mask=255.255.254.0, gw=172.19.216.3,
     host=172.19.217.210, domain=, nis-domain=(none),
     bootserver=172.19.216.101, rootserver=172.19.216.101, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 172.19.216.101
eth0: Setting half-duplex based on MII#1 link partner capability of 0021.
Looking up port of RPC 100005/1 on 172.19.216.101
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 232k init 24k pmac 4k chrp 4k openfirmware

And the output of lspci -v

00:00.0 Host bridge: Motorola Raven (rev 05)
        Flags: bus master, medium devsel, latency 0
        I/O ports at <unassigned> [disabled]
        Memory at <ignored> (32-bit, non-prefetchable) [size=256K]

00:0b.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] (
rev 41)
        Flags: bus master, stepping, medium devsel, latency 0

00:0b.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8
f [Master SecP SecO PriP PriO])
        Flags: bus master, stepping, medium devsel, latency 0
        I/O ports at fff0 [size=8]
        I/O ports at ffec [size=4]
        I/O ports at ffe0 [size=8]
        I/O ports at ffdc [size=4]
        I/O ports at ffc0 [size=16]

00:0b.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 02) (prog-if 00 [UH
CI])
        Subsystem: Unknown device 0925:1234
        Flags: bus master, medium devsel, latency 22, IRQ 11
        I/O ports at ffa0 [size=32]

00:0b.3 Non-VGA unclassified device: VIA Technologies, Inc. VT82C586B ACPI (rev
10)
        Flags: medium devsel

00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip 21140 [Faster
Net] (rev 22)
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at 1000 [size=128]
        Memory at 80000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=256K]

00:14.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 02) (prog-i
f 00 [Normal decode])
        Flags: bus master, medium devsel, latency 128
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=128
        Capabilities: [dc] Power Management version 1




--
<rsi@panix.com> a.k.a. Rajappa Iyer.
	They also surf who stand in the waves.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
