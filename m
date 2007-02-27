Return-Path: <dgibson@ozlabs.org>
Date: Tue, 27 Feb 2007 14:45:41 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Message-ID: <20070227034541.GD1861@localhost.localdomain>
References: <9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net>
	<259dc2545888e6588a8a0707ad2e84b0@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A59732@az33exm25.fsl.freescale.net>
	<1172299259.1902.22.camel@localhost.localdomain>
	<20070226041646.GC29826@localhost.localdomain>
	<4540139ce9bb2426dbcc3822e6c1a63a@kernel.crashing.org>
	<20070226130837.GA32080@localhost.localdomain>
	<de3b5db39f5254bc8d5f859c718e7103@kernel.crashing.org>
	<20070227023243.GC1861@localhost.localdomain>
	<0bb86e9c2642f033697bfb44a4f59ff8@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0bb86e9c2642f033697bfb44a4f59ff8@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 27, 2007 at 03:52:41AM +0100, Segher Boessenkool wrote:
> >> And if a program parsing the device tree sees no valid
> >> "interrupts" property, it can validly assume the device
> >> doesn't have interrupts.
> >>
> >> Same problem.
> >
> > Sort of.  But the probable consequences of mistakenly believing a
> > device has no interrupts are substantially less messy than mistakenly
> > believing you understand the node's interrupts when you don't.
> 
> "Less messy"...  well the device won't work properly
> in either case.  The kernel might completely screw
> up programming the interrupts, which would mean it
> doesn't do enough sanity checking; or it could give
> spectacular oopses, where the "less messy" case would
> simply be a device driver not running for your device.
> 
> If the one case gives you more information to track
> down the problem than the other case, I argue that's
> a shortcoming of the kernel, not of the OF binding.

Segher, think for a moment instead of just arguing.  There just isn't
enough information available for the kernel to do sanity checking when
there is an apparently valid 'interrupts' property.  Consider:

Interrupt controllers are generally initialized with all interrupts
masked (yes, not always, but usually).  So, if a client mistakenly
believes a device has no interrupts, those interrupts will never be
configured, and the CPU will never see those interrupts.  This is only
going to cause a problem if there is an active driver which is
expecting interrupts.  But if there's a driver expecting interrupts,
it must at some point earlier have attempted to configure the
interrupts (if the client is the kernel, that's a request_irq()).  In
order to configure the interrupt, it would have parsed the device tree
to find data about the interrupt.  In doing so it would have run into
the lack of 'interrupts' property.

There's a good chance at this point it will just print an error saying
"Huh? Where's my interrupt" and abort driver initialization.  If it
doesn't do that, it's very likely it will immediately crash attempting
to dereference or parse the non-existant property.  Either way, the
problem shows up at the point we're attempting to parse the interrupt
tree, and will be pretty easy to debug.

Now, a different case.  Suppose we're using the 'interrupts' /
'interrupt-parents' approach.  We have a board with two identical
interrupt controllers, cascaded.  It has a network device with two
interrupts, the first is end-of-packet and is routed to the top-level
IC, the second signals a fairly rare error condition and is routed to
the cascaded IC.  The network device sits under a bridge which has a
single interrupt routed to the primary IC (and thus has an
'interrupt-parent' property).  So, to an old-style parser it looks
like the network device has two interrupts on the primary controller,
routed via the bridge.

When the network driver initializes, it requests its irqs, correctly
configures the first, and misconfigures the second (because it follows
the interrupt tree old-style and assumes they're all routed to the
primary IC).  It sends and receives packets fine, then the error
condition happens, but the recovery ISR is never called and the
network suddenly stops at some random time after startup.  Programmer,
baffled, tries half-a-dozen theories before noticing the error status
bit and going "but why didn't we get an interrupt?".

Or suppose the second interrupt signals a (fairly unimportant) status
change, level-sensitive.  The network driver works just fine.  Then
along comes another driver that shares an interrupt with the second
network driver interrupt.  It crashes with an unhandled interrupt on
startup if-and-only-if the network driver has had a status change
event before the second driver started.  This is common on some
networks and rare on others.  Bafflement all around...

Or for that matter, the network driver could crash with an unhandled
interrupt when the device which is really using what the network
driver thinks is its second irq, generates an interrupt.  When that
happens could depend on that other device, its driver, the board
configuration, then network or other external environment...

And those are just the first 3 recipes for utter confusion I can come
up.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
