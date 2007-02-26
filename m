Return-Path: <dgibson@ozlabs.org>
Date: Tue, 27 Feb 2007 00:08:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Message-ID: <20070226130837.GA32080@localhost.localdomain>
References: <20070222011811.GA18364@localhost.localdomain>
	<45b623f395654fc4f4920b9553794def@kernel.crashing.org>
	<20070222103410.GB11014@localhost.localdomain>
	<b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net>
	<259dc2545888e6588a8a0707ad2e84b0@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A59732@az33exm25.fsl.freescale.net>
	<1172299259.1902.22.camel@localhost.localdomain>
	<20070226041646.GC29826@localhost.localdomain>
	<4540139ce9bb2426dbcc3822e6c1a63a@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4540139ce9bb2426dbcc3822e6c1a63a@kernel.crashing.org>
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

On Mon, Feb 26, 2007 at 06:36:29AM +0100, Segher Boessenkool wrote:
> >> On the other hand, I do quite like keeping with the old principle that
> >> having interrupts == having an "interrupts" node.
> >
> > That would be nice.  On the other hand, re-using interrupts means that
> > it's possible to get a silent misparse of the interrupt information:
> 
> Incorrect parsing of interrupt info tends to end up
> in spectacular crashes, not silent at all ;-)

Well, yes, but "sorry, I can't understand this device tree" or "huh?
I can't find the interrupts" would be preferable to spectacular
crashes.

> > a
> > parser which doesn't understand the new 'interrupt-parents' property
> > will encounter the node, see the 'interrupts' property, assume that
> > the interrupt parent is the physical parent and, if the
> > #interrupt-cells values match up, which is quite possible, assume that
> > it has correctly understood the interrupt information.
> 
> Something similar is true for *every* new binding; although
> indeed if you get a misparse the effects can be disastrous,
> with interrupts.  For other cases, the kernel would have to
> say "I don't understand this device" and give up on it, which
> can easily mean a failed boot; or silently assume something
> that is just a guess at best.
> 
> You cannot boot a client program that doesn't understand the
> device tree and expect it to understand the device tree ;-)

Obviously, but I'd like the client program to *know* that it doesn't
understand the device tree.

> > This is arguably a worse behaviour than simply having an old-style
> > parser see the lack of 'interrupts' property and assume the device has
> > no interrupts.
> 
> Until recently (well, not that recently) Linux couldn't
> parse the interrupt tree correctly and would royally
> mess up in unusual cases.  Does that mean that no device
> tree in the world should use the interrupt mapping binding?
> 
> Also, a device that has interrupts but no "interrupts"
> property is *just wrong*.  There are many more things
> that (can) look at the device tree than just the kernel,
> don't let your opinion be guided solely by what you
> think the kernel would do with a tree.

It's not specific to the kernel, the same reasoning applies to any
program using the device tree.  If something that's not aware of the
new property sees a node with an 'interrupts' but no
'interrupt-parent' property, it has *no reason* to believe there's
anything more to know.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
