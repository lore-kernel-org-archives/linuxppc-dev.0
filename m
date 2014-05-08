Return-Path: <masami.hiramatsu.pt@hitachi.com>
Received: from mail7.hitachi.co.jp (mail7.hitachi.co.jp [133.145.228.42])
 by ozlabs.org (Postfix) with ESMTP id 7C3E21401A7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 15:40:09 +1000 (EST)
Message-ID: <536B18B0.9060209@hitachi.com>
Date: Thu, 08 May 2014 14:40:00 +0900
From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
MIME-Version: 1.0
To: ananth@in.ibm.com
Subject: Re: [RFT PATCH -next ] [BUGFIX] kprobes: Fix "Failed to find
 blacklist" error on ia64 and ppc64
References: <536A16A6.5040709@hitachi.com>
 <20140507115551.22259.70581.stgit@ltc230.yrl.intra.hitachi.co.jp>
 <20140508044753.GA13413@in.ibm.com>
In-Reply-To: <20140508044753.GA13413@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, linux-ia64@vger.kernel.org,
 sparse@chrisli.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-tip-commits@vger.kernel.org,
 anil.s.keshavamurthy@intel.com, Ingo Molnar <mingo@kernel.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>,
 yrl.pp-manager.tt@hitachi.com, akataria@vmware.com,
 Tony Luck <tony.luck@intel.com>, Kevin Hao <haokexin@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, rdunlap@infradead.org,
 Tony Luck <tony.luck@gmail.com>, dl9pf@gmx.de,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(2014/05/08 13:47), Ananth N Mavinakayanahalli wrote:
> On Wed, May 07, 2014 at 08:55:51PM +0900, Masami Hiramatsu wrote:
> 
> ...
> 
>> +#if defined(CONFIG_PPC64) && (!defined(_CALL_ELF) || _CALL_ELF == 1)
>> +/*
>> + * On PPC64 ABIv1 the function pointer actually points to the
>> + * function's descriptor. The first entry in the descriptor is the
>> + * address of the function text.
>> + */
>> +#define constant_function_entry(fn)	(((func_descr_t *)(fn))->entry)
>> +#else
>> +#define constant_function_entry(fn)	((unsigned long)(fn))
>> +#endif
>> +
>>  #endif /* __ASSEMBLY__ */
> 
> Hi Masami,
> 
> You could just use ppc_function_entry() instead.

No, I think ppc_function_entry() has two problems (on the latest -next kernel)

At first, that is an inlined functions which is not applied in build time.
Since the NOKPROBE_SYMBOL() is used outside of any functions as like as
EXPORT_SYMBOL(), we can only use preprocessed macros.
Next, on PPC64 ABI*v2*, ppc_function_entry() returns local function entry,
which seems global function entry + 2 insns. I'm not sure about implementation
of the kallsyms on PPC64 ABIv2, but I guess we need global function entry
for kallsyms.

BTW, could you test this patch on the latest -next tree on PPC64 if possible?

Thank you,

-- 
Masami HIRAMATSU
Software Platform Research Dept. Linux Technology Research Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
