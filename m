To: Tom Rini <trini@kernel.crashing.org>
Cc: Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: linuxppc_2_4_devel patch: 8xx FEC extensions 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 31 Dec 2002 09:13:05 MST."
             <20021231161305.GC12063@opus.bloom.county>
Date: Thu, 02 Jan 2003 18:40:05 +0100
Message-Id: <20030102174010.D97DFC6139@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20021231161305.GC12063@opus.bloom.county> you wrote:
>
> > How do we _get_ happy, then?
>
> Well, Dan thinks that dropping the 'violatile' here will do bad things,

I don't see where a "volatile" gets dropped in any really significant
way.

For example, the old code has:

	volatile uint *s = &(fep->phy_status);

	*s &= ~(PHY_STAT_LINK | PHY_STAT_FAULT | PHY_STAT_ANC);
(1)
	if (mii_reg & 0x0004)
		*s |= PHY_STAT_LINK;
(2)
	...

The new code has:

	uint s = fep->phy_status;

	s &= ~(PHY_STAT_LINK | PHY_STAT_FAULT | PHY_STAT_ANC);

	if (mii_reg & 0x0004)
		s |= PHY_STAT_LINK;
(3)
	...

For (1), I expect to see code like "lwz,  and[i],  stw";  for  (2)  I
expect  "lwz,  or[i], stw"; (3) will probably look like "lwz, and[i],
or[i], stw". If there is  any  problem  with  asynchronously  running
threads  than  we  have a race condition in the gap between "lwz" and
"stw" anyway. The only significant difference between the old and the
new code is that the old code has many short gaps while our patch has
only one slightly longer one.

> you believe it will fix a problem, and I think it's fishy that a
> volatile is needed here at all.  If you want to get just the multicast

I did not see any problems with the patched code yet. Actually, I see
less problems with the patches version than with the original one.

> that.  For this particular problem I'd like you and Dan to agree on
> something.

Dan, what do you think under which conditions the patches  code  will
show a problem that was not present with the old code?


Best regards, and a Happy New Year!

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
There are two ways to write error-free programs. Only the  third  one
works.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
