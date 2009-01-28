Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9D049DE04C
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 12:16:25 +1100 (EST)
Message-Id: <58058585-0740-4EC1-9E18-7EE5F101D186@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090127181414.GA23299@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc/cpm2 Fix set interrupt type
Date: Tue, 27 Jan 2009 19:16:16 -0600
References: <497EC957.2050205@conspiracy.net>
	<07B22E7C-2C6F-43FB-84FB-EE5CC9FCE74A@kernel.crashing.org>
	<20090127181414.GA23299@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	paulfax <paulfax@conspiracy.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 27, 2009, at 12:14 PM, Anton Vorontsov wrote:

> On Tue, Jan 27, 2009 at 08:31:16AM -0600, Kumar Gala wrote:
>>
>> On Jan 27, 2009, at 2:44 AM, paulfax wrote:
>>
>>> This is a simple change to correct problems when using  
>>> set_irq_type on
>>> platforms using CPM2.
>>> This code correct the problem on most platform but still fails on  
>>> 8272
>>> derived platforms for some interrupts.
>>> On 8272 PC2 & 3 are missing and PC 23 & 29 are added, which this  
>>> patch
>>> does not address.
>
> This is the same as in MPC8555.

I guess I'm concerned about Paul's comments related to 8272 still  
failing and the patch not addressing PC2/3.

>>> Signed-off-by: Paul Bilke <paul at conspiracy.net>
>>> ---
>>
>> Anton,
>>
>> Is this something you can review
>
> Sure. According to MPC8555 and MPC8272 reference manuals,
> current code indeed has the issue, and the patch correctly
> fixes it. SIEXR register map looks like this (bits are in
> big-endian numbering scheme):
>
> [0:1] - PC0..PC1
> [2:13] - PC4..PC15
> [14:15] - PC23 and PC29
>
> Let's look into fixed version, assuming we got src 48 (PC29):
>
> edibit = (31 - (CPM2_IRQ_PORTC0 - src));
> edibit = (31 - (63 - 48)) = 16
>
> 1 << 16 points to PC29 (bit 15 in big-endian bit numbering scheme),
> just as it should be.
>
> The same code should work for MPC8560 too (where there are no
> PC23 & PC29, but PC2 and PC3).
>
>> and look into the 8272 issue?
>
> I don't actually see any issues wrt 8272. To me, it looks like
> the fixed code should work fine...

Paul?

- k
