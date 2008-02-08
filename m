Return-Path: <dgibson@ozlabs.org>
Date: Fri, 8 Feb 2008 17:14:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] [POWERPC] get rid of `model = "UCC"' in the ucc nodes
Message-ID: <20080208061451.GC26868@localhost.localdomain>
References: <20080201150126.GB26545@localhost.localdomain>
	<72B60725-FB4A-42FA-832D-8FD5434B9042@kernel.crashing.org>
	<fa686aa40802010823n1b837ffk7110a72e2bd44bf6@mail.gmail.com>
	<20080205132026.GE7983@localhost.localdomain>
	<fa686aa40802050839k652aeb4ga0e6b304d91ee9dd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40802050839k652aeb4ga0e6b304d91ee9dd@mail.gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 05, 2008 at 09:39:02AM -0700, Grant Likely wrote:
> On 2/5/08, David Gibson <david@gibson.dropbear.id.au> wrote:
> > On Fri, Feb 01, 2008 at 09:23:47AM -0700, Grant Likely wrote:
> > > cell-index has been useful for things like clock controllers to know
> > > what offset into a shared clock control register or something like
> > > that and a driver would pass the cell-index value to the shared reg
> > > driver when requesting service.
> >
> > Right.  Except that if the shared resource is just a single register,
> > calling the routines to access it a "shared reg driver" gives a
> > misleading impression.  Depending on how the shared reg is used, even
> > a lock may not be necessary, so potentially the drivers for the
> > individual device instances using the shared resource can (safely)
> > directly access it.
> 
> Fair enough.  In the case of a single shared, or a homogeneous set of
> shared registers (all of them use the same index) I can see the
> argument for cell index.

Yes, that's the situation it was created for.

> However, there are places where cell-index is being used where the
> value of cell-index has no relation to the offset into a register.
> But what about the case where the device uses multiple shared
> registers, each one using a *different* offset.  cell-index doesn't
> describe this situation well (or at least no better than just using
> the value of reg instead, a translation is still required)

Absolutely.  This is not a suitable situation in which to use
cell-index.

[snip]
> >From booting-without-of (in the EMAC description):
> - cell-index        : 1 cell, hardware index of the EMAC cell on a
> given ASIC (typically 0x0 and 0x1 for EMAC0 and EMAC1 on each Axon
> chip.
> 
> So, even if the intent was for cell-index to specify offsets into
> shared regs, the description does not reflect that purpose.  And
> reading thorough the rest of the document, cell-index is described
> purely in terms of enumerating ip blocks, so that is clearly the
> assumption that people are making when using it.
> 
> In other words, my point is this:  *If* cell-index is just a way to
> encode the manufacturing assigned ip-block number (EMAC0, EMAC1, etc)
> then there is probably little or no value in it.  The two arguments I
> see for using cell-index in that mode are:
> 
> 1) to offset into shared registers (but this doesn't hold because ip
> block numbers often don't match register offsets and the reg property
> would be just as suitable)
> 
> 2) to logically identify ip blocks to the user (but cell-index was
> never intended for this and /aliases is a better solution anyway)

Right.  The confusion arises because cell-index was invented on 4xx,
where it's common practice to index global registers by the ip block
number.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
