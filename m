Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 84E52DDF9E
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Mar 2007 10:46:29 +1100 (EST)
Date: Sat, 3 Mar 2007 17:57:55 -0600
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] DMA 4GB boundary protection
Message-ID: <20070303235755.GC8028@lixom.net>
References: <1172872183.5310.145.camel@goblue>
	<20070303232915.GB8028@lixom.net>
	<8049bab22e1c006dcf916eb12202b73d@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8049bab22e1c006dcf916eb12202b73d@kernel.crashing.org>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Mar 04, 2007 at 12:32:04AM +0100, Segher Boessenkool wrote:
> > The drawback of this patch is that it adds code to every single 
> > allocation.
> > Instead, you should just mark the last entry before the 4GB boundary
> > as allocated when you setup the bitmaps for the table. That way, no
> > allocation will ever be able to cross over.
> 
> Jake said that this bug happens when crossing _any_ 4GB
> boundary, so that means reserving a few more blocks.

Yes, sorry. I was presuming that the table provided by firmware was less
than 4GB in size. He would obviously need to mark at each boundary.

> > Even nicer would be to only do it when a boot option is specified, so
> > we actually have a chance to expose and find the driver bugs instead of
> > papering them over.
> 
> Almost all drivers (*) that can do DAC already avoid
> crossing the SAC-to-DAC boundary.  I have never heard
> about a card having the bug on _any_ 4GB crossing, I
> doubt they are that common.  Just fix the drivers :-)

I can see the point with dealig with backports. Having a boot option
that is disabled by default would help working around it until a fix is
available, but it'd still help expose driver bugs.


-Olof
