Date: Wed, 30 Jun 2004 10:21:50 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Pegasos 2 support patch ...
Message-ID: <20040630082150.GA23593@pegasos>
References: <20040629165029.GA13468@pegasos> <20040629204230.GA15900@pegasos> <1088564249.1906.14.camel@gaston> <20040630060019.GA22053@pegasos> <Pine.GSO.4.58.0406301009020.20130@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <Pine.GSO.4.58.0406301009020.20130@waterleaf.sonytel.be>
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jun 30, 2004 at 10:10:07AM +0200, Geert Uytterhoeven wrote:
> On Wed, 30 Jun 2004, Sven Luther wrote:
> > On Tue, Jun 29, 2004 at 09:57:29PM -0500, Benjamin Herrenschmidt wrote:
> > > > Another solution would be to test before doing the translate call, maybe
> > > > this would be more elegant ?
> > >
> > > Yup, if you know it will be broken, don't bother calling it,
> > > and please, avoid the over-long line :)
> >
> > Ok, this is then the final patch, i hope it is now correct.
>
> > --- kernel-source-2.6.7.orig/arch/ppc/syslib/prom_init.c	2004-06-16 07:20:24.000000000 +0200
> > +++ kernel-source-2.6.7.peg2/arch/ppc/syslib/prom_init.c	2004-06-30 07:51:49.975232432 +0200
> > @@ -850,11 +853,20 @@
> >
> >  	klimit = (char *) (mem - offset);
> >
> > -	/* If we are already running at 0xc0000000, we assume we were
> > -	 * loaded by an OF bootloader which did set a BAT for us.
> > -	 * This breaks OF translate so we force phys to be 0.
> > -	 */
> > -	if (offset == 0) {
> > +	node = call_prom("finddevice", 1, 1, "/");
> > +	rc = call_prom("getprop", 4, 1, node, "model", model, sizeof(model));
> > +	if (rc > 0 && !strncmp (model, "Pegasos", 7)
> > +		&& strncmp (model, "Pegasos2", 8)) {
> > +		/* Pegasos 1 has a broken translate method in the OF,
> > +		 * and furthermore the BATs are mapped 1:1 so the phys
> > +		 * address calculated above is * correct, so let's use
>                                                ^
> Bogus asterisk

Ok, i will remove it thanks.

Friendly,

Sven Luther

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
