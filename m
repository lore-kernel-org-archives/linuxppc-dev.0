Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 53A77DDFCE
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 14:19:52 +1000 (EST)
Subject: Re: powerpc: DMA coherent allocations broken for
	CONFIG_NOT_COHERENT_CACHE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <20090528001152.6c00b238@lappy.seanm.ca>
References: <9481.63517.qm@web28305.mail.ukl.yahoo.com>
	<1243160487.22770.59.camel@pasglop> <1243210914.24376.11.camel@pasglop>
	<200905250243.15436.arnd@arndb.de> <1243226023.24376.23.camel@pasglop>
	<20090527233451.2d02343d@lappy.seanm.ca>
	<1243482749.3171.80.camel@pasglop>
	<20090528001152.6c00b238@lappy.seanm.ca>
Content-Type: text/plain
Date: Thu, 28 May 2009 14:19:46 +1000
Message-Id: <1243484386.3171.83.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-05-28 at 00:11 -0400, Sean MacLennan wrote:
> On Thu, 28 May 2009 13:52:29 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > Can't you set ISA_DMA_THRESHOLD = ~0L from your warp.c platform file ?
> 
> I actually set it in the driver proper since it is faster to test, but
> it works. I am just wondering how kosher that is.

Set it in warp.c and send me a patch for 2.6.30, we can have a proper
device bound to it for .31.

> The advantage of the platform_device is I can go back to using the top
> level function. And I suspect down the road the __dma* functions may
> require a real device.
> 
> However, the ISA_DMA_THRESHOLD = ~0L is a less intrusive patch.

Yes until you have a proper device probed of the device-tree.

Cheers,
Ben.
