Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AC990DE027
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 13:08:33 +1000 (EST)
Date: Thu, 14 May 2009 13:08:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: device trees.
Message-ID: <20090514030829.GI1804@yookeroo.seuss>
References: <4A08C599.2030100@dlasys.net>
	<20090512005554.EEE1019D009B@mail129-dub.bigfish.com>
	<4A08E050.9000302@dlasys.net>
	<20090512042733.8D4A21400054@mail184-dub.bigfish.com>
	<fa686aa40905112230ve176b30o25abcdf5c203f6c7@mail.gmail.com>
	<20090513001048.490B533005D@mail141-va3.bigfish.com>
	<20090513023614.GJ24338@yookeroo.seuss>
	<4A0A6495.2050605@dlasys.net>
	<20090513062127.GU24338@yookeroo.seuss>
	<4A0B0D4A.6000405@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A0B0D4A.6000405@dlasys.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 13, 2009 at 02:11:22PM -0400, David H. Lynch Jr. wrote:
> David Gibson wrote:
> >
> >
> > Ok.  If you have NOR flash, why couldn't you just put the dtb in a
> > separate partition of the NOR?
> >
> >   
> It is not THE dtb, it is A dtb. Our systems support and typically use
> multiple FPGA bit streams.

Ah, ok.  And those multiple bitstreams all inhabit the same NOR flash?
>From what I read below I'm guessing not..

> Clients are
> That means each bitstream must have its own dtb, clients are
> allowed/expected to create their own firmware,
> but the norm is to leave the "PrimaryBoot.bit" startup bit file intact.
> Clients may swap between several bit files for development purposes in
> the course of a day.
> It is even possible that a clients application may require swapping bit
> files as part of normal operations.
> I want one linux binary - because I know damn well that given two my
> clients will use the wrong one alteast 30% of the time.
> Somewhere arround 4 binaries that becomes almost 100% of the time.
> Using dtb's to make the linux binary does NOT solve the problem it just
> changes the file they have to get right.

Ok.  But they must be using some tool to push the bitstream into the
board yes?  Could that same tool be made to take a bitstream+dtb
bundle and push each piece into the right section of flash?

> Worse still the wrong dtb will probably mostly work. If it just failed
> they would be more likely to grasp what they got wrong.
> 
> I need/want the device tree welded to the bitstream. That means creating
> it dynamically or welding it to the bitstream.
> Anything else wil be a support nightmare.

Right.  I guess it's all a question of what constitutes "welded" given
the tool setup that's typically used by your clients.  I'm trying to
understand enough about your system to make practical suggestions of
how to achieve weldedness.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
