Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by ozlabs.org (Postfix) with ESMTP id BDABADE05F
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 03:39:05 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so766221anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Feb 2008 08:39:02 -0800 (PST)
Message-ID: <fa686aa40802050839k652aeb4ga0e6b304d91ee9dd@mail.gmail.com>
Date: Tue, 5 Feb 2008 09:39:02 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Kumar Gala" <galak@kernel.crashing.org>,
	"Jon Loeliger" <jdl@jdl.com>, linuxppc-dev@ozlabs.org,
	"Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH] [POWERPC] get rid of `model = "UCC"' in the ucc nodes
In-Reply-To: <20080205132026.GE7983@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080201150126.GB26545@localhost.localdomain>
	<72B60725-FB4A-42FA-832D-8FD5434B9042@kernel.crashing.org>
	<fa686aa40802010823n1b837ffk7110a72e2bd44bf6@mail.gmail.com>
	<20080205132026.GE7983@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 2/5/08, David Gibson <david@gibson.dropbear.id.au> wrote:
> On Fri, Feb 01, 2008 at 09:23:47AM -0700, Grant Likely wrote:
> > cell-index has been useful for things like clock controllers to know
> > what offset into a shared clock control register or something like
> > that and a driver would pass the cell-index value to the shared reg
> > driver when requesting service.
>
> Right.  Except that if the shared resource is just a single register,
> calling the routines to access it a "shared reg driver" gives a
> misleading impression.  Depending on how the shared reg is used, even
> a lock may not be necessary, so potentially the drivers for the
> individual device instances using the shared resource can (safely)
> directly access it.

Fair enough.  In the case of a single shared, or a homogeneous set of
shared registers (all of them use the same index) I can see the
argument for cell index.

However, there are places where cell-index is being used where the
value of cell-index has no relation to the offset into a register.
But what about the case where the device uses multiple shared
registers, each one using a *different* offset.  cell-index doesn't
describe this situation well (or at least no better than just using
the value of reg instead, a translation is still required)

> > Typically, shared registers and the like are all chip specific and the
> > behaviour of the shared register drivers usually needs to be tweaked
> > for different SoCs.  Each ip core on an SoC is already uniquely
> > indexed via the reg property.  True, 'reg' is sparse (0x2000, 0x2200,
> > 0x2300, ...) whereas cell-index is tight (0,1,2,3,...), but I don't
> > think that introduces any additional difficulty.
> >
> > So, instead of a driver passing it's cell-index value to the shared
> > reg driver, it would pass it's reg base instead.  The shared register
> > driver could then choose an internal representation that makes sense
> > for it instead of whatever layout was chosen by the device tree.
>
> Except that the "shared reg driver" then needs a way to map from reg
> property to index.  So either it has to have that hardcoded, or the
> shared resource will need its own device tree representation for the
> mapping.

SoCs are fickle things; Writing code to handle differences between the
same devices on different SoCs is going to happen anyway.  Isn't that
what a device driver is for?  :-)

>
> In some cases the shared resource is complex enough that that makes
> sense (e.g. an mdio bus shared between ethernet MACs to take an
> extreme example).  But when the "shared reg driver" consists entirely
> of:
>         (readl(shared_reg_addr) & (1UL << cell_index))
> and/or:
>         writel(shared_reg_addr, 1UL << cell_index)
> your approach would seem to be overkill and then some.  (The latter
> example can be safe without locking in the case of a read/clear
> register).
>
> Exactly this sort of thing is fairly common on 4xx, which is just the
> context in which BenH invented "cell-index" as a really simple way of
> representing the index into shared registers like this.

>From booting-without-of (in the EMAC description):
- cell-index        : 1 cell, hardware index of the EMAC cell on a
given ASIC (typically 0x0 and 0x1 for EMAC0 and EMAC1 on each Axon
chip.

So, even if the intent was for cell-index to specify offsets into
shared regs, the description does not reflect that purpose.  And
reading thorough the rest of the document, cell-index is described
purely in terms of enumerating ip blocks, so that is clearly the
assumption that people are making when using it.

In other words, my point is this:  *If* cell-index is just a way to
encode the manufacturing assigned ip-block number (EMAC0, EMAC1, etc)
then there is probably little or no value in it.  The two arguments I
see for using cell-index in that mode are:

1) to offset into shared registers (but this doesn't hold because ip
block numbers often don't match register offsets and the reg property
would be just as suitable)

2) to logically identify ip blocks to the user (but cell-index was
never intended for this and /aliases is a better solution anyway)

> > Dropping cell-index would mean one less property to keep in sync when
> > tailoring device trees. (== less complexity for board porters).
> > Besides, the purpose of cell-index is often misunderstood already by
> > people trying to use it to describe port numbers (ttyS0, ttyS1, etc).
>
> This is indeed a problem.  But I don't think ditching cell-index
> entirely is a sensible solution, sorry.

Gah!  Don't apologize!  :-)  My goal was to spur on debate to better
firm up our device tree conventions.  Mission accomplished (or at
least in progress.)  :-)

Also, I can probably be convinced on the continued usage of
cell-index, but as it stands right now I think we're over using it.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
