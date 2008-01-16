Return-Path: <markus.mehlan@ritter-elektronik.de>
Received: from mail.textile.saurer.com (mail.textile.saurer.com
	[193.158.88.134]) by ozlabs.org (Postfix) with ESMTP id AECF4DDDFF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Jan 2008 23:32:18 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: MPC52xx problems with fec-driver
Date: Wed, 16 Jan 2008 13:20:05 +0100
Message-ID: <FACFFB02D783C64FB2CEF2D6825F6FC206EEF1A2@SRVEXC01.sts.saurer.vpn>
From: "Mehlan, Markus (Ritter Elektronik)" <markus.mehlan@ritter-elektronik.de>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

i have a mpc5200b-based board with 2 ethernet interfaces,
Kernel 2.6.23.1-rt5 (arch=3Dpowerpc), last fec/bestcomm-patches:
eth0: mpc52xx_FEC
eth1: natsemi dp8381x

The natsemi driver works pretty, but the FEC makes problems:
If i ping the board i get damaged packages. The interrupt-counter
for the control-irq (mpc52xx-fec_ctrl) stays on zero.

The FEC interface works with an older kernel (2.6.14-rt22 arch=3Dppc).

Markus

root@phyCORE-MPC5200B-tiny:~ cat /proc/interrupts
           CPU0
 66:          5   MPC52xx IRQ[0-3]  Edge      eth1
132:       1368  MPC52xx Peripherals Edge      mpc52xx_psc_uart
133:          0  MPC52xx Peripherals Edge      mpc52xx-fec_ctrl
143:          2  MPC52xx Peripherals Edge      i2c-mpc
144:         60  MPC52xx Peripherals Edge      i2c-mpc
145:          0  MPC52xx Peripherals Edge      can0
146:          0  MPC52xx Peripherals Edge      can1
192:         32  MPC52xx SDMA Edge      mpc52xx-fec_rx
193:         35  MPC52xx SDMA Edge      mpc52xx-fec_tx
BAD:          0

ritter-ewc2:/home/meh # ping -a 192.168.0.9
PING 192.168.0.9 (192.168.0.9) 56(84) bytes of data.
64 bytes from 192.168.0.9: icmp_seq=3D3 ttl=3D64 time=3D0.267 ms
64 bytes from 192.168.0.9: icmp_seq=3D11 ttl=3D64 time=3D0.271 ms
64 bytes from 192.168.0.9: icmp_seq=3D17 ttl=3D64 time=3D0.266 ms
wrong data byte #20 should be 0x14 but was 0x0
#8      8 9 a b c d e f 10 11 12 13 0 15 16 17 18 19 1a 1b 1c 1d 1e 1f
20 21 22 23 24 25 26 27
#40     28 29 2a 2b 2c 2d 2e 2f 30 31 32 33 34 35 36 37

--- 192.168.0.9 ping statistics ---
19 packets transmitted, 3 received, 84% packet loss, time 18026ms

------------------------------------------------------------------
Using ritter_el392 machine description
Linux version 2.6.23.1-rt5-el392trunk (meh@ritter-ewc2) (gcc version
4.1.2) #445 PREEMPT RT Wed Jan 16 12:05:52 CET 2008
Found initrd at 0xc3a2e000:0xc3f47e63
Zone PFN ranges:
  DMA             0 ->    16384
  Normal      16384 ->    16384
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0:        0 ->    16384
Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
Built 1 zonelists in Zone order.  Total pages: 16256
Kernel command line: console=3DttyPSC0,115200 root=3D/dev/ram0 rw
ip=3D192.168.0.10:192.168.0.1::255.255.255.0:RITTER_EL392:eth1:off =
panic=3D1
WARNING: experimental RCU implementation.
MPC52xx PIC is up and running!
PID hash table entries: 256 (order: 8, 1024 bytes)
console [ttyPSC0] enabled
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 56972k/65536k available (2412k kernel code, 8500k reserved, 132k
data, 101k bss, 148k init)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing PCI hardware
DMA: MPC52xx BestComm driver
DMA: MPC52xx BestComm engine @f0001200 ok !
Generic PHY xxx: Registered new driver
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 4, 73728 bytes)
TCP bind hash table entries: 2048 (order: 3, 57344 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Freeing initrd memory: 5223k freed
io scheduler noop registered (default)
Serial: MPC52xx PSC UART driver
f0002c00.serial: ttyPSC0 at MMIO 0xf0002c00 (irq =3D 132) is a MPC52xx =
PSC
RAMDISK driver initialized: 2 RAM disks of 20480K size 1024 blocksize
mpc52xx-mscan initializing
mpc52xx-mscan mpc52xx-mscan.0: probe for a port 0xC500A900 done
mpc52xx-mscan mpc52xx-mscan.1: probe for a port 0xC500C980 done
mpc52xx MII bus: probed
natsemi dp8381x driver, version 2.1, Sept 11, 2006
  originally by Donald Becker <becker@scyld.com>
  2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
PCI: Enabling device 0000:00:18.0 (0006 -> 0007)
natsemi eth1: NatSemi DP8381[56] at 0xa0000000 (0000:00:18.0),
00:0b:93:80:01:00, IRQ 66, port TP.
i2c /dev entries driver
pcf8563 1-0051: chip found, driver version 0.4.2
pcf8563 1-0051: rtc core: registered pcf8563 as rtc0
MPC52xx Watchdog Timer on GPT0
MPC52xx Watchdog-Relay on GPIO
Registered led device: el392:right
Registered led device: el392:middle
Registered led device: el392:left
EL392 Front-LEDs found
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
can: controller area network core (rev 20070916 abi 8)
NET: Registered protocol family 29
can: raw protocol (rev 20070916)
pcf8563 1-0051: setting the system clock to 2008-01-16 12:06:42
(1200485202)
eth1: DSPCFG accepted after 0 usec.
eth1: link up.
eth1: Setting full-duplex based on negotiated link capability.
IP-Config: Complete:
      device=3Deth1, addr=3D192.168.0.10, mask=3D255.255.255.0,
gw=3D255.255.255.255,
     host=3DRITTER_EL392, domain=3D, nis-domain=3D(none),
     bootserver=3D192.168.0.1, rootserver=3D192.168.0.1, rootpath=3D
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 148k init
mounting filesystems...done.
running rc.d services...
mounting... tmpfs at /dev
creating static nodes
creating initial udev device nodes...done
udev startup is finished
loading modules
syslogd starting
klogd starting
starting network interfaces...
can0: baudrate 250
can1: baudrate 250
net eth0: attached phy 0 to driver Generic PHY
PURE-FTPD: No /etc/pure-ftpd.defaults found.
/usr/sbin/pure-ftpd
PURE-FTPD: Starting pure-ftpd: /usr/sbin/pure-ftpd
PURE-FTPD: no upload script defined, skipping
Done
Starting telnetd...
thttpd:  starting
thttpd:  done
el392 login:=20
PHY: f0003000:00 - Link is Up - 100/Full
net eth0: attached phy 0 to driver Generic PHY
