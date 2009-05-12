Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5ACE0DDF90
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 11:12:22 +1000 (EST)
Date: Tue, 12 May 2009 11:12:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: device trees.
Message-ID: <20090512011219.GB18223@yookeroo.seuss>
References: <4A0457BC.3040408@dlasys.net>
	<fa686aa40905091351k140c64a0w27eb44908218814@mail.gmail.com>
	<1242007203.7767.28.camel@concordia>
	<fa686aa40905102108l5c964893y2dfb84763e13511@mail.gmail.com>
	<4A07C664.6040609@dlasys.net>
	<fa686aa40905110651r1c18b78bpe8ffebe041726695@mail.gmail.com>
	<4A085612.9050602@dlasys.net>
	<fa686aa40905111047p5f350b0dh796564cc1383a336@mail.gmail.com>
	<4A089AC8.9080704@dlasys.net>
	<fa686aa40905111609l3feaf555taadf048714030a1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <fa686aa40905111609l3feaf555taadf048714030a1@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, "David H. Lynch Jr." <dhlii@dlasys.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 11, 2009 at 05:09:27PM -0600, Grant Likely wrote:
> On Mon, May 11, 2009 at 3:38 PM, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
> > Grant Likely wrote:
> >>
> >> What do you mean by "one size fits all solution?"
> >>
> >> The kernel doesn't care where the device tree comes from.  All it
> >> cares about is that by the time the kernel is started the device tree
> >> must be fully formed and populated.  It can be completely pre-canned
> >> (like simpleImage), it can be modified by firmware (like u-boot), or
> >> it can be generated from scratch (like with real OpenFirmware).  There
> >> is lots of flexibility on how to handle it.
> >>
> >>
> > First device trees are now the ONLY means of  passing information to the
> > kernel.
> > By definition that means it is a one size fits all solution.
> > While there is nothing inherently wrong with that, solutions intended to
> > meet all circumstances need to be
> > simple, powerful, and flexible. They need to work well 100% of the time
> > not 98%.
> >
> > Not only is the device tree expected to pass static hardware
> > configuration information, but it is the sole means of passing anything.
> > As an example Command lines are to be in the device tree.
> > Everything is supposed to be in the device tree, whether that
> > information is static or dynamic, whether it is hardware information,
> > or user choices.
> 
> It is the sole means of passing anything *to the kernel*.  You can
> pass whatever you like to the bootwrapper.  :-)
> 
> >    That means that whether you are in a Sun or Apple Desktop or a
> > system with the no flash and barely enough resources to run Linux,
> > you still may have to manipulate the device tree.
> 
> ...or if you really are constrained, then define a format for the data
> you want to pass, pass it to the bootwrapper along with the device
> tree, and use the bootwrapper (which already has libfdt) to update the
> device tree.  cuImage targets do this to support older u-boots which
> don't understand device trees.  You are not forced to put device tree
> support in your firmware.
> 
> In other words; having your bootloader support FDT is preferred, but
> not required.

I wouldn't even go so far as to say it's preferred.  IMO, people have
gone a bit prematurely keen on moving devtree handling into the
firmware.  Putting it in the firmware has a number of advantages, but
it also has a number of non-trivial disadvantages.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
