Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B1568DDE00
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 23:32:32 +1100 (EST)
Message-ID: <473AEA91.8090109@ru.mvista.com>
Date: Wed, 14 Nov 2007 15:31:13 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH 2/2] PowerPC: make 4xx uic use generic edge and level
	irq handlers
References: <20071113201559.GA26172@ru.mvista.com>	
	<20071113202731.GA26319@ru.mvista.com>	
	<20071114021326.GB19378@localhost.localdomain>
	<1195011796.28865.28.camel@pasglop>
In-Reply-To: <1195011796.28865.28.camel@pasglop>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-dev@ozlabs.org, David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Wed, 2007-11-14 at 13:13 +1100, David Gibson wrote:
>> Hrm.  I *think* I'm convinced this is safe, although acking in a
>> callback which doesn't say it acks is rather yucky.  Essentially this
>> code is trading flow readability (because just reading
>> handle_level_irq will tell you something other than what it does in
>> our case) for smaller code size.  I'm not sure if this is a good trade
>> or not.
>>

It's not just code size. Actually, I was having problems with Ingo's 
real-time patch, that works on all platforms that use generic hard irq 
handlers and doesn't work just on 4xx since we use a custom one here.
And I thought that using generic handlers would be easier to maintain.
I agree that ack'ing in a callback which doesn't say it ack's looks odd, 
but ack'ing level-triggered interrupts is quirky on UIC itself. So, I 
just thought that adding a couple of quirks to mask_ack and unmask 
callbacks was not that bad.

>> There's also one definite problem: according to the discussions I had
>> with Thomas Gleixner when I wrote uic.c, handle_edge_irq is not what
>> we want for edge interrupts.
>>
>> Apparently handle_edge_irq is only for edge interrupts on "broken"
>> PICs which won't latch new interrupts while the irq is masked.  UIC is
>> not in this category, so handle_level_irq is actually what we want,
>> even for an edge irq.
>>
>> Yes, I thought the naming was more than a little confusing, too.
> 
> Hrm... handle_edge_irq works for both and you have a small performance
> benefit in not masking, and thus using handle_edge_irq, so I don't
> totally agree here. Basically, what handle_edge_irq() does is lazy
> masking. Now there -is- an issue here is that if you do lazy masking,
> you need to be able to re-emit in some convenient way.

With the ack quirks added we can use handle_level_irq for edge-triggered 
interrupts. I'll test and resubmit the patch.

> 
> Ben.
> 
> 

Thanks,
Valentine.
