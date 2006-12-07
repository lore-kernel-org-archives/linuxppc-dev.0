Return-Path: <roger.larsson@norran.net>
Received: from mail.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id 4BB2F67C63
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Dec 2006 12:22:10 +1100 (EST)
From: Roger Larsson <roger.larsson@norran.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: shared config registers and locking
Date: Thu, 7 Dec 2006 02:22:06 +0100
References: <1165381847.5469.70.camel@localhost.localdomain>
	<200612062314.kB6NE8iQ083398@penguin.ncube.com>
	<1165448053.5469.145.camel@localhost.localdomain>
In-Reply-To: <1165448053.5469.145.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200612070222.07456.roger.larsson@norran.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 07 December 2006 00:34, you wrote:
> > GACK!  Many better engineers than any of us have spent countless hours
> > breaking down locks.  A lock takes nearly no space at all, you're not
> > proposing to lock any less often, so multiple locks take no less time,
> > the only thing you stand to gain by protecting multiple data structures
> > with one lock is the possibility of lock contention.  Please reconsider.
>
> Wait wait wait.... I'm perfectly aware of lock contention issues and I'm
> not proposing to have a giant lock for everything in the system.
>
> I was proposing something very clearly aimed at configuration type
> things that are generally accessed a bit at boot time and then every
> time the phase of the moon changes, in which case, it's just a pain to
> have to use fine grained locking and one shared lock is plenty enough.
>
> The specific example that made me think about it was some clock control
> registers on 4xx that the EMAC driver is whacking every now and then (on
> link state change, no lock contention to be worried about here), though
> they could be used by other drivers too (or platform code). Since those
> registers are a bit different from one 4xx to the next too, and since I
> now have a non-4xx platform that needs to use EMAC and has similar clock
> control bits I might have to toggle there too, I'm basically ending up
> with a global spinlock that I can't precisely define better than "global
> clock control lock" ....
>

Do all EMAC implementations have this problem?

- - -

> Another approach would be to remove the code from EMAC and have it
> instead use the "feature call" thingy to call into platform code to do
> the magic clock tweaking (with appropriate locking) but I don't like
> much that idea as all 4xx platforms pretty much would have to duplicate
> that code, and I prefer keeping some of that magic in the EMAC driver
> itself.

I usually preferre this approach. Since the magic from one point of view 
(EMAC) is normal configuration from another.

Good candidates from EMACs(!) point of view...
	EMAC_RX_CLK_TX(int idx)
	EMAC_RX_CLK_DEFAULT(int idx)
But form clock config it is probably closer to this.
	CLK_DEFAULT(int idx)
	...

Another approach might be to factor out the modification code only,
keeping the original locking code for comparation...
	static inline modify_dcr(reg, set_mask, reset_mask)
	{
		unsigned long flags;
		local_irq_save(flags);
		mtdcr(reg, mfdcr(reg) & ~reset_mask | set_mask ))
		local_irq_restore(flags);
	}
and
	static inline SDR_MODIFY(...)

#if defined(CONFIG_405EP)
#define EMAC_RX_CLK_TX(idx) modify_dcr(0xf3, 1<< (idx), 0)
#else
#define EMAC_RX_CLK_TX(idx) SDR_MODIFY(DCRN_SDR_MFR, (0x08000000 >> idx), 0)
#endif

/RogerL
