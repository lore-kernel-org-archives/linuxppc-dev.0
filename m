Date: Fri, 6 Aug 2004 14:12:36 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Ralph Siemsen <rsiemsen@rossvideo.com>
Cc: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>,
	Matt Porter <mporter@kernel.crashing.org>
Subject: Re: [PATCH] 44x ethernet MDIO access
In-Reply-To: <41129315.600@rossvideo.com>
Message-ID: <Pine.GSO.4.58.0408061411220.26252@waterleaf.sonytel.be>
References: <41128413.7030900@rossvideo.com> <41129315.600@rossvideo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 5 Aug 2004, Ralph Siemsen wrote:
> Attached is a patch that "works for me" - turns the long udelay() into a
> polling loop with short little delays instead.  This allows MDIO_DELAY
> to be increased to a larger value (say 150) without slowing down most
> systems.

> @@ -451,9 +460,13 @@
>
>  	out_be32(&emacp->em0stacr, stacr);
>
> -	udelay(MDIO_DELAY);
> +	count = 0;
> +	while (((stacr = in_be32(&emacp->em0stacr) & EMAC_STACR_OC) == 0)
> +					&& (count++ < 5000))
                                                      ^^^^
						      MDIO_DELAY?

And perhaps you want to create a (possibly inlined) function just for this
loop?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
