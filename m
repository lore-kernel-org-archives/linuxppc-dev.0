Date: Mon, 5 Jan 2004 08:41:08 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PPC32: Add support for the OpenPIC register set to be in BE mode.
Message-ID: <20040105154108.GA2415@stop.crashing.org>
References: <200401032002.i03K23iM024298@hera.kernel.org> <Pine.GSO.4.58.0401051501220.3740@waterleaf.sonytel.be> <20040105152830.GJ12213@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040105152830.GJ12213@krispykreme>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jan 06, 2004 at 02:28:30AM +1100, Anton Blanchard wrote:

> > > diff -Nru a/arch/ppc/kernel/open_pic.c b/arch/ppc/kernel/open_pic.c
> > > --- a/arch/ppc/kernel/open_pic.c	Sat Jan  3 12:02:04 2004
> > > +++ b/arch/ppc/kernel/open_pic.c	Sat Jan  3 12:02:04 2004
> > > @@ -166,13 +166,21 @@
> > >  {
> > >  	u_int val;
> > >
> > > +#ifdef CONFIG_PPC_OPENPIC_BE
> > > +	val = in_be32(addr);
> > > +#else
> > >  	val = in_le32(addr);
> > > +#endif
> > >  	return val;
> > >  }
> >
> > Wouldn't it be better to #define openpic_in() and openpic_out() macros, so you
> > need the #ifdef at one spot only?

I suppose we should do it like that for 2.6 (note made).

> Or grab the bit out of the ppc64 openpic code that detects this at runtime
> and get rid of the CONFIG option completely :)

I assume you mean the broken_ipi_registers bit (I only see used in one
spot in what I've got locall) ? I think maybe with some thought it could
work (it's needed in openpic_{read,write} as well for these machines,
prpmc800 and e500, iirc).

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
