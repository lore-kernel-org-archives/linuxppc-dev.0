Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6433C67B22
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Oct 2006 16:39:46 +1000 (EST)
Subject: Re: [PATCH] General CHRP/MPC5K2 Platform and drivers support - to
	comment
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <453B6A84.3050209@bplan-gmbh.de>
References: <453771E5.4090808@bplan-gmbh.de>
	<77AD49CA-69CB-4ADA-B8F3-3BC3A066BCF9@kernel.crashing.org>
	<453884F5.4000804@bplan-gmbh.de>
	<122A4E06-B8A6-4256-B96E-3811EA93EA25@kernel.crashing.org>
	<453B6A84.3050209@bplan-gmbh.de>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 16:36:11 +1000
Message-Id: <1161585371.10524.444.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, tnt@246tNt.com, sl@bplan-gmbh.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ok, here's a batch of comments. They go on top of the comments I sent
about your device-tree, which you might want to make public.

Also note that the size of the patch is partially due to stale ##
and .orig files :)

In general, one big thing is: Don't bother with re-using the arch/ppc
code, API, .h etc... There is not enough re-use there to justify it (FEC
driver is new, serial can easily be changed, as for USB).

* /proc/ppc64/rtas changes: we need to continue that discussion
separately and ask for paulus point of view. I prefer /proc/powerpc
personally with a /proc/ppc64->/proc/powerpc symlink on 64 bits machines
only.

* mpc5k2_bestcomm.c (& helpers):

  - name changes (mpc5200_bestcomm.c would be better)
  - location change -> arch/powerpc/sysdev
  - look into using rheap instead of your current sram bits (and I don't
care about being compatible with arch/ppc code).
  - the whole sdma_io_va/pa/... looks like bullcrap to me. The bestcomm
interface should use the normal dma mapping APIs
  - I don't like having those helpers like fec or ata helpers in that
file. I think we need to rethink the API between the bestcomm and the
drivers. I understand that part of this is related to the fact that the
tasks themselves in the bestcomm are tailored for various devices and
with different descriptor formats. That sucks. I suppose we can live
with that for now (with a bit more cleanup) but we should have a healthy
discussion on how to rework the whole thing properly.

In general, I think there's a lot more code in those files that would be
necessary ;)

* mpc5k2.c :

Well, to start with, I don't think we need that file at all :) A lot of
the stuff in there is completely unnecessary provided that you make
better use of the device-tree. 

The main thing is: use of_platform devices, not platform devices, so
that you have a linkage with the device-tree. In fact, you could
register of platform devices for every direct children of your "buildin"
node (which is to be renamed, I hope, according to my comments about
your device-tree).

You'll even be able to make good use of some work I've been doing lately
for Cell by adding a call to a single function to the main chrp setup
code that will register for you all those devices. You might want to
keep PCI at the root of the tree for now though that won't even be
necessary.

The core of platform matching code will take care of matching devices to
drivers based on standard OF properties (name,device_type,compatible).
Drivers will use standard prom_parse.c functions to obtain resources
like addresses (instead of directly accessing "reg" property from a
useless helper) etc...

But first, let's get your device-tree in shape :)

* mpc5k2_pic.c :

This should go in arch/powerpc/sysdev (and be renamed as for other
files, something like mpc5200_pic.c would be fine).

There are several issues here, though some of them are definitely
related to the chip design being completely alien to common sense:

 - enable/disable/end shouldn't be used that way anymore. use
mask/unmask and set the appropriate IRQ flow handler for your IRQs. That
is, basically, adapt your driver to genirq. That will simplify.

 - You need to add an irq host, probably set it as default, with the
appropriate xlate, map, etc... routines as done by other controllers in
2.6.18.

 - the if/else bits in enable/disable (to become mask/unmask) should
probably be changed into something a bit more sane. You have a large
freedom of chosing what kind of IRQ "hardware" numbers you use. Since
2.6.18 new irq code, there is no direct relationship anymore between a
linux irq number (virtual irq number) and a HW number manipulated by a
PIC. Thus you can do what you want with those HW numbers, like, for
example, using some top bits to represent the "base" (IRQ0...3, SDMA,
PERP, ...) and use bottom bits for the actual bit in the mask. That will
simplify your mask/unmask implementation.

* chrp/pci.c

