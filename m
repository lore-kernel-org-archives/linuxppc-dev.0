Date: Wed, 30 Jun 2004 10:10:07 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Pegasos 2 support patch ...
In-Reply-To: <20040630060019.GA22053@pegasos>
Message-ID: <Pine.GSO.4.58.0406301009020.20130@waterleaf.sonytel.be>
References: <20040629165029.GA13468@pegasos> <20040629204230.GA15900@pegasos>
 <1088564249.1906.14.camel@gaston> <20040630060019.GA22053@pegasos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 30 Jun 2004, Sven Luther wrote:
> On Tue, Jun 29, 2004 at 09:57:29PM -0500, Benjamin Herrenschmidt wrote:
> > > Another solution would be to test before doing the translate call, maybe
> > > this would be more elegant ?
> >
> > Yup, if you know it will be broken, don't bother calling it,
> > and please, avoid the over-long line :)
>
> Ok, this is then the final patch, i hope it is now correct.

> --- kernel-source-2.6.7.orig/arch/ppc/syslib/prom_init.c	2004-06-16 07:20:24.000000000 +0200
> +++ kernel-source-2.6.7.peg2/arch/ppc/syslib/prom_init.c	2004-06-30 07:51:49.975232432 +0200
> @@ -850,11 +853,20 @@
>
>  	klimit = (char *) (mem - offset);
>
> -	/* If we are already running at 0xc0000000, we assume we were
> -	 * loaded by an OF bootloader which did set a BAT for us.
> -	 * This breaks OF translate so we force phys to be 0.
> -	 */
> -	if (offset == 0) {
> +	node = call_prom("finddevice", 1, 1, "/");
> +	rc = call_prom("getprop", 4, 1, node, "model", model, sizeof(model));
> +	if (rc > 0 && !strncmp (model, "Pegasos", 7)
> +		&& strncmp (model, "Pegasos2", 8)) {
> +		/* Pegasos 1 has a broken translate method in the OF,
> +		 * and furthermore the BATs are mapped 1:1 so the phys
> +		 * address calculated above is * correct, so let's use
                                               ^
Bogus asterisk

> +		 * it directly.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
