Return-Path: <andrea.galbusera@teamware.it>
Received: from smtp3.aruba.it (smtpd2.aruba.it [62.149.128.207])
	by ozlabs.org (Postfix) with SMTP id 01EF3DDF0D
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  2 Apr 2007 19:29:44 +1000 (EST)
Subject: RE: Post-boot PCI bus rescan
From: Andrea Galbusera <andrea.galbusera@teamware.it>
To: Arvid Staub <Arvid.Staub@mediornet.com>
In-Reply-To: <8B59AE8CCFB44040B58FCBC1342ED3C420B426@mnx.mediornet.lan>
References: <8B59AE8CCFB44040B58FCBC1342ED3C420B426@mnx.mediornet.lan>
Content-Type: text/plain; charset=ISO-8859-1
Date: Mon, 02 Apr 2007 11:29:22 +0200
Message-Id: <1175506163.15384.49.camel@localhost.localdomain>
Mime-Version: 1.0
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
available device. This is done by issuing from shell: 

echo 1 > /sys/bus/pci/slot/<PCI-device-ID>/power

I found documentation about fakephp in mailinglist archives by deeply
googlein' on the subject.

NOTE: to enable the choice of this module in kconfig I had to add the
following line to arch/ppc/Kconfig

source "drivers/pci/hotplug/Kconfig"

In my kernel (2.6.16) this is available in arch/powerpc but not in
arch/ppc. Don't know if this is wanted or not. This step should not be
required if you are using ARCH=powerpc instead. After enabling the
choice the module is built ok with my kernel.

After adding the line above you can find "Fake PCI hotplug driver" in
kconfig under Bus Options / PCI Hotplug support.

2. Using the rescan procedure contributed by John Carlson. This is
basically a kernel module that issue a PCI bus rescan when you load it.
John helped me to port this module to 2.6.16 kernel API and I had more
or less the same result using this and fakephp. 

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

On Wed, 2007-03-21 at 17:32 +0100, Arvid Staub wrote:
> Hi there!
> 
> I'm very interested if you found a clean solution to the PCI rescan issue.
> We have a board in development here which should utilize such a mechanism as well - but it's not yet done. it's a Taihu-like PPC405EP setup with the PCI bus connected to a Virtex-5 LXT FPGA.
> 
> can you point me to some information about the rescan in general?
> which PCI bridge and Buses do you use inside your FPGA?
> 
> thx & ciao,
> arvid
> 
> 
> 
> -----Ursprüngliche Nachricht-----
> Von: linuxppc-embedded-bounces+arvid.staub=mediornet.com@ozlabs.org [mailto:linuxppc-embedded-bounces+arvid.staub=mediornet.com@ozlabs.org] Im Auftrag von Andrea Galbusera
> Gesendet: Mittwoch, 28. Februar 2007 12:41
> An: linuxppc-embedded@ozlabs.org
> Betreff: Post-boot PCI bus rescan
> 
> Hi all,
> I'm working on a mpc5200 based custom board. This is basically a
> Lite5200 like platform. I have an onboard FPGA that I configure from
> userspace linux with the required "firmware". Only after configuration
> the FPGA shows its PCI device "nature".
> I have the problem to make linux correctly see the PCI device, in order
> to load my device driver and go on running applications.
> 
> First solution we implemented was to go through a reboot (without
> powering off the FPGA, of course) and consequent boot-time rescan of the
> bus. Works fine but performance is an issue here.
> 
> I then started digging around and found some PCI rescan solution (mainly
> fakephp from the kernel tree and a rescan routine by John Carlson). Both
> these can detect the device and correctly initialize /sys entries. 
> 
> Unfortunately my PCI device config space appears to be different from
> the one I have with the reboot approach. I then compiled my kernel with
> full PCI debugging enabled and got the log attached below. As far as I
> can understand during boot linux calls some fixups on irqs and resouces
> for my PCI device (0000:00:18.0). Those seem to be called by
> pcibios_init() in arch/ppc/kernel/pci.c.
> 
> My question is: am I on the right way to figure out why PCI device
> config space appear different with the two approaches? What is the logic
> behind those fixups? Can I call them again after boot i.e. from my
> rescan module?
> 
> Thanks in advance for any kind help
> Andrea
> 
> 
> ----------------------------------------
> Boot time PCI debug messages if I reboot
> ----------------------------------------
> 
> > PCI: Probing PCI hardware
> > DEV: registering device: ID = 'pci0000:00'
> > kobject pci0000:00: registering. parent: <NULL>, set: devices
> > kobject_uevent
> > CLASS: registering class device: ID = '0000:00'
> > kobject 0000:00: registering. parent: pci_bus, set: class_obj
> > kobject_uevent
> > fill_kobj_path: path = '/class/pci_bus/0000:00'
> > class_uevent - name = 0000:00
> > PCI: Scanning bus 0000:00
> > PCI: Found 0000:00:18.0 [1172/abcd] 00ffed 00
> > PCI: Calling quirk c00098bc for 0000:00:18.0
> > PCI: Calling quirk c010d400 for 0000:00:18.0
> > PCI: Found 0000:00:1a.0 [1057/5809] 000680 00
> > PCI: Calling quirk c00098bc for 0000:00:1a.0
> > PCI: Calling quirk c010d400 for 0000:00:1a.0
> > PCI: Fixups for bus 0000:00
> > PCI: Bus scan for 0000:00 returning with max=00
> > DEV: registering device: ID = '0000:00:18.0'
> > kobject 0000:00:18.0: registering. parent: pci0000:00, set: devices
> > kobject_uevent
> > fill_kobj_path: path = '/devices/pci0000:00/0000:00:18.0'
> > bus pci: add device 0000:00:18.0
> > DEV: registering device: ID = '0000:00:1a.0'
> > kobject 0000:00:1a.0: registering. parent: pci0000:00, set: devices
> > kobject_uevent
> > fill_kobj_path: path = '/devices/pci0000:00/0000:00:1a.0'
> > bus pci: add device 0000:00:1a.0
> > PCI: fixup irq: (0000:00:18.0) got 1
> > PCI: fixup irq: (0000:00:1a.0) got 0
> > PCI: bridge rsrc 0..ffffff (100), parent c027a1fc
> > PCI: bridge rsrc 80000000..9fffffff (1200), parent c027a1e0
> > PCI: bridge rsrc a0000000..afffffff (200), parent c027a1e0
> >   got res [80000000:80000fff] bus [80000000:80000fff] flags 1208 for
> BAR 0 of 0000:00:18.0
> > PCI: moved device 0000:00:18.0 resource 0 (1208) to 80000000
> >   got res [80800000:80ffffff] bus [80800000:80ffffff] flags 1208 for
> BAR 1 of 0000:00:18.0
> > PCI: moved device 0000:00:18.0 resource 1 (1208) to 80800000
> >   got res [a0000000:a0003fff] bus [a0000000:a0003fff] flags 200 for
> BAR 2 of 0000:00:18.0
> > PCI: moved device 0000:00:18.0 resource 2 (200) to a0000000
> >   got res [a0040000:a007ffff] bus [a0040000:a007ffff] flags 200 for
> BAR 0 of 0000:00:1a.0
> > PCI: moved device 0000:00:1a.0 resource 0 (200) to a0040000
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
