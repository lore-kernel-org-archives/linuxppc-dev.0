Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4A3CFDDED6
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 16:36:42 +1100 (EST)
In-Reply-To: <20070226041646.GC29826@localhost.localdomain>
References: <200702212325.l1LNPBwL007793@ld0164-tx32.am.freescale.net>
	<A31D7159-8C25-445D-A21D-85F04C1FDC45@kernel.crashing.org>
	<20070222011811.GA18364@localhost.localdomain>
	<45b623f395654fc4f4920b9553794def@kernel.crashing.org>
	<20070222103410.GB11014@localhost.localdomain>
	<b16b3a03ce9b890909b3f64f50e78b75@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A592C7@az33exm25.fsl.freescale.net>
	<259dc2545888e6588a8a0707ad2e84b0@kernel.crashing.org>
	<9696D7A991D0824DBA8DFAC74A9C5FA302A59732@az33exm25.fsl.freescale.net>
	<1172299259.1902.22.camel@localhost.localdomain>
	<20070226041646.GC29826@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4540139ce9bb2426dbcc3822e6c1a63a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: document new interrupt-array property
Date: Mon, 26 Feb 2007 06:36:29 +0100
To: David Gibson <david@gibson.dropbear.id.au>
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

>> On the other hand, I do quite like keeping with the old principle that
>> having interrupts == having an "interrupts" node.
>
> That would be nice.  On the other hand, re-using interrupts means that
> it's possible to get a silent misparse of the interrupt information:

Incorrect parsing of interrupt info tends to end up
in spectacular crashes, not silent at all ;-)

> a
> parser which doesn't understand the new 'interrupt-parents' property
> will encounter the node, see the 'interrupts' property, assume that
> the interrupt parent is the physical parent and, if the
> #interrupt-cells values match up, which is quite possible, assume that
> it has correctly understood the interrupt information.

Something similar is true for *every* new binding; although
indeed if you get a misparse the effects can be disastrous,
with interrupts.  For other cases, the kernel would have to
say "I don't understand this device" and give up on it, which
can easily mean a failed boot; or silently assume something
that is just a guess at best.

You cannot boot a client program that doesn't understand the
device tree and expect it to understand the device tree ;-)

> This is arguably a worse behaviour than simply having an old-style
> parser see the lack of 'interrupts' property and assume the device has
> no interrupts.

Until recently (well, not that recently) Linux couldn't
parse the interrupt tree correctly and would royally
mess up in unusual cases.  Does that mean that no device
tree in the world should use the interrupt mapping binding?

Also, a device that has interrupts but no "interrupts"
property is *just wrong*.  There are many more things
that (can) look at the device tree than just the kernel,
don't let your opinion be guided solely by what you
think the kernel would do with a tree.


Segher
