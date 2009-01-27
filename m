Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 97EE8DDF65
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 05:14:16 +1100 (EST)
Date: Tue, 27 Jan 2009 21:14:14 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/cpm2 Fix set interrupt type
Message-ID: <20090127181414.GA23299@oksana.dev.rtsoft.ru>
References: <497EC957.2050205@conspiracy.net>
	<07B22E7C-2C6F-43FB-84FB-EE5CC9FCE74A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <07B22E7C-2C6F-43FB-84FB-EE5CC9FCE74A@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	paulfax <paulfax@conspiracy.net>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 27, 2009 at 08:31:16AM -0600, Kumar Gala wrote:
>
> On Jan 27, 2009, at 2:44 AM, paulfax wrote:
>
>> This is a simple change to correct problems when using set_irq_type on 
>> platforms using CPM2.
>> This code correct the problem on most platform but still fails on 8272 
>> derived platforms for some interrupts.
>> On 8272 PC2 & 3 are missing and PC 23 & 29 are added, which this patch 
>> does not address.

This is the same as in MPC8555.

>> Signed-off-by: Paul Bilke <paul at conspiracy.net>
>> ---
>
> Anton,
>
> Is this something you can review

Sure. According to MPC8555 and MPC8272 reference manuals,
current code indeed has the issue, and the patch correctly
fixes it. SIEXR register map looks like this (bits are in
big-endian numbering scheme):

[0:1] - PC0..PC1
[2:13] - PC4..PC15
[14:15] - PC23 and PC29

Let's look into fixed version, assuming we got src 48 (PC29):

edibit = (31 - (CPM2_IRQ_PORTC0 - src));
edibit = (31 - (63 - 48)) = 16

1 << 16 points to PC29 (bit 15 in big-endian bit numbering scheme),
just as it should be.

The same code should work for MPC8560 too (where there are no
PC23 & PC29, but PC2 and PC3).

> and look into the 8272 issue?

I don't actually see any issues wrt 8272. To me, it looks like
the fixed code should work fine...

Reviewed-by: Anton Vorontsov <avorontsov@ru.mvista.com>


>> diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/ 
>> cpm2_pic.c
>> index b16ca3e..78f1f7c 100644
>> --- a/arch/powerpc/sysdev/cpm2_pic.c
>> +++ b/arch/powerpc/sysdev/cpm2_pic.c
>> @@ -165,7 +165,7 @@ static int cpm2_set_irq_type(unsigned int virq,  
>> unsigned int flow_type)
>>                        edibit = (14 - (src - CPM2_IRQ_EXT1));
>>        else
>>                if (src >= CPM2_IRQ_PORTC15 && src <= CPM2_IRQ_PORTC0)
>> -                       edibit = (31 - (src - CPM2_IRQ_PORTC15));
>> +                       edibit = (31 - (CPM2_IRQ_PORTC0 - src));
>>                else
>>                        return (flow_type & IRQ_TYPE_LEVEL_LOW) ? 0 :  
>> -EINVAL;

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
