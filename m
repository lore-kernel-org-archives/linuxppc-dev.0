Date: Tue, 6 Jan 2004 02:28:30 +1100
From: Anton Blanchard <anton@samba.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PPC32: Add support for the OpenPIC register set to be in BE mode.
Message-ID: <20040105152830.GJ12213@krispykreme>
References: <200401032002.i03K23iM024298@hera.kernel.org> <Pine.GSO.4.58.0401051501220.3740@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.GSO.4.58.0401051501220.3740@waterleaf.sonytel.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > diff -Nru a/arch/ppc/kernel/open_pic.c b/arch/ppc/kernel/open_pic.c
> > --- a/arch/ppc/kernel/open_pic.c	Sat Jan  3 12:02:04 2004
> > +++ b/arch/ppc/kernel/open_pic.c	Sat Jan  3 12:02:04 2004
> > @@ -166,13 +166,21 @@
> >  {
> >  	u_int val;
> >
> > +#ifdef CONFIG_PPC_OPENPIC_BE
> > +	val = in_be32(addr);
> > +#else
> >  	val = in_le32(addr);
> > +#endif
> >  	return val;
> >  }
>
> Wouldn't it be better to #define openpic_in() and openpic_out() macros, so you
> need the #ifdef at one spot only?

Or grab the bit out of the ppc64 openpic code that detects this at runtime
and get rid of the CONFIG option completely :)

Anton

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
