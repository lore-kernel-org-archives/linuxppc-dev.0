To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_4_devel patch: 8xx FEC extensions 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 30 Dec 2002 08:29:45 MST."
             <20021230152945.GD5564@opus.bloom.county>
Date: Mon, 30 Dec 2002 17:26:16 +0100
Message-Id: <20021230162621.1741CC6139@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20021230152945.GD5564@opus.bloom.county> you wrote:
>
> scripts/Lindent is 'happy', then that's good enough.  Also, is there any
> reason to go from 'volatile uint *s = &(...->...);' to 'uint s =
> ...->...;' ?  Maybe it's too early in the morning for me, but why
> couldn't it be just 'uint *s', if that volatile isn't needed?

Yes, there is a reason. The old code will access the device  register
several  times,  and  create  intermediate  states  that  may  not be
intended, or even harmful. For example:

	static void mii_parse_sr( ... )
	{
		...
		volatile uint *s = &(fep->phy_status);

		*s &= ~(PHY_STAT_LINK | PHY_STAT_FAULT | PHY_STAT_ANC);

		if (mii_reg & 0x0004)
			*s |= PHY_STAT_LINK;
		if (mii_reg & 0x0010)
			*s |= PHY_STAT_FAULT;
		if (mii_reg & 0x0020)
			*s |= PHY_STAT_ANC;
		...

Assume all the relevant bits in mii_reg are set, then we first  clear
all  the  LINK,  FAULT,  and ANC bits in phy_status, just to tun them
back on step by step.

I cannot really prove it, but I think I have seen at least one  board
where this cause / contributed to some problems with the PHY.

> This is on hold for now, and for future patches please keep cleanup
> seperate from functionality as much as possible.

This _is_ functionality.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"All my life I wanted to be someone; I guess I should have been  more
specific."                                              - Jane Wagner

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
