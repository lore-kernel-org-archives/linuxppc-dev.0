Date: Fri, 3 Mar 2000 19:44:59 -0600
From: Grant Erickson <grant@borg.umn.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: HELP: Power Mac G3 PCI Strangeness in 2.2 and 2.3
Message-ID: <Pine.SGI.4.21.0003031924100.31240-100000@brule.borg.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am working on a driver for a really simple, but custom, PCI chip
installed into one of the slots on my Power Macintosh G3 which is giving
me no end to troubles. The driver and the card work fine in a passel of
i386-based Linux machines (w/ the Linux PCI driver code modified to detect
the odd 0xFFFF/0x0000 VID/DID combo).

With this chip, I can read, modify and write the PCI configuration
register on both a Power Mac and on an i386 machine. A sample dump of the
PCI registers at the time my driver is loaded:

-------------------------------------------------
Off.  PCI Register Name                Value
----  -------------------------------- ----------
0x00  Vendor ID                        0x    ffff
0x02  Device ID                        0x       0
0x04  Command                          0x       2
0x06  Status                           0x     280
0x08  Revision ID                      0x       0
0x09  Program Interface                0x       0
0x0a  Device Class                     0x       0
0x0c  Cache Line Size                  0x       0
0x0d  Primary Latency Timer            0x       0
0x0e  Header Type                      0x       0
0x0f  Built-in Self Test               0x       0
0x10  Base Address 0                   0xfffc0000
0x14  Base Address 1                   0x       0
0x18  Base Address 2                   0x       0
0x1c  Base Address 3                   0x       0
0x20  Base Address 4                   0x       0
0x24  Base Address 5                   0x       0
0x28  Cardbus CIS Pointer              0x       0
0x2c  Subsystem Vendor ID              0x       0
0x2e  Subsystem ID                     0x       0
0x30  Expansion ROM Address            0x       0
0x3c  Interrupt Line                   0x       0
0x3d  Interrupt Pin                    0x       0
0x3e  Minimum Grant                    0x       0
0x3f  Maximum Latency                  0x       0

>From /proc/pci:

  Bus  0, device  20, function  0:
    Class 0000: PCI device ffff:0000 (rev 0).
      Non-prefetchable 32 bit memory at 0xfffc0000 [0xffffffff].

However, once I enable memory space access, request a memory region, and
remap the address, I fail to get the correct first base register from the
device (should be 0x00000103)

The output from my test code:

Found: Bus 0, Slot 20, Function 0, Vendor 0xffff, Device 0x0
PCI Base 0 addr = 0xfffc0000
resource[0].start = 0xfffc0000
Banging on Vendor and Device IDs...
Vendor and Device IDs match!
Chip remapped @ 0xc39dd000
Banging on chip ID...
Chip ID: 0x5504c00f @ 0xc39dd000
Bad chip ID!

If I hook things up to a logic analyzer I can see the VID/DID loop
working; however, once I map in memory access space, nothing goes out on
the bus.

Looking at other PCI devices in the system and the remapped address,
things look suspect. However, after looking at other drivers, I don't see
what I'm missing. Any certain gotchas I should look for?

A brief summary of my code:

{
        int i;
        struct pci_dev *dp;
        u_short data;
        unsigned long addr, res_start, res_size;
        struct resource *rp;
        unsigned long chip;

        dp = pci_find_device(0xFFFF, 0x0000, NULL);

        if (dp == NULL)
                return (-1);

        rp = &dp->resource[0];
        if (rp->flags & IORESOURCE_IO)
                rp = &dp->resource[1];
        addr = rp->start;

        if (!addr)
                return (-EFAULT);

        res_start = rp->start;
        res_size = rp->end - rp->start + 1;

        if (!request_mem_region(res_start, res_size, "chip")) {
                return (-ENOMEM);
        }

        for (i = 0; i < 10000000; i++) {
                pci_read_config_word(dp, PCI_VENDOR_ID, &data);
                if (data != 0xFFFF)
                        break;
                pci_read_config_word(dp, PCI_DEVICE_ID, &data);
                if (data != 0x0000)
                        break;
        }

        pci_read_config_word(dp, PCI_COMMAND, &data);
        if (!(data & PCI_COMMAND_MEMORY)) {
                data |= PCI_COMMAND_MEMORY;
                pci_write_config_word(dp, PCI_COMMAND, data);
        }

        chip = (unsigned long)ioremap(res_start, res_size);

        for (i = 0; i < 100000000; i++)
                readl(chip);

	if (readl(chip) != 0x00000103)
		printk("Bad Chip ID!\n");

        release_mem_region(res_start, res_size);

        return (-1);
}

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
