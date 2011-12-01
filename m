Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AEF3@saturn3.aculab.com>
References: <AE90C24D6B3A694183C094C60CF0A2F6D8AEF3@saturn3.aculab.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1E6FA02A-2922-4C2C-8E6D-D99151527FB8@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 5/6] powerpc/boot: Add mfdcrx
Date: Thu, 1 Dec 2011 23:55:29 +0100
To: David Laight <David.Laight@ACULAB.COM>
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> +#define mfdcrx(rn) \
>>> +	({	\
>>> +		unsigned long rval; \
>>> +		asm volatile("mfdcrx %0,%1" : "=r"(rval) : "g"(rn)); \
>>> +		rval; \
>>> +	})
>>
>> "g" is never correct on PowerPC, you want "r" here.  You can write
>> this as a static inline btw, you only need the #define stuff when
>> there is an "i" constraint involved.
>
> I think you can still use static inlines even when a
> constraint is one that requires a compile time constant.

Marking a function inline does not guarantee the compiler will
perform inline substitution on it, which you need here.  I don't
think it's a problem with recent GCC in the context of the Linux
kernel though, if you use __always_inline that is.


Segher
