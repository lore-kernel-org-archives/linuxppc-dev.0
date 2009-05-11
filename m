Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5BE51DDF86
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 10:54:16 +1000 (EST)
Date: Tue, 12 May 2009 08:56:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: device trees.
Message-ID: <20090511225631.GA15371@yookeroo.seuss>
References: <4A0457BC.3040408@dlasys.net>
	<fa686aa40905091351k140c64a0w27eb44908218814@mail.gmail.com>
	<1242007203.7767.28.camel@concordia>
	<fa686aa40905102108l5c964893y2dfb84763e13511@mail.gmail.com>
	<4A07C664.6040609@dlasys.net>
	<fa686aa40905110651r1c18b78bpe8ffebe041726695@mail.gmail.com>
	<4A085612.9050602@dlasys.net>
	<fa686aa40905111047p5f350b0dh796564cc1383a336@mail.gmail.com>
	<4A089AC8.9080704@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A089AC8.9080704@dlasys.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 11, 2009 at 05:38:16PM -0400, David H. Lynch Jr. wrote:
> Grant Likely wrote:
> >   
> > What do you mean by "one size fits all solution?"
> >
> > The kernel doesn't care where the device tree comes from.  All it
> > cares about is that by the time the kernel is started the device tree
> > must be fully formed and populated.  It can be completely pre-canned
> > (like simpleImage), it can be modified by firmware (like u-boot), or
> > it can be generated from scratch (like with real OpenFirmware).  There
> > is lots of flexibility on how to handle it.

> First device trees are now the ONLY means of passing information to
> the kernel.

That's not really true in practice.  Yes, the device tree is the only
way to pass information to the kernel proper, but having a
bootwrapper, built along with the kernel, which translates information
in some other form into a device tree is a perfectly reasonable
solution for the right circumstances.

>  By definition that means it is a one size fits all
> solution.  While there is nothing inherently wrong with that,
> solutions intended to meet all circumstances need to be simple,
> powerful, and flexible. They need to work well 100% of the time not
> 98%.
>    
> Not only is the device tree expected to pass static hardware
> configuration information, but it is the sole means of passing anything.
> As an example Command lines are to be in the device tree.
> Everything is supposed to be in the device tree, whether that
> information is static or dynamic, whether it is hardware information,
> or user choices.
> 
>     That means that whether you are in a Sun or Apple Desktop or a
> system with the no flash and barely enough resources to run Linux,
> you still may have to manipulate the device tree.

Compared to running Linux, manipulating the device tree is a complete
triviality, so I don't see what the problem is here.

[snip]
>     Welding the bit file to the dtb might solve 75% of my issues,
>      And it probably would get me to the point where I could move
> forward and live with
>     the remaining issues untile I was inspired to solve them.
>     but it does not solve everything. It is increasingly clear to me
> that I am going to have to
>     manipulate device trees.

That's probably true.  But you don't necessarily have to do it within
your BRAM firmware - you can do it inside the Linux bootwrapper.

> >>    Anyway, all I was looking for was a leg up on figuring out how to do
> >> what I want with them. Rather than starting from scratch.
> >>    I am not looking to be convinced that I am approaching this all wrong.
> >>    If you are happy with what you have - great. I am not.
> >>    While I was not looking to restart a great debate over device trees
> >> - I do not actually think they are a bad idea.
> >>     
> >
> > I still don't understand what you're worried about starting an arguing
> > about.  Pretty much any of the PowerPC maintainers can point at warts
> > and problems in the current handling of device trees.  I'm not
> > particularly happy with simpleImage (and I wrote it), but it takes
> > time and effort to write something more capable.
> >   
>     I was not trying to start an argument, my initial question was
> 
>    "Is there an example somewhere that shows building a device tree on the fly ?"
> 
>    The responses have questioned why I want to do that rather than how can I do that.
>    I was not actually seeking a debate over the merit of device trees, or u-boot, or libdft, or .... 

Probably the closest things to suitable examples here are
arch/powerpc/kernel/prom_init.c, which builds the dtb from the "live"
OF device tree.  At the moment that's a bit of a special case, but
there's no inherent reason that logic couldn't be moved to the
bootwrapper.

The other, not in the main tree, is Paul's restodt, which builds a
device tree from old-style PReP residual information.  I recall it was
sent to the list as a userspace program (we were gathering information
on the sorts of PReP out there).  I think Paul made at least a first
cut at fusing it into the bootwrapper, but I don't know if that ever
got sent out to the list.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
