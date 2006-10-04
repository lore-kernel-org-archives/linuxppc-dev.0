Return-Path: <dan@embeddedalley.com>
Received: from smtp103.biz.mail.re2.yahoo.com (smtp103.biz.mail.re2.yahoo.com
	[68.142.229.217]) by ozlabs.org (Postfix) with SMTP id 5FDFB67CE3
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Oct 2006 00:31:51 +1000 (EST)
In-Reply-To: <17699.769.632098.479906@cargo.ozlabs.ibm.com>
References: <20060927155626.4d5ca19c@vitb.ru.mvista.com>
	<4879B0C6C249214CBE7AB04453F84E4D19D865@zch01exm20.fsl.freescale.net>
	<20060927165556.04c8d5d7@vitb.ru.mvista.com>
	<CE624A83-809E-4180-800E-660A578FFCFC@embeddedalley.com>
	<20060927112201.293fef44@localhost.localdomain>
	<EBD0615C-4F22-430F-BD23-1283DF98F1B3@embeddedalley.com>
	<17699.769.632098.479906@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2867EA41-5135-43F7-9873-044C617EAC1B@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
Date: Wed, 4 Oct 2006 09:53:43 -0400
To: Paul Mackerras <paulus@samba.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 3, 2006, at 8:40 PM, Paul Mackerras wrote:

> ....   That means that ifdefs
> are evil, because they obfuscate the code....

This is not an #ifdefs discussion.  We've had those
discussions many years ago and have done many
things to eliminate that :-)

It's just a discussion about the purpose of placing
things that are quite static about a board port in
the board specific include file with a #define, rather
than trying to add it as a device tree node.

If I:
	#define MY_BOARD_BCSR 0xf00

and then,

	bcsr = ioremap(MY_BOARD_BCSR);

I think it's pretty clear what I'm doing.
In all of my experience, something like a BCSR
is quite board specific and I honestly don't
see any "generic BCSR code" that's going
to exist and actually take advantage of
representing this in a device tree.


> The device-tree concept offers a way to make drivers more readable and
> reusable, by separating out the board-specific configuration
> information (thus reducing ifdefs) and by encouraging the style of
> code that naturally copes with any number of device instances.

Again, it's not a discussion of #ifdefs.  Most of the
drivers we are discussing that take advantage of this
have long since been properly written to use board
specific information without them.  Initially, we just
used #defines in a board specific file, then we had
platform data, now we have device tree.  That "progress"
didn't make a driver any more readable or reusable,
it's just someone's personal preference for yet another
implementation to do the same thing.  The people with
the most time to waste on this are just able to push
that in over the rest of us that don't.

> How does the "internal memory map" differ from "everything addressable
> in the system"?

By quite a bit.  If you look at the Freescale SOC parts,
many have the very same or quite similar functional
units, they may just appear at different addresses
in the memory map for the different variants of
processor.  Again, proper use of #defines in a board
specific file or platform data solved this problem just
as nicely as device tree.  The real progress was using
the smaller addressable units individually rather than
dereference from the large structure.  The way we get
those addresses and information (#defines, platform
data, device tree) wasn't the enabler to this flexibility.

When you venture off the SOC, you not only have
board specific addresses, but also the register
format and even the logic to access these devices
varies greatly from one board to another.  Yeah,
the BCSR address and maybe something about its
size is in the device tree....BFD, what do I do with it?

As we have seen in some e-mail exchanges already,
people have tracking down "bugs" that eventually
ended up in an improper device tree configuration.
I don't see how this makes board ports any easier,
it's just a different way of representing the information
that has been needed all along.....  and adding
additional steps to the process.

> Leo Li had an interesting idea, which is a preprocessor that would
> take kernel code ...

Ummmm,  I'm going to pretend I didn't even hear this
suggestion :-)  Please, no, I really don't see any value
in this.  Talk about obfuscation......  At least I have a
chance at finding my way though #ifdefs :-)

I'm not against using the device tree (or platform data
or #defines) when it's appropriate to do so.  I think our
obsession to represent everything there is what is
creating the complexity.  If a #define in a board
specific port file makes sense, then just do that,
even if it is a BSCR address.  The device tree just
seems like the new toy that everyone wants to play
with, and we are forgetting that the old fashioned way
of just writing some C code may be the way
to implement what we need.

Thanks.

	-- Dan
