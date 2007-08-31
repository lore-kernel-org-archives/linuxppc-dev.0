Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 12A82DE090
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Sep 2007 06:44:28 +1000 (EST)
Date: Fri, 31 Aug 2007 15:44:18 -0500
From: Scott Wood <scottwood@freescale.com>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH 3/9] 8xx: Add pin and clock setting functions.
Message-ID: <20070831204418.GA3461@ld0162-tx32.am.freescale.net>
References: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
	<20070828201719.GC24260@ld0162-tx32.am.freescale.net>
	<20070830013833.4c4d5d0b@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070830013833.4c4d5d0b@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 30, 2007 at 01:38:33AM +0400, Vitaly Bordug wrote:
> On Tue, 28 Aug 2007 15:17:19 -0500
> Scott Wood wrote:
> > +struct cpm_ioport16 {
> > +	__be16 dir, par, sor, dat, intr;
> > +	__be16 res[3];
> > +};
> > +
> Hmm. If we are using such a non-standard types, it worths at least
> explanation why...

It's so I can index into the port array.  The standard struct has
non-indexable names such as "padir", "pcpar", etc.

> > +struct cpm_ioport32 {
> > +	__be32 dir, par, sor;
> > +};
> > +
> > +static void cpm1_set_pin32(int port, int pin, int flags)
> > +{
> > +	struct cpm_ioport32 __iomem *iop;
> > +	pin = 1 << (31 - pin);
> > +
> > +	if (port == 1)
> Probably put here define or alike so that we wouldn't have confusion what 1/whatever port number does mean.
> Or some comment explaining for PQ newcomer what's going on here. ditto below.

I suppose I could add CPM_PORTA, CPM_PORTB, etc. defines.

> > +int cpm1_clk_setup(enum cpm_clk_target target, int clock, int mode)
> > +{
> > +	int shift;
> > +	int i, bits = 0;
> > +	u32 __iomem *reg;
> > +	u32 mask = 7;
> > +
> gotta at least briefly explain the clue here, too.

I'm not sure what you mean... what exactly are you asking me to explain?

Note that this code is mostly duplicated from the existing CPM2 version.

> We're adding helper functions and should be ready that something
> somewhere won't work as expected.

Could you elaborate on what you expect to possibly not work, or what we
should do to "be ready"?

> > diff --git a/include/asm-powerpc/commproc.h
> > b/include/asm-powerpc/commproc.h index ccb32cd..a95a434 100644
> > --- a/include/asm-powerpc/commproc.h
> > +++ b/include/asm-powerpc/commproc.h
> > @@ -692,4 +692,45 @@ extern void cpm_free_handler(int vec);
> >  #define IMAP_ADDR		(get_immrbase())
> >  #define IMAP_SIZE		((uint)(64 * 1024))
> >  
> Pull from the dts?

It is.  I kept IMAP_ADDR around to ease interdependencies on changes in
drivers/net/fs_enet.  It appears IMAP_SIZE isn't used.

-Scott
