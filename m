Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4F572DDFC2
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Mar 2007 10:32:18 +1100 (EST)
In-Reply-To: <20070303232915.GB8028@lixom.net>
References: <1172872183.5310.145.camel@goblue>
	<20070303232915.GB8028@lixom.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8049bab22e1c006dcf916eb12202b73d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] DMA 4GB boundary protection
Date: Sun, 4 Mar 2007 00:32:04 +0100
To: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The drawback of this patch is that it adds code to every single 
> allocation.
> Instead, you should just mark the last entry before the 4GB boundary
> as allocated when you setup the bitmaps for the table. That way, no
> allocation will ever be able to cross over.

Jake said that this bug happens when crossing _any_ 4GB
boundary, so that means reserving a few more blocks.

> Even nicer would be to only do it when a boot option is specified, so
> we actually have a chance to expose and find the driver bugs instead of
> papering them over.

Almost all drivers (*) that can do DAC already avoid
crossing the SAC-to-DAC boundary.  I have never heard
about a card having the bug on _any_ 4GB crossing, I
doubt they are that common.  Just fix the drivers :-)

(*) Well, amongst those that matter and have this bug.


Segher
