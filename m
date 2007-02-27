Return-Path: <dgibson@ozlabs.org>
Date: Tue, 27 Feb 2007 13:32:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Message-ID: <20070227023243.GC1861@localhost.localdomain>
References: <20070222103410.GB11014@localhost.localdomain>
	<b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net>
	<259dc2545888e6588a8a0707ad2e84b0@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A59732@az33exm25.fsl.freescale.net>
	<1172299259.1902.22.camel@localhost.localdomain>
	<20070226041646.GC29826@localhost.localdomain>
	<4540139ce9bb2426dbcc3822e6c1a63a@kernel.crashing.org>
	<20070226130837.GA32080@localhost.localdomain>
	<de3b5db39f5254bc8d5f859c718e7103@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <de3b5db39f5254bc8d5f859c718e7103@kernel.crashing.org>
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

On Mon, Feb 26, 2007 at 03:26:38PM +0100, Segher Boessenkool wrote:
> >> Incorrect parsing of interrupt info tends to end up
> >> in spectacular crashes, not silent at all ;-)
> >
> > Well, yes, but "sorry, I can't understand this device tree" or "huh?
> > I can't find the interrupts" would be preferable to spectacular
> > crashes.
> 
> Yes, of course.  It sometimes just can't be helped though.
> 
> Oh btw, since Linux has the new interrupt mapping code, you
> quite probably will *not* hard crash, the kernel notices the
> interrupt map isn't sane and uses a fallback.  You can get
> unlucky of course.  Also, and this is just an inherent problem
> to all interrupts, many important devices just don't work
> without correctly configured interrupts (or their Linux drivers
> don't).  With ATA at least you still get one block through
> every 30s, but that is hardly optimal ;-)
> 
> >> You cannot boot a client program that doesn't understand the
> >> device tree and expect it to understand the device tree ;-)
> >
> > Obviously, but I'd like the client program to *know* that it doesn't
> > understand the device tree.
> 
> Solving that would be equivalent to the halting problem I'm
> afraid.  It can be done for *simple* cases of course.
> 
> > It's not specific to the kernel, the same reasoning applies to any
> > program using the device tree.  If something that's not aware of the
> > new property sees a node with an 'interrupts' but no
> > 'interrupt-parent' property, it has *no reason* to believe there's
> > anything more to know.
> 
> And if a program parsing the device tree sees no valid
> "interrupts" property, it can validly assume the device
> doesn't have interrupts.
> 
> Same problem.

Sort of.  But the probable consequences of mistakenly believing a
device has no interrupts are substantially less messy than mistakenly
believing you understand the node's interrupts when you don't.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
