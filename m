Return-Path: <dan@embeddedalley.com>
Received: from smtp103.biz.mail.re2.yahoo.com (smtp103.biz.mail.re2.yahoo.com
	[68.142.229.217]) by ozlabs.org (Postfix) with SMTP id A54E667C62
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Oct 2006 01:03:22 +1000 (EST)
In-Reply-To: <1159942128.13323.21.camel@localhost.localdomain>
References: <20060927155626.4d5ca19c@vitb.ru.mvista.com>
	<4879B0C6C249214CBE7AB04453F84E4D19D865@zch01exm20.fsl.freescale.net>
	<20060927165556.04c8d5d7@vitb.ru.mvista.com>
	<CE624A83-809E-4180-800E-660A578FFCFC@embeddedalley.com>
	<20060927112201.293fef44@localhost.localdomain>
	<EBD0615C-4F22-430F-BD23-1283DF98F1B3@embeddedalley.com>
	<1159942128.13323.21.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7BD0D5CE-7BA3-43DC-B972-B75672F6A31E@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
Date: Wed, 4 Oct 2006 10:48:29 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 4, 2006, at 2:08 AM, Benjamin Herrenschmidt wrote:

> It's not that complex and the single binary is not necessarily the  
> main
> objective (it's a good practice as it enforce avoiding ugly #ifdef  
> hacks

Would you guys please get off of this #ifdefs discussion! :-)
That's not what this is about.

> There is fundamentally little difference between the OCP tables we had
> before and the device-tree.

Exactly!  So why has it become such a desire to represent
stuff in the device tree that was never necessary to represent
in other table formats before?

> The new device-tree model provides a more flexible and richer semantic
> for adding all sort of driver or BSP private infos, and for dealing  
> with
> address mapping and interrupt mapping.

Not really, we had all of this before.....  and in a way
that I didn't have to learn a new syntax to represent.

> When done right, it does simplify the matter. An example that I've  
> seen
> internally is embedded boards with all sorts of variety of dodgy
> interrupt controllers cascaded on each other.

Good example.  Cascaded interrupt controllers are always
a challenge.  :-)  It doesn't matter how you present the
information about their configuration if you don't have
the code written properly to manage them.  It's the
_code_ you write the solves the problem, not the
device tree.

> It simplifies the code, both on the driver and the platform side,

I don't see that.  If I look at drivers we've had around for
a while that have survived all of these evolutions, the
core of them hasn't changed one bit.  The initialization
functions have gone from simply stuffing an information
data structure with #defined board information to lengthy
process of performing (the once hated) OF searches
and conversion of information, to stuff into the data
structures.


> ....   doing so
> makes it simpler for your own code/driver to retreive informations  
> such
> as base addresses, interrupts (see above), and all sort of auxilliary
> infos you may which to pass to a given driver (MAC address, serial
> number, default clock, whatever).

It doesn't really make it any simpler for the driver, because
they have always retrieved that information in some way that
has been consistent, usually from the old board descriptor
or platform data.  The method of converting that information,
usually a concern of the boot rom or the boot wrapper or
compiled in, is what we are changing now.

> There is a great flexibility of putting whatever you want in  
> there... or
> not.

It's the 'or not' part that I am worried about.  Things like
you mention above make sense.  I'm starting to worry about
some of this other stuff, and the bscr example is what
woke me up :-)  I think that's an example of things that
should be considered not necessary.

> It's up to the embedded developper to use that tool, it can be used
> in a bloated way, or in a smart way, we aren't enforcing any direction
> here.

Not really.  To use a particular driver you are going to have
to provide the proper amount of information.  It's not up to
me as a consumer of something already written.  I can
only control that if I'm the developer of the code.

> I think you are a bit too dismissive here. The approach has always  
> been
> to provide the choice,

There isn't a choice.  If I want to use a particular driver
I have to provide the proper and necessary information
using a device tree, period.  If I want to change my
board design for some reason that is advantageous
to me, and the driver doesn't support it, no possible
convolution of device tree information is going to make
that happen.

> ...  is hopefully an easier way to create the BSP in the first place,

Sorry, but I don't see that.  You are either skilled at
creating a BSP or you are not.  The device tree just adds
another dimension of information in a syntax and structure
that you have to learn.

> .... The -ability- to build multi-board
> kernels is made mandatory for code to be merged upstream,

Why?  When are people going to realize that the
ratio of Linux on custom embedded systems to a standard
workstation is about a million to one?  So what if I
can boot the same kernel on a couple of obsolete
PowerPC workstations using drivers that aren't used
anywhere else?  Or, on a couple of embedded eval
boards that don't represent how people build products?
Hell, I tried to build an x86 kernel the other day
for a PC and still don't have one that boots.  I can't
seem to figure out what processor configuration
options or compiler options to use.  Linux doesn't
even support this on a "standard" PC. :-)

> ... as it enforces
> a certain level of quality,

That's BS and you know it :-)


> ....  In fact, you client may be happy, once it's done rev 3 of the
> board with a 3rd type of wifi chip or a 2nd type of ethernet HUB to  
> have
> the ability to easily build, maintain, distribute and test a single
> kernel image,

That's not very important.  For high volume products that
are already in the field, the way the binary image is created
or if they need different ones on different versions, isn't
important.  The whole process of tracking, testing, distributing,
installing, upgrading, reverting makes our development
tools insignificant to them.  All that is desired is an image
that when upgraded doesn't turn a million boxes into
bricks.  If it does, our cleverness to use a device tree to
support multiple boards better not be the problem, because
if it is it will never be used again.

Thanks.

	-- Dan
