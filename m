Return-Path: <yangtze31@gmail.com>
Received: from nproxy.gmail.com (nproxy.gmail.com [64.233.182.206])
	by ozlabs.org (Postfix) with ESMTP id 673DD6868F
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Nov 2005 09:04:59 +1100 (EST)
Received: by nproxy.gmail.com with SMTP id n28so32931nfc
	for <linuxppc-dev@ozlabs.org>; Sat, 05 Nov 2005 14:04:58 -0800 (PST)
Message-ID: <51ad2e0d0511051358p2fe15f1i7278615996183eb1@mail.gmail.com>
Date: Sat, 5 Nov 2005 22:58:37 +0100
From: Bin Zhang <yangtze31@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1130999620.4680.28.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1130999620.4680.28.camel@gaston>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: 2.6.14 USB vs. sleep issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/3/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> For those who experience crashes on sleep and/or wakeup (typically due
> to USB) with 2.6.14, I made a test patch that might help. Please let me
> know if it makes things more reliable.
>
I've tried your patch with usb wifi dlink dwl-g122 (my eth1). It works.
There are some differences in /var/log/syslog :
-----------------------
resume without your patch :

Nov  5 22:39:27 localhost anacron[5244]: Anacron 2.3 started on 2005-11-05
Nov  5 22:39:27 localhost anacron[5244]: Normal exit (0 jobs run)
Nov  5 22:39:27 localhost /usr/sbin/gpm[5268]: oops() invoked from gpn.c(20=
5)
Nov  5 22:39:27 localhost /usr/sbin/gpm[5268]: /var/run/gpm.pid: No
such file or directory
Nov  5 22:39:28 localhost pbbuttonsd: INFO: Script
'/etc/power/pmcs-pbbuttonsd suspend ac ram' launched and exited
normally
Nov  5 22:39:28 localhost kernel: ural 4-1:1.0: resume is unsafe!
Nov  5 22:39:28 localhost kernel: usb 4-1: no poweroff yet, suspending inst=
ead
Nov  5 22:39:28 localhost kernel: failed to set volume
Nov  5 22:39:28 localhost kernel: usb usb4: no poweroff yet, suspending ins=
tead
Nov  5 22:39:28 localhost kernel: usb 1-1: no poweroff yet, suspending inst=
ead
Nov  5 22:39:28 localhost kernel: usb usb3: no poweroff yet, suspending ins=
tead
Nov  5 22:39:28 localhost kernel: usb usb2: no poweroff yet, suspending ins=
tead
Nov  5 22:39:28 localhost kernel: usb usb1: no poweroff yet, suspending ins=
tead
Nov  5 22:39:29 localhost kernel: eth0: suspending, WakeOnLan disabled
Nov  5 22:39:29 localhost kernel: radeonfb (0000:00:10.0): suspending
to state: 2...
Nov  5 22:39:29 localhost kernel: uninorth-agp: disabling AGP on
device 0000:00:10.0
Nov  5 22:39:29 localhost kernel: uninorth-agp: disabling AGP on
bridge 0000:00:0b.0
Nov  5 22:39:29 localhost kernel: radeonfb (0000:00:10.0): resuming
from state: 2...
Nov  5 22:39:29 localhost kernel: PCI: Enabling device 0000:00:10.0
(0000 -> 0003)
Nov  5 22:39:29 localhost kernel: radeon: PAD_CTLR_STRENGTH doesn't stabili=
ze !
Nov  5 22:39:29 localhost kernel: agpgart: Putting AGP V2 device at
0000:00:0b.0 into 4x mode
Nov  5 22:39:29 localhost kernel: agpgart: Putting AGP V2 device at
0000:00:10.0 into 4x mode
Nov  5 22:39:29 localhost kernel: PCI: Enabling device 0001:10:1b.0
(0000 -> 0002)
Nov  5 22:39:29 localhost kernel: PCI: Enabling device 0001:10:1b.1
(0000 -> 0002)
Nov  5 22:39:29 localhost kernel: PCI: Enabling device 0001:10:1b.2
(0000 -> 0002)
Nov  5 22:39:29 localhost kernel: ehci_hcd 0001:10:1b.2: park 0
Nov  5 22:39:29 localhost kernel: ehci_hcd 0001:10:1b.2: USB 2.0
restarted, EHCI 1.00, driver 10 Dec 2004
Nov  5 22:39:31 localhost kernel: eth0: resuming
Nov  5 22:39:31 localhost kernel: PHY ID: 4061e4, addr: 0
Nov  5 22:39:32 localhost kernel: hda: Enabling Ultra DMA 5
Nov  5 22:39:32 localhost kernel: hdc: Enabling MultiWord DMA 2
Nov  5 22:39:32 localhost dhclient: receive_packet failed on eth1:
Network is down
Nov  5 22:39:32 localhost kernel: usb 4-1: USB disconnect, address 3
Nov  5 22:39:32 localhost kernel: usb 4-1: new high speed USB device
using ehci_hcd and address 4
Nov  5 22:39:32 localhost postfix/postfix-script: refreshing the
Postfix mail system
Nov  5 22:39:32 localhost postfix/master[3972]: reload configuration
/etc/postfix
Nov  5 22:39:32 localhost kernel: ural_eeprom_read: 4 -> 00:11:95:87:2c:ad
Nov  5 22:39:32 localhost kernel: eth1: 11b rates: 1Mbps 2Mbps 5.5Mbps 11Mb=
ps
Nov  5 22:39:32 localhost kernel: eth1: 11g rates: 1Mbps 2Mbps 5.5Mbps
11Mbps 6Mbps 9Mbps 12Mbps 18Mbps 24Mbps 36Mbps 48Mbps 54Mbps
Nov  5 22:39:32 localhost kernel: eth1: RT2570 (rev 0x03), RF RT2526,
ether 00:11:95:87:2c:ad at usb-0001:10:1b.2-1
Nov  5 22:39:39 localhost kernel: adb: starting probe task...
Nov  5 22:39:39 localhost dhclient: Internet Software Consortium DHCP
Client 2.0pl5
Nov  5 22:39:39 localhost dhclient: Copyright 1995, 1996, 1997, 1998,
1999 The Internet Software Consortium.
Nov  5 22:39:39 localhost dhclient: All rights reserved.
Nov  5 22:39:39 localhost dhclient:
Nov  5 22:39:39 localhost dhclient: Please contribute if you find this
software useful.
Nov  5 22:39:39 localhost dhclient: For info, please visit
http://www.isc.org/dhcp-contrib.html
Nov  5 22:39:39 localhost dhclient:
Nov  5 22:39:39 localhost dhclient: sit0: unknown hardware address type 776
Nov  5 22:39:39 localhost kernel: ural_set_macaddr: 00:11:95:87:2c:ad
Nov  5 22:39:39 localhost kernel: setting MAC address to 00:11:95:87:2c:ad
Nov  5 22:39:39 localhost kernel: leaving promiscuous mode
Nov  5 22:39:39 localhost kernel: ural_set_macaddr: 00:11:95:87:2c:ad
Nov  5 22:39:39 localhost kernel: setting MAC address to 00:11:95:87:2c:ad
Nov  5 22:39:39 localhost kernel: adb devices: [2]: 2 c4 [3]: 3 1 [7]: 7 1f
Nov  5 22:39:39 localhost kernel: ADB keyboard at 2, handler 1
Nov  5 22:39:39 localhost kernel: ADB mouse at 3, handler set to 4 (trackpa=
d)
Nov  5 22:39:39 localhost kernel: adb: finished probe task...
Nov  5 22:39:39 localhost kernel: agpgart: Putting AGP V2 device at
0000:00:0b.0 into 4x mode
Nov  5 22:39:39 localhost kernel: agpgart: Putting AGP V2 device at
0000:00:10.0 into 4x mode
Nov  5 22:39:39 localhost kernel: [drm] Loading R200 Microcode
Nov  5 22:39:39 localhost ifd[5442]: starting
Nov  5 22:39:39 localhost ifd[5442]: executing:
'/usr/share/laptop-net/link-change eth0 managed unknown
up,running,disconnected'
Nov  5 22:39:39 localhost ifd: PID file written: /var/run/ifd.pid
Nov  5 22:39:39 localhost pbbuttonsd: INFO: Script
'/etc/power/pmcs-pbbuttonsd resume ac ram' launched and exited
normally
Nov  5 22:39:39 localhost laptop-net: Stopping network interface "eth0"
Nov  5 22:39:40 localhost dhclient: sit0: unknown hardware address type 776
Nov  5 22:39:40 localhost dhclient: Listening on LPF/eth1/00:11:95:87:2c:ad
Nov  5 22:39:40 localhost dhclient: Sending on   LPF/eth1/00:11:95:87:2c:ad
Nov  5 22:39:40 localhost dhclient: Sending on   Socket/fallback/fallback-n=
et
Nov  5 22:39:40 localhost dhclient: DHCPREQUEST on eth1 to
255.255.255.255 port 67
Nov  5 22:39:42 localhost kernel: ural_set_macaddr: 00:11:95:87:2c:ad
Nov  5 22:39:42 localhost kernel: setting MAC address to 00:11:95:87:2c:ad
Nov  5 22:39:42 localhost kernel: ural_set_macaddr: 00:11:95:87:2c:ad
Nov  5 22:39:42 localhost kernel: setting MAC address to 00:11:95:87:2c:ad
Nov  5 22:39:42 localhost kernel: ural_set_macaddr: 00:11:95:87:2c:ad
Nov  5 22:39:42 localhost kernel: setting MAC address to 00:11:95:87:2c:ad
Nov  5 22:39:44 localhost dhclient: DHCPREQUEST on eth1 to
255.255.255.255 port 67
Nov  5 22:39:45 localhost kernel: setting BSSID to 00:11:95:36:fc:f7
Nov  5 22:39:45 localhost kernel: enabling TSF synchronization
Nov  5 22:39:49 localhost kernel: eth1: no IPv6 routers present
Nov  5 22:39:53 localhost dhclient: DHCPDISCOVER on eth1 to
255.255.255.255 port 67 interval 5
Nov  5 22:39:53 localhost dhclient: DHCPOFFER from 192.168.0.1
Nov  5 22:39:55 localhost dhclient: DHCPREQUEST on eth1 to
255.255.255.255 port 67
Nov  5 22:39:55 localhost dhclient: DHCPACK from 192.168.0.1
Nov  5 22:39:55 localhost kernel: leaving promiscuous mode
Nov  5 22:39:55 localhost kernel: leaving promiscuous mode
Nov  5 22:39:56 localhost postfix/postfix-script: refreshing the
Postfix mail system
Nov  5 22:39:56 localhost postfix/master[3972]: reload configuration
/etc/postfix
Nov  5 22:39:56 localhost dhclient: bound to 192.168.0.101 -- renewal
in 302400 seconds.
Nov  5 22:39:56 localhost ifd[5442]: + cat:
/var/run/dhclient.eth0.pid: No such file or directory
Nov  5 22:40:08 localhost kernel: eth0: no IPv6 routers present
--------------------------------------

