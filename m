From: benh@kernel.crashing.org
To: Val Henson <val@nmt.edu>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: EV-64260-BP & GT64260 bi_recs
Date: Tue, 26 Mar 2002 11:14:19 +0100
Message-Id: <20020326101419.26730@mailhost.mipsys.com>
In-Reply-To: <20020325202132.M24258@boardwalk>
References: <20020325202132.M24258@boardwalk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Basically, don't create special cases, just treat the generic case of
>a driver and a bootloader and some information you want to pass
>between them.  I don't like BI_DEVICE, I do like BI_NOT_FOR_THE_KERNEL
>or something shorter but equivalent. :)
>
>I'm happy to hear reasons for why a more complicated interface is a
>good idea.

Ok, so first, the generic case is there as you can always stuff
things inside a toplevel bi_rec and use bi_find within that.

The point of BI_DEVICE is to standardize a bit the interface
between known drivers and the bootloader. Your scheme would
require each device on my board to have a different bi_rec,
which will lead into proprietary stuff & more driver patching.

For example, let's say we fix some "common" ethernet drivers
like pcnet32, tulip, etc... to be able to locate a bi_rec
for a BI_DEV_TYPE_PCI based on the bus/devfn and use the HW
address in there. Once that's done, no kernel/driver change
is needed, even if you happen to have 3 instances of the
ethernet chip on your PCI bus, just pass the appropriate infos
from the bootloader. Of course, this is mostly useful for
embedded cases where the PCI device is wired, not in a slot.

Also, a set BI_DEV_TYPE_PCI with just a BI_IRQ_NUMBER
(no indication of the device class/name) can also be used
to provide the PCI interrupt routing for PCI slots, though
in this specific case, I'd prefer seeing the firmware fill
the PCI_INTERRUPT_LINE register in the config space and the
kernel retreive that.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
