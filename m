Return-Path: <smitha.vanga@wipro.com>
Received: from wipro-blr-out01.wipro.com (wipro-blr-out01.wipro.com
	[203.91.198.74])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B8556B6F91
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Aug 2011 16:02:16 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01CC63B5.8546B44C"
Subject: RE: Kernel boot up
Date: Fri, 26 Aug 2011 11:30:56 +0530
Message-ID: <07ACDFB8ECA8EF47863A613BC01BBB22035E3D59@HYD-MKD-MBX02.wipro.com>
In-Reply-To: <4E56A30F.4010509@freescale.com>
From: <smitha.vanga@wipro.com>
To: <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CC63B5.8546B44C
Content-Type: text/plain;
	charset="us-ascii"
content-transfer-encoding: quoted-printable

 
Thanks scott.

There was an issue with the file system. Now my board is up with the
linux boot prompt .
But ping is not working. The local loopback ping works. My phy chip
BCM5221 is connected on port A
I am using FCC1 as the MAC.  I see that the intrrupt handler is being
registered properly. And even the fs_enet_start_xmit() gets called and
it returns with return NETDEV_TX_OK. When I do a ifconfig -a 
I see the TX packets count increases for the loop back device but not
for eth0. I am using the wireshark tool to see any packets on the witr.
But don't see any ARP packets coming out on the wire.
Can you please suggest . Below are the logs. Attache dis the .dts file.
I have commented the bcsr register part in the .dts is this required. 

EPN412> bootm 1000000 2000000 c00000
## Current stack ends at 0x03e93cc8
*  kernel: cmdline image address =3D 0x01000000
## Booting kernel from Legacy Image at 01000000 ...
   Image Name:   Linux-2.6.39
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1765760 Bytes =3D 1.7 MiB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   kernel data at 0x01000040, len =3D 0x001af180 (1765760)
*  ramdisk: cmdline image address =3D 0x02000000
## Loading init Ramdisk from Legacy Image at 02000000 ...
   Image Name:   uboot ext2 ramdisk rootfs
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    3972156 Bytes =3D 3.8 MiB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   ramdisk start =3D 0x02000040, ramdisk end =3D 0x023c9c7c
*  fdt: cmdline image address =3D 0x00c00000
## Checking for 'FDT'/'FDT Image' at 00c00000
*  fdt: raw FDT blob
## Flattened Device Tree blob at 00c00000
   Booting using the fdt blob at 0xc00000
   of_flat_tree at 0x00c00000 size 0x00000f12
   Uncompressing Kernel Image ... OK
   kernel loaded at 0x00000000, end =3D 0x0038bd20
## initrd_high =3D 0xffffffff, copy_to_ram =3D 1
   Loading Ramdisk to 03ac9000, end 03e92c3c ... OK
   ramdisk load start =3D 0x03ac9000, ramdisk load end =3D 0x03e92c3c
## device tree at 00c00000 ... 00c00f11 (len=3D16146 [0x3F12])
   Loading Device Tree to 007fc000, end 007fff11 ... OK
Updating property 'clock-frequency' =3D  00 fe 70 b8
Updating property 'bus-frequency' =3D  03 f9 c2 e0
Updating property 'timebase-frequency' =3D  00 7f 38 5c
Updating property 'clock-frequency' =3D  09 f0 67 30
## Transferring control to Linux (at address 00000000) ...
   Booting using OF flat tree...
Using Freescale MPC8272 ADS machine description
Linux version 2.6.39 (2.6.39) (ktuser@ktuser) (gcc version 4.4.5
(Buildroot 2011.02) ) #7
 Thu Aug 25 20:59:40 IST 2011
