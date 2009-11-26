Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B1DAC1007D8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 15:21:30 +1100 (EST)
Subject: Re: [RFC PATCH 02/19] powerpc: gamecube: device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40911221502g2de254d2o4341d9abed0cdf41@mail.gmail.com>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221502g2de254d2o4341d9abed0cdf41@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 26 Nov 2009 15:21:23 +1100
Message-ID: <1259209283.16367.241.camel@pasglop>
Mime-Version: 1.0
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2009-11-22 at 16:02 -0700, Grant Likely wrote:

> > +       /* devices contained int the flipper chipset */
> > +       soc {
> 
> It would be better to rename this as IMMR or the bus type.  This node
> doesn't actually describe the entire chip, but describes the internal
> memory mapped registers.

I would really just call it "flipper" :-)

> > +               #address-cells = <1>;
> > +               #size-cells = <1>;
> > +               #interrupt-cells = <1>;
> > +               model = "flipper";
> 
> Drop the model property
> 
> > +               compatible = "nintendo,flipper";
> > +               clock-frequency = <162000000>; /* 162MHz */
> > +               ranges = <0x0c000000 0x0c000000 0x00010000>;
> 
> Since you're only doing 1:1 mappings; you could replace this with an
> empty "ranges;" property instead.

On the other hand it is a useful "documentation" to specify the exact
range decoded when you know it :-) For non documented HW I prefer when
the DT contains as precise information as possible. It also allows, if
so wished, to create proper hierarchical struct resource in the kernel
that represent the bus hierarchy in a nicer way. So I vote for keeping
that in.

> > +
> > +               video@0c002000 {
> > +                       compatible = "nintendo,flipper-video";
> > +                       reg = <0x0c002000 0x100>;
> > +                       interrupts = <8>;
> > +                       interrupt-parent = <&pic>;
> 
> Hint:  If you move the interrupt-parent property up to the root node,
> then you don't need to specify it in every single device node; it will
> just inherit from the parent.

Note that this is a linux-ism no ? (aka ePAPRism). If they aim toward
having a real OF which I think they do they may wish to pass on this
trick.

> > +                       /* XFB is the eXternal FrameBuffer */
> > +                       xfb-start = <0x01698000>; /* end-of-ram - xfb-size */
> > +                       xfb-size = <0x168000>;
> 
> Can 'xfb' be made a second tuple to the 'reg' property so that all the
> address mapping code works on it?  ie:
> 
> reg = <0x0c002000 0x100
>        0x01698000 0x168000>;
>
> At the very least, it is wise to adopt the same form as the reg
> property when describing address ranges instead of splitting it into
> multiple properties.

I agree with using the same form as reg. I'm not sure about using "reg",
it depends. Albert, is that xfb location something that is configurable
or is it fixed ? If it's configurable, it could remain a separate
property I suppose, since it overlaps main memory, it's a bit fishy to
have it in "reg"... you do seem to strip off the fb from the memory
"reg" property though... Maybe the right thing to do is to leave the
memory "reg" property to be the whole RAM and just reserve the area
covered by the fb ?

> > +               /* External Interface bus */
> > +               exi@0c006800 {
> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +                       compatible = "nintendo,flipper-exi";
> > +                       reg = <0x0c006800 0x40>;
> > +                       interrupts = <4>;
> > +                       interrupt-parent = <&pic>;
> > +
> > +                       USBGECKO0: usbgecko@0c006814 {
> > +                               compatible = "usbgecko,usbgecko";
> > +                               reg = <0x0c006814 0x14>;
> > +                               virtual-reg = <0xcc006814>;
> > +                       };
> > +               };
> > +        };
> > +};
> > +

Shouldn't the above be dynamically detected ?

Cheers,
Ben.
