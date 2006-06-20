Return-Path: <rick.moleres@xilinx.com>
Received: from outbound2-red-R.bigfish.com (outbound-red.frontbridge.com
	[216.148.222.49])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id BF59467B37
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Jun 2006 01:55:03 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Linux on Virtex4
Date: Tue, 20 Jun 2006 09:29:30 -0600
Message-ID: <689CB232690D8D4E97DA6C76DA098E6C027E6274@XCO-EXCHVS1.xlnx.xilinx.com>
From: "Rick Moleres" <rick.moleres@xilinx.com>
To: "Martin, Tim" <tim.martin@viasat.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Tim,

There's also a Linux 2.4 patch provided with the ML403 PPC reference
design on the Xilinx website
(http://www.xilinx.com/products/boards/ml403/reference_designs.htm) that
takes care of a Virtex-4 PPC cache issue (CCR0 register).  Have you
applied this?

-Rick

-----Original Message-----
From: linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org] On
Behalf Of Martin, Tim
Sent: Monday, June 19, 2006 5:24 PM
To: linuxppc-embedded@ozlabs.org
Subject: Linux on Virtex4

I have been working with a small module made by Memec/Avnet
(FX12MM1-BASE) that has a Virtex-4 FX12 with some DDR SDRAM, a Gigabit
Ethernet PHY, some FLASH, etc.  I am using EDK 8.1 and generated the BSP
for MontaVista 3.1 "preview kit" (which is based on the 2.4.20 kernel).
This works, but occasionally panics while booting (doesn't panic all the
time, maybe 1/3 the time).  Examples of "good" boot and 2 "crash" boots
below.  We are using a root filesystem over NFS, and the panics seem to
always be after the file system is mounted.  I'm not sure if it is NFS
related or not.

I have also been working with the paulus 2.6 kernel tree (and I have
tried the MVL linux-xilinx-26 tree), but have not been able to get the
kernel to boot.  The primary problem there is that we are using the
uartlite instead of the full uart, and the patches I have found for
uartlite support don't work.  I can get the early serial messages to
work, but I don't know enough about the console and serial core to get
everything else working.  I am also getting panics that seem to be
non-serial related, but I haven't tracked it down yet.

So two questions:

1) Is there anything obvious from the kernel panics below that I should
be looking for?  Just the answer "linux 2.4.20 is really fricken old,
upgrade" is probably the right answer.

2) Does anyone have working UartLite support on a Virtex-4 FX12 design?


------------ Examples of 2.4.20 good:

