Return-Path: <dgibson@ozlabs.org>
Date: Thu, 25 Oct 2007 09:52:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Audio codec device tree entries
Message-ID: <20071024235214.GA23694@localhost.localdomain>
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>
	<471E12C7.8020509@freescale.com>
	<8416ea754e013a67441aec778c81ad73@kernel.crashing.org>
	<9e4733910710231529h1089eacdy888306f20af92555@mail.gmail.com>
	<471F52ED.10007@freescale.com>
	<9e4733910710240800y24952e70g8c318e35e2e45e2e@mail.gmail.com>
	<471F5FC4.1040804@freescale.com>
	<fa686aa40710240828p532e8e4axf1f9b9ad4cd324f8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40710240828p532e8e4axf1f9b9ad4cd324f8@mail.gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 24, 2007 at 09:28:42AM -0600, Grant Likely wrote:
> On 10/24/07, Timur Tabi <timur@freescale.com> wrote:
> > Jon Smirl wrote:
[snip]
> > My vote is for this version.  In fact, I think it *has* to be this way.  If
> > you're using a CS4270 codec (as I am), the I2C interface is *optional*.  So I
> > want the I2S node to point to the I2C node if it exists.
> 
> It doesn't have to be this way.  If the codec does not have a control
> interface, then it can happily be a child of the i2s node.  But if it
> *does*; don't break convention by separating it from it's control
> interface.
> 
> I strongly recommend following the lead of ethernet phys and mdio
> busses here.

Yes.  Devices should appear on the bus from which they're addressable,
that is from the control interface in this case.  Sometimes different
things need to be done for bus-bridges which are configured from a
different bus than the one they bridge, but this is not such a
situation.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
