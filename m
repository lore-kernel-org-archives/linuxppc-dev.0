Date: Tue, 4 Feb 2003 12:32:24 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: was: FEC on MPC860T & race condition
Message-ID: <20030204193224.GB3522@ip68-0-152-218.tc.ph.cox.net>
References: <3E395B40.9090506@imc-berlin.de> <3E39898E.5060804@embeddededge.com> <3E3A3EE9.7000608@imc-berlin.de> <20030203210959.GA7857@ip68-0-152-218.tc.ph.cox.net> <3E3F7C29.8030807@imc-berlin.de> <20030204160401.GA30936@ip68-0-152-218.tc.ph.cox.net> <3E3FE6D0.1010600@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E3FE6D0.1010600@imc-berlin.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Feb 04, 2003 at 05:14:08PM +0100, Steven Scholz wrote:

> I'll attach my patch. It is not configurable since I think it won't break
> anything.

Okay.  Moving along the process, I have a comment:

> @@ -2285,6 +2278,39 @@
>  	fep->old_status = 0;
>  #endif	/* CONFIG_USE_MDIO */
>
> +#ifdef CONFIG_USE_MDIO
> +# ifndef PHY_INTERRUPT
> +#  error Want to use MII, but PHY_INTERRUPT not defined!
> +# endif
> +	/* before requesting the irq, we should wait until PHY is discovered
> +	 * to avoid race conditions
> +	 */
> +	while (!fep->phy_id_done) {
> +		udelay(5);
> +	}

I believe this is wrong, in that trying to udelay() here is a bad idea.
I don't have the time right now, but I suspect google, or #kernelnewbies
might be able to suggest a more appropriate way of waiting here.

Or perhaps classes have fried my mind, and this is correct.

> +	/* I found the following lines in a post from yhkim@da-san.com>
> +	 * (http://lists.linuxppc.org/linuxppc-embedded/200110/msg00206.html)
> +	 * But I am not sure if and why this is necessary.
> +	 * Enable it just to be sure, be sure ... ?
> +	 * It works for me without it.
> +	 */
> +#if 0
> +	mii_do_cmd(dev, fep->phy->ack_int);
> +	mii_do_cmd(dev, fep->phy->startup);
> +
> +	{
> +		int tmp;
> +		for (tmp = 0; tmp < 50; tmp++)
> +			udelay(5);
> +	}
> +#endif

I believe this is an attempt at waiting as well.  Kick the PHY and do
nothing until it's hopefully discovered.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
