Date: Sun, 21 Dec 2003 13:31:40 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Pantelis Antoniou <panto@intracom.gr>,
	Dan Malek <dan@embeddededge.com>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 8xx drivers for 2.6
In-Reply-To: <20031215161815.GC23731@stop.crashing.org>
Message-ID: <Pine.GSO.4.58.0312211329540.681@waterleaf.sonytel.be>
References: <20031211191854.GK23731@stop.crashing.org> <3FD8C932.60205@embeddededge.com>
 <20031211212529.GL23731@stop.crashing.org> <3FDDA552.7030007@intracom.gr>
 <20031215161815.GC23731@stop.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 15 Dec 2003, Tom Rini wrote:
> On Mon, Dec 15, 2003 at 02:13:06PM +0200, Pantelis Antoniou wrote:
> > Tom Rini wrote:
> > >On Thu, Dec 11, 2003 at 02:44:50PM -0500, Dan Malek wrote:
> > >>Tom Rini wrote:
> > >>
> > >>>Ok. I've gone and ported the 8xx serial driver, and other misc 8xx
> > >>>things up to what 2.6 wants them to be, as well as a few of the
> > >>>simpler changes to head_8xx.S.
> > >>>
> > >>>
> > >>Thanks. So, does the kernel at least compile now? :-)
> > >>
> > >
> > >Compiles, links, boots and happily dies inside of head_8xx.S :)
> > >
> > >>>...and in 2.6 having request_8xxirq becomes much uglier because of
> > >>>the irqreturn_t stuff
> >
> > That sounds nice.
> >
> > Any chance to push the changes to the linuxppc-2.5 tree for us poor saps?
> > It doesn't have to work or anything, just give us something to work...
>
> Sure, done.

> diff -Nru a/include/linux/interrupt.h b/include/linux/interrupt.h
> --- a/include/linux/interrupt.h	Thu Dec 11 12:14:00 2003
> +++ b/include/linux/interrupt.h	Thu Dec 11 12:14:00 2003
> @@ -26,7 +26,9 @@
>   * IRQ_HANDLED means that we did have a valid interrupt and handled it.
>   * IRQ_RETVAL(x) selects on the two depending on x being non-zero (for handled)
>   */
> +#ifndef __CONFIG_8xx_DEFS
>  typedef int irqreturn_t;
> +#endif
>
>  #define IRQ_NONE	(0)
>  #define IRQ_HANDLED	(1)

And this breaks compilation for non-8xx machines in current linuxppc-2.5:

| In file included from arch/ppc/kernel/traps.c:29:
| include/linux/interrupt.h:38: error: parse error before "irqreturn_t"

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
