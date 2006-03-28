Return-Path: <Phil.Nitschke@avalon.com.au>
Received: from camden.avalon.com.au (unknown [150.101.131.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8757C67A63
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Mar 2006 15:21:31 +1100 (EST)
Subject: Re: Memory mapping PCI memory region to user space
From: Phil Nitschke <Phil.Nitschke@avalon.com.au>
To: David Hawkins <dwh@ovro.caltech.edu>
In-Reply-To: <44280D45.7090103@ovro.caltech.edu>
References: <B1E46DE837A394458BB1A58F74A66A780596CB@ala-mail02.corp.ad.wrs.com>
	<204E7000-3E88-4497-86C0-5AF786D72F75@kernel.crashing.org>
	<1143446542.24304.8.camel@lamorak.int.avalon.com.au>
	<44280D45.7090103@ovro.caltech.edu>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 14:51:00 +1030
Message-Id: <1143519660.24304.18.camel@lamorak.int.avalon.com.au>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: Phil.Nitschke@avalon.com.au
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 2006-03-27 at 08:05 -0800, David Hawkins wrote:
>
> Try building an insmodding the pci_io driver I posted, it'll pick
> up the two BAR regions and allow you to access them, and you can
> add more debugging comments to that code fairly easily.

> http://www.ovro.caltech.edu/~dwh/pci_io.tar.gz

Hi Dave,

I tried your program briefly, but (I guess) since I'm not using udev,
the program failed rather early, and I didn't persist for too long.
I've attached a log of the session below.  

(I used it on a commercial VME carrier board with a PmPPC7448 PMC module
and a PMC FPDP module, and a recent 2.6.16 kernel.org kernel built for
PPC. I used the ELDK4 NFS filesystem.)

-- 
Phil Nitschke <Phil.Nitschke@avalon.com.au>
Avalon Systems Pty Ltd


Linux 2.6.16-pmppc744x (arty5) (13:01 on Tuesday, 28 March 2006)

login: root
Last login: Tue Mar 28 13:00:32 from 192.168.1.14
bash-3.00# mount
/dev/nfs on / type nfs (rw)
none on /proc type proc (rw)
none on /sys type sysfs (rw)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
bash-3.00# lsmod
Module                  Size  Used by
bash-3.00# lspci -v 
00:01.0 Class 0680: 10e3:0148 (rev 01)
	Subsystem: 10e3:0000
	Flags: bus master, 66Mhz, medium devsel, latency 128, IRQ 71
	Memory at 000000009ffff000 (64-bit, non-prefetchable) [size=4K]
	Capabilities: [40] PCI-X non-bridge device.

00:02.0 Class 1100: 129a:dd11 (rev 01)
	Subsystem: 129a:dd11
	Flags: bus master, medium devsel, latency 128, IRQ 72
	Memory at 000000009f000000 (32-bit, prefetchable) [size=8M]
	Memory at 000000009e800000 (32-bit, non-prefetchable) [size=8M]

bash-3.00# mknod /dev/pci_00:02.0_0 c 254 0
bash-3.00# insmod /lib/modules/2.6.16-pmppc744x/misc/pci_io.ko major=254
bash-3.00# tail -6 /var/log/messages 
Mar 28 13:04:24 arty5 ntpd[236]: kernel time sync disabled 0041
Mar 28 13:04:51 arty5 kernel: pci_io: <init>
Mar 28 13:04:51 arty5 kernel: pci_io: register the PCI driver
Mar 28 13:04:51 arty5 kernel: pci_io: PCI registration succeeded
(returned 0)
Mar 28 13:04:51 arty5 kernel: pci_io: module loaded
Mar 28 13:05:29 arty5 ntpd[236]: kernel time sync enabled 0001
bash-3.00# ls -la  /sys/module/pci_io/parameters/
total 0
drwxr-xr-x  2 root root    0 Mar 28 13:04 .
drwxr-xr-x  4 root root    0 Mar 28 13:04 ..
-r--r--r--  1 root root 4096 Mar 28 13:22 debug
-r--r--r--  1 root root 4096 Mar 28 13:22 major
-r--r--r--  1 root root 4096 Mar 28 13:22 search
bash-3.00# cat /sys/module/pci_io/parameters/debug
1
bash-3.00# cat /sys/module/pci_io/parameters/major 
254
bash-3.00# cat /sys/module/pci_io/parameters/search 
0
bash-3.00# pci_debug -s 00:02.0 -e
Open device /dev/pci_00:02.0_0
Device open failed: errno 6, No such device or address
bash-3.00# rmmod pci_io
bash-3.00# insmod /lib/modules/2.6.16-pmppc744x/misc/pci_io.ko major=254
search=1
bash-3.00# tail -6 /var/log/messages 
Mar 28 13:24:03 arty5 kernel: pci_io: <init>
Mar 28 13:24:03 arty5 kernel: pci_io: search for 1 specified PCI IDs
Mar 28 13:24:03 arty5 kernel: pci_io: device 10b5:10b5 was not found
Mar 28 13:24:03 arty5 kernel: pci_io: register the PCI driver
Mar 28 13:24:03 arty5 kernel: pci_io: PCI registration succeeded
(returned 0)
Mar 28 13:24:03 arty5 kernel: pci_io: module loaded
bash-3.00# pci_debug -s 00:02.0 -e
Open device /dev/pci_00:02.0_0
Device open failed: errno 6, No such device or address
