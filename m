Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5251167A0E
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 02:21:26 +1000 (EST)
In-Reply-To: <20060529154923.GA9025@skynet.ie>
References: <20060526151214.GA5190@skynet.ie>
	<20060526094924.10efc515.akpm@osdl.org>
	<20060529154923.GA9025@skynet.ie>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2ebd96e4a7ea753273b2c5f856ba8c7a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Compile failure fix for ppc on 2.6.17-rc4-mm3 (2nd
	attempt)
Date: Mon, 29 May 2006 18:22:33 +0200
To: mel@csn.ul.ie (Mel Gorman)
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

>>>  arch/powerpc/kernel/built-in.o(.init.text+0x77b4): In function 
>>> `vrsqrtefp':
>>>  : undefined reference to `__udivdi3'
>>>  arch/powerpc/kernel/built-in.o(.init.text+0x7800): In function 
>>> `vrsqrtefp':
>>>  : undefined reference to `__udivdi3'
>>>  make: *** [.tmp_vmlinux1] Error 1
>>
>> A function with a name like that doesn't _deserve_ to compile.

Would vector_reciprocal_square_root_estimate_floating_point() be any 
better...
Anyway, this is just a machine insn mnemonic, so the function name is 
fine
I believe.

>  #define push_end(res, size) do { unsigned long __sz = (size) ; \
> -	res->end = ((res->end + __sz) / (__sz + 1)) * (__sz + 1) + __sz; \
> +	resource_size_t farEnd = (res->end + __sz); \
> +	do_div(farEnd, (__sz + 1)); \
> +	res->end = farEnd * (__sz + 1) + __sz; \
>      } while (0)

Size here is a) a misnomer (size + 1 is the actual size) and b) always 
a power
of two minus one.  So instead, do

#define push_end(res, mask) res->end = -(-res->end & ~(unsigned 
long)mask)

(with a do { } while(0) armour if you prefer).


Segher
