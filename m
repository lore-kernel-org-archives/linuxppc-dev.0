Return-Path: <AZeffertt@cambridgebroadband.com>
Received: from cambridgebroadband.com (mailhost.cambridgebroadband.com
	[217.204.121.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 75B6167BD6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Sep 2006 02:42:48 +1000 (EST)
Message-ID: <45195882.1090003@cambridgebroadband.com>
Date: Tue, 26 Sep 2006 17:42:42 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: local_irq_save not masking interrupts
References: <995B09A8299C2C44B59866F6391D263516C42D@zch01exm21.fsl.freescale.net>
	<451900B0.7010006@cambridgebroadband.com>
	<45194F1F.7030003@freescale.com>
	<45195296.8000405@cambridgebroadband.com>
	<451954D8.3050909@freescale.com>
In-Reply-To: <451954D8.3050909@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Alex Zeffertt wrote:
>> I agree this indicates an intent to make it atomic, but I don't see how
>> this could cause interrupts to become re-enabled during the request_irq()
>> call.  Also, since I am calling request_irq at insmod time, i.e. in 
>> process
>> context, both GFP_ flags *should* work.
> 
> You're effectively not in process context when you disable IRQs (at 
> least, if you want them to stay that way).  By specifying GFP_KERNEL, 
> you're giving the allocator permission to go to sleep, enable IRQs, etc. 
>  The IRQ enabling will happen any time cache_grow() is called with 
> GFP_WAIT (which is part of GFP_KERNEL), assuming a growable slab.

Ah-ha!  This explains a lot...

One of the oddities I was seeing with this problem was that if I
did an "ifconfig down" on a completely unrelated net_device (a vlan)
the problem would *not* occur, i.e. I did not get an interrupt
during the critical section.  Now I understand why:  the "ifconfig down"
command freed some memory so that the kmalloc(,GFP_KERNEL) did not
need to grow the cache.

It follows from what you are saying that kmalloc(,GFP_KERNEL)
MUST NOT occur anywhere in the call chain during a critical section.

This must catch others out too.  Surely kmalloc/cache_grow should
return NULL rather than enable interrupts.  In fact, shouldn't it be
a BUG() if kmalloc(,GFP_KERNEL) is called with IRQs disabled?


Thanks for your explanation!

Alex
