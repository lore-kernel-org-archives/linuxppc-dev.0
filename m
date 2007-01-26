Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C693DE0DA
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 08:24:45 +1100 (EST)
Subject: Re: [RFC/PATCH 0/16] Ops based MSI Implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1wt3awbtf.fsf@ebiederm.dsl.xmission.com>
References: <1169714047.65693.647693675533.qpush@cradle>
	<m1wt3awbtf.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Sat, 27 Jan 2007 08:24:19 +1100
Message-Id: <1169846659.24996.152.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I haven't done more than skim the patches yet but I am distressed.
> 
> You code appears to be nice simple clean and to not support MSI in
> a useful way.  I may be reading too quickly but at the moment your infrastructure
> appears useless if you are on a platform that doesn't enforce MSI's get filtered
> with a legacy interrupt controller.

How so ?

We have at least 3 models we had in mind when designing this:

 - the MPIC backend : MSIs are handled by a decoder that turns them into
vector inputs on the MPIC interrupt controller

 - the Cell "AXON" backend (not finished yet) : MSI messages are written
into a ring buffer in main memory (DMAed) and an IRQ to the interrupt
controller is additionally sent when such a message is written

 - the RTAS model which is a toplevel hook and thus easy

In addition, I had in mind what x86 does and I don't see how it woudn't
fit the model.

What I see it working in a way around those lines, let me know if I
missed something:

 - alloc : allocates a vector and a linux irq, sets up the irq desc
with an irq chip mostly equivalent to what you have now, using
mask/unmask routines that toggle the mask bit (note that we should have
those in the generic code for optional use by backends) 

 - enable / disable : use the generic routines

 - setup_msi_msg : returns the appropriate address/data with all the
bits specific to the intel platform and the appropriate default
affinity.

 - free : well, should i explain ? :-)

I don't see off-hand what in that model doesn't "fit" the x86 needs.
Nowhere there is a requirement of being hooked to a separate irq
controller. One of the important ideas is that alloc() is supposed to
return a linux irq number with a fully initialized irq_desc/irq_chip.
However, that irq_chip doesn't -have- to be the one of a legacy
interrupt controller, it could be one local to the backend specific for
MSIs which uses the mask bit for mask/unmask etc... the way x86 does it.

In a way, this is similar to what we will be doing for Cell (backend not
there yet, sorry).

> You don't have MSI-X support (which is the interesting case) and you don't have
> suspend/resume support.

MSI-X is the main issue right now indeed. For suspend/resume, I was
thinking about just adding a pair of hooks to the ops, but it looks like
Michael didn't have time to add them just yet.

Those are the reasons why aren't trying to -replace- the existing code
just yet :-) And why Michael's initial implementation sat in
arch/powerpc and not in a generic place, as we felt that while it fit
our immediate needs, it wasn't quite ready to take over the world yet.

(immediate needs = pci express support, there are already devices that
don't support anything but MSI, so without at least that standard MSI
support , those devices simply don't work at all... that's also why we
have some sense of "urgency" in getting that up as without it, those
devices won't work on any PCIe powerpc machine).

> You don't support the MSI mask bit.

At first I though that could stay in the backend, but it looks like I'll
use that in the cell backend too, so we can just made a pair of generic
mask/unmask (well, two actually, one for MSI and one for MSI-X) for use
by irq_chip's in backends that use the mask bit. Should be trivial
enough.

> Looking at your msi_ops it does not map to what I am doing on x86.  There
> is the implicit assumption that the msi_message is fixed for the lifetime
> of the msi.  Which is wrong.

That's some aspect I've missed of the x86 code... in which circumstances
do you modify the message ? I know you modify the address for affinity
setting, but the message I'm not sure what for.

For affinity, you can have your set_affinity() just call back
msi_raw_enable(), or if you want, we can export an msi_raw_update...

> So in short summary I cannot use your msi_ops they are inappropriate for
> i386, x86_64 and ia64.

I think they aren't -that- inappropriate as I mostly explained above,
but let me know if you think we missed something important.

> So at the moment I am opposed to this code because as it sits it appears to
> be a serious regression.

Only if it was to replace the intel code as of today, as it does indeed
lacks some functionalities that we haven't completed yet. I don't think
the overall design is though and I do think it's saner especially when
having to deal with 3 or 4 different backends in the same kernel as we
do on powerpc (and I'm sure other archs will have similar need,
especially in the embedded field where all sort of crazy things happen).

> The additional bits that feel like this code was primarily targeted at supporting
> the RTAS with real hardware support thrown in as an after thought just seem
> to add insult to injury. 

That is both unfair and untrue. It was mostly designed around some
initial MPIC backend and with the 3 cases I described above in mind
(along with whatever I understood of the x86 case back then). We then
tweaked things a bit to make the RTAS backend "fit", mostly by defining
that enable/disable/setup can be optional, in which case alloc/free are
doing all the job (and thus become top-level hooks suitable for RTAS).

> Supporting the RTAS first and breaking everyone who actually has real
> hardware seems like very much the wrong approach to get a good
> multiple platform solution.

We have tested the MPIC (non-RTAS) model more than we have the RTAS so
this is unfair as well.
 
> After I get some sleep I will see if I can up with some constructive
> criticism on how we can make things work.

That would be great :-)

Ben.
