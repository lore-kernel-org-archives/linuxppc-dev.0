Return-Path: <dgibson@ozlabs.org>
Date: Thu, 25 Oct 2007 10:04:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Audio codec device tree entries
Message-ID: <20071025000425.GD23694@localhost.localdomain>
References: <8416ea754e013a67441aec778c81ad73@kernel.crashing.org>
	<9e4733910710231529h1089eacdy888306f20af92555@mail.gmail.com>
	<471F52ED.10007@freescale.com>
	<9e4733910710240800y24952e70g8c318e35e2e45e2e@mail.gmail.com>
	<fa686aa40710240816l6187b559l31fb72656ec265c@mail.gmail.com>
	<fa686aa40710240820l62d5a50ewcd7707fed8f9176f@mail.gmail.com>
	<9e4733910710240828x412f598dy7fc4a75faa76358d@mail.gmail.com>
	<fa686aa40710240843r5271c749m33bce043702603b7@mail.gmail.com>
	<9e4733910710240854y6ac115b6i5e0400eb369fcf7@mail.gmail.com>
	<fa686aa40710240938l5b8c30b9qe538cc641df5e61b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40710240938l5b8c30b9qe538cc641df5e61b@mail.gmail.com>
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

On Wed, Oct 24, 2007 at 10:38:11AM -0600, Grant Likely wrote:
> On 10/24/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > On 10/24/07, Grant Likely <grant.likely@secretlab.ca> wrote:
[snip]
> > > For example:
> > > sound@0 {
> > >       compatible = "<mfg>,<board>,sound"   // The board might have
> > > more than one sound i/f which could be wired differently
> > >       codec-handle = <&codec0>;
> > > };
> 
> The difference here is that the node provides real information about
> the board.  It has a compatible field which tells you *exactly* what
> sound circuit is present on the board.  It can have additional
> information that does make sense to encode into the device tree (ie.
> the codec that is used).  It's not addressable (no registers or
> anything), but it does describe the board.
> 
> It would be possible and reasonable for a single fabric driver to work
> with many different circuit layouts as long as it has the information
> needed to adapt each instance.

This still seems nasty, since it seems to do little but duplicate the
platform information.

I'm afraid I still don't understand quite what information this
"fabric" driver is conveying.  Is it really inherently platform
specific, or is it something that can be encoded directly in a
sensible way.  If the latter we could have a general "device tree"
fabric driver that will handle all systems with the layout correctly
encoded in the device tree.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
