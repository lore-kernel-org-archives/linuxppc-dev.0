Return-Path: <sfalco@harris.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 16313B70A0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Jun 2009 00:25:27 +1000 (EST)
Received: from mlbe2k2.cs.myharris.net (mlbe2k2.cs.myharris.net
	[137.237.90.89]) by ozlabs.org (Postfix) with ESMTP id 5F084DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 00:25:26 +1000 (EST)
Message-ID: <4A423750.8080605@harris.com>
Date: Wed, 24 Jun 2009 10:25:20 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>, Stefan Roese <sr@denx.de>
Subject: Re: [Question] m25p80 driver versus spi clock rate
References: <4A3FEE98.60700@harris.com>
	<200906231408.26912.david-b@pacbell.net>
	<4A414E07.5050303@harris.com>
	<200906231538.40125.david-b@pacbell.net>
In-Reply-To: <200906231538.40125.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	linux-mtd@lists.infradead.org, Mike Frysinger <vapier.adi@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Brownell wrote:
> On Tuesday 23 June 2009, Steven A. Falco wrote:
>> m25p80 spi0.0: invalid bits-per-word (0)
>>
>> This message comes from spi_ppc4xx_setupxfer.  I believe your patch
>> is doing what you intended (i.e. forcing an initial call to
>> spi_ppc4xx_setupxfer), but it exposes an OF / SPI linkage problem.
>>
>> Namely, of_register_spi_devices does not support a bits-per-word
>> property, so bits-per-word is zero.
> 
> Bits-per-word == 0 must be interpreted as == 8.
> 
> Simple bug in the ppc4xx code.  It currently rejects
> values other than 8.

Ok - I'll post a patch for that.  Your changes to bitbang_work look
good.  I'm not clear on why you first set do_setup = -1 but later
use do_setup = 1.  Perhaps they should both be "1".  Other than that,

Acked-by: Steven A. Falco <sfalco@harris.com>

> 
> Speaking of spi_ppc4xx issues ... I still have an oldish
> copy in my review queue, it needs something like the
> appended patch.  (Plus something to accept bpw == 0.)
> Is there a newer version?

That is a question for Stefan.  Perhaps when I post my patch
to the PPC list, we can move this further along...

	Steve