----------------------------------
resume with your patch :

Nov  5 22:28:21 localhost anacron[6603]: Anacron 2.3 started on 2005-11-05
Nov  5 22:28:21 localhost anacron[6603]: Normal exit (0 jobs run)
Nov  5 22:28:21 localhost /usr/sbin/gpm[6627]: oops() invoked from gpn.c(20=
5)
Nov  5 22:28:21 localhost /usr/sbin/gpm[6627]: /var/run/gpm.pid: No
such file or directory
Nov  5 22:28:21 localhost pbbuttonsd: INFO: Script
'/etc/power/pmcs-pbbuttonsd suspend ac ram' launched and exited
normally
Nov  5 22:28:22 localhost kernel: ural 2-1:1.0: resume is unsafe!
Nov  5 22:28:22 localhost kernel: usb 2-1: no poweroff yet, suspending inst=
ead
Nov  5 22:28:22 localhost kernel: failed to set volume
Nov  5 22:28:22 localhost kernel: usb 1-1: no poweroff yet, suspending inst=
ead
Nov  5 22:28:22 localhost kernel: usb usb3: no poweroff yet, suspending ins=
tead
Nov  5 22:28:22 localhost kernel: usb usb2: no poweroff yet, suspending ins=
tead
Nov  5 22:28:22 localhost kernel: usb usb1: no poweroff yet, suspending ins=
tead
Nov  5 22:28:22 localhost kernel: eth0: suspending, WakeOnLan disabled
Nov  5 22:28:22 localhost kernel: radeonfb (0000:00:10.0): suspending
to state: 2...
Nov  5 22:28:22 localhost kernel: uninorth-agp: disabling AGP on
device 0000:00:10.0
Nov  5 22:28:22 localhost kernel: uninorth-agp: disabling AGP on
bridge 0000:00:0b.0
Nov  5 22:28:23 localhost kernel: radeonfb (0000:00:10.0): resuming
from state: 2...
Nov  5 22:28:23 localhost kernel: PCI: Enabling device 0000:00:10.0
(0000 -> 0003)
Nov  5 22:28:23 localhost kernel: radeon: PAD_CTLR_STRENGTH doesn't stabili=
ze !
Nov  5 22:28:23 localhost kernel: agpgart: Putting AGP V2 device at
0000:00:0b.0 into 4x mode
Nov  5 22:28:23 localhost kernel: agpgart: Putting AGP V2 device at
0000:00:10.0 into 4x mode
Nov  5 22:28:23 localhost kernel: PCI: Enabling device 0001:10:1b.0
(0000 -> 0002)
Nov  5 22:28:23 localhost kernel: PCI: Enabling device 0001:10:1b.1
(0000 -> 0002)
Nov  5 22:28:24 localhost kernel: eth0: resuming
Nov  5 22:28:24 localhost kernel: PHY ID: 4061e4, addr: 0
Nov  5 22:28:25 localhost kernel: hda: Enabling Ultra DMA 5
Nov  5 22:28:25 localhost kernel: hdc: Enabling MultiWord DMA 2
Nov  5 22:28:38 localhost kernel: adb: starting probe task...
Nov  5 22:28:38 localhost kernel: adb devices: [2]: 2 c4 [3]: 3 1 [7]: 7 1f
Nov  5 22:28:38 localhost kernel: ADB keyboard at 2, handler 1
Nov  5 22:28:38 localhost kernel: ADB mouse at 3, handler set to 4 (trackpa=
d)
Nov  5 22:28:38 localhost kernel: adb: finished probe task...
Nov  5 22:28:38 localhost kernel: agpgart: Putting AGP V2 device at
0000:00:0b.0 into 4x mode
Nov  5 22:28:38 localhost kernel: agpgart: Putting AGP V2 device at
0000:00:10.0 into 4x mode
Nov  5 22:28:38 localhost kernel: [drm] Loading R200 Microcode
Nov  5 22:28:38 localhost ifd[6680]: starting
Nov  5 22:28:38 localhost ifd[6680]: executing:
'/usr/share/laptop-net/link-change eth0 managed unknown
up,running,disconnected'
Nov  5 22:28:38 localhost ifd: PID file written: /var/run/ifd.pid
Nov  5 22:28:38 localhost pbbuttonsd: INFO: Script
'/etc/power/pmcs-pbbuttonsd resume ac ram' launched and exited
normally
Nov  5 22:28:39 localhost laptop-net: Stopping network interface "eth0"
Nov  5 22:28:39 localhost ifd[6680]: + cat:
/var/run/dhclient.eth0.pid: No such file or directory
Nov  5 22:28:50 localhost kernel: eth0: no IPv6 routers present
-------------------------------------------------------------------

Thanks,
Bin


> http://gate.crashing.org/~benh/fix-ohci-sleep.diff
>
> Note that the patch is totally untested here so it may be just plain
> bogus :)
>
> Ben.
>
>
>
> --
> To UNSUBSCRIBE, email to debian-powerpc-REQUEST@lists.debian.org
> with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian=
.org
>
>
