Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B3E83DE223
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 09:49:42 +1100 (EST)
Message-ID: <49B83FF9.1020703@freescale.com>
Date: Wed, 11 Mar 2009 17:49:29 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v5] introduce macro spin_event_timeout()
References: <1236723118-3577-1-git-send-email-timur@freescale.com>	
	<49B6EAA4.9000803@freescale.com>	
	<20090310223753.GB26415@zod.rchland.ibm.com>	
	<1236729551.7086.26.camel@pasglop>	
	<ed82fe3e0903101722i610638e8le1f2e925095c8ba6@mail.gmail.com>	
	<1236731097.7086.32.camel@pasglop>	
	<fa686aa40903111010l7bd7e2f8r47c7d42184d0a36a@mail.gmail.com>
	<1236808190.7086.61.camel@pasglop> <49B83332.9040201@freescale.com>
In-Reply-To: <49B83332.9040201@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Benjamin Herrenschmidt wrote:
> 
>> Well, there's a non-empty set of HW where polling as fast as you can
>> will effectively prevent it to make fwd progress...
> 
> Alan Cox mentioned this.  He gave PCI and 10us as an example.  I 
> suggested adding a third parameter that would be a udelay() inserted 
> into the loop.  He countered with this:
> 
> spin_until_timeout(readb(foo) & 0x80, 30 * HZ) {
>     udelay(10);
>     /* Maybe do other stuff */
> }

Hmm, the person objecting that it could lead to people using it for 
excessive timeouts suggested a timeout of *30 seconds*?

> But I don't know how to make that work *and* have it return a value 
> indicating timeout or success.

And it also doesn't allow using the udelay as part of the timeout mechanism.

-Scott
