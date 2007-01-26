Return-Path: <grundler@lackof.org>
Received: from colo.lackof.org (colo.lackof.org [198.49.126.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.lackof.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C0235DE02C
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 07:40:48 +1100 (EST)
Date: Fri, 26 Jan 2007 10:19:28 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC/PATCH 14/16] MPIC MSI backend
Message-ID: <20070126171928.GA22275@colo.lackof.org>
References: <1169714047.65693.647693675533.qpush@cradle>
	<20070125083417.69895DE3C5@ozlabs.org>
	<20070126064352.GA328@colo.lackof.org>
	<m1ejpiw9s8.fsf@ebiederm.dsl.xmission.com>
	<5A6F70E0-A8AB-4636-8F41-2EC82A3B13B7@kernel.crashing.org>
	<m1r6thvjdq.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <m1r6thvjdq.fsf@ebiederm.dsl.xmission.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Brice Goglin <brice@myri.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S.Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 26, 2007 at 09:32:33AM -0700, Eric W. Biederman wrote:
> > Well of course it's connected to real hardware.  The virq
> > numbers are a flat space; hwirqs are not (those are relative
> > to one certain interrupt controller) so virqs are easier
> > in use.
> 
> ....However they are the linux abstraction of the hardware and
> as such a useful mapping to the hardware is not required.

What?!!! The whole point of the abstraction ("flat space") is
to be able to do reverse lookups for additional information.

> ia64 is the strong culprit
> in this regard, and simply picks the next free number it can use
> when a device asks for an irq.

I think this is the only viable aproach to support MSI migration.
Basing the "virq" value on bits in the addr/data pair can't migrate.

...
> The minimum silicon version of the destination of an MSI really only
> needs the ability to record that it happened.

"it" == record the data value sent to a specific address.

If the IRQ handler lookup is done in HW it can save us a substantial number
of CPU cycles before we invoke the corresponding handler.

> A prioiri setup of the
> controller (in hardware) for each individual MSI source interrupt
> seems to imply extra hardware logic, and limit the total number of
> MSI's the system can handle for no apparent reason.  For that
> reason I expect more systems to do things closer to how x86 does it.
> If for no other reason than because it is less logic to validate.

It doesn't matter how many systems "do things closer to how x86"
works since 95% (or more) of the systems running linux are x86.
Linux MSI support must work on x86.

Helping Michael make it work would be a constructive way forward.
I think Michael has the abstraction correct so it's NOT x86 centric
but still works optimally on x86.

> On x86 the only hardware we have to deal with is the 8 bit number
> delivered to the cpu at interrupt time and the MSI registers.

8 bit number? That's the Intel Interrupt architecture definition.
The PCI spec defines 16-bit messages for MSI. The chipsets
can implement any number of bits they want up to that limits.

> All of
> the rest of the x86 logic needed to translate MSI interrupts to
> processor bus messages and the like has no registers we can set

Are the EID and ID fields defined in Intel adrresses not programmable?
Those are part of the MSI address.

> and
> always behaves exactly the same way so is for all intents and purposes
> transparent.  The PCI-HT bridge logic for MSI is the most visible our
> logic for MSI ever becomes.  As for the destination window it is an
> architecturally defined target with fixed meanings for all of the bits
> on every system.  So by transparent I mean that we don't have to
> perform any per irq setup in the hardware except the pci card to make
> MSI's work.

I had the impression "we" was the OS and the setup was being done by BIOS.
IIRC, main reason for doing setup in BIOS was to enable existing OS versions
to run new HW without any changes. Paying customers like that sort of thing.

thanks,
grant

> The big difference here between what you have and what x86 has
> is that on x86 I can easily setup a pool of locations usable
> by MSI allocate a location, and then independently associate
> that with an MSI irq.  Apparently PPC cannot do that, although
> from what little I have heard about the MPIC just now I don't 
> understand why not.  Any clue where I can find a MPIC datasheet?
> 
> I care about more than x86 but x86 and derivatives is the platform
> I primarily work with, have test hardware for, and understand all
> of the details of.  To make an abstraction that works across all
> platforms and to help maintain that I need to understand all of the
> relevant details so I do care about ppc.  Especially when I have ppc
> people I can work with.
> 
> Likewise what is different about x86 needs some explaining so it becomes
> clear why msi_ops do not handle what x86 is doing today.  The big
> difference there comes with irq migration because when we migrate an
> irq we must reprogram the msi registers on the cards themselves,
> likewise when we mask an irq we must mask it using the msi registers.
> 
> >From that comes our need for a data structure to map from an irq to a
> msi data structure in a generic fashion, because we don't just program
> the pci card and forget about it.  From those requirements comes our
> need for a little bit more complete support of the features of the
> hardware that Michaels implementation.
> 
> Eric
