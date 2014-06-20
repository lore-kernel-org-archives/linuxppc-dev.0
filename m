Return-Path: <masami.hiramatsu.pt@hitachi.com>
Received: from mail4.hitachi.co.jp (mail4.hitachi.co.jp [133.145.228.5])
 by lists.ozlabs.org (Postfix) with ESMTP id 171D91A02CD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jun 2014 12:13:24 +1000 (EST)
Message-ID: <53A398BB.2010909@hitachi.com>
Date: Fri, 20 Jun 2014 11:13:15 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFT PATCH -next v3] [BUGFIX] kprobes: Fix "Failed to find
 blacklist" error on ia64 and ppc64
References: <5387F150.5000307@hitachi.com>
 <20140530031838.17427.75896.stgit@ltc230.yrl.intra.hitachi.co.jp>
 <539161D6.7020508@hitachi.com> <1403078179.32307.7.camel@concordia>
 <53A15201.7060404@hitachi.com> <1403141433.4768.1.camel@concordia>
 <53A26C99.6060000@hitachi.com> <53A285D0.1030106@in.ibm.com>
 <53A2908E.2000806@hitachi.com> <53A2B136.108@in.ibm.com>
 <53A2C315.9030006@hitachi.com> <53A2C78D.9060708@hitachi.com>
 <1403224646.18509.1.camel@concordia>
In-Reply-To: <1403224646.18509.1.camel@concordia>
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

(2014/06/20 9:37), Michael Ellerman wrote:
> On Thu, 2014-06-19 at 20:20 +0900, Masami Hiramatsu wrote:
>> (2014/06/19 20:01), Masami Hiramatsu wrote:
>>
>>>>>>> Ah, those messages should be shown in dmesg when booting if it doesn't work,
>>>>>>> because the messages are printed by initialization process of kprobe blacklist.
>>>>>>> So, reproducing it is just enabling CONFIG_KPROBES and boot it.
>>>>>> Well,  we don't get those messages on Power, since the kallsyms has the
>>>>>> entries for ".function_name". The correct way to verify is, either  :
>>>>>
>>>>> Hmm, that seems another issue on powerpc. Is that expected(and designed)
>>>>> behavior?
>>>> AFAIK, yes, it is.
>>>> To be more precise :
>>>>
>>>> we have 'foo' and '.foo' for a function foo(), where 'foo' points to the
>>>> function_entry and '.foo' points to the actual function.
>>>
>>> Ah, I see. So if we run
>>>
>>>   func_ptr p = foo;
>>>   return p == kallsyms_lookup_name(".foo");
>>>
>>> it returns true.
>>
>> One more thing I should know, is the address of ".function_name" within the
>> kernel text? In other words, does kernel_text_address() return true for that
>> address? If not, it's easy to verify the address.
> 
> Yes. That is the text address, kernel_text_address() should definitely return
> true.
> 
> On 64-bit, ABIv1, "foo" points to the function descriptor, in the ".opd"
> section.
> 
> ".foo" points to the actual text of the function, in ".text".

Hmm, I misunderstood that. Anyway, we can verify it by kernel_text_address().

> 
> On 64-bit, ABIv2, "foo" points to the text in ".text". There are no dot
> symbols.

OK, in that case, kernel_text_address() check is still available. :)

Thank you,


-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
