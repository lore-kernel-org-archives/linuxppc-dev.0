Subject: Re: MPC8250 + PCMCIA + airo_cs card + IO Port mapping proble
From: Jim Rowe <rowejames@acmsystems.com>
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <5.1.0.14.2.20030522143346.04b7e260@falcon.si.com>
References: <5.1.0.14.2.20030522143346.04b7e260@falcon.si.com>
Message-Id: <1053662461.16860.17.camel@kneedragger>
Mime-Version: 1.0
Date: 22 May 2003 21:01:01 -0700
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2003-05-22 at 11:35, Jerry Van Baren wrote:
> Kernel memory space starts at 0xC0000000.  You need to set your I/O well
> above this (above the kernel executable).  It is illegal to have I/O below
> the kernel (its a memory management issue).  That is why the common IMMR
> setting is 0xF0000000.  I would suggest you try setting your PCI window at
> 0xF8000000 or something like that.
>
> gvb

Ok, thanks for the pointer. I've scooted my PCI IO space up in memory to
where I had room.

This is how my IO is now setup:

    pci_init_resource(&hose->io_resource,
                       0xd0000000,
                       0xdfffffff,
                       IORESOURCE_IO,
                       "PCI host bridge");

    pci_init_resource (&hose->mem_resources[0],
                        0x80000000,
                        0x803fffff,
                        IORESOURCE_MEM,
                        "PCI host bridge");

     hose->io_space.start = 0xd0000000;
     hose->io_space.end = 0xdfffffff;
     hose->mem_space.start = 0x7ff00000;
     hose->mem_space.end = 0x803fffff;
     hose->io_base_virt = (void *)0;

my _IO_BASE is now 0xd0000000 and I do

io_block_mapping(0xd0000000, 0xd0000000, 0x1000000, _PAGE_IO);

early when the board is getting setup.


I've also setup PCIBR0 and PCIBR1 in the boot loader to have windows of
0x80000000 to 0xbfffffff and 0xd0000000 to 0xdfffffff.


Now when I try to write to the PCMCIA card, I don't see anything go out
on the PCMCIA bus (write enable and chipselect don't change).  A printk
in the out_le16() routine shows that the address seems to be correct
(0xd00000102), but when I try to read from the card I get a Machine
Check Exception that is "Transfer ack error". I suspect that my IO
mapping is still not correct.

I know that the board is wired up correctly because the I am able to
read the card's CIS through io memory. Why aren't my IO Ports working?


-- James

>
>
> At 12:29 PM 5/22/2003 -0400, you wrote:
>
> >On Wed, 2003-05-21 at 21:33, Dan Malek wrote:
> > > Jim Rowe wrote:
> > >
> > > >>From what I can see - and please correct me if I'm wrong, the way that
> > > > Linux translates the Port IO to the memory mapped IO is through the outb
> > > > and outw macros, which add an offset of _IO_BASE. How do I determine the
> > > > correct value of _IO_BASE?
> > >
> > > The value of _IO_BASE depends upon how you configure and map the host PCI
> > > bridge on the 8250.
> >
> >Here is how my PCI bridge gets mapped:
> >
> >     pci_init_resource(&hose->io_resource,
> >                       0xb0000000,
> >                       0xb00fffff,
> >                       IORESOURCE_IO,
> >                       "PCI host bridge");
> >
> >     pci_init_resource (&hose->mem_resources[0],
> >                        0x80000000,
> >                        0x803fffff,
> >                        IORESOURCE_MEM,
> >                        "PCI host bridge");
> >
> >     hose->io_space.start = 0xb0000000;
> >     hose->io_space.end = 0xb00fffff;
> >     hose->mem_space.start = 0x7ff00000;
> >     hose->mem_space.end = 0x803fffff;
> >     hose->io_base_virt = (void *)0;
> >
> >
> >
> > >
> > > > ... I looked in m8260_setup.c and found
> > >
> > > The 8260 doesn't have a PCI bridge, so these mappings aren't appropriate
> > > for your board.  The 0xf0000000 is needed to get to the IMMR space, but
> > > those accesses don't (shouldn't) be using in/out macros.  The 0xe0000000
> > > space is generally used for flash prom, external devices, local sdram
> > > and so on.
> >
> >I am basing the 8250 startup from the m8260_setup.c file.
> >
> >
> > >
> > > There are a variety of configuration options for the PCI bridge and all of
> > > the other I/O in your system and the mapping using either BATs or page
> > > tables.  It depends upon the address ranges of all of the I/O in your
> > > system and their physical space allocation.
> > >
> >
> >It looks like my _IO_BASE should be 0xb0000000. I've added a line in
> >m8260_setup.c to do
> >
> >         io_block_mapping(0xb0000000, 0xb0000000, 0x000fffff, _PAGE_IO);
> >
> >however, I get an Oops when I try to write with an outw(). From my debug
> >statements I see the address I'm trying to write to is
> >
> >16-bit write: addr:b0000102 val:00000000
> >
> >which looks correct since it is adding the 0xb0000000 offset.
> >
> >Does it look like I have my mapping setup properly, and if so why am I
> >still getting Oopses?
> >
> >
> >
> > >
> > >       -- Dan
> > >
> > >
> >--
> >Jim Rowe
> >Advanced CounterMeasure Systems
> >Phone: (916)669-4304
> >Email: jrowe@acmsystems.com
> >
> >
>
>
>
> **********************************************************************
> This e-mail and any files transmitted with it may be confidential and
> may be legally privileged or otherwise exempt from disclosure under
> applicable law. This e-mail and its files are intended solely for
> the individual or entity to whom they are addressed and their content
> is the property of Smiths Aerospace.  If you are not the intended
> recipient, please do not read, copy, use or disclose this communication.
> If you have received this e-mail in error please notify the e-mail
> administrator at postmaster@smiths-aerospace.com and then delete this
> e-mail, its files and any copies.
>
> This footnote also confirms that this e-mail message has been scanned
> for the presence of known computer viruses.
>
> Smiths addresses are changing!  The new addresses are of the form
> firstname.lastname@smiths-aerospace.com.  Please update your address
> books!  Please begin using the new form immediately.
> ***********************************************************************
--
Jim Rowe
Advanced CounterMeasure Systems
Phone: (916)669-4304
Email: jrowe@acmsystems.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
