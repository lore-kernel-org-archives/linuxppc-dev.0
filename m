Return-Path: <arvid.staub@mediornet.com>
Received: from mx.inode.at (mx08.lb01.inode.at [62.99.145.8])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7E77EDDEC8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Apr 2007 02:13:46 +1000 (EST)
Subject: AW: Post-boot PCI bus rescan
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 11 Apr 2007 18:03:53 +0200
Message-ID: <8B59AE8CCFB44040B58FCBC1342ED3C420B60A@mnx.mediornet.lan>
From: "Arvid Staub" <Arvid.Staub@mediornet.com>
To: "Andrea Galbusera" <andrea.galbusera@teamware.it>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi andrea!

Thanks for sharing!
I'm planning to use a 2.4-series kernel, unless I'm forced to switch.
I suppose the PCI stuff isn't very different in 2.4, but I will see ... =
;)

we're currently testing all sort of hardware on our board, and I think =
it will take another week or so until I will look into the PCI thing =
again.

ciao,
arvid



-----Urspr=FCngliche Nachricht-----
Von: linuxppc-embedded-bounces+arvid.staub=3Dmediornet.com@ozlabs.org =
[mailto:linuxppc-embedded-bounces+arvid.staub=3Dmediornet.com@ozlabs.org]=
 Im Auftrag von Andrea Galbusera
Gesendet: Montag, 02. April 2007 11:29
An: Arvid Staub
Cc: linuxppc-embedded@ozlabs.org
Betreff: RE: Post-boot PCI bus rescan

Hi Arvid,
sorry for very very late reply... I had to collect a few ideas that I
hope could be useful to you.

First let me state that we didn't reach a completely clean solution to
the PCI rescan issue yet. I have been mainly experimenting on the topic.
Let me share my results...

I had reasonably good result in getting "basic" rescan to work: this can
be done at least with two methods:

1. Exploting the fake-php module already included in vanilla kernels
(see drivers/pci/hotplug/fakephp.c). If you already have a probed device
on the bus (I have the bridge to the CPU in my system) you can fire the
rescan, after configuring your fpga, by "re-powering" the already
available device. This is done by issuing from shell:=20

echo 1 > /sys/bus/pci/slot/<PCI-device-ID>/power

I found documentation about fakephp in mailinglist archives by deeply
googlein' on the subject.

NOTE: to enable the choice of this module in kconfig I had to add the
following line to arch/ppc/Kconfig

source "drivers/pci/hotplug/Kconfig"

In my kernel (2.6.16) this is available in arch/powerpc but not in
arch/ppc. Don't know if this is wanted or not. This step should not be
required if you are using ARCH=3Dpowerpc instead. After enabling the
choice the module is built ok with my kernel.

After adding the line above you can find "Fake PCI hotplug driver" in
kconfig under Bus Options / PCI Hotplug support.

2. Using the rescan procedure contributed by John Carlson. This is
basically a kernel module that issue a PCI bus rescan when you load it.
John helped me to port this module to 2.6.16 kernel API and I had more
or less the same result using this and fakephp.=20

I said these two methods would bring only "basic" rescan. The main point
is that, as far as I can figure out, when bus scanning is done at boot,
the ppc platform specific code will start a lot of quirks, irq fixups
and resource remapping functions that will not be executed with the
"manual" rescan done by the methods listed above. As a result, the
config space for the pci device exposed by my fpga is sligtly different
from that I have by rebooting after configuring the fpga. I suppose I
can fix this later i.e. by using the setpci tool, but I don't have deep
enough understanding of all those platform specific fixups and didn't
get the same result of rebooting yet.

Hope this quite confused thoughts may help you implementing your rescan.
Please, keep me informed if you go further and get a cleaner solution.

Regaards,
Andrea
