Message-Id: <200108241930.PAA15782@orchid.cspi.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Brian Waite <bwaite@cspi.com>
Reply-To: bwaite@cspi.com
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SCSI PMC card
Date: Fri, 24 Aug 2001 15:23:10 -0400
References: <85256AB1.005815DF.00@pine.cspi.com>
In-Reply-To: <85256AB1.005815DF.00@pine.cspi.com>
MIME-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ok now I moved up to a 2.4.9 kernel from the linuxppc_2_4_stable tree and I
see the same problem. Here is the output of debug being defined in both
drivers/pci.c and arch/ppc/kernel/pci.c. Below are the dumps of 2 boots, one
without the SCSI card attached and one with the SCSI card attached to the
baseboard. Does anything looks suspicious? This card did work on the base
under 2.2.18 when I initiaslly tested it.
PS I can't seem to get my 2.4 devel tree to boot on the 2400, the
decompress_kernel fails with fffffffd.


Without SCSI card attached:

OpenPIC Version 1.3 (2 CPUs and 16 IRQ sources) at effde000
OpenPIC timer frequency is 12.500243 MHz
time_init: decrementer frequency = 24.999957 MHz
Calibrating delay loop... 699.59 BogoMIPS
Memory: 125408k available (1000k kernel code, 540k data, 96k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Scanning bus 00
Found 00:00 [1057/4803] 000600 00
Fixup res 1 (200) of dev 00:00.0: 3c000000 -> fc000000
Found 00:58 [10ad/0565] 000601 00
Found 00:59 [10ad/0105] 000101 00
Found 00:68 [10e3/0000] 000680 00
Fixup res 0 (200) of dev 00:0d.0: 2ff7f000 -> eff7f000
Found 00:70 [1011/0019] 000200 00
Fixup res 1 (200) of dev 00:0e.0: 2ff7ec00 -> eff7ec00
PCI:00:0e.0 Resource 6 [fffc0000-ffffffff] is unassigned
Fixups for bus 00
Bus scan for 00 returning with max=00
Setting PCI interrupts for a "MVME 2400"
PCI:00:00.0: Resource 1: fc000000-fc03ffff (f=200)
PCI:00:0b.1: Resource 0: 0ff7fff8-0ff7ffff (f=109)
PCI:00:0b.1: Resource 1: 0ff7fff4-0ff7fff7 (f=105)
PCI:00:0b.1: Resource 2: 0ff7ffe8-0ff7ffef (f=109)
PCI:00:0b.1: Resource 3: 0ff7ffe4-0ff7ffe7 (f=105)
PCI:00:0b.1: Resource 4: 0ff7ffd0-0ff7ffdf (f=101)
PCI:00:0b.1: Resource 5: 0ff7ffc0-0ff7ffcf (f=101)
PCI:00:0d.0: Resource 0: eff7f000-eff7ffff (f=200)
PCI:00:0d.0: Resource 1: 0ff7e000-0ff7efff (f=101)
PCI:00:0e.0: Resource 0: 0ff7df80-0ff7dfff (f=101)
PCI:00:0e.0: Resource 1: eff7ec00-eff7efff (f=200)
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI
edttyS00 at 0x03f8 (irq = 4) is a 16550A
block: 128 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
eth0: DC21143 at 0xff7df80 (PCI bus 0, device 14), h/w address
08:00:3e:2f:14:9,      and requires IRQ18 (provided by PCI BIOS).
de4x5.c:V0.546 2001/02/22 davies@maniac.ultranet.com
loop: loaded (max 8 devices)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 1189k freed
VFS: Mounted root (romfs filesystem) readonly.
Freeing unused kernel memory: 96k init 12k pmac 4k chrp 4k openfirmware
 Good morning from the ROMFS
mounting /proc..


With SCSI card attached:
OpenPIC Version 1.3 (2 CPUs and 16 IRQ sources) at effde000
OpenPIC timer frequency is 12.500243 MHz
time_init: decrementer frequency = 24.999957 MHz
Calibrating delay loop... 699.59 BogoMIPS
Memory: 125408k available (1000k kernel code, 540k data, 96k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Scanning bus 00
Found 00:00 [1057/4803] 000600 00
Fixup res 1 (200) of dev 00:00.0: 3c000000 -> fc000000
Found 00:58 [10ad/0565] 000601 00
Found 00:59 [10ad/0105] 000101 00
Found 00:68 [10e3/0000] 000680 00
Fixup res 0 (200) of dev 00:0d.0: 2ff7f000 -> eff7f000
Found 00:70 [1011/0019] 000200 00
Fixup res 1 (200) of dev 00:0e.0: 2ff7ec00 -> eff7ec00
PCI:00:0e.0 Resource 6 [fffc0000-ffffffff] is unassigned
Found 00:88 [1000/000c] 000100 00
<HANGS HERE>

--
Brian Waite

Looking for a TeraFLOP in a closet
www.fastcluster.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
