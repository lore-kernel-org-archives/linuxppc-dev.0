Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4AD92DDEBF
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 18:24:16 +1000 (EST)
In-Reply-To: <467FCC9D.6010904@ru.mvista.com>
References: <1181729973.25586.31.camel@dolphin.spb.rtsoft.ru>	<db0d38e5b5e1a9a3a7fe35d25ebd357a@kernel.crashing.org>	<467176EB.7060404@ru.mvista.com>	<6c416bf9f79a648fc82f64619aca86de@kernel.crashing.org>	<20070615212016.GB18055@mag.az.mvista.com>
	<1182429443.24740.8.camel@localhost.localdomain>
	<467BE91F.1030003@ru.mvista.com>
	<3372b921591ca9731d2703f04e6c35f1@kernel.crashing.org>
	<467FCC9D.6010904@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ce09df5afe642e8f6e9a576306cc1e41@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: MPC7450 L2 HW cache flush feature utilization
Date: Thu, 28 Jun 2007 10:24:06 +0200
To: Vladislav Buzov <vbuzov@ru.mvista.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Note that 745x processors have L3 cache installed and may have the 
>>> same
>>> problem requiring similar code modifications to use L3 hardware 
>>> flushing
>>> mechanism.
>>
>> What does the erratum say?
>
> The erratum says nothing about any HW bugs with L3 cache flush. I just 
> mentioned that the L3 cache flush operation described in MPC7450 
> Reference manual is similar to the L2 using the L3 cache hardware 
> flushing mechanism. For instance, it requires a complete L3 locking 
> before flushing.

Then I think we should use that mechanism in the Linux kernel.
Anything else is waiting for bugs to bite.

>> The L3 is a very different beast from the L2, IIRC it is
>> a pure victim cache so it cannot have this problem at all?
>
> I'm not sure if it is a pure victim cache. I read the MPC7450 
> reference manual and see that the L3 cache operates similarly to the 
> L2. The main difference between those caches is that L3 uses an 
> external SRAM memory while L2 is a pure on-chip cache.

Yeah but it isn't involved in any prefetching AFAIK.  Anyway,
moot point, since we really should do the recommended flush
algorithm (esp. since we clearly do not sufficiently understand
the details of the L3 operation!)


Segher
