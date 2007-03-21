Return-Path: <arvid.staub@mediornet.com>
Received: from mailbackup.inode.at (mailbackup.inode.at [213.229.60.24])
	by ozlabs.org (Postfix) with ESMTP id B71FCDDF0A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Mar 2007 03:32:27 +1100 (EST)
Received: from [62.99.145.19] (port=53458 helo=mx.inode.at)
	by mailbackup.inode.at with esmtp (Exim 4.62)
	(envelope-from <arvid.staub@mediornet.com>) id 1HU3je-0000jt-04
	for linuxppc-embedded@ozlabs.org; Wed, 21 Mar 2007 17:32:26 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Post-boot PCI bus rescan
Date: Wed, 21 Mar 2007 17:32:07 +0100
Message-ID: <8B59AE8CCFB44040B58FCBC1342ED3C420B426@mnx.mediornet.lan>
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

Hi there!

I'm very interested if you found a clean solution to the PCI rescan =
issue.
We have a board in development here which should utilize such a =
mechanism as well - but it's not yet done. it's a Taihu-like PPC405EP =
setup with the PCI bus connected to a Virtex-5 LXT FPGA.

can you point me to some information about the rescan in general?
which PCI bridge and Buses do you use inside your FPGA?

thx & ciao,
arvid



-----Urspr=FCngliche Nachricht-----
Von: linuxppc-embedded-bounces+arvid.staub=3Dmediornet.com@ozlabs.org =
[mailto:linuxppc-embedded-bounces+arvid.staub=3Dmediornet.com@ozlabs.org]=
 Im Auftrag von Andrea Galbusera
Gesendet: Mittwoch, 28. Februar 2007 12:41
An: linuxppc-embedded@ozlabs.org
Betreff: Post-boot PCI bus rescan

Hi all,
I'm working on a mpc5200 based custom board. This is basically a
Lite5200 like platform. I have an onboard FPGA that I configure from
userspace linux with the required "firmware". Only after configuration
the FPGA shows its PCI device "nature".
I have the problem to make linux correctly see the PCI device, in order
to load my device driver and go on running applications.

First solution we implemented was to go through a reboot (without
powering off the FPGA, of course) and consequent boot-time rescan of the
bus. Works fine but performance is an issue here.

I then started digging around and found some PCI rescan solution (mainly
fakephp from the kernel tree and a rescan routine by John Carlson). Both
these can detect the device and correctly initialize /sys entries.=20

Unfortunately my PCI device config space appears to be different from
the one I have with the reboot approach. I then compiled my kernel with
full PCI debugging enabled and got the log attached below. As far as I
can understand during boot linux calls some fixups on irqs and resouces
for my PCI device (0000:00:18.0). Those seem to be called by
pcibios_init() in arch/ppc/kernel/pci.c.

My question is: am I on the right way to figure out why PCI device
config space appear different with the two approaches? What is the logic
behind those fixups? Can I call them again after boot i.e. from my
rescan module?

Thanks in advance for any kind help
Andrea


----------------------------------------
Boot time PCI debug messages if I reboot
----------------------------------------

> PCI: Probing PCI hardware
> DEV: registering device: ID =3D 'pci0000:00'
> kobject pci0000:00: registering. parent: <NULL>, set: devices
> kobject_uevent
> CLASS: registering class device: ID =3D '0000:00'
> kobject 0000:00: registering. parent: pci_bus, set: class_obj
> kobject_uevent
> fill_kobj_path: path =3D '/class/pci_bus/0000:00'
> class_uevent - name =3D 0000:00
> PCI: Scanning bus 0000:00
> PCI: Found 0000:00:18.0 [1172/abcd] 00ffed 00
> PCI: Calling quirk c00098bc for 0000:00:18.0
> PCI: Calling quirk c010d400 for 0000:00:18.0
> PCI: Found 0000:00:1a.0 [1057/5809] 000680 00
> PCI: Calling quirk c00098bc for 0000:00:1a.0
> PCI: Calling quirk c010d400 for 0000:00:1a.0
> PCI: Fixups for bus 0000:00
> PCI: Bus scan for 0000:00 returning with max=3D00
> DEV: registering device: ID =3D '0000:00:18.0'
> kobject 0000:00:18.0: registering. parent: pci0000:00, set: devices
> kobject_uevent
> fill_kobj_path: path =3D '/devices/pci0000:00/0000:00:18.0'
> bus pci: add device 0000:00:18.0
> DEV: registering device: ID =3D '0000:00:1a.0'
> kobject 0000:00:1a.0: registering. parent: pci0000:00, set: devices
> kobject_uevent
> fill_kobj_path: path =3D '/devices/pci0000:00/0000:00:1a.0'
> bus pci: add device 0000:00:1a.0
> PCI: fixup irq: (0000:00:18.0) got 1
> PCI: fixup irq: (0000:00:1a.0) got 0
> PCI: bridge rsrc 0..ffffff (100), parent c027a1fc
> PCI: bridge rsrc 80000000..9fffffff (1200), parent c027a1e0
> PCI: bridge rsrc a0000000..afffffff (200), parent c027a1e0
>   got res [80000000:80000fff] bus [80000000:80000fff] flags 1208 for
BAR 0 of 0000:00:18.0
> PCI: moved device 0000:00:18.0 resource 0 (1208) to 80000000
>   got res [80800000:80ffffff] bus [80800000:80ffffff] flags 1208 for
BAR 1 of 0000:00:18.0
> PCI: moved device 0000:00:18.0 resource 1 (1208) to 80800000
>   got res [a0000000:a0003fff] bus [a0000000:a0003fff] flags 200 for
BAR 2 of 0000:00:18.0
> PCI: moved device 0000:00:18.0 resource 2 (200) to a0000000
>   got res [a0040000:a007ffff] bus [a0040000:a007ffff] flags 200 for
BAR 0 of 0000:00:1a.0
> PCI: moved device 0000:00:1a.0 resource 0 (200) to a0040000


_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
