Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f220.google.com (mail-gx0-f220.google.com
	[209.85.217.220]) by ozlabs.org (Postfix) with ESMTP id 5A7DCDDFB5
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 13:42:40 +1000 (EST)
Received: by gxk20 with SMTP id 20so4701065gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 20:42:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090527233451.2d02343d@lappy.seanm.ca>
References: <9481.63517.qm@web28305.mail.ukl.yahoo.com>
	<1243160487.22770.59.camel@pasglop>
	<1243210914.24376.11.camel@pasglop> <200905250243.15436.arnd@arndb.de>
	<1243226023.24376.23.camel@pasglop>
	<20090527233451.2d02343d@lappy.seanm.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 27 May 2009 21:42:18 -0600
Message-ID: <fa686aa40905272042yd7b4698gbd1133b4c61c9b87@mail.gmail.com>
Subject: Re: powerpc: DMA coherent allocations broken for
	CONFIG_NOT_COHERENT_CACHE
To: Sean MacLennan <smaclennan@pikatech.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 27, 2009 at 9:34 PM, Sean MacLennan <smaclennan@pikatech.com> w=
rote:
> On Mon, 25 May 2009 14:33:43 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>> This is going to .30 if nobody hollers. I've done some testing here
>> and it seems to be fine, but more eyes at this stage are much welcome.
>
> Sigh, I didn't get a chance to look at this until tonight. I use
> __dma_alloc_coherent in one of the warp drivers because I don't have a
> device to pass to dma_alloc_coherent. I was hoping to put it off until
> the summer.
>
> I assume I am scuppered without a device:
>
> [ =A0260.101751] coherent allocation too big (requested 0x5000 mask 0x0)
> [ =A0260.108054] pikadma: Unable to allocate SGL
>
> This is with a NULL passed as the device. And it looks
> like if the device is null, it just defaults to ISA_DMA_THRESHOLD,
> which is 0 as shown above.
>
> Is there a global platform device or something similar that I can
> piggyback off of? There is no bus associated with this driver, so no
> device.

Make your driver use a platform device or an of_platform device.  It's
not at all hard.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
