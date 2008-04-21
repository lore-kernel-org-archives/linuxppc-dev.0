Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 53337DEE0D
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 02:28:17 +1000 (EST)
In-Reply-To: <20080421142826.GA19458@polina.dev.rtsoft.ru>
References: <20080418190632.GA32204@polina.dev.rtsoft.ru>
	<20080418190908.GA4407@polina.dev.rtsoft.ru>
	<fa686aa40804210703iaa8251ctc125313a8e52f4ef@mail.gmail.com>
	<20080421142826.GA19458@polina.dev.rtsoft.ru>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4a0ef28ea7b12ffd518a44d5c5b850eb@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/5] [POWERPC] sysdev: implement FSL GTM support
Date: Mon, 21 Apr 2008 18:28:10 +0200
To: avorontsov@ru.mvista.com
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>  +static inline void gtm_ack_timer16(struct gtm_timer *tmr, u16 
>>> events)
>>>  +{
>>>  +       out_be16(tmr->gtevr, events);
>>>  +}
>>
>> Drop 'inline' and expect gcc to do the right thing.
>
> Not sure about newer gccs, but older complained about "defined but not
> used" functions w/o inline keyword. I'm almost sure that this is still
> true.

It is.  So why is it unused?  Because you put the code in the header
file.  Can't you move it to the .c file instead?

> I can surely use __maybe_unused, but "static inline" is pretty
> settled tradition, plus this function is small enough anyway.

All code in header files should be inline.  Code in implementation
files should only be inline if you have a very good reason for
doing so.  Same goes for __maybe_unused.


Segher
