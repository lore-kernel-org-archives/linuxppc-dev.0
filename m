Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40710240843r5271c749m33bce043702603b7@mail.gmail.com>
Date: Wed, 24 Oct 2007 09:43:36 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Audio codec device tree entries
In-Reply-To: <9e4733910710240828x412f598dy7fc4a75faa76358d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910710221859q6ea54810nba58907d5ddd966d@mail.gmail.com>
	<471E12C7.8020509@freescale.com>
	<8416ea754e013a67441aec778c81ad73@kernel.crashing.org>
	<9e4733910710231529h1089eacdy888306f20af92555@mail.gmail.com>
	<471F52ED.10007@freescale.com>
	<9e4733910710240800y24952e70g8c318e35e2e45e2e@mail.gmail.com>
	<fa686aa40710240816l6187b559l31fb72656ec265c@mail.gmail.com>
	<fa686aa40710240820l62d5a50ewcd7707fed8f9176f@mail.gmail.com>
	<9e4733910710240828x412f598dy7fc4a75faa76358d@mail.gmail.com>
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

On 10/24/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 10/24/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> > > Two valid methods have been proposed
> > > 1. a codec-
> >
> > oops
> >
> > 1. a codec-handle property in the i2s node
> > 2. an i2s-handle property in the codec node
> >
> > Either are reasonable.  I prefer putting the handle in the i2s node;
> > but I'm looking at it from the way that ethernet phys are being
> > described currently.  The other is also perfectly valid.
> >
> > I suppose it depends on what point of view you see the system from; either:
> > a. the codec is supported by the i2s bus, in which case use the
> > i2s-handle property
> > b. the i2s bus is supported by the codec; in which case use the
> > codec-handle property.
>
> Do you want to pick one and add it to the device tree documentation
> with an example for i2s and ac97? I'll use which ever one is picked.

Sure, I'll draft something up and post it for review.

On the device probing front; what about this method:

Rather than trying to figure things out from the board model, or the
combination of the codec and i2s bus; add another node to represent
the sound circuit.  All that node would need is a unique compatible
property and a phandle to either the i2s bus or the codec (depending
on which binding approach is used).  It could have additional
properties to represent optional features, etc.

For example:
sound@0 {
      compatible = "<mfg>,<board>,sound"   // The board might have
more than one sound i/f which could be wired differently
      codec-handle = <&codec0>;
};

This would give your fabric driver something unique to probe on; but
the i2c, i2s and codec nodes which actually describe interconnects
will still be present.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
