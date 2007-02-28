Return-Path: <devtty0@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id F1181DDECC
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Mar 2007 07:55:43 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so215392ugf
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2007 12:55:42 -0800 (PST)
Message-ID: <45E5ED35.7090207@gmail.com>
Date: Wed, 28 Feb 2007 21:59:33 +0100
From: Luotao Fu <devtty0@gmail.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: problems with pci bus on a pm520 board
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Folks,
I'm having trouble with the pci bus on a microsys pm520 (with
mpc5200b) board the last days. There're a Ethernet controller (gd82551,
supported by intel e100 driver) and an USB controller (philips isp1536bm
philips, supported by hcd-ohci) on the pci bus. mpc52xx_pci is compiled
in. I modified the interrupt map in the device tree, so that the pci bus
got correctly scanned. If I don't activate any device driver except the
one for the host bridge, the system starts correctly and the sysfs pci
bus get the correct entries, which looks like this:

root@testboard:~ ls /sys/bus/pci/devices/
0000:00:10.0  0000:00:11.0  0000:00:11.1  0000:00:11.2  0000:00:12.0

while 10.0 ist the ethernet controller, 11.* is the usb controller and
12.0 is the hostbridge. Seemed to me that the mpc52xx pci driver is
working properly. However, if I compile the usb driver in and try to
boot. The system stucks somewhere at ohci_init or ohci_run without doing
anything till I switch the power off. I attached a bdi to the system and
found out that the system always stucks at the instruction lwbrx, which
is called by ohci_readl(). Seemed that the usb driver failed to acces
some mapped io memory address somehow. The funny thing is that the e100
driver also does some reading calls on iomem in the initialisation, such
as readb() in e100_eeprom_read(). It however doesn't cause system
freezing and the driver quits with an error message that the eeprom is
corrupted. I suppose the problem is somehow still on the pci
configuration in the device tree. I took the dts file of the lite5200
had to do quite some modifications to get the pci bus working at all,
however I still don't get the idea of the mapping thing completely.
Hence I suppose the file is still not OK. Anybody could help me with an
idea where I still could look for or give me some detailed information
on the format of device tree?

Along with this mail I attached my dts file. I am using the git kernel
2.6.21-rc1-dirty, compiled with gcc4.1.2

Thanks a lot for any suggestions.

Cheers
Luotao Fu
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF5ez9iruQY+UyUmERAr3gAKCfJbVSi3WbP8oTyVUzYpCB3drANgCgqQKh
ZVCJSd9FbaTGhdn1gQ9bhZA=
=MBxJ
-----END PGP SIGNATURE-----
