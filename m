Date: Wed, 8 May 2002 13:27:32 -0700
From: Matt Porter <mporter@mvista.com>
To: Armin <akuster@pacbell.net>
Cc: Matt Porter <mporter@mvista.com>,
	ppc_devel <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 4xx change to core files
Message-ID: <20020508202732.GG5280@beef.az.mvista.com>
References: <3CD9560E.9000909@pacbell.net> <20020508105157.A28846@home.com> <3CD977C3.7030504@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CD977C3.7030504@pacbell.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, May 08, 2002 at 12:08:51PM -0700, Armin wrote:
> Matt Porter wrote:
> >On Wed, May 08, 2002 at 09:45:02AM -0700, Armin wrote:
> >
> >>The core_ocp[] is don ein the following:
> >>
> >>new struct in asm-ppc/ocp.h
> >>
> >>struct ocp_def {
> >>	enum ocp_type type;
> >>	int paddr;
> >>	int irq;
> >>};
> >>
> > };
> >
> ><snip>
> >
> >>new ocp APIs:
> >>
> >>unsigned long get_ocp_paddr(int type, int dev_num);
> >> returns the physical address for a given ocp type for the nth one.
> >> this is used when the mmu is not completely up such as during pci
> >>bring up.
> >>
> >
> >It would be helpful for 36-bit 4xx core implementations (440gp/440gx)
> >if the paddr used the phys_addr_t typedef so we could store a
> >native 64-bit address.
>
> ok
>
> >
> >It would appear to me that one would expect to be able to do
> >the following:
> >
> >	ioremap(get_ocp_paddr(<type>, <num>), <size>);
> >
> >Is that the intention?
>
>
> Yeap

Ok, then the other piece that will be necessary is to
change to using a 'ioremap_native' for the ocp drivers.
That will resolve to 'ioremap' on 32-bit phys cores and
'ioremap64' on 36+-bit phys cores.

I'm able to "fixup" 32-bit phys addrs in the 440-specific
ioremap on the 440gp since the memory map luckily provided
unique (least significant 32-bit) addresses.  This is
may or may not work on upcoming 440+ implementations as
the memory maps will differ...possibly having I/O regions
overlapping in their least significant 32-bits.

Regards,
--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
