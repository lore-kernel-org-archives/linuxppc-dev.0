Return-Path: <roger.larsson@norran.net>
Received: from mail.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id 4055167B77
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Dec 2006 21:11:52 +1100 (EST)
From: Roger Larsson <roger.larsson@norran.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: shared config registers and locking
Date: Thu, 7 Dec 2006 19:18:39 +0100
References: <1165381847.5469.70.camel@localhost.localdomain>
	<200612070222.07456.roger.larsson@norran.net>
	<1165459663.5469.159.camel@localhost.localdomain>
In-Reply-To: <1165459663.5469.159.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200612071918.39355.roger.larsson@norran.net>
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

On Thursday 07 December 2006 03:47, Benjamin Herrenschmidt wrote:
> > > The specific example that made me think about it was some clock control
> > > registers on 4xx that the EMAC driver is whacking every now and then
> > > (on link state change, no lock contention to be worried about here),
> > > though they could be used by other drivers too (or platform code).
> > > Since those registers are a bit different from one 4xx to the next too,
> > > and since I now have a non-4xx platform that needs to use EMAC and has
> > > similar clock control bits I might have to toggle there too, I'm
> > > basically ending up with a global spinlock that I can't precisely
> > > define better than "global clock control lock" ....
> >
> > Do all EMAC implementations have this problem?
>
> No, only some of them.
>
> > Another approach might be to factor out the modification code only,
> > keeping the original locking code for comparation...
> > 	static inline modify_dcr(reg, set_mask, reset_mask)
> > 	{
> > 		unsigned long flags;
> > 		local_irq_save(flags);
> > 		mtdcr(reg, mfdcr(reg) & ~reset_mask | set_mask ))
> > 		local_irq_restore(flags);
> > 	}
> > and
> > 	static inline SDR_MODIFY(...)
>
> Since we need a spinlock here (the whole point of the exercise is to
> make it SMP and -rt safe), that means having a global spinlock used by
> modify_dcr / SDR_MODIFY which boils down to something not far from my
> proposal.

That is correct. BUT I do like my other approach better.
Add functions with names that work on for example clocks.
By doing that there will be no need to comment on what is done, only why.

Modify all users to use those functions (you will need to modify all users
for all approaches). ALL modification on clock config registers will be 
required to use the modify_dcr internally - then it might be a lot better to 
add a cleaner interface directly.

And that interface would take care of the differences in how the actual
modify clock between 405 and 440 (use of dcr or sdr).

>
> > #if defined(CONFIG_405EP)
> > #define EMAC_RX_CLK_TX(idx) modify_dcr(0xf3, 1<< (idx), 0)
> > #else
> > #define EMAC_RX_CLK_TX(idx) SDR_MODIFY(DCRN_SDR_MFR, (0x08000000 >> idx),
> > 0) #endif
>
> The ifdef's are going away in my rework in favor of something like
>
> 	if (emac_has_feature(dev, EMAC_FTR_NEED_405EP_CLK_FIX))
> 		xxxx
>
> So that we can build support for multiple models in one driver if we
> want. If we don't, the above if will turn into if (0) / if (1) depending
> on what we build for and thus the compiler will do the right thing and
> optimize out unused code. That's the approach we use already for CPU and
> firmware features and it works well.

Nice!

/RogerL
