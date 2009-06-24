Return-Path: <sfalco@harris.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AF7C8B70A2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Jun 2009 02:15:02 +1000 (EST)
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 15339DDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jun 2009 02:15:01 +1000 (EST)
Message-ID: <4A425102.8050507@harris.com>
Date: Wed, 24 Jun 2009 12:14:58 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
Subject: Re: [Question] m25p80 driver versus spi clock rate
References: <4A3FEE98.60700@harris.com>
	<200906231538.40125.david-b@pacbell.net>
	<4A423750.8080605@harris.com>
	<200906240813.01220.david-b@pacbell.net>
In-Reply-To: <200906240813.01220.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Stefan Roese <sr@denx.de>, linux-mtd@lists.infradead.org,
	Mike Frysinger <vapier.adi@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Brownell wrote:
> On Wednesday 24 June 2009, Steven A. Falco wrote:
>> Your changes to bitbang_work look good.
> 
> You tested?
> 

Yes - I built a kernel with your patch, combined with the changes I
just posted to linuxppc-dev@ozlabs.org as:

"[PATCH v1] Make spi_ppc4xx.c tolerate 0 bits-per-word and 0 speed_hz"

I was successful in operating both the m25p16 at 16 MHz and the AVR
at 240 KHz, as verified by oscilloscope.  So my "ack" includes testing.

> 
>> I'm not clear on why you first set do_setup = -1 but later 
>> use do_setup = 1.  Perhaps they should both be "1".  Other than that,
>>
>> Acked-by: Steven A. Falco <sfalco@harris.com>
> 
> The "-1" is for the init path, "1" for per-transfer overrides;
> this way it avoids some extra calls to set up the bits/speed.

Got it.  No further comments.  My "ack" stands.

I'll start looking at a revised version of the spi_ppc4xx.c driver,
integrating your comments.

	Steve
