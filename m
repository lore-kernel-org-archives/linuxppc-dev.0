Date: Wed, 7 Aug 2002 15:51:31 -0700
From: Matt Porter <porter@cox.net>
To: acurtis@directvinternet.com
Cc: mlan@cpu.lu, linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI enlightenment follow-up
Message-ID: <20020807155131.B20123@home.com>
References: <E17cK7s-000080-00@piglet.grunz.lu> <NCBBIINEHIPFGJPLBEIFGEHLDKAA.acurtis@directvinternet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <NCBBIINEHIPFGJPLBEIFGEHLDKAA.acurtis@directvinternet.com>; from acurtis@directvinternet.com on Wed, Aug 07, 2002 at 09:03:53AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Aug 07, 2002 at 09:03:53AM -0700, acurtis@directvinternet.com wrote:
>
> > > ======= Board specs ========
> > > Host phys: 0x40000000 - 0x47ffffff	=>
> > > PCI I/O space 0x00000000 - 0x07ffffff
> > >
> > > Host phys: 0x48000000 - 0x4fffffff =>
> > > PCI Memory space 0x00000000 - 0x07ffffff
> > >
> > > PCI phys: 0x40000000 -  0x47ffffff =>
> > > Host Memory 0x00000000 - 0x07ffffff
> > >
> > > Host Memory:
> > > phys: 0x00000000
> > > virt: 0xc0000000
> > > size: 0x08000000
> > >
> > > PCI BAR: (only 1 bus)
> > > Memory: 0x00000000
> > > I/O:    0x00000000
> > >
> > > ========== Boot Messages ===========
> > > /* SCSI controller resource allocation is fine */
> > > PCI:00:0f.0: Resource 0: 47ffff00-47ffffff (f=101)
> > > PCI:00:0f.0: Resource 1: 4ffffc00-4fffffff (f=200)
> > > PCI:00:0f.0: Resource 2: 4fffc000-4fffdfff (f=200)
> >
> > OK, obviously, the pci_dev resource regions get set up with the
> > necessary offset to get to the right address on the PCI bus.
>
> Yes, but I am beginning to suspect that this is where the problem is. If the
> I/O addresses should not be translated because the in/out() functions
> automagically add the offset, then perhaps the I/O regions should not be
> fixed?

Yep, that's a problem.  Your comment states that
isa_io_base == io_base_virt.  Yet I see isa_io_base=0x00000000
and io_base_virt=0x40000000.  You should have isa_io_base=0x40000000.
You don't want those I/O BARs fixed up as you've suggested above.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
