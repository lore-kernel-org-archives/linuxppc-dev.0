Date: Wed, 27 Feb 2002 01:04:50 -0800 (PST)
From: "David A. Gatwood" <dgatwood@gatwood.net>
Reply-To: "David A. Gatwood" <dgatwood@gatwood.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Nasty ATI/tulip interaction
In-Reply-To: <Pine.LNX.3.96.1020226125122.28711C-100000@gatwood.net>
Message-ID: <Pine.LNX.3.96.1020226185429.7844B-100000@gatwood.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 26 Feb 2002, David A. Gatwood wrote:

> Weird issue.  I finally got the PowerBase 180, and I've attempted to move
> my Linux system from the G4 over to it.  I'm running a heavily patched
> 2.2.21-pre2 kernel.  It includes the PCI fixup patches, Promise Ultra
> ATA/66 patches, and a few (possibly ppc-specific) bug fixes
[ in IDE ].

Thanks to Ben Herrenschmidt, I've gotten it back to the point where I have
a console, but enabling the ethernet card still hoses the ATI output.

On a hunch, I downloaded, compiled, and installed pciutils, and I found
the problem....  The tulip card and the motherboard VGA got assigned the
same I/O ports address (0xf2000400).  No idea how that happened, but it's
quite consistent.

Looks like something broken.  I'd try without Michel Lanners' PCI fixup
patches, but I can't boot without them.  I'm trying to track down what's
breaking, but it isn't obvious.  I've tried to duplicate the code that
remaps planb to remap the ethernet device, but I'm getting nowhere fast.
It's attempting to do the remap, and it is successfully changing the
kernel's notion of the device address, but it looks like for some reason,
the change isn't happening in the controller itself, since I'm getting a
machine check when I actually try to access the device now.  I'm probably
doing something wrong.

I'm giving up for the night, but when I get back to this tomorrow night,
does anyone have any suggestions on how to change the PCI addy of the
ethernet card?

Later,
David

BTW, this doesn't work:

        unsigned char bus, devfn, confreg;
        unsigned short cmd;
        unsigned int i, reg;

        struct device_node *eth_device;

        eth_device = find_devices("pci1385,f004");
        if (eth_device == 0) {
                printk(KERN_WARNING "PCI: Error fixing eth: no OF
device.\n");
                return;
        }
        if (eth_device->next != NULL)
                printk(KERN_WARNING "PCI: Only fixing first eth
device.\n");
        if (eth_device->n_addrs != 1) {
                printk(KERN_WARNING "PCI: Error fixing eth: expected 1 "
                        "address, got %d.\n", eth_device->n_addrs);
                return;
        }
        DBG("PCI: Relocating address %lx ->%lx\n", dev->base_address[0],
                dev->base_address[0]+0x1000);
        dev->base_address[0] = dev->base_address[0] | 0x1000;
        /* Either 0 or PCI_BASE_ADDRESS_0 on next line */
        confreg=PCI_BASE_ADDRESS_0;
        pci_write_config_dword(dev, confreg,
                dev->base_address[0]);
        *newaddr=dev->base_address[0];
        confreg=0;

        /* Enable i/o space, once the new base is set */
        pcibios_read_config_dword (bus, devfn, confreg, &i);
        pcibios_read_config_word (bus, devfn, PCI_COMMAND, &cmd);
        cmd |= PCI_COMMAND_IO;
        pcibios_write_config_word (bus, devfn, PCI_COMMAND, cmd);

Nor this

        confreg = eth_device->addrs[0].space & 0xff;
        reg = (confreg - PCI_BASE_ADDRESS_0) >> 2;

        bus=dev->bus;
        devfn=dev->devfn;

        /* Set the new base address */
        pcibios_write_config_dword (bus, devfn, confreg, newaddr);

	dev->base_address[0] = newaddr;

        /* Enable i/o space, once the new base is set */
        pcibios_read_config_dword (bus, devfn, confreg, &i);
        pcibios_read_config_word (bus, devfn, PCI_COMMAND, &cmd);
        cmd |= PCI_COMMAND_IO;
        pcibios_write_config_word (bus, devfn, PCI_COMMAND, cmd);


---------------------------------------------------------------------
                    Check out my weekly web comic:
                     http://www.techmagazine.org


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