Found initrd at 0xc3ac9000:0xc3e92c3c
No bcsr in device tree
Zone PFN ranges:
  DMA      0x00000000 -> 0x00004000
  Normal   empty
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00004000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages:
16256
Kernel command line: mem=3D64M root=3D/dev/ram rw
PID hash table entries: 256 (order: -2, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 56244k/65536k available (3528k kernel code, 9292k reserved, 104k
data, 1137k bss,
 168k init)
Kernel virtual memory layout:
  * 0xfffdf000..0xfffff000  : fixmap
  * 0xfdfb6000..0xfe000000  : early ioremap
  * 0xc5000000..0xfdfb6000  : vmalloc & ioremap
SLUB: Genslabs=3D15, HWalign=3D32, Order=3D0-3, MinObjects=3D0, CPUs=3D1, No=
des=3D1
NR_IRQS:512 nr_irqs:512 16
No pci pic node in device tree.
clocksource: timebase mult[1dfc2974] shift[22] registered
console [ttyCPM0] enabled
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing PCI hardware
bio: create slab <bio-0> at 0
vgaarb: loaded
Switching to clocksource timebase
Switched to NOHz mode on CPU #0
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 2, 16384 bytes)
TCP bind hash table entries: 2048 (order: 1, 8192 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
UDP hash table entries: 256 (order: 0, 4096 bytes)
UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
NET: Registered protocol family 1
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RPC: Registered tcp NFSv4.1 backchannel transport module.
Trying to unpack rootfs image as initramfs...
rootfs image is not initramfs (no cpio magic); looks like an initrd
Freeing initrd memory: 3879k freed
msgmni has been set to 119
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler deadline registered
io scheduler cfq registered (default)
f0011a00.serial: ttyCPM0 at MMIO 0xc5014a00 (irq =3D 40) is a CPM UART
f0011a60.serial: ttyCPM1 at MMIO 0xc5018a60 (irq =3D 43) is a CPM UART
brd: module loaded
loop: module loaded
of-flash ff800000.flash: do_map_probe() failed
=3D=3D=3D=3D=3Draj gem init
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
eth0: fs_enet: 00:00:00:00:00:00
eth1: fs_enet: 00:00:00:00:00:00
CPM2 Bitbanged MII: probed
mousedev: PS/2 mouse device common for all mice
TCP cubic registered
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
RAMDISK: gzip image found at block 0
VFS: Mounted root (ext2 filesystem) on device 1:0.
Freeing unused kernel memory: 168k init
Mounting /proc and /sys
Setting the hostname to mpc837xemds
Mounting filesystems
mount: mounting usbfs on /proc/bus/usb failed: No such file or directory
Starting syslogd and klogd
Running sysctl
Setting up networking on loopback device:
Setting up networking on eth0:
SIOCSIFFLAGS: Cannot assign requested address
Adding static route for default gateway to 192.168.1.1:
SIOCADDRT: Network is unreachable
Setting nameserver to 192.168.1.1 in /etc/resolv.conf:
Setting up networking on eth1:
SIOCSIFFLAGS: Cannot assign requested address
Adding static route for default gateway to 192.168.1.1:
SIOCADDRT: Network is unreachable
Setting nameserver to 192.168.1.1 in /etc/resolv.conf:
Starting inetd:
Please set the system time using
    date <mmddhhmnyyyy>
    /sbin/hwclock -w


        Welcome to Freescale Semiconductor Embedded Linux Environment

!!!!! WARNING !!!!!!!

The default password for the root account is: root
please change this password using the 'passwd' command
and then edit this message (/etc/issue) to remove this message

mpc837xemds login: root
Password:
[root@mpc837xemds /root]#
[root@mpc837xemds /root]#
[root@mpc837xemds /root]#
[root@mpc837xemds /root]# cat /proc/interrupts
           CPU0
 40:         55  CPM2 SIU Level     cpm_uart
LOC:       3507   Local timer interrupts
SPU:          0   Spurious interrupts
CNT:          0   Performance monitoring interrupts
MCE:          0   Machine check exceptions
[root@mpc837xemds /root]# cat /proc/interrupts
           CPU0
 40:         67  CPM2 SIU Level     cpm_uart
LOC:       3536   Local timer interrupts
SPU:          0   Spurious interrupts
CNT:          0   Performance monitoring interrupts
MCE:          0   Machine check exceptions
[root@mpc837xemds /root]# ping localhost
PING localhost (127.0.0.1): 56 data bytes
64 bytes from 127.0.0.1: seq=3D0 ttl=3D64 time=3D1.803 ms
64 bytes from 127.0.0.1: seq=3D1 ttl=3D64 time=3D1.784 ms
64 bytes from 127.0.0.1: seq=3D2 ttl=3D64 time=3D1.190 ms
64 bytes from 127.0.0.1: seq=3D3 ttl=3D64 time=3D1.187 ms

--- localhost ping statistics ---
4 packets transmitted, 4 packets received, 0% packet loss
round-trip min/avg/max =3D 1.187/1.491/1.803 ms
[root@mpc837xemds /root]# cat /proc/interrupts
           CPU0
 40:        106  CPM2 SIU Level     cpm_uart
LOC:       3636   Local timer interrupts
SPU:          0   Spurious interrupts
CNT:          0   Performance monitoring interrupts
MCE:          0   Machine check exceptions
[root@mpc837xemds /root]# ping l
[root@mpc837xemds /root]# ifconfig
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:8 errors:0 dropped:0 overruns:0 frame:0
          TX packets:8 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:672 (672.0 b)  TX bytes:672 (672.0 b)

[root@mpc837xemds /root]# ifconfig eth0 up
SIOCSIFFLAGS: Cannot assign requested address
[root@mpc837xemds /root]# ifconfig -a
eth0      Link encap:Ethernet  HWaddr 00:00:00:00:00:00
          inet addr:192.168.1.100  Bcast:192.168.1.255
Mask:255.255.255.0
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

eth1      Link encap:Ethernet  HWaddr 00:00:00:00:00:00
          inet addr:192.168.1.101  Bcast:192.168.1.255
Mask:255.255.255.0
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:8 errors:0 dropped:0 overruns:0 frame:0
          TX packets:8 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:672 (672.0 b)  TX bytes:672 (672.0 b)

sit0      Link encap:UNSPEC  HWaddr
00-00-00-00-04-22-10-02-00-00-00-00-00-00-00-00
          NOARP  MTU:1480  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

[root@mpc837xemds /root]# ifconfig eth0 hw ether 00:00:00:00:00:01
[root@mpc837xemds /root]# ifconfig eth0 up
ADDRCONF(NETDEV_UP): eth0: link is not ready
[root@mpc837xemds /root]# ADDRCONF(NETDEV_CHANGE): eth0: link becomes
ready

[root@mpc837xemds /root]#
[root@mpc837xemds /root]#
[root@mpc837xemds /root]#
[root@mpc837xemds /root]# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:00:00:00:00:01
          inet addr:192.168.1.100  Bcast:192.168.1.255
Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:5
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:398 (398.0 b)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:8 errors:0 dropped:0 overruns:0 frame:0
          TX packets:8 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:672 (672.0 b)  TX bytes:672 (672.0 b)

[root@mpc837xemds /root]# ping 192.168.1.1
PING 192.168.1.1 (192.168.1.1): 56 data bytes

--- 192.168.1.1 ping statistics ---
3 packets transmitted, 0 packets received, 100% packet loss
[root@mpc837xemds /root]# cat /proc/interrupts
           CPU0
 32:          9  CPM2 SIU Level     fs_enet-mac
 40:        384  CPM2 SIU Level     cpm_uart
LOC:       4369   Local timer interrupts
SPU:          0   Spurious interrupts
CNT:          0   Performance monitoring interrupts
MCE:          0   Machine check exceptions
[root@mpc837xemds /root]#




Regards,
Smitha 

Please do not print this email unless it is absolutely necessary. =0A=
=0A=
The information contained in this electronic message and any attachments to=
 this message are intended for the exclusive use of the addressee(s) and may=
 contain proprietary, confidential or privileged information. If you are not=
 the intended recipient, you should not disseminate, distribute or copy this=
 e-mail. Please notify the sender immediately and destroy all copies of this=
 message and any attachments. =0A=
=0A=
WARNING: Computer viruses can be transmitted via email. The recipient should=
 check this email and any attachments for the presence of viruses. The compa=
ny accepts no liability for any damage caused by any virus transmitted by th=
is email. =0A=
=0A=
www.wipro.com

------_=_NextPart_001_01CC63B5.8546B44C
Content-Type: application/octet-stream;
	name="mpc8272ads.dts"
Content-Transfer-Encoding: base64
Content-Description: mpc8272ads.dts
Content-Disposition: attachment;
	filename="mpc8272ads.dts"

LyoKICogTVBDODI3MiBBRFMgRGV2aWNlIFRyZWUgU291cmNlCiAqCiAqIENvcHlyaWdodCAyMDA1
LDIwMDggRnJlZXNjYWxlIFNlbWljb25kdWN0b3IgSW5jLgogKgogKiBUaGlzIHByb2dyYW0gaXMg
ZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgIGl0IGFuZC9vciBtb2RpZnkgaXQK
ICogdW5kZXIgIHRoZSB0ZXJtcyBvZiAgdGhlIEdOVSBHZW5lcmFsICBQdWJsaWMgTGljZW5zZSBh
cyBwdWJsaXNoZWQgYnkgdGhlCiAqIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbjsgIGVpdGhlciB2
ZXJzaW9uIDIgb2YgdGhlICBMaWNlbnNlLCBvciAoYXQgeW91cgogKiBvcHRpb24pIGFueSBsYXRl
ciB2ZXJzaW9uLgogKi8KCi9kdHMtdjEvOwoKLyB7Cgltb2RlbCA9ICJNUEM4MjcyQURTIjsKCWNv
bXBhdGlibGUgPSAiZnNsLG1wYzgyNzJhZHMiOwoJI2FkZHJlc3MtY2VsbHMgPSA8MT47Cgkjc2l6
ZS1jZWxscyA9IDwxPjsKCglhbGlhc2VzIHsKCQlldGhlcm5ldDAgPSAmZXRoMDsKCQlldGhlcm5l
dDEgPSAmZXRoMTsKCQlzZXJpYWwwID0gJnNjYzE7CgkJc2VyaWFsMSA9ICZzY2M0OwoJfTsKCglj
cHVzIHsKCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKCQkjc2l6ZS1jZWxscyA9IDwwPjsKCgkJUG93
ZXJQQyw4MjQ3QDAgewoJCQlkZXZpY2VfdHlwZSA9ICJjcHUiOwoJCQlyZWcgPSA8MHgwPjsKCQkJ
ZC1jYWNoZS1saW5lLXNpemUgPSA8MzI+OwoJCQlpLWNhY2hlLWxpbmUtc2l6ZSA9IDwzMj47CgkJ
CWQtY2FjaGUtc2l6ZSA9IDwxNjM4ND47CgkJCWktY2FjaGUtc2l6ZSA9IDwxNjM4ND47CgkJCXRp
bWViYXNlLWZyZXF1ZW5jeSA9IDwwPjsKCQkJYnVzLWZyZXF1ZW5jeSA9IDwwPjsKCQkJY2xvY2st
ZnJlcXVlbmN5ID0gPDA+OwoJCX07Cgl9OwoKCW1lbW9yeSB7CgkJZGV2aWNlX3R5cGUgPSAibWVt
b3J5IjsKCQlyZWcgPSA8MHgwIDB4NDAwMDAwMD47Cgl9OwoKCWxvY2FsYnVzQGYwMDEwMTAwIHsK
CQljb21wYXRpYmxlID0gImZzbCxtcGM4MjcyLWxvY2FsYnVzIiwKCQkgICAgICAgICAgICAgImZz
bCxwcTItbG9jYWxidXMiOwoJCSNhZGRyZXNzLWNlbGxzID0gPDI+OwoJCSNzaXplLWNlbGxzID0g
PDE+OwoJCXJlZyA9IDwweGYwMDEwMTAwIDB4NDA+OwoKCQlyYW5nZXMgPSA8MHgwIDB4MCAweGZm
ODAwMDAwIDB4MDA4MDAwMDA+OwoJCSAgICAvKiAgICAgIDB4MSAweDAgMHhmNDUwMDAwMCAweDgw
MDAKCQkgICAgICAgICAgMHgzIDB4MCAweGY4MjAwMDAwIDB4ODAwMD47ICovCgoJCWZsYXNoQDAs
MCB7CgkJCWNvbXBhdGlibGUgPSAiamVkZWMtZmxhc2giOwoJCQlyZWcgPSA8MHgwIDB4MCAweDAw
ODAwMDAwPjsKCQkJYmFuay13aWR0aCA9IDw0PjsKCQkJZGV2aWNlLXdpZHRoID0gPDE+OwoJCX07
Ci8qCgkJYm9hcmQtY29udHJvbEAxLDAgewoJCQlyZWcgPSA8MHgxIDB4MCAweDIwPjsKCQkJY29t
cGF0aWJsZSA9ICJmc2wsbXBjODI3MmFkcy1iY3NyIjsKCQl9OwoKCQlQQ0lfUElDOiBpbnRlcnJ1
cHQtY29udHJvbGxlckAzLDAgewoJCQljb21wYXRpYmxlID0gImZzbCxtcGM4MjcyYWRzLXBjaS1w
aWMiLAoJCQkgICAgICAgICAgICAgImZzbCxwcTJhZHMtcGNpLXBpYyI7CgkJCSNpbnRlcnJ1cHQt
Y2VsbHMgPSA8MT47CgkJCWludGVycnVwdC1jb250cm9sbGVyOwoJCQlyZWcgPSA8MHgzIDB4MCAw
eDg+OwoJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZQSUM+OwoJCQlpbnRlcnJ1cHRzID0gPDIwIDg+
OwoJCX07CiovCX07CgovKgoJcGNpQGYwMDEwODAwIHsKCQlkZXZpY2VfdHlwZSA9ICJwY2kiOwoJ
CXJlZyA9IDwweGYwMDEwODAwIDB4MTBjIDB4ZjAwMTAxYWMgMHg4IDB4ZjAwMTAxYzQgMHg4PjsK
CQljb21wYXRpYmxlID0gImZzbCxtcGM4MjcyLXBjaSIsICJmc2wscHEyLXBjaSI7CgkJI2ludGVy
cnVwdC1jZWxscyA9IDwxPjsKCQkjc2l6ZS1jZWxscyA9IDwyPjsKCQkjYWRkcmVzcy1jZWxscyA9
IDwzPjsKCQljbG9jay1mcmVxdWVuY3kgPSA8NjY2NjY2NjY+OwoJCWludGVycnVwdC1tYXAtbWFz
ayA9IDwweGY4MDAgMHgwIDB4MCAweDc+OwoJCWludGVycnVwdC1tYXAgPSA8CgkJICAgICAgICAg
ICAgICAgICAvKiBJRFNFTCAweDE2IAoJCSAgICAgICAgICAgICAgICAgMHhiMDAwIDB4MCAweDAg
MHgxICZQQ0lfUElDIDAKCQkgICAgICAgICAgICAgICAgIDB4YjAwMCAweDAgMHgwIDB4MiAmUENJ
X1BJQyAxCgkJICAgICAgICAgICAgICAgICAweGIwMDAgMHgwIDB4MCAweDMgJlBDSV9QSUMgMgoJ
CSAgICAgICAgICAgICAgICAgMHhiMDAwIDB4MCAweDAgMHg0ICZQQ0lfUElDIDMKCgkJICAgICAg
ICAgICAgICAgICAvKiBJRFNFTCAweDE3IAoJCSAgICAgICAgICAgICAgICAgMHhiODAwIDB4MCAw
eDAgMHgxICZQQ0lfUElDIDQKCQkgICAgICAgICAgICAgICAgIDB4YjgwMCAweDAgMHgwIDB4MiAm
UENJX1BJQyA1CgkJICAgICAgICAgICAgICAgICAweGI4MDAgMHgwIDB4MCAweDMgJlBDSV9QSUMg
NgoJCSAgICAgICAgICAgICAgICAgMHhiODAwIDB4MCAweDAgMHg0ICZQQ0lfUElDIDcKCgkJICAg
ICAgICAgICAgICAgICAvKiBJRFNFTCAweDE4IAoJCSAgICAgICAgICAgICAgICAgMHhjMDAwIDB4
MCAweDAgMHgxICZQQ0lfUElDIDgKCQkgICAgICAgICAgICAgICAgIDB4YzAwMCAweDAgMHgwIDB4
MiAmUENJX1BJQyA5CgkJICAgICAgICAgICAgICAgICAweGMwMDAgMHgwIDB4MCAweDMgJlBDSV9Q
SUMgMTAKCQkgICAgICAgICAgICAgICAgIDB4YzAwMCAweDAgMHgwIDB4NCAmUENJX1BJQyAxMT47
CgoJCWludGVycnVwdC1wYXJlbnQgPSA8JlBJQz47CgkJaW50ZXJydXB0cyA9IDwxOCA4PjsKCQly
YW5nZXMgPSA8MHg0MjAwMDAwMCAweDAgMHg4MDAwMDAwMCAweDgwMDAwMDAwIDB4MCAweDIwMDAw
MDAwCgkJICAgICAgICAgIDB4MjAwMDAwMCAweDAgMHhhMDAwMDAwMCAweGEwMDAwMDAwIDB4MCAw
eDIwMDAwMDAwCgkJICAgICAgICAgIDB4MTAwMDAwMCAweDAgMHgwIDB4ZjYwMDAwMDAgMHgwIDB4
MjAwMDAwMD47Cgl9OwoqLwoJc29jQGYwMDAwMDAwIHsKCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsK
CQkjc2l6ZS1jZWxscyA9IDwxPjsKCQlkZXZpY2VfdHlwZSA9ICJzb2MiOwoJCWNvbXBhdGlibGUg
PSAiZnNsLG1wYzgyNzIiLCAiZnNsLHBxMi1zb2MiOwoJCXJhbmdlcyA9IDwweDAgMHhmMDAwMDAw
MCAweDUzMDAwPjsKCgkJLy8gVGVtcG9yYXJ5IC0tIHdpbGwgZ28gYXdheSBvbmNlIGtlcm5lbCB1
c2VzIHJhbmdlcyBmb3IgZ2V0X2ltbXJiYXNlKCkuCgkJcmVnID0gPDB4ZjAwMDAwMDAgMHg1MzAw
MD47CgoJCWNwbUAxMTljMCB7CgkJCSNhZGRyZXNzLWNlbGxzID0gPDE+OwoJCQkjc2l6ZS1jZWxs
cyA9IDwxPjsKCQkJY29tcGF0aWJsZSA9ICJmc2wsbXBjODI3Mi1jcG0iLCAiZnNsLGNwbTIiOwoJ
CQlyZWcgPSA8MHgxMTljMCAweDMwPjsKCQkJcmFuZ2VzOwoKCQkJbXVyYW1AMCB7CgkJCQkjYWRk
cmVzcy1jZWxscyA9IDwxPjsKCQkJCSNzaXplLWNlbGxzID0gPDE+OwoJCQkJcmFuZ2VzID0gPDB4
MCAweDAgMHgxMDAwMD47CgoJCQkJZGF0YUAwIHsKCQkJCQljb21wYXRpYmxlID0gImZzbCxjcG0t
bXVyYW0tZGF0YSI7CgkJCQkJcmVnID0gPDB4MCAweDIwMDAgMHg5ODAwIDB4ODAwPjsKCQkJCX07
CgkJCX07CgoJCQlicmdAMTE5ZjAgewoJCQkJY29tcGF0aWJsZSA9ICJmc2wsbXBjODI3Mi1icmci
LAoJCQkJICAgICAgICAgICAgICJmc2wsY3BtMi1icmciLAoJCQkJICAgICAgICAgICAgICJmc2ws
Y3BtLWJyZyI7CgkJCQlyZWcgPSA8MHgxMTlmMCAweDEwIDB4MTE1ZjAgMHgxMD47CgkJCX07CgoJ
CQlzY2MxOiBzZXJpYWxAMTFhMDAgewoJCQkJZGV2aWNlX3R5cGUgPSAic2VyaWFsIjsKCQkJCWNv
bXBhdGlibGUgPSAiZnNsLG1wYzgyNzItc2NjLXVhcnQiLAoJCQkJICAgICAgICAgICAgICJmc2ws
Y3BtMi1zY2MtdWFydCI7CgkJCQlyZWcgPSA8MHgxMWEwMCAweDIwIDB4ODAwMCAweDEwMD47CgkJ
CQlpbnRlcnJ1cHRzID0gPDQwIDg+OwoJCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmUElDPjsKCQkJ
CWZzbCxjcG0tYnJnID0gPDE+OwoJCQkJZnNsLGNwbS1jb21tYW5kID0gPDB4ODAwMDAwPjsKCQkJ
fTsKCgkJCXNjYzQ6IHNlcmlhbEAxMWE2MCB7CgkJCQlkZXZpY2VfdHlwZSA9ICJzZXJpYWwiOwoJ
CQkJY29tcGF0aWJsZSA9ICJmc2wsbXBjODI3Mi1zY2MtdWFydCIsCgkJCQkgICAgICAgICAgICAg
ImZzbCxjcG0yLXNjYy11YXJ0IjsKCQkJCXJlZyA9IDwweDExYTYwIDB4MjAgMHg4MzAwIDB4MTAw
PjsKCQkJCWludGVycnVwdHMgPSA8NDMgOD47CgkJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZQSUM+
OwoJCQkJZnNsLGNwbS1icmcgPSA8ND47CgkJCQlmc2wsY3BtLWNvbW1hbmQgPSA8MHhjZTAwMDAw
PjsKCQkJfTsKCgkJLyoJdXNiQDExYjYwIHsKCQkJCWNvbXBhdGlibGUgPSAiZnNsLG1wYzgyNzIt
Y3BtLXVzYiI7CgkJCQlyZWcgPSA8MHgxMWI2MCAweDQwIDB4OGIwMCAweDEwMD47CgkJCQlpbnRl
cnJ1cHRzID0gPDExIDg+OwoJCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmUElDPjsKCQkJCW1vZGUg
PSAicGVyaXBoZXJhbCI7CgkJCX07ICovCgoJCQltZGlvQDEwZDQwIHsKCQkJCWRldmljZV90eXBl
ID0gIm1kaW8iOwoJCQkJY29tcGF0aWJsZSA9ICJmc2wsbXBjODI3MmFkcy1tZGlvLWJpdGJhbmci
LAoJCQkJICAgICAgICAgICAgICJmc2wsbXBjODI3Mi1tZGlvLWJpdGJhbmciLAoJCQkJICAgICAg
ICAgICAgICJmc2wsY3BtMi1tZGlvLWJpdGJhbmciOwoJCQkJcmVnID0gPDB4MTBkNDAgMHgxND47
CgkJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKCQkJCSNzaXplLWNlbGxzID0gPDA+OwoJCQkJZnNs
LG1kaW8tcGluID0gPDIzPjsgCgkJCQlmc2wsbWRjLXBpbiA9IDwyMj47IAoKCQkJCVBIWTA6IGV0
aGVybmV0LXBoeUAwIHsKCQkJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZQSUM+OwoJCQkJCWludGVy
cnVwdHMgPSA8MjMgOD47CgkJCQkJcmVnID0gPDB4MD47CgkJCQkJZGV2aWNlX3R5cGUgPSAiZXRo
ZXJuZXQtcGh5IjsKCQkJCX07CgoJCQkJUEhZMTogZXRoZXJuZXQtcGh5QDEgewoJCQkJCWludGVy
cnVwdC1wYXJlbnQgPSA8JlBJQz47CgkJCQkJaW50ZXJydXB0cyA9IDwyMyA4PjsKCQkJCQlyZWcg
PSA8MHgzPjsKCQkJCQlkZXZpY2VfdHlwZSA9ICJldGhlcm5ldC1waHkiOwoJCQkJfTsKCQkJfTsK
CgkJCWV0aDA6IGV0aGVybmV0QDExMzAwIHsKCQkJCWRldmljZV90eXBlID0gIm5ldHdvcmsiOwoJ
CQkJY29tcGF0aWJsZSA9ICJmc2wsbXBjODI3Mi1mY2MtZW5ldCIsCgkJCQkgICAgICAgICAgICAg
ImZzbCxjcG0yLWZjYy1lbmV0IjsKCQkJCXJlZyA9IDwweDExMzAwIDB4MjAgMHg4NDAwIDB4MTAw
IDB4MTEzOTAgMHgxPjsKCQkJCWxvY2FsLW1hYy1hZGRyZXNzID0gWyAwMCAwMCAwMCAwMCAwMCAw
MCBdOwoJCQkJaW50ZXJydXB0cyA9IDwzMiA4PjsKCQkJCWludGVycnVwdC1wYXJlbnQgPSA8JlBJ
Qz47CgkJCQlwaHktaGFuZGxlID0gPCZQSFkwPjsKCQkJCWxpbnV4LG5ldHdvcmstaW5kZXggPSA8
MD47CgkJCQlmc2wsY3BtLWNvbW1hbmQgPSA8MHgxMjAwMDMwMD47CgkJCX07CgoJCQlldGgxOiBl
dGhlcm5ldEAxMTMyMCB7CgkJCQlkZXZpY2VfdHlwZSA9ICJuZXR3b3JrIjsKCQkJCWNvbXBhdGli
bGUgPSAiZnNsLG1wYzgyNzItZmNjLWVuZXQiLAoJCQkJICAgICAgICAgICAgICJmc2wsY3BtMi1m
Y2MtZW5ldCI7CgkJCQlyZWcgPSA8MHgxMTMyMCAweDIwIDB4ODUwMCAweDEwMCAweDExM2IwIDB4
MT47CgkJCQlsb2NhbC1tYWMtYWRkcmVzcyA9IFsgMDAgMDAgMDAgMDAgMDAgMDAgXTsKCQkJCWlu
dGVycnVwdHMgPSA8MzMgOD47CgkJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZQSUM+OwoJCQkJcGh5
LWhhbmRsZSA9IDwmUEhZMT47CgkJCQlsaW51eCxuZXR3b3JrLWluZGV4ID0gPDE+OwoJCQkJZnNs
LGNwbS1jb21tYW5kID0gPDB4MTYyMDAzMDA+OwoJCQl9OwoKCQkJaTJjQDExODYwIHsKCQkJCWNv
bXBhdGlibGUgPSAiZnNsLG1wYzgyNzItaTJjIiwKCQkJCQkgICAgICJmc2wsY3BtMi1pMmMiOwoJ
CQkJcmVnID0gPDB4MTE4NjAgMHgyMCAweDhhZmMgMHgyPjsKCQkJCWludGVycnVwdHMgPSA8MSA4
PjsKCQkJCWludGVycnVwdC1wYXJlbnQgPSA8JlBJQz47CgkJCQlmc2wsY3BtLWNvbW1hbmQgPSA8
MHgyOTYwMDAwMD47CgkJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKCQkJCSNzaXplLWNlbGxzID0g
PDA+OwoJCQl9OwoJCX07CgoJCVBJQzogaW50ZXJydXB0LWNvbnRyb2xsZXJAMTBjMDAgewoJCQkj
aW50ZXJydXB0LWNlbGxzID0gPDI+OwoJCQlpbnRlcnJ1cHQtY29udHJvbGxlcjsKCQkJcmVnID0g
PDB4MTBjMDAgMHg4MD47CgkJCWNvbXBhdGlibGUgPSAiZnNsLG1wYzgyNzItcGljIiwgImZzbCxj
cG0yLXBpYyI7CgkJfTsKCgkJY3J5cHRvQDMwMDAwIHsKCQkJY29tcGF0aWJsZSA9ICJmc2wsc2Vj
MS4wIjsKCQkJcmVnID0gPDB4NDAwMDAgMHgxMzAwMD47CgkJCWludGVycnVwdHMgPSA8NDcgMHg4
PjsKCQkJaW50ZXJydXB0LXBhcmVudCA9IDwmUElDPjsKCQkJZnNsLG51bS1jaGFubmVscyA9IDw0
PjsKCQkJZnNsLGNoYW5uZWwtZmlmby1sZW4gPSA8MjQ+OwoJCQlmc2wsZXhlYy11bml0cy1tYXNr
ID0gPDB4N2U+OwoJCQlmc2wsZGVzY3JpcHRvci10eXBlcy1tYXNrID0gPDB4MTAxMDQxNT47CgkJ
fTsKCX07CgoJY2hvc2VuIHsKCQlsaW51eCxzdGRvdXQtcGF0aCA9ICIvc29jL2NwbS9zZXJpYWxA
MTFhMDAiOwoJfTsKfTsK

------_=_NextPart_001_01CC63B5.8546B44C--
