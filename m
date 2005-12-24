Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BDC32688F3
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Dec 2005 09:28:05 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
In-Reply-To: <20051224201753.GA26801@elf.ucw.cz>
References: <111520052143.16540.437A5680000BE8A60000409C220076369200009A9B9CD3040A029D0A05@comcast.net>
	<70210ED5-37CA-40BC-8293-FF1DAA3E8BD5@comcast.net>
	<20051129000615.GA20843@hansmi.ch> <20051130223917.GA15102@hansmi.ch>
	<20051130234653.GB15102@hansmi.ch>
	<1133533712.23129.25.camel@localhost.localdomain>
	<20051204224221.GA28218@hansmi.ch> <1135382385.4542.8.camel@gaston>
	<20051224201753.GA26801@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 25 Dec 2005 09:27:51 +1100
Message-Id: <1135463271.5611.3.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org, Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: PowerBook5,8 - TrackPad update
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2005-12-24 at 21:17 +0100, Pavel Machek wrote:
> Hi!
> 
> > Ok, I finally received my new laptop (PowerBook5,8 15"). I tried the
> > latest patch you posted, and while the kernel driver seem to work ok
> > (though you can feel the lack of a proper acceleration curve), the
> > synaptics driver in X doesn't work in any useable way. I updated the one
> > that comes with breezy to whatever was the latest on the author web site
> > (.44 I think) and while it detected the tracpkad, the result was soooooo
> > slooooow that it was totally unseable. I've tried the config tool that
> > comes with KDE for it but couldn't "boost" it to anything useful. Is
> > that expected or is there still issues to be resolved in the driver ?
> > I'm tempted to add some minimum support for a proper acceleration curve
> > in the kernel driver in fact...
> 
> I do not think you should add it inside *kernel*. Proper acceleration
> support really belongs to X...

X, fbdev apps, gpm ... acceleration curves are typically done in HW,
thus it makes sense in this case to have it in the kernel driver
(besides, it should be fairly simple anyway) when it's in normal mode.
When it's in raw mode for use by the synaptics X driver, if course, it's
expected that those things are to be done by that driver.

Ben.
