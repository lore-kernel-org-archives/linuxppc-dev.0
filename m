Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/15] celleb: interfaces to the hypervisor of Celleb
Date: Tue, 12 Dec 2006 14:50:40 +1100
References: <200612120323.kBC3NjEW004119@toshiba.co.jp>
In-Reply-To: <200612120323.kBC3NjEW004119@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612121450.41561.jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +static inline int64_t beat_allocate_memory(uint64_t __in0, uint64_t
> __in1, uint64_t __in2, uint64_t __in3,void** __out0,uint64_t* __out1)
> { +	register uint64_t __reg0 __asm__("r3");
> +	register uint64_t __reg1 __asm__("r4");
> +	register uint64_t __reg2 __asm__("r5");
> +	register uint64_t __reg3 __asm__("r6");
> +	register uint64_t __sn __asm__("r11") = (0UL);
> +	__reg0 = (uint64_t)__in0;
> +	__reg1 = (uint64_t)__in1;
> +	__reg2 = (uint64_t)__in2;
> +	__reg3 = (uint64_t)__in3;
> +	__asm__ __volatile__("or 2,2,2\n.long 0x44000022"
> +	: "=&r"(__sn), "=&r"(__reg0), "=&r"(__reg1), "=&r"(__reg2),
> "=&r"(__reg3) +	: "0"(__sn), "1"(__reg0), "2"(__reg1), "3"(__reg2),
> "4"(__reg3) +	: "memory", "cr0", "cr1", "cr6", "cr7", "xer", "lr");
> +	*__out0 = (void*)__reg1;
> +	*__out1 = (uint64_t)__reg2;
> +	if(__reg0) beat_errno = __reg0;
> +	return __reg0;
> +}

Wow.

I'd start by implementing these in assembler, rather than making C look 
like assembler. You'll be able to throw out the input argument 
assignments, because (according to the ABI) your arguments will already 
be in the registers you're assigning them to. You'll just need a little 
post-call glue to assign the output arguments.

Then you'll probably find that each function contains a lot of code (the 
or and the .long, for starters) that can be shared, then you can put 
that in a macro.

Take a look at plpar_hcall in arch/powerpc/platforms/pseries/hvCall.S.

Also, do you need beat_errno? you return the same value in every 
function anyway.

Cheers,


Jeremy
