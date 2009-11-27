Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 181001007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 23:10:07 +1100 (EST)
In-Reply-To: <9741644C-BED3-45D9-B405-4C4FC2184DC7@kernel.crashing.org>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-12-git-send-email-albert_herranz@yahoo.es>
	<8E6E11A2-25F1-4AB8-B42E-58C269018CD2@kernel.crashing.org>
	<4B0D65C5.8090304@yahoo.es>
	<7556BF73-5D6D-4817-A02F-3DFA05E9AC58@kernel.crashing.org>
	<4B0EFBB2.9090206@yahoo.es>
	<9741644C-BED3-45D9-B405-4C4FC2184DC7@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <786BBFA3-39AF-4100-8406-6B32258D3174@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 11/19] powerpc: gamecube/wii: flipper interrupt
	controller support
Date: Fri, 27 Nov 2009 13:17:07 +0100
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>>>>> +/*
>>>>>> + * Each interrupt has a corresponding bit in both
>>>>>> + * the Interrupt Cause (ICR) and Interrupt Mask (IMR) registers.
>>>>>> + *
>>>>>> + * Enabling/disabling an interrupt line involves asserting/ 
>>>>>> clearing
>>>>>> + * the corresponding bit in IMR. ACK'ing a request simply  
>>>>>> involves
>>>>>> + * asserting the corresponding bit in ICR.
>>>>>> + */
>>>
>>> I looked it up in YAGCD; it says that _reading_ the ICR reg already
>>> acks all interrupts (and clears the bits), you never write this reg!
>>
>> YAGCD is not always right. You should not take it as _the truth_.
>
> Oh I know.  But I have no better source of information.  Well I could
> actually test it, that's very easy using OF :-)  Let's do that.

I tested it.  It turns out that neither reading or writing this register
does anything; the bits are automatically cleared when the source  
deasserts.

I didn't test all interrupts, some are harder to generate "on demand"  
than
others.


Segher
