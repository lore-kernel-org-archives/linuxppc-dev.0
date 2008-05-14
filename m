Return-Path: <SEW_S@tqs.de>
Received: from mail.tqs.de (mail.tqs.de [62.157.136.17])
	by ozlabs.org (Postfix) with ESMTP id 1F4A6DDE16
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 May 2008 18:04:01 +1000 (EST)
Message-ID: <482A9CF0.7050600@tqs.de>
Date: Wed, 14 May 2008 10:04:00 +0200
From: Jens Gehrlein <sew_s@tqs.de>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: smc911x: how to call the driver?
References: <4829BC19.5000909@tqs.de> <87hcd1749f.fsf@macbook.be.48ers.dk>
In-Reply-To: <87hcd1749f.fsf@macbook.be.48ers.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded Mailinglist <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Peter,

thank you for responding.

Peter Korsgaard schrieb:
>>>>>> "Jens" == Jens Gehrlein <sew_s@tqs.de> writes:
> 
>  Jens> Hi,
>  Jens> on our board a SMSC LAN9215i is connected to an i.MX31 ARM
>  Jens> processor. My hope is to get the smc911x driver run on this chip. The
>  Jens> LAN921x data sheets say that existing 911x drivers should work.
> 
> Why are you asking this in a powerpc list?

Uuh, sorry. In the haste I just read "embedded". Actually, my question 
isn't processor related. Rather it's (network) device driver related.
Could you recommend a mailing list for this?

>  Jens> My next problem is:
>  Jens> Where and when get the functions smc911x_drv_probe() and
>  Jens> smc911x_init() called? Any hints?
> 
> You need to register a struct platform_device in your platform code,
> E.G. something like:
> 
> static struct resource smc911x_resources[] = {
>         [0] = {
>                 .start  = 0x8e000000,
>                 .end    = 0x8e0000ff,
>                 .flags  = IORESOURCE_MEM,
>         },
>         [1] = {
>                 .start  = 4,
>                 .end    = 4,
>                 .flags  = IORESOURCE_IRQ,
>         },
> };
> 
> static struct platform_device thinlite_eth = {
>         .name                   = "smc911x",
>         .id                     = 0,
>         .num_resources          = ARRAY_SIZE(smc911x_resources),
>         .resource               = smc911x_resources,
> };
> 
> And then do a platform_add_devices with it.

Mmmh, this is all new to me. I'll try to get through it and perhaps 
we'll meet on the other mailinglist again.

Thank you very much so far.

Best Regards,
Jens