id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:mapin_ram done
MMU:setio
MMU:exit
Linux version 2.4.20_mvl31-v4fx12 (ahamel@uhflinux) (gcc version 3.3.1
(MontaVista 3.3.1-3.0.10.6
setup_arch: enter
setup_arch: bootmem
Xilinx Virtex-II Pro port (C) 2002 MontaVista Software, Inc.
(source@mvista.com)
arch: exit
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=3D/dev/nfs
nfsroot=3D192.168.1.1:/opt/montavista/previewkit/ppc/405/target4
Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFF000
Calibrating delay loop... 197.01 BogoMIPS
Memory: 63268k available (1092k kernel code, 340k data, 60k init, 0k
highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX

Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
LSP Revision 42
ikconfig 0.5 with /proc/ikconfig
Starting kswapd
Disabling the Out Of Memory Killer
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
xgpio #0 at 0x40020000 mapped to 0xC5000000
xgpio #1 at 0x40040000 mapped to 0xC5011000
xgpio #2 at 0x40060000 mapped to 0xC5022000
xilinx_spi: got major number 254
xilinx_spi0 at 0x40800000 mapped to 0xC5033000, irq=3D29
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
XTemac: Device instance #0 found
eth0: XTemac: using fifo direct interrupt driven mode.
eth0: XTemac: PHY detected at address 4.
eth0: Xilinx TEMAC #0 at 0x80400000 mapped to 0xC5044000, irq=3D28
eth0: XTemac: id 1.0f, block id 5, type 8
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
eth0: XTemac: Options: 0xb8f0
eth0: XTemac: We renegotiated the speed to: 1000
eth0: XTemac: speed set to 1000Mb/s
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 192.168.1.1, my address is 192.168.1.75
IP-Config: Complete:
      device=3Deth0, addr=3D192.168.1.75, mask=3D255.255.255.0,
gw=3D192.168.1.1,
     host=3D192.168.1.75, domain=3D, nis-domain=3D(none),
     bootserver=3D192.168.1.1, rootserver=3D192.168.1.1, rootpath=3D
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.1.1
Looking up port of RPC 100005/1 on 192.168.1.1
VFS: Mounted root (nfs filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 60k init
serial console detected.  Disabling virtual terminals.
init started:  BusyBox v0.60.2 (2004.04.30-17:49+0000) multi-call binary

Welcome to MontaVista Linux Preview Kit

Starting system...
mounting /proc: done.
Mounting '/' read-only: done.
brining up loopback interface: done.
Mounting /tmp: done.
Starting syslogd: done.
Starting klogd: done.
Starting inetd: done.
Starting thttpd: done.
System started.

MontaVista(R) Linux(R) Professional Edition 3.1, Preview Kit

192.168.1.75 login:

------ Example 1 of panic

id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:mapin_ram done
MMU:setio
MMU:exit
Linux version 2.4.20_mvl31-v4fx12 (ahamel@uhflinux) (gcc version 3.3.1
(MontaVista 3.3.1-3.0.10.6
setup_arch: enter
setup_arch: bootmem
Xilinx Virtex-II Pro port (C) 2002 MontaVista Software, Inc.
(source@mvista.com)
arch: exit
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=3D/dev/nfs
nfsroot=3D192.168.1.1:/opt/montavista/previewkit/ppc/405/target4
Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFF000
Calibrating delay loop... 197.01 BogoMIPS
Memory: 63268k available (1092k kernel code, 340k data, 60k init, 0k
highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX

Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
LSP Revision 42
ikconfig 0.5 with /proc/ikconfig
Starting kswapd
Disabling the Out Of Memory Killer
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
xgpio #0 at 0x40020000 mapped to 0xC5000000
xgpio #1 at 0x40040000 mapped to 0xC5011000
xgpio #2 at 0x40060000 mapped to 0xC5022000
xilinx_spi: got major number 254
xilinx_spi0 at 0x40800000 mapped to 0xC5033000, irq=3D29
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
XTemac: Device instance #0 found
eth0: XTemac: using fifo direct interrupt driven mode.
eth0: XTemac: PHY detected at address 4.
eth0: Xilinx TEMAC #0 at 0x80400000 mapped to 0xC5044000, irq=3D28
eth0: XTemac: id 1.0f, block id 5, type 8
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
eth0: XTemac: Options: 0xb8f0
eth0: XTemac: We renegotiated the speed to: 1000
eth0: XTemac: speed set to 1000Mb/s
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 192.168.1.1, my address is 192.168.1.75
IP-Config: Complete:
      device=3Deth0, addr=3D192.168.1.75, mask=3D255.255.255.0,
gw=3D192.168.1.1,
     host=3D192.168.1.75, domain=3D, nis-domain=3D(none),
     bootserver=3D192.168.1.1, rootserver=3D192.168.1.1, rootpath=3D
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.1.1
Looking up port of RPC 100005/1 on 192.168.1.1
VFS: Mounted root (nfs filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 60k init
nfs: server 192.168.1.1 not responding, still trying
Oops: kernel access of bad area, sig: 11
NIP: C00F05B4 XER: 20000000 LR: C00F0C80 SP: C0131C80 REGS: c0131bd0
TRAP: 0800    Not tainted
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DEAR: 00000045, ESR: 00000000
TASK =3D c0130020[0] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR00: C00CA728 C0131C80 C0130020 00000001 00001030 00000000 C02C9180
C023F9F8
GPR08: C02CA000 C0150000 00000003 00001DC7 84002022 1006E950 03FD0000
00000000
GPR16: 00000001 00000001 FFFFFFFF 007FFF00 00001032 00131EE0 00000000
C0000000
GPR24: C0151D24 C02C90D0 C0150000 00000000 C0157F00 C02E8080 C02C90D8
C02E8080
Call backtrace:
C00F0A4C C00CA728 C00EED30 C00C2958 C00200DC C001BD20 C001BB9C
C001B868 C0005E48 C00047CC C00274E4 C0005D80 C0005D94 C0002434
C01425CC C000232C
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing
 <0>Rebooting in 180 seconds..

------- Example 2 of crash
id mach(): done
MMU:enter
MMU:hw init
MMU:mapin
MMU:mapin_ram done
MMU:setio
MMU:exit
Linux version 2.4.20_mvl31-v4fx12 (ahamel@uhflinux) (gcc version 3.3.1
(MontaVista 3.3.1-3.0.10.6
setup_arch: enter
setup_arch: bootmem
Xilinx Virtex-II Pro port (C) 2002 MontaVista Software, Inc.
(source@mvista.com)
arch: exit
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=3D/dev/nfs
nfsroot=3D192.168.1.1:/opt/montavista/previewkit/ppc/405/target4
Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFF000
Calibrating delay loop... 197.01 BogoMIPS
Memory: 63268k available (1092k kernel code, 340k data, 60k init, 0k
highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX

Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
LSP Revision 42
ikconfig 0.5 with /proc/ikconfig
Starting kswapd
Disabling the Out Of Memory Killer
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
xgpio #0 at 0x40020000 mapped to 0xC5000000
xgpio #1 at 0x40040000 mapped to 0xC5011000
xgpio #2 at 0x40060000 mapped to 0xC5022000
xilinx_spi: got major number 254
xilinx_spi0 at 0x40800000 mapped to 0xC5033000, irq=3D29
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
XTemac: Device instance #0 found
eth0: XTemac: using fifo direct interrupt driven mode.
eth0: XTemac: PHY detected at address 4.
eth0: Xilinx TEMAC #0 at 0x80400000 mapped to 0xC5044000, irq=3D28
eth0: XTemac: id 1.0f, block id 5, type 8
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
eth0: XTemac: Options: 0xb8f0
eth0: XTemac: We renegotiated the speed to: 1000
eth0: XTemac: speed set to 1000Mb/s
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 192.168.1.1, my address is 192.168.1.75
IP-Config: Complete:
      device=3Deth0, addr=3D192.168.1.75, mask=3D255.255.255.0,
gw=3D192.168.1.1,
     host=3D192.168.1.75, domain=3D, nis-domain=3D(none),
     bootserver=3D192.168.1.1, rootserver=3D192.168.1.1, rootpath=3D
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.1.1
Looking up port of RPC 100005/1 on 192.168.1.1
VFS: Mounted root (nfs filesystem).
Mounted devfs on /dev
Freeing unused kernel memory: 60k init
serial console detected.  Disabling virtual terminals.
init started:  BusyBox v0.60.2 (2004.04.30-17:49+0000) multi-call binary

Welcome to MontaVista Linux Preview Kit

Starting system...
mounting /proc: done.
Mounting '/' read-only: done.
brining up loopback interface: done.
Mounting /tmp: done.
Starting syslogd: done.
Starting klogd: done.
Starting inetd: done.
Starting thttpd: done.
System started.
Oops: Exception in kernel mode, sig: 4
NIP: C010D660 XER: 00000000 LR: C010D6F0 SP: C3EB7E60 REGS: c3eb7db0
TRAP: 0700    Not tainted
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK =3D c3eb6000[48] 'insmod' Last syscall: 90
last math 00000000 last altivec 00000000
GPR00: 00000001 C3EB7E60 C3EB6000 C3F06CD8 C014F524 C014DAE0 C014DB00
C014DAF8
GPR08: C014D000 C3F06C78 0000001C C014D9D8 24022222 00000000 300277F8
00000000
GPR16: 10001AA1 7FFFF118 00000030 C0150000 00000000 FFFFFFF4 00000002
00000002
GPR24: 00100077 00000032 00000000 00000001 C014F524 C014DAF8 C3F06CD8
C014D9D8
Call backtrace:
C002A84C C0029684 C0029BC0 C0009DE0 C000459C 3000646C 30007784
3000B810 3000CE68 3000C1F8 30002FE8 3000F7F0 30001FDC 30002434
30010904
kernel BUG at mmap.c:1304!
Oops: Exception in kernel mode, sig: 4
NIP: C002AD48 XER: 00000000 LR: C002AD48 SP: C3EB7C60 REGS: c3eb7bb0
TRAP: 0700    Not tainted
MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK =3D c3eb6000[48] 'insmod' Last syscall: 90
last math 00000000 last altivec 00000000
GPR00: C002AD48 C3EB7C60 C3EB6000 0000001B 00001030 00000001 00000F14
C0139D93
GPR08: 00000000 00000000 00000034 C3EB7B70 C0150000 00000000 300277F8
00000000
GPR16: 10001AA1 7FFFF118 00000030 C0150000 00009032 03EB7DA0 00000000
C00047D4
GPR24: C0004BC4 C0150000 C0150000 00000000 00001000 7FFFF000 C014F520
00000000
Call backtrace:
C002AD48 C0014684 C0019EE8 C000497C C00049EC C00047D4 C002A84C
C0029684 C0029BC0 C0009DE0 C000459C




_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