I dislike the whole "is_bplan" thingy with ugly magic numbers. The
is_pegasos with 3 values was already on the limit .... In fact, you
probably don't even need it. The whole pcibios_fixup change is useless,
let the fixup code run, it will do no harm, and in fact will be
necessary as soon as you have a correct interrupt-tree anyway. Which
means basically that you shoudn't even need to patch this file...

* chrp/setup.c

Did you do any change to chrp_init2() appart from moving it around ?
Please don't move it for no reason or explain why you did it, it makes
the patch bigger than necessary and more difficult to read.

Why did you add back bits that I removed, like:

+       if (_chrp_type == _CHRP_Pegasos)
+               ppc_md.get_irq        = i8259_irq;

This should be handled by the chrp code just fine now (basically 8259
takes over when no mpic was found and sets that callback).

You may have noticed that I changed the code a bit too regaring how irq
controllers are handled in chrp in 2.6.18. You should follow that
instead of bringing back the old scheme. Basically add a
chrp_find_mpc5200_pic or something like that and have it change
ppc_md.get_irq itself if it finds it.

This all init2 vs init_alt business is very ugly. What is your reason
for doing so ? What is chrp_init2 doesn't work for you ? (you should fix
that instead).

* fec driver

(That driver should ultimately be submited to the netdev list & Jeff
Garzik, but here's a fist pass at comments on things that need to be
fixed before you get there).

I'm not sure you have enough files here to justify a subdir. Especially
since you should probably get rid of fec_phy.c and replace it with the
generic PHY code that Andy Fleming wrote in drivers/net/phy/. That old
state machine PHY code from montavista has outlived its usefulness

The driver should be in drivers/net, in fact, it should just be one or
two files: drivers/net/mpc5200_fec.{c,h}

Do not keep #ifdefs around for chrp/non-chrp. I don't want the mpc5200
stuff to have any difference between platforms. The driver wasn't in the
tree before so I don't care about whatevber old API was used by an out
of tree driver in arch/ppc. We are defining an API for use by any
mpc5200 based device under arch/powerpc here, nothing specific to EFIKA
or CHRP.

+       if ( _chrp_type == _CHRP_E5K2 )
+               return (132*1000*1000);
+

Gack ! Make that a  property in the device-tree instead. By converting
the driver to be an of_platform device, you'll get your device-node
reference for free anyway.

kfree_skb() -> dev_kfree_skb() afaik. Also, you might want to make sure
you are getting the right irq/non-irq/any version of it depending on the
context you are calling it in.

You are never calling netif_carrier_on/off... might be useful to do so
to inform the kernel about the state of your link... though if you use
the generic PHY layer, it will do it for you.

+               if (status & 0x370000) {

What about using symbolic constants instead ?

virt_to_phys() is deprecated. See my comments in the bestcomm code too,
use the dma mapping API instead.

Your rx code doesn't seem to do the fairly common optimisation of
copying the data to a new skb when it's small enough rather than
allocating a new one and replacing...

fec_interrupt() has some serious coding style issues.

I'm a bit dubious about the implementation of the re-init code... it
looks racy vs. interrupts, and I don't like at all you calling back into
open(). I'd rather have a separate common routine called by both open
and reinit. You may also want to defer that to a work queue.

ethtool ioctls: You are using a deprecated interface. grep for
ethtool_ops for the right way to do it.

+               while(!priv->sequence_done)
+                       schedule();
+

This is evil. Don't do that. In fact, you should not need to do it, look
at what other drivers do.

* serial stuff

Pretty much all of the same comments as the fec driver regarding
things like:

+static unsigned long get_ipbfreq(void)
+{
+#ifdef CONFIG_PPC_CHRP
+       if ( _chrp_type == _CHRP_E5K2 )
+               return 132*1000*1000;
+
+       return 0;
+#else
+       return __res.bi_ipbfreq
+#endif
+}
+

Just get rid of the bi case and remove the ifdef. Now howevr that I see
at least 2 drivers having the same function to get this ibp freq I'm
starting to wonder why you don't just put the value in the device-tree
possibly in the parent node ?

Same for the default baudrate. Remove the ifdef gunk. Use the baudrate
that's passed in by the system and possibly implement something akin to
check_legacy_serial_console() in arch/powerpc/kernel/legacy_serial.c to
get proper auto-detect. (I would even accept adding a special case to
detect the mpc5200 serial in there)

Make it an of_platform device anyway, that's better. Just ifdef to be
compatible with the stuff in arch/ppc (I didn't even know we ever merged
that... oh well).

* USB

Do an ohci-ppc-of.c that use an OF platform device for probing

Ben.
