Return-Path: <dgibson@ozlabs.org>
Date: Tue, 8 Jul 2008 13:41:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Add MPC5200B base board mvBC-P
Message-ID: <20080708034122.GC1549@yookeroo.seuss>
References: <486E515B.80508@matrix-vision.de>
	<20080706235046.GA6267@yookeroo.seuss>
	<4871CA6E.9080805@matrix-vision.de>
	<fa686aa40807070712x77ff7aben4cf51731bb4f5985@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40807070712x77ff7aben4cf51731bb4f5985@mail.gmail.com>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>,
	Andre Schwarz <andre.schwarz@matrix-vision.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 07, 2008 at 08:12:11AM -0600, Grant Likely wrote:
> On Mon, Jul 7, 2008 at 1:49 AM, Andre Schwarz
> <andre.schwarz@matrix-vision.de> wrote:
> > David,
> >
> > thanks - removed "device_type" from the DMA controller.
> >
> > Which nodes actually require "device_type" and which don't ?
> >
> > Is there some general rule ?
> 
> Segher, David;
> 
> In OF, what is the purpose of device_type?  From what I understand
> right now, each value of device_type claims a software interface that
> the device supports.  So for example, device_type = "serial" means
> that firmware supports using the device as a serial port, correct?

That's correct.  And more specially allows using it as a serial port
using the OF defined method interface.

> So, similarly, if OF did not have a driver for the device, then the
> presence a device_type property would be a bug, right?

Um.. not precisely sure about this case, don't know if 1275 allows
device nodes with no OF driver / method interface.

> Does device_type indicated any other information other than firmware
> driver interface?

In theory, no.  In practice... sort of, sometimes, maybe.

> I had an epiphany about device_type this weekend (and by epiphany, I
> mean realizing my own stupidity).  If I'm correct about the above
> questions, then that would mean it is *always* a bug to have a
> device_type property in .dts file because there is no firmware
> interface.  So, it seems to me that we shouldn't just be eliminating
> undefined device_type values, but also eliminate the ones that are
> defined in OF because .dts users do not support the firmware driver
> interface.
> 
> Am I correct?

Again, in theory, yes.  In practice.. maybe.

As you say, device_type is only supposed to describe the firmware
provided software-interface and should not be used for other device
identification purposes.  However, because device_type used to be
present on basically everything, it sometimes is, by Linux and
presumably also by other OSes.

We certainly don't want to encourage or perpetuate that incorrect use,
which is why we're so insistent that people don't invent new
device_type values or use ones that aren't described in the existing
1275 bindings.

There are the few "special" devices that don't typically have
'compatible' values, so there isn't really any way to identify them
other than 'device_type' and name.  That's the memory and cpu nodes
typically, and sometimes pci IIRC (PCI bridges really should have a
compatible value to describe their register interface, but I have a
feeling they fairly often don't).  ISA nodes may fall in this category
too, I forget.  I am strongly inclined to continue recommending
device_type be present in these cases rather than relying solely on
the name, or inventing a new way of marking these nodes.

Then there are the devices that do generally have 'compatible', but do
have long established device_type values: "serial" and "network" are
the main ones.  We might be able to just drop the device_type values
here and have nothing break.  Unfortunatly, I rather suspect some
drivers will check the device_type value, even though they shouldn't.
Therefore I'm mildly inclined to at least suggest that device_type be
optionally present for improved compatibility with legacy code.

> The only situation where I can see it being appropriate to specify
> device_type is to work around older bindings that are ambiguous with
> their other properties.

Exactly right.  The important thing is to always be aware than *any*
presence of device_type in a flattened tree is basically a hack for
compatibility with code expecting real-OF-like trees; it has no
inherent purpose in a flattened tree.

Unfortunately getting people writing trees to realise this, when the
property has that name, and appears freqeutnly in existing trees,
seems to be a tricky problem.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
