Return-Path: <masami.hiramatsu.pt@hitachi.com>
Received: from mail4.hitachi.co.jp (mail4.hitachi.co.jp [133.145.228.5])
 by lists.ozlabs.org (Postfix) with ESMTP id A108C1A0123
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 18:47:05 +1000 (EST)
Message-ID: <53A15201.7060404@hitachi.com>
Date: Wed, 18 Jun 2014 17:46:57 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: Re: [RFT PATCH -next v3] [BUGFIX] kprobes: Fix "Failed to
 find blacklist" error on ia64 and ppc64
References: <5387F150.5000307@hitachi.com>
 <20140530031838.17427.75896.stgit@ltc230.yrl.intra.hitachi.co.jp>
 <539161D6.7020508@hitachi.com> <1403078179.32307.7.camel@concordia>
In-Reply-To: <1403078179.32307.7.camel@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-ia64@vger.kernel.org,
 sparse@chrisli.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-tip-commits@vger.kernel.org,
 anil.s.keshavamurthy@intel.com, Ingo Molnar <mingo@kernel.org>,
 "Suzuki K. Poulose" <suzuki@in.ibm.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Rusty Russell <rusty@rustcorp.com.au>,
 Chris Wright <chrisw@sous-sol.org>, yrl.pp-manager.tt@hitachi.com,
 akataria@vmware.com, Tony Luck <tony.luck@intel.com>,
 Kevin Hao <haokexin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 rdunlap@infradead.org, Tony Luck <tony.luck@gmail.com>, dl9pf@gmx.de,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(2014/06/18 16:56), Michael Ellerman wrote:
> On Fri, 2014-06-06 at 15:38 +0900, Masami Hiramatsu wrote:
>> Ping?
>>
>> I guess this should go to 3.16 branch, shouldn't it?
> 
>>> diff --git a/arch/powerpc/include/asm/types.h b/arch/powerpc/include/asm/types.h
>>> index bfb6ded..8b89d65 100644
>>> --- a/arch/powerpc/include/asm/types.h
>>> +++ b/arch/powerpc/include/asm/types.h
>>> @@ -25,6 +25,17 @@ typedef struct {
>>>  	unsigned long env;
>>>  } func_descr_t;
>>>  
>>> +#if defined(CONFIG_PPC64) && (!defined(_CALL_ELF) || _CALL_ELF == 1)
>>> +/*
>>> + * On PPC64 ABIv1 the function pointer actually points to the
>>> + * function's descriptor. The first entry in the descriptor is the
>>> + * address of the function text.
>>> + */
>>> +#define function_entry(fn)	(((func_descr_t *)(fn))->entry)
>>> +#else
>>> +#define function_entry(fn)	((unsigned long)(fn))
>>> +#endif
> 
> We already have ppc_function_entry(), can't you use that?

I'd like to ask you whether the address which ppc_function_entry() returns on
PPC ABIv2 is really same address in kallsyms or not.
As you can see, kprobes uses function_entry() to get the actual entry address
where kallsyms knows. I have not much information about that, but it seems that
the "global entry point" is the address which kallsyms knows, isn't it?

Thank you,

-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
