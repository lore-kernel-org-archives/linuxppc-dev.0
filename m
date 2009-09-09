Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BF061B7043
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 04:29:03 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3DC3FDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 04:29:02 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n89ISx8F015375
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Sep 2009 11:28:59 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n89ISwxu022706
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Sep 2009 13:28:58 -0500 (CDT)
Date: Wed, 9 Sep 2009 13:28:57 -0500
From: Scott Wood <scottwood@freescale.com>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: MPC85xx External/Internal Interrupts
Message-ID: <20090909182857.GB8215@b07421-ec1.am.freescale.net>
References: <d970ff420909040604h1bb3874eg5c79f79f85e713a3@mail.gmail.com>
	<d970ff420909041228h3638e840r34c0c0e79f178e55@mail.gmail.com>
	<d970ff420909041229hb3aa96dya329e06ea56dd1ac@mail.gmail.com>
	<20090906110641.GA11350@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090906110641.GA11350@Chamillionaire.breakpoint.cc>
Cc: linuxppc-dev@ozlabs.org, Alemao <xcarandiru@gmail.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 06, 2009 at 01:06:41PM +0200, Sebastian Andrzej Siewior wrote:
> irq_of_parse_and_map() creates a mapping between the hardware irq number
> as specified in the device tree and the linux number (virq) which is
> used within the linux api in request_irq() for instance.
> irq_of_parse_and_map() is essential to create a mapping between those
> two. The interrupt controller on the MPC8555 (mpic) specifies the first
> few interrupt numbers as external sources followed by internal sources. 
> Now, during the init sequenze of the mpic every interrupt source
> (internal and external) becomes its uniqe vector number which identifies
> the source by a number. This number is the hardware interrupt number
> i.e. that thing in the device tree. The init sequence is a for loop
> which starts at 0 for the first interrupt source which happens to be
> external interrupt 0, 1 for external interrupt 1 and so on. At the time
> it reaches the first internal interrupt source the vector number is 16.
> That's why you always have an offset of 16 between every internal
> interupt source number in the MPC855ERM document and those weired
> numbers in the device tree :)

This seems to be a common point of confusion -- we should probably put
something in the dts bindings that explains it.  Am I correct in assuming
that this particular internal/external split is Freescale-specific and
not a general OpenPIC thing?

-Scott
