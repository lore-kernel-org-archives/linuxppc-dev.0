Return-Path: <vbuzov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E32EADDF97
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 20:47:18 +1000 (EST)
Message-ID: <468391B3.3080100@ru.mvista.com>
Date: Thu, 28 Jun 2007 14:47:15 +0400
From: Vladislav Buzov <vbuzov@ru.mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: MPC7450 L2 HW cache flush feature	utilization
References: <1181729973.25586.31.camel@dolphin.spb.rtsoft.ru>	
	<db0d38e5b5e1a9a3a7fe35d25ebd357a@kernel.crashing.org>	
	<467176EB.7060404@ru.mvista.com>	
	<6c416bf9f79a648fc82f64619aca86de@kernel.crashing.org>	
	<20070615212016.GB18055@mag.az.mvista.com>	
	<1182429443.24740.8.camel@localhost.localdomain>	
	<467BE91F.1030003@ru.mvista.com>	
	<3372b921591ca9731d2703f04e6c35f1@kernel.crashing.org>	
	<467FCC9D.6010904@ru.mvista.com>	
	<ce09df5afe642e8f6e9a576306cc1e41@kernel.crashing.org>
	<1183022026.5521.269.camel@localhost.localdomain>
In-Reply-To: <1183022026.5521.269.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

>>>The erratum says nothing about any HW bugs with L3 cache flush. I just 
>>>mentioned that the L3 cache flush operation described in MPC7450 
>>>Reference manual is similar to the L2 using the L3 cache hardware 
>>>flushing mechanism. For instance, it requires a complete L3 locking 
>>>before flushing.
>>>      
>>>
>>Then I think we should use that mechanism in the Linux kernel.
>>Anything else is waiting for bugs to bite.
>>    
>>
>
>I just figured out ... we actually already have all of that cache flush
>code :-) I wrote most of it in fact. It's just that for some (bad)
>reasons, it's somewhat hidden in arch/powerpc/platforms/powermac/cache.S
>
>So I think best would be to take it from there and make it more
>generic ...
>  
>
I'm just wondering who is supposed to do that. I can copy the code from 
cache.S to l2cr_6xx.S and test it on 7448 since I have only this 
processor on hand. So, I can't test the L3.      

I've looked through cache.S and see it contains a dcbf loop over 4Mb 
along with L2, L3 HW cache flushing. The comments says 'Due to a bug 
with the HW flush on some CPU revs, we occasionally experience data 
corruption...'. Could you please clarify which CPU revisions have this 
bug and whether it is the same bug described in errata and requiring a 
complete cache locking before flushing? Do we still need to use the dcbf 
loop in _set_L2CR() for MPC7450 processors?

Thanks,
Vlad.

>Cheers,
>Ben.
>
>
>  
>
