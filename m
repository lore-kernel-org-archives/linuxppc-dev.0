Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C001BDDFC3
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 13:52:35 +1000 (EST)
Subject: Re: powerpc: DMA coherent allocations broken for
	CONFIG_NOT_COHERENT_CACHE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <20090527233451.2d02343d@lappy.seanm.ca>
References: <9481.63517.qm@web28305.mail.ukl.yahoo.com>
	<1243160487.22770.59.camel@pasglop> <1243210914.24376.11.camel@pasglop>
	<200905250243.15436.arnd@arndb.de> <1243226023.24376.23.camel@pasglop>
	<20090527233451.2d02343d@lappy.seanm.ca>
Content-Type: text/plain
Date: Thu, 28 May 2009 13:52:29 +1000
Message-Id: <1243482749.3171.80.camel@pasglop>
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

On Wed, 2009-05-27 at 23:34 -0400, Sean MacLennan wrote:
> On Mon, 25 May 2009 14:33:43 +1000

  ../..

You can just make it a platform device I suppose. In the meantime...

> Maybe set ISA_DMA_THRESHOLD somewhere? Some platforms seem to set it:
> 
> ./platforms/52xx/efika.c:       ISA_DMA_THRESHOLD = ~0L;
> ./platforms/amigaone/setup.c:           ISA_DMA_THRESHOLD = 0x00ffffff;
> ./platforms/chrp/setup.c:       ISA_DMA_THRESHOLD = ~0L;
> ./platforms/powermac/setup.c:   ISA_DMA_THRESHOLD = ~0L;
> 
> So if anybody knows another way around this? The driver is basically
> allocating a scatter gather list that is passed to a DMA engine in the
> FPGA.
> 
> This isn't a showstopper.... we are not planning to move to 2.6.30 in
> the near future.

Can't you set ISA_DMA_THRESHOLD = ~0L from your warp.c platform file ?

Cheers,
Ben.
