Subject: Re: MPC8250 + PCMCIA + airo_cs card + IO Port mapping problem?
From: Jim Rowe <rowejames@acmsystems.com>
To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3ECC532F.1080008@embeddededge.com>
References: <1053557921.16972.149.camel@kneedragger>
	 <3ECC532F.1080008@embeddededge.com>
Message-Id: <1053631771.23624.11.camel@kneedragger>
Mime-Version: 1.0
Date: 22 May 2003 12:29:31 -0700
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2003-05-21 at 21:33, Dan Malek wrote:
> Jim Rowe wrote:
>
> >>From what I can see - and please correct me if I'm wrong, the way that
> > Linux translates the Port IO to the memory mapped IO is through the outb
> > and outw macros, which add an offset of _IO_BASE. How do I determine the
> > correct value of _IO_BASE?
>
> The value of _IO_BASE depends upon how you configure and map the host PCI
> bridge on the 8250.

Here is how my PCI bridge gets mapped:

    pci_init_resource(&hose->io_resource,
                      0xb0000000,
                      0xb00fffff,
                      IORESOURCE_IO,
                      "PCI host bridge");

    pci_init_resource (&hose->mem_resources[0],
                       0x80000000,
                       0x803fffff,
                       IORESOURCE_MEM,
                       "PCI host bridge");

    hose->io_space.start = 0xb0000000;
    hose->io_space.end = 0xb00fffff;
    hose->mem_space.start = 0x7ff00000;
    hose->mem_space.end = 0x803fffff;
    hose->io_base_virt = (void *)0;



>
> > ... I looked in m8260_setup.c and found
>
> The 8260 doesn't have a PCI bridge, so these mappings aren't appropriate
> for your board.  The 0xf0000000 is needed to get to the IMMR space, but
> those accesses don't (shouldn't) be using in/out macros.  The 0xe0000000
> space is generally used for flash prom, external devices, local sdram
> and so on.

I am basing the 8250 startup from the m8260_setup.c file.


>
> There are a variety of configuration options for the PCI bridge and all of
> the other I/O in your system and the mapping using either BATs or page
> tables.  It depends upon the address ranges of all of the I/O in your
> system and their physical space allocation.
>

It looks like my _IO_BASE should be 0xb0000000. I've added a line in
m8260_setup.c to do

	io_block_mapping(0xb0000000, 0xb0000000, 0x000fffff, _PAGE_IO);

however, I get an Oops when I try to write with an outw(). From my debug
statements I see the address I'm trying to write to is

16-bit write: addr:b0000102 val:00000000

which looks correct since it is adding the 0xb0000000 offset.

Does it look like I have my mapping setup properly, and if so why am I
still getting Oopses?



>
> 	-- Dan
>
>
--
Jim Rowe
Advanced CounterMeasure Systems
Phone: (916)669-4304
Email: jrowe@acmsystems.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
