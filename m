Return-Path: <sfalco@harris.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7B46FB6F56
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 27 Jun 2009 02:17:39 +1000 (EST)
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id BEC9FDDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jun 2009 02:17:38 +1000 (EST)
Message-ID: <4A44F49E.3030003@harris.com>
Date: Fri, 26 Jun 2009 12:17:34 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
Subject: Re: Subject: [PATCH v7] spi: Add PPC4xx SPI driver
References: <4A43CC2C.1030409@harris.com>
	<200906252104.46189.david-b@pacbell.net>
In-Reply-To: <200906252104.46189.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Brownell wrote:
> On Thursday 25 June 2009, Steven A. Falco wrote:
>> +       if (spi->mode & ~MODEBITS) {
>> +               dev_dbg(&spi->dev, "setup: unsupported mode bits %x\n",
>> +                       spi->mode & ~MODEBITS);
>> +               return -EINVAL;
>> +       }
> 
> This wasn't tested against 2.6.30-rc1 was it?
> 

I tested against Ben's "next" branch, plus your fix for bitbang_work.
But the new version I'll post is tested against Linus' master branch
(2.6.31-rc1) to take advantage of your mode_bits addition.  If you need
this driver to be based on something else, please say so.

> See the recent fixup patch I sent.  There's a spi_master->modebits
> mask that should have been initialized, and which eliminates the
> need for tests like that ...
> 

Done.

>> +       dev_dbg(&spi->dev, "%s: mode %d, %u bpw, %d hz\n",
>> +               __func__, spi->mode, spi->bits_per_word,
>> +               spi->max_speed_hz);
>> +
> 
> ... also the SPI core now provides a *standard* format debug
> message for that stuff.  It also handles one more thing, which
> I expect to see fixed in a v8 of this patch ...  :) 

Ok - I removed that dev_dbg().  Also, I noticed that spi_setup sets
bits_per_word to 8, so I've removed that as well.  Did I pass your
test?  :-) 

Version 8 will follow shortly.  BTW, this driver is dependent on your
bitbang_work fix.  Not sure if that means it should be added via your
tree.  But since we are in an rc phase, I'm guessing this won't merge
until 2.6.32, by which time your fix should be in the mainline.

	Steve
