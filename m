Return-Path: <frey_simon@yahoo.fr>
Received: from web26005.mail.ukl.yahoo.com (web26005.mail.ukl.yahoo.com
	[217.12.10.216]) by ozlabs.org (Postfix) with SMTP id 1A4E5DDF35
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jun 2008 00:53:00 +1000 (EST)
Date: Fri, 13 Jun 2008 14:46:19 +0000 (GMT)
From: Simon Frey <frey_simon@yahoo.fr>
Subject: XLLTemac with SGDMA working on virtex4FX ?
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-ID: <433607.2549.qm@web26005.mail.ukl.yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

does anyone have working driver for xps_ll_temac unsing sg dma and checksum=
 offload on rx and tx ??

I use the xlnx kernel with ARCH=3Dpowerpc  and a device tree generated with=
 the gen_mhs_devtree under EDK 10.1

I don't know what's wrong but i can't get or send anything  even the speed =
is only 10 Mb/s !

that's what i get when the kernel starts...

## Starting application at 0x004007d0 ...
Using Xilinx Virtex machine description
Linux version 2.6.25-xlnx (simon@linux) (gcc version 4.2.2) #11 PREEMPT Fri=
 Jun 13 15:51:29 CEST 2008
Zone PFN ranges:
  DMA             0 ->    16384
  Normal      16384 ->    16384
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->    16384
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 16256
Kernel command line: console=3DttyS0,115200 ip=3Ddhcp
Xilinx intc at 0x81800000 mapped to 0xfdfff000
PID hash table entries: 256 (order: 8, 1024 bytes)
clocksource: timebase mult[1400000] shift[22] registered
Console: colour dummy device 80x25
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 61704k/65536k available (2892k kernel code, 3768k reserved, 112k da=
ta, 141k bss, 144k init)
Mount-cache hash table entries: 512
net_namespace: 536 bytes
NET: Registered protocol family 16
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
83e00000.serial: ttyS0 at MMIO 0x83e00003 (irq =3D 16) is a 16550A
console [ttyS0] enabled
brd: module loaded
loop: module loaded
Device Tree Probing 'ethernet'
xilinx_lltemac 81c00000.ethernet: MAC address is now  0: a:35: 0:22: 1
xilinx_lltemac 81c00000.ethernet: XLlTemac: using DMA mode.
XLlTemac: Dma base address: phy: 0x84600100, virt: 0xc5010100
XLlTemac: buffer descriptor size: 32768 (0x8000)
XLlTemac: Allocating DMA descriptors with kmalloc<6>XLlTemac: (buffer_descr=
iptor_init) phy: 0x3868000, virt: 0xc3868000, size: 0x8000
XTemac: PHY detected at address 4.
xilinx_lltemac 81c00000.ethernet: eth0: Xilinx TEMAC at 0x81C00000 mapped t=
o 0xC500E000, irq=3D17
mice: PS/2 mouse device common for all mice
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
eth0: XLlTemac: Options: 0x3fa
eth0: XLlTemac: allocating interrupt 19 for dma mode tx.
eth0: XLlTemac: allocating interrupt 18 for dma mode rx.
eth0: XLlTemac: speed set to 10Mb/s
eth0: XLlTemac: Send Threshold =3D 240, Receive Threshold =3D 40
eth0: XLlTemac: Send Wait bound =3D 254, Receive Wait bound =3D 254
Sending DHCP requests ...... timed out!
IP-Config: Reopening network devices...
eth0: XLlTemac: Options: 0x3fa                                             =
                                                               =20



I can see the led blinking on my switch but don't see nothing using wiresha=
k !!!


Finaly, i know the the temac works because i can use it with uboot !!! even=
=20
at speed 1000.

In:    serial
Out:   serial
Err:   serial
U-Boot relocated to 03fcf000
### main_loop entered: bootdelay=3D3

### main_loop: bootcmd=3D"loooaadd %addr"
Press Enter within 3 seconds to stop autoboot
Unknown command 'loooaadd' - try 'help'
=3D> setenv bootfile zImage.virtex
=3D> tftp 40000
eth0: Xilinx XPS LocalLink Tri-Mode Ether MAC #0 at 0x81C00000.
1000BASE-T/FD
TFTP from server 192.168.1.100; our IP address is 192.168.1.200
Filename 'zImage.virtex'.
Load address: 0x40000
Loading: #################################################################
         ########################################################
done
Bytes transferred =3D 1772215 (1b0ab7 hex)
=3D>


so if someone already had that problem...=20

Thanks in advance=20

Simon
=0A=0A=0A      ____________________________________________________________=
_________________ =0AEnvoyez avec Yahoo! Mail. Une boite mail plus intellig=
ente http://mail.yahoo.fr
