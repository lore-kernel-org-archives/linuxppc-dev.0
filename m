Return-Path: <andrea.galbusera@teamware.it>
Received: from smtp5.aruba.it (smtpd2.aruba.it [62.149.128.207])
	by ozlabs.org (Postfix) with SMTP id EE740DDE08
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Feb 2007 22:47:13 +1100 (EST)
Subject: Post-boot PCI bus rescan
From: Andrea Galbusera <andrea.galbusera@teamware.it>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Wed, 28 Feb 2007 12:41:00 +0100
Message-Id: <1172662860.2799.66.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

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
these can detect the device and correctly initialize /sys entries. 

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
> DEV: registering device: ID = 'pci0000:00'
> kobject pci0000:00: registering. parent: <NULL>, set: devices
> kobject_uevent
> CLASS: registering class device: ID = '0000:00'
> kobject 0000:00: registering. parent: pci_bus, set: class_obj
> kobject_uevent
> fill_kobj_path: path = '/class/pci_bus/0000:00'
> class_uevent - name = 0000:00
> PCI: Scanning bus 0000:00
> PCI: Found 0000:00:18.0 [1172/abcd] 00ffed 00
> PCI: Calling quirk c00098bc for 0000:00:18.0
> PCI: Calling quirk c010d400 for 0000:00:18.0
> PCI: Found 0000:00:1a.0 [1057/5809] 000680 00
> PCI: Calling quirk c00098bc for 0000:00:1a.0
> PCI: Calling quirk c010d400 for 0000:00:1a.0
> PCI: Fixups for bus 0000:00
> PCI: Bus scan for 0000:00 returning with max=00
> DEV: registering device: ID = '0000:00:18.0'
> kobject 0000:00:18.0: registering. parent: pci0000:00, set: devices
> kobject_uevent
> fill_kobj_path: path = '/devices/pci0000:00/0000:00:18.0'
> bus pci: add device 0000:00:18.0
> DEV: registering device: ID = '0000:00:1a.0'
> kobject 0000:00:1a.0: registering. parent: pci0000:00, set: devices
> kobject_uevent
> fill_kobj_path: path = '/devices/pci0000:00/0000:00:1a.0'
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
