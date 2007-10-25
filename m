Return-Path: <dgibson@ozlabs.org>
Date: Thu, 25 Oct 2007 10:38:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Audio codec device tree entries
Message-ID: <20071025003849.GB24382@localhost.localdomain>
References: <471F52ED.10007@freescale.com>
	<9e4733910710240800y24952e70g8c318e35e2e45e2e@mail.gmail.com>
	<fa686aa40710240816l6187b559l31fb72656ec265c@mail.gmail.com>
	<fa686aa40710240820l62d5a50ewcd7707fed8f9176f@mail.gmail.com>
	<9e4733910710240828x412f598dy7fc4a75faa76358d@mail.gmail.com>
	<fa686aa40710240843r5271c749m33bce043702603b7@mail.gmail.com>
	<9e4733910710240854y6ac115b6i5e0400eb369fcf7@mail.gmail.com>
	<fa686aa40710240938l5b8c30b9qe538cc641df5e61b@mail.gmail.com>
	<20071025000425.GD23694@localhost.localdomain>
	<9e4733910710241717i3c436e76l48f6c273d7114b94@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910710241717i3c436e76l48f6c273d7114b94@mail.gmail.com>
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

On Wed, Oct 24, 2007 at 08:17:57PM -0400, Jon Smirl wrote:
> On 10/24/07, David Gibson <david@gibson.dropbear.id.au> wrote:
> > I'm afraid I still don't understand quite what information this
> > "fabric" driver is conveying.  Is it really inherently platform
> > specific, or is it something that can be encoded directly in a
> > sensible way.  If the latter we could have a general "device tree"
> > fabric driver that will handle all systems with the layout correctly
> > encoded in the device tree.
> 
> Codecs are like GPIOs, all of their pins are programmable. So the same
> codec can be wired into various boards quite differently and then
> software programmed to work the same. The fabric driver contains the
> mapping information.
> 
> People were making a codec driver for each board, but this resulted in
> lots of similar codec drivers for the same chips. I believe a common
> Wolfson chip had eight drivers in the kernel. In the new model the
> codec drivers are generic and the fabric driver describes the mapping.

Ok, but the fabric driver is about the wiring of a specific codec
chip, yes?  If a board was foolishly designed to have two identical
codec chips, but each wired differently, it would need two instances
of the same codec driver, plus one instance each of two different
fabric drivers?

If this is so, then the fabric information *must* be per-codec, and
should therefore go with the codec node.

> A side effect of this is that we need to load the fabric driver which
> doesn't have a device associated with it.

Well, it does have a device associated with it, it's just a question
of how to represent it.  There's not reason a single device node can't
cause instantiation of multiple driver instances.  Depending on the
complexity of typical fabric arrangements, one of the following
options might make sense:
	- the device node's compatible has enough information to
specify both fabric and codec driver.  The fabric driver is
instantiated from this node, and instantiates the codec driver itself
(since I gather fabric drivers are frequently codec specific in any
case).
	- both fabric and codec drivers are instantiated from the same
device node, and co-ordinate with each other.
	- The codec is represented as:
codec-fabric@... {
	compatible = "...";
	<properties describing the fabric>
	codec {
	      compatible = "...";
	      <properties describing the codec>
	}
}

This is different from a "pseudo" node, because the codec-fabric node
represents a real piece of hardware:  specifically the cluster of
wires between the sound bus and the codec.

Remember: the device tree describes the hardware, how the chooses to
structure its driver model to meet the demands of that hardware is up
to it.  Don't put the cart before the horse.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
