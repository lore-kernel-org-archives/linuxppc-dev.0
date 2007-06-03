Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C5A62DDEC5
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 03:27:46 +1000 (EST)
In-Reply-To: <E1HurPt-0002EP-It@jdl.com>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
	<1180734314.5674.49.camel@rhino>
	<4fb92a9dfccf515bdc1522d08f10f823@kernel.crashing.org>
	<20070602085359.GA10333@iram.es>
	<3ebd6ca6877ea74925f066ff96ac81db@kernel.crashing.org>
	<20070602195308.GA21618@iram.es>
	<12ad593bd17f769e44f05bc24eac4d0a@kernel.crashing.org>
	<1180828907.14025.37.camel@localhost.localdomain>
	<28e0600256815f93db45b2f4eb2d9df5@kernel.crashing.org>
	<20070603083339.GB2157@iram.es> <E1HurPt-0002EP-It@jdl.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e72c7789d673e340d4a7feed22e535de@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts
	file.
Date: Sun, 3 Jun 2007 19:27:12 +0200
To: Jon Loeliger <jdl@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I think this is an example of Early Days Misunderstanding Creep.

Is that the official name?  :-)

> It was likely one of the very first attempts to write the file for
> any FSL embedded part, and as such, it was probably not so good.

But it also probably worked just fine, given all the
big fat workarounds in the Linux tree parsing code,
which are applied on *all* boards -- this will have
to change sooner or later, just like you don't run
all PCI quirks on all boards: it simply doesn't scale
and the side effects make everything impossible to
understand.  In almost all cases, simply fixing the
device tree (Linux' runtime copy, anyway) in some
pre-processing pass is conceptually a much simpler
solution as well.

> Likely, it could use some cleanup.  Patches and suggestions welcome.

I rather just wait until things break and then
deprecate (and later remove) support for those
boards.  Unless the respective maintainers for
those boards fix things up, all is fine then
of course ;-)

Slightly more seriously -- since there are so
many DTS files, and their number grows real fast;
and since they are non-modular, and mostly copy-
and-paste; most fixes have to be made to lots
of separate DTS files.  And that is something
no one can do, since no one can *test* those fixes,
since you need the hardware to do that.


Segher
