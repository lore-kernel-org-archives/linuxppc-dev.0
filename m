Return-Path: <dgibson@ozlabs.org>
Date: Thu, 25 Oct 2007 09:55:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Audio codec device tree entries
Message-ID: <20071024235511.GB23694@localhost.localdomain>
References: <471E12C7.8020509@freescale.com>
	<8416ea754e013a67441aec778c81ad73@kernel.crashing.org>
	<9e4733910710231529h1089eacdy888306f20af92555@mail.gmail.com>
	<471F52ED.10007@freescale.com>
	<9e4733910710240800y24952e70g8c318e35e2e45e2e@mail.gmail.com>
	<fa686aa40710240816l6187b559l31fb72656ec265c@mail.gmail.com>
	<fa686aa40710240820l62d5a50ewcd7707fed8f9176f@mail.gmail.com>
	<9e4733910710240828x412f598dy7fc4a75faa76358d@mail.gmail.com>
	<fa686aa40710240843r5271c749m33bce043702603b7@mail.gmail.com>
	<9e4733910710240854y6ac115b6i5e0400eb369fcf7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910710240854y6ac115b6i5e0400eb369fcf7@mail.gmail.com>
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

On Wed, Oct 24, 2007 at 11:54:23AM -0400, Jon Smirl wrote:
> On 10/24/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> > > Do you want to pick one and add it to the device tree documentation
> > > with an example for i2s and ac97? I'll use which ever one is picked.
> >
> > Sure, I'll draft something up and post it for review.
> >
> > On the device probing front; what about this method:
> >
> > Rather than trying to figure things out from the board model, or the
> > combination of the codec and i2s bus; add another node to represent
> > the sound circuit.  All that node would need is a unique compatible
> > property and a phandle to either the i2s bus or the codec (depending
> > on which binding approach is used).  It could have additional
> > properties to represent optional features, etc.
> 
> That's the pseudo-sound node proposal that other people objected to.
> 
> It makes sense to me, there needs to be some way to trigger loading
> the fabric driver.
> 
> >
> > For example:
> > sound@0 {
> >       compatible = "<mfg>,<board>,sound"   // The board might have
> > more than one sound i/f which could be wired differently
> >       codec-handle = <&codec0>;
> > };
> 
> Do you even need the parameters,  how about simply this?
> 
> sound-fabric {
> };
> 
> That will trigger loading all of the sound-fabric drivers built into
> the kernel. In their probe functions they can look in the device tree
> and extract the machine name and then decide to stay loaded or fail
> the probe.

We shouldn't be basing driver configuration on the machine name unless
we really have to.  We should be able to find a sane way to encode the
necessary information in the tree proper.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
