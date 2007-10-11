Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by ozlabs.org (Postfix) with ESMTP id F35F7DDFDD
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2007 15:27:15 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so518639wag
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2007 22:27:14 -0700 (PDT)
Message-ID: <fa686aa40710102227j474a4025p6f3aa7118adf03db@mail.gmail.com>
Date: Wed, 10 Oct 2007 23:27:14 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Josh Boyer" <jwboyer@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Device tree bindings for Xilinx devices
In-Reply-To: <20071011050850.GI14873@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071008075127.9887.38702.stgit@trillian.cg.shawcable.net>
	<1192048682.5534.92.camel@localhost.localdomain>
	<20071011013817.GB14873@localhost.localdomain>
	<fa686aa40710101925x6b005aa7paaeb072ba492c81f@mail.gmail.com>
	<20071011040622.GE14873@localhost.localdomain>
	<fa686aa40710102118p3e62d06eqff8db252772eb58c@mail.gmail.com>
	<20071011042441.GG14873@localhost.localdomain>
	<fa686aa40710102158r5d488d3kae3d02177625da1e@mail.gmail.com>
	<20071011050850.GI14873@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/10/07, David Gibson <dwg@au1.ibm.com> wrote:
> > My main concern is that I don't like the implicit numbering that
> > occurs simply based on the order of devices in the device tree.  If
> > the probe algorithm ever changes to parse in reverse order or
> > something reorders the tree, then the device numbers also change.  :-(
>
> Way of the future, apparently, everything's supposed to use udev to
> give things logical names.  No, I'm not thrilled at the prospect
> either.

...

So in the OF aliases approach, would udev need to read the aliases
node when assigning names to devices?

>
> > I'd rather be explicit.  In fact I've already been bitten by this
> > where the mpc5200 has 6 PSC, each of which can be configured as a
> > serial port.  However, I've got access to 3 different boards; each of
> > which has the logical port numbers 100% unrelated to the 'cell'
> > number.
>
> In any case, this can't really belong in a *device* binding.  Because
> the numbering has to cross devices of the same basic type, but
> different implementations.  Where "basic type" is based on how device
> names are allocated, and is thus inherently Linux specific.

Okay, that makes sense.

> > > Segher's suggestion of using OF-style aliases for this is a fairly
> > > good one, actually.  I just need to get to implementing it...
> >
> > /me needs to look up what that look like and how I would use it.  My
> > knowledge of OF is sadly lacking.
>
> Short version by example:
> / {
>         /* ... */
>         aliases {
>                 hd = "/pci@f0000000/sata@f4000000/....";
>                 enet0 = "/soc/ethernet@c000";
>                 enet1 = "/soc/ethernet@d000";
>                 enet2 = "/pci@f0000000/isa/ethernet@i480"
>                 ttya = "/soc/serial@e000";
>                 ttyb = "/pci/isa/serail@3f8";
>         }
> }

Ah, my plan worked...  I got you to teach me about OF aliases and I
have to do any work myself.  :-)

Hmm, yes that would provide the information nicely.  As long as the
data is in the tree, I'm pretty happy.

Cheers,
g.

>
> --
> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _other_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
