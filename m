Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B1106B7D6A
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 15:48:34 +1100 (EST)
Subject: Re: 2.6.34-rc1: Badness at fs/proc/generic.c:316
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
In-Reply-To: <m2tysjw27p.fsf@whitebox.home>
References: <alpine.DEB.2.01.1003131544340.5493@bogon.housecafe.de>
	<20100314065526.GA5353@x200>
	<alpine.DEB.2.01.1003140336280.5493@bogon.housecafe.de>
	<20100314112428.GA4142@x200>
	<alpine.DEB.2.01.1003140431040.5493@bogon.housecafe.de>
	<m2tysjw27p.fsf@whitebox.home>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 15 Mar 2010 14:23:46 +1100
Message-ID: <1268623426.2209.109.camel@pasglop>
Mime-Version: 1.0
Cc: Christian Kujau <lists@nerdbynature.de>, linuxppc-dev@ozlabs.org,
	Alexey Dobriyan <adobriyan@gmail.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2010-03-14 at 12:51 +0100, Andreas Schwab wrote:
> Christian Kujau <lists@nerdbynature.de> writes:
> 
> > On Sun, 14 Mar 2010 at 13:24, Alexey Dobriyan wrote:
> >> Post "find /proc/device-tree" output.
> >
> > I did upload[0] a tarball of /proc/device-tree, please see below the 
> > "find" output.
> >
> > Indeed, there's a /cpus/PowerPC,G4@0/l2-cache and 
> > /cpus/PowerPC,G4@0/l2-cache#1 in the device-tree. However, from looking at 
> > the logfiles, the
> >
> >    device-tree: Duplicate name in /cpus/PowerPC,G4@0, renamed to "l2-cache#1"
> 
> That's a red herring, the real problem is this:
> 
> name 'pulses/rev'
> 
> Of course, this name cannot be found in /proc/device-tree, because it
> wasn't created.

You mean apple stuck a bloody "/" in a name property ? ARGH !

We should just add code to detect that and replace it with a "_" or
something...

Cheers,
Ben.
