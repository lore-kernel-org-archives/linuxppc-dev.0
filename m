From: "David W. Patmore" <dwp@bluesteelnet.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Update:  RE: G4 + Linux + PCI device + x86 driver = 0
Date: Fri, 3 Dec 1999 15:00:13 -0800
Message-ID: <NDBBKOPFGLPEGICBJFDIOEDCCDAA.dwp@bluesteelnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <382FD386.5BCEBF84@agelectronics.co.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I posted a question about getting a PCI device working on LinuxPPC (G4!).
Thanks to those who responded; your assistance made a big difference.  I
finally finished my project, and wanted to post a few dribs that I had to
deal with (that were different from the Linux x86 driver).

1.  I had to enable memory writes (PCI_COMMAND_MEMORY), which was somehow
handled automataically on x86, but not here.
    {
    pci_read_config_word( pDev, PCI_COMMAND, &value );
    value |= PCI_COMMAND_MEMORY;
    pci_write_config_word( pDev, PCI_COMMAND, value );
    }
    For good measure, I also set PCI_COMMAND_MASTER, though I also call
pci_set_master(), which covers the issue.

2.  I had to byte-swap all pointers that I supply to my device.  For
portability, I made a set of macros, "SYS_TO_LE() and LE_TO_SYS(), etc. so
that both endian architectures could work out.

3.  I had to byte-swap all data that I supply to my device, except the data
that is handled as a byte stream.  This involved major discussions with my
colleagues, because of the need to consider Big Endian, Little Endian, and
Network Byte Order.

Now I'm going to put my feet up and take an asprin.  Thanks again for your
help.

David Patmore
www.BlueSteelNet.com
> -----Original Message-----
> From: apc@multi59.netcomi.com [mailto:apc@multi59.netcomi.com]On Behalf
> Of Adrian Cox
> Sent: Monday, November 15, 1999 1:34 AM
> To: David W. Patmore
> Cc: linuxppc-dev@lists.linuxppc.org
> Subject: Re: G4 + Linux + PCI device + x86 driver = 0
>
>
> "David W. Patmore" wrote:
> [snip]
> > The original x86 (Redhat 6.0) driver uses virt_to_bus() to get
> the address
> > to write to.  In LinuxPPC, that function is not available (not in name
> > table).  I guess that I'm supposed to use ioremap(), but that
> doesn't seem
> > to do it for me either.
>
> You should include <asm/io.h>. But virt_to_bus(), phys_to_virt(), and
> their relatives, only apply to RAM.
>
> > Code snip:
> >         ul_reg_addr = p_dev->base_address[0];
> >
> >         pul_remapped =ioremap( ul_reg_addr, 32 );
> >
> >         printk( "pcidrv: base addr %08X \n", ul_reg_addr );
> >         printk( "pcidrv: pul_remapped %08X \n", pul_remapped );
> >         printk( "pcidrv: remapped data: %08X \n", *pul_remapped );
> >
> >         iounmap( pul_remapped );
>
> Note that as a general principal of cross platform Linux programming,
> the thing returned by ioremap is not a true pointer, and should only be
> used with readl(), writel(), etc.
>
> These are not your problem - the problem is most likely the device not
> being enabled by the boot firmware. This may mean that
> (1) The PCI fixup code is broken on the G4s.
> (2) The device has unusual startup requirements.
>
> - Adrian Cox, AG Electronics
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
