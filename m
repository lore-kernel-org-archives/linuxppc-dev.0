Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8D72FDE03D
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 04:52:02 +1000 (EST)
Message-ID: <469E614B.1000700@freescale.com>
Date: Wed, 18 Jul 2007 13:51:55 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 28/61] Add cpm2_set_pin().
References: <20070718013535.GZ15238@ld0162-tx32.am.freescale.net>
	<44F03DBB-C3D6-4AA1-9960-730F64829EC6@kernel.crashing.org>
In-Reply-To: <44F03DBB-C3D6-4AA1-9960-730F64829EC6@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Jul 17, 2007, at 8:35 PM, Scott Wood wrote:
>> +
>> +struct cpm2_ioports {
>> +    u32    dir, par, sor, odr, dat;
> 
> __be32?

OK.

>> +    u32    res[3];
>> +};
>> +
>> +void cpm2_set_pin(int port, int pin, int flags)
> 
> 
> Can we make the function take a pointer to the port directly?

I'd rather not -- it'd require the caller to use the immr struct 
directly, and either have no type checking, or different functions for 
different types of ports (on 8xx).

>> +{
>> +    struct cpm2_ioports __iomem *iop =
>> +        (struct cpm_ioports __iomem *)&cpm2_immr->im_ioport;
>> +
>> +    pin = 1 << (31 - pin);
>> +
>> +    if (flags & CPM_PIN_OUTPUT)
>> +        setbits32(&iop[port].dir, pin);
>> +    else
>> +        clrbits32(&iop[port].dir, pin);
>> +
>> +    if (!(flags & CPM_PIN_GPIO))
>> +        setbits32(&iop[port].par, pin);
>> +    else
>> +        clrbits32(&iop[port].par, pin);
>> +
>> +    if (flags & CPM_PIN_SECONDARY)
>> +        setbits32(&iop[port].sor, pin);
>> +    else
>> +        clrbits32(&iop[port].sor, pin);
> 
> 
> should we only do this if !(flags & CPM_PIN_GPIO)?

I don't think it matters.

> Any reason we don't also set odr here?

It wasn't clear to me when we need to set it.  I can add a flag for it, 
though.

-Scott
