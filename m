Return-Path: <broonie@sirena.org.uk>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9D9F9B7B86
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 08:45:25 +1000 (EST)
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4104ADDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 08:45:25 +1000 (EST)
Date: Wed, 12 Aug 2009 23:45:07 +0100
From: Mark Brown <broonie@sirena.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Message-ID: <20090812224506.GA7519@sirena.org.uk>
References: <1250063825.15143.43.camel@pasglop>
	<20090812123551.GC11227@sirena.org.uk>
	<1250112847.3587.26.camel@pasglop>
	<20090812214444.GA4731@sirena.org.uk>
	<1250114192.3587.41.camel@pasglop>
	<20090812222843.GA7118@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090812222843.GA7118@flint.arm.linux.org.uk>
Subject: Re: ARM clock API to PowerPC
Cc: John Jacques <john.jacques@lsi.com>, devicetree-discuss@lists.ozlabs.org,
	Torez Smith <torez@us.ibm.com>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 12, 2009 at 11:28:43PM +0100, Russell King wrote:

> We used to pass names.  Everyone got the idea that they could ignore
> the struct device argument, and chaos ensued in drivers - people wanted
> to name each of their individual clk structures uniquely, and pass
> clock names, or even struct clk pointers into drivers via platform data.
> Some drivers conditionalized the clock name depending on the SoC they
> were built for in the driver code.

Yes, that sort of stuff is obviously crazy - you just end up with more
code to pass the name/pointer around than you have to register things at
init time.

> What I'm saying is that always passing a bunch of names has been well
> proven to lead people down the wrong path of matching only by names
> and then running into problems later.  We need drivers passing a NULL
> name to ensure that people get the right idea.  Comments in code/headers
> don't seem to work. ;(

I always suspected half the problem with people getting the wrong idea
is that having to implement the lookup and mapping stuff (which clkdev
now provides) seemed like too much work.
