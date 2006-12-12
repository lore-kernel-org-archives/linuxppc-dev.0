Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from inet-tsb5.toshiba.co.jp (inet-tsb5.toshiba.co.jp [202.33.96.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2A37567B93
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 22:21:30 +1100 (EST)
Date: Tue, 12 Dec 2006 20:21:21 +0900 (JST)
Message-Id: <200612121121.kBCBLMBI029593@toshiba.co.jp>
To: jk@ozlabs.org, benh@kernel.crashing.org
Subject: Re: [PATCH 4/15] celleb: interfaces to the hypervisor of Celleb
In-Reply-To: <1165898559.11914.18.camel@localhost.localdomain
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Jeremy-san, Ben-san,

Thank you for your comment.

From: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 4/15] celleb: interfaces to the hypervisor of Celleb
Date: Tue, 12 Dec 2006 14:50:40 +1100

> > +static inline int64_t beat_allocate_memory(uint64_t __in0, uint64_t
> > __in1, uint64_t __in2, uint64_t __in3,void** __out0,uint64_t* __out1)
> > { +	   register uint64_t __reg0 __asm__("r3");
> > + register uint64_t __reg1 __asm__("r4");
> > + register uint64_t __reg2 __asm__("r5");
> > + register uint64_t __reg3 __asm__("r6");
> > + register uint64_t __sn __asm__("r11") = (0UL);
> > + __reg0 = (uint64_t)__in0;
> > + __reg1 = (uint64_t)__in1;
> > + __reg2 = (uint64_t)__in2;
> > + __reg3 = (uint64_t)__in3;
> > + __asm__ __volatile__("or 2,2,2\n.long 0x44000022"
> > + : "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2),
> > "=&r"(__reg3) +  : "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2),
> > "4"(__reg3) + : "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
> > +		*__out0 = (void*)__reg1;
> > +		*__out1 = (uint64_t)__reg2;
> > +		if(__reg0) beat_errno = __reg0;
> > +		return __reg0;
> > +}

> Wow.

> I'd start by implementing these in assembler, rather than making C look 
> like assembler. You'll be able to throw out the input argument 
> assignments, because (according to the ABI) your arguments will already 
> be in the registers you're assigning them to. You'll just need a little 
> post-call glue to assign the output arguments.

Thanks, I understand that. The above code is written only to embed
call-ups into inline function in C.
So I think 'inlining hypervisor call' is thrown away from Linux.
Is this correct?

Anyway, we have no reason to divert implementation too far from that of
pSeries, so we will make change the code.

> Then you'll probably find that each function contains a lot of code (the 
> or and the .long, for starters) that can be shared, then you can put 
> that in a macro.

I see.

> Take a look at plpar_hcall in arch/powerpc/platforms/pseries/hvCall.S.

Thank you. We will look it deeply.

> Also, do you need beat_errno? you return the same value in every 
> function anyway.

"beat_errno" is exactly for our library. not for Linux. So we can remove
it. The code above is machine-generated from our hypervisor call table.

Best regards,
Kou Ishizaki
