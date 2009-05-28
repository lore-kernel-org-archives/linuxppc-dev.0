Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 2B3B1DDEF9
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 13:34:55 +1000 (EST)
Date: Wed, 27 May 2009 23:34:51 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: powerpc: DMA coherent allocations broken for
	CONFIG_NOT_COHERENT_CACHE
Message-ID: <20090527233451.2d02343d@lappy.seanm.ca>
In-Reply-To: <1243226023.24376.23.camel@pasglop>
References: <9481.63517.qm@web28305.mail.ukl.yahoo.com>
	<1243160487.22770.59.camel@pasglop>
	<1243210914.24376.11.camel@pasglop>
	<200905250243.15436.arnd@arndb.de>
	<1243226023.24376.23.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 25 May 2009 14:33:43 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> This is going to .30 if nobody hollers. I've done some testing here
> and it seems to be fine, but more eyes at this stage are much welcome.

Sigh, I didn't get a chance to look at this until tonight. I use
__dma_alloc_coherent in one of the warp drivers because I don't have a
device to pass to dma_alloc_coherent. I was hoping to put it off until
the summer.

I assume I am scuppered without a device:

[  260.101751] coherent allocation too big (requested 0x5000 mask 0x0)
[  260.108054] pikadma: Unable to allocate SGL

This is with a NULL passed as the device. And it looks
like if the device is null, it just defaults to ISA_DMA_THRESHOLD,
which is 0 as shown above.

Is there a global platform device or something similar that I can
piggyback off of? There is no bus associated with this driver, so no
device.

Maybe set ISA_DMA_THRESHOLD somewhere? Some platforms seem to set it:

./platforms/52xx/efika.c:       ISA_DMA_THRESHOLD = ~0L;
./platforms/amigaone/setup.c:           ISA_DMA_THRESHOLD = 0x00ffffff;
./platforms/chrp/setup.c:       ISA_DMA_THRESHOLD = ~0L;
./platforms/powermac/setup.c:   ISA_DMA_THRESHOLD = ~0L;

So if anybody knows another way around this? The driver is basically
allocating a scatter gather list that is passed to a DMA engine in the
FPGA.

This isn't a showstopper.... we are not planning to move to 2.6.30 in
the near future.

Cheers,
   Sean
