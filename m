Message-ID: <39A4896C.935393F3@mvista.com>
Date: Wed, 23 Aug 2000 19:33:16 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: David Monro <davidm@amberdata.demon.co.uk>
CC: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: strange PCI resource behaviour in 2.4
References: <39A47457.EB8AC497@amberdata.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Monro wrote:
>
> Hi,
>
> I'm seeing a strange problem with the PCI code on 2.4. What is happening
> is that the PCI code seems to be detecting a memory region on my pcnet32
> chip, but leaving it at 0x0:
>
> prozac:~# lspci -v -vv -s 0c
> 00:0c.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 [PCnet
> LANCE] (rev 16)
>         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B-
>         Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR-
>         Interrupt: pin A routed to IRQ 15
>         Region 0: I/O ports at 1000200 [disabled] [size=32]
>         Region 1: Memory at <unassigned> (32-bit, non-prefetchable) [disabled]
> [size=32]
>         Expansion ROM at <unassigned> [disabled] [size=64K]
>
> (On a 2.2 kernel, Region 1 and the Expansion ROM simply aren't there,
> presumably bacuse the firmware doesn't enable them.)
>
> This means when the device driver calls pci_enable_device, it doesn't
> work.
>
> excerpt from dmesg:
> pcnet32_probe_pci: found device 0x001022.0x002000
>   ioaddr=0x1000200  resource_flags=0x000101
> PCI: Device 00:0c.0 not available because of resource collisions
> pcnet32.c: failed to enable device -- err=-22
>
> This is because the code in pcibios_enable_device() checks for the
> combination of a region with a base of 0 and a non-0 end and fails if
> that is the case.
>
> I guess this is a consequence of the new code which searches for pci
> regions rather then just accepting what the bios gives it. Should I make
> it assign a sensible base address to the regions it finds, or fix it so
> that the end address is also 0 if the start address is left at 0? Where
> should the fix go? Note that I don't get any "PCI: Address space
> collision on region ..." messages while booting, so the initialization
> code doesn't seem to think there is a problem at any stage.
>
> This is using an IBM 850.
>
> Cheers,
>
>         Davvid
>

I've run afoul of this check too.  I currently have it commented out for
the IBM 405GP in 2.4.0-test2:


int pcibios_enable_device(struct pci_dev *dev)
{
        u16 cmd, old_cmd;
        int idx;
        struct resource *r;

        pci_read_config_word(dev, PCI_COMMAND, &cmd);
        old_cmd = cmd;
        for (idx=0; idx<6; idx++) {
                r = &dev->resource[idx];
#if     !defined(CONFIG_IBM405GP)
                if (!r->start && r->end) {
                        printk(KERN_ERR "PCI: Device %s not available because of resource collisions\n", dev->slot_name);
                        return -EINVAL;
                }
#endif
                if (r->flags & IORESOURCE_IO)
                        cmd |= PCI_COMMAND_IO;
                if (r->flags & IORESOURCE_MEM)
                        cmd |= PCI_COMMAND_MEMORY;
        }


-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
