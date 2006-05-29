Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 25D8867A40
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 03:54:12 +1000 (EST)
In-Reply-To: <Pine.LNX.4.64.0605291825500.11234@skynet.skynet.ie>
References: <20060526151214.GA5190@skynet.ie>
	<20060526094924.10efc515.akpm@osdl.org>
	<20060529154923.GA9025@skynet.ie>
	<2ebd96e4a7ea753273b2c5f856ba8c7a@kernel.crashing.org>
	<Pine.LNX.4.64.0605291825500.11234@skynet.skynet.ie>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c6414fc4b2c627791a49085bf8eea7e8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Compile failure fix for ppc on 2.6.17-rc4-mm3 (2nd
	attempt)
Date: Mon, 29 May 2006 19:56:21 +0200
To: Mel Gorman <mel@csn.ul.ie>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org, vgoyal@in.ibm.com,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>  #define push_end(res, size) do { unsigned long __sz = (size) ; \
>>> -	res->end = ((res->end + __sz) / (__sz + 1)) * (__sz + 1) + __sz; \
>>> +	resource_size_t farEnd = (res->end + __sz); \
>>> +	do_div(farEnd, (__sz + 1)); \
>>> +	res->end = farEnd * (__sz + 1) + __sz; \
>>>      } while (0)
>>
>> Size here is a) a misnomer (size + 1 is the actual size) and b) 
>> always a power
>> of two minus one.  So instead, do
>>
>> #define push_end(res, mask) res->end = -(-res->end & ~(unsigned 
>> long)mask)
>>
>> (with a do { } while(0) armour if you prefer).
>>
>
> It's not doing the same as the old code so is your suggested fix a 
> correct replacement?
>
> For example, given 0xfff for size the current code rounds res->end to 
> the next 0x1000 boundary and adds 0xfff. Your propose fix just rounds 
> it to the next 0x1000 if I'm reading it correctly but is what the code 
> was meant to do in the first place? Using masks, the equivilant of the 
> current code is something like;
>
> #define push_end(res, mask) do { \
> 	res->end = -(-res->end & ~(unsigned long)mask); \
> 	res->end += mask; \
> } while (0)

Yeah forgot a bit, this looks fine.


Segher
