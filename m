Date: Sat, 29 Nov 2003 11:54:20 +0900
From: Eiji Ogata <eiji_ogata@ooi.co.jp>
To: linuxppc-dev@lists.linuxppc.org
Subject: mpc10x PCI Bus error
Message-Id: <20031129115338.2EF2.EIJI_OGATA@ooi.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all.

I am porting linuxppc to our custom board which based mpc8245.
cpu is connected two rtl8100 nics with PCI bus and detected them when
kernel startup. /proc/pci info and 'lspci -x' results are below.

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: PCI device 1057:0006 (Motorola) (rev 20).
      Prefetchable 32 bit memory at 0x0 [0xffffffff].
      Non-prefetchable 32 bit memory at 0x0 [0xfff].
      Prefetchable 32 bit memory at 0x0 [0xffffffff].
  Bus  0, device  16, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 16).
      IRQ 16.
      Master Capable.  Latency=128.  Min Gnt=32.Max Lat=32.
      I/O at 0xfebfff00 [0xfebfffff].
      Non-prefetchable 32 bit memory at 0x8fffff00 [0x8fffffff].
  Bus  0, device  17, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (#2) (rev 16).

      IRQ 17.
      Master Capable.  Latency=128.  Min Gnt=32.Max Lat=32.
      I/O at 0xfebffe00 [0xfebffeff].
      Non-prefetchable 32 bit memory at 0x8ffffe00 [0x8ffffeff].


00:00.0 Host bridge: Motorola: Unknown device 0006 (rev 14)
00: 57 10 06 00 04 00 20 20 14 00 00 06 00 00 00 00
10: 08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 01 00 00

00:10.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00: ec 10 39 81 07 00 00 22 10 00 00 02 00 80 00 00
10: 01 ff bf 00 00 ff ff 8f 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 10 01 20 20

00:11.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
00: ec 10 39 81 07 00 00 02 10 00 00 02 00 80 00 00
10: 01 fe bf 00 00 fe ff 8f 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 11 01 20 20


I tried ping command and no packets sent to network and got errors below.

myboard:~# ping 172.18.11.67
PING 172.18.11.67 (172.18.11.67): 56 data bytes

--- 172.18.11.67 ping statistics ---
8 packets transmitted, 0 packets received, 100% packet loss
myboard:~# NETDEV WATCHDOG: eth0: transmit timed out
NETDEV WATCHDOG: eth0: transmit timed out
eth0: Setting 100mbps half-duplex based on auto-negotiated partner ability 40a1.

eth0: Setting 100mbps half-duplex based on auto-negotiated partner ability 40a1.

eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 0200.
eth0: PCI Bus error 0200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: PCI Bus error 2200.
eth0: Too much work at interrupt, IntrStatus=0x8000.
eth0: Too much work at interrupt, IntrStatus=0x8000.


I checked rtl8100 registers with JTAG.

>BKM>dmb 8fffff00 100
 8FFFFF00: 00 10 C1 FF FF 01 00 00 80 00 00 00 00 00 00 00
 8FFFFF10: 00 20 00 00 00 20 00 00 00 20 00 00 00 20 00 00
 8FFFFF20: 00 80 A2 07 00 86 A2 07 00 8C A2 07 00 92 A2 07
 8FFFFF30: 00 00 A6 07 00 00 04 0D F0 FF 00 00 7F C0 42 80
 8FFFFF40: 80 06 40 74 8E F7 00 00 09 2A 18 41 7B 04 00 00
 8FFFFF50: 01 10 4C 00 00 00 00 00 10 00 80 00 00 00 10 00
 8FFFFF60: 0F 00 00 10 2D 78 E1 05 A1 40 01 00 00 00 00 00
 8FFFFF70: 00 00 00 00 C8 07 01 00 59 0C F6 60 60 26 73 7B
 8FFFFF80: 1A 00 00 00 00 00 00 00 80 00 00 00 00 00 00 00
 8FFFFF90: 08 00 20 00 00 00 00 00 00 10 00 00 00 00 04 00
 8FFFFFA0: 00 00 00 00 00 00 40 00 00 00 00 00 00 00 00 08
 8FFFFFB0: 00 00 00 00 00 80 10 00 00 00 00 00 80 00 00 00
 8FFFFFC0: 00 00 00 C0 00 80 09 00 00 00 00 86 00 00 00 00
 8FFFFFD0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 8FFFFFE0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 8FFFFFF0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00


Mentioned above Tx descriptors (offset 0x20-) are 0x07a28000,
0x07a28600, 0x07a28c00, 07a29200.

mpc8245's PCI bridge is supported by mpc10x_common.c.
mpc10x_common.c setup the bridge to 'PCI compatibility hole' mode which
 maps local memory between 0xa0000-0xbffff to PCI memory region.

I think bus error is caused by kernel did not assign PCI DMA memory
from 0xa0000-0xbffff.

I checked System.map and found no 'PCI compatibility hole'.
I think need to do two things which are PCI DMA memory assigned from
0xa0000-0xbffff and create 'PCI compatibility hole' to kernel image.

Q1.
How do I change kernel code to assign PCI DMA memory from 0xa0000-0xbffff
 ?

Q2.
How do I create 0xa0000-0xbffff hole to kernel image ?

Eiji Ogata


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
