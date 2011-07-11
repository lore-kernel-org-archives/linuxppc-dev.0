Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 17007B6F75
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jul 2011 21:29:35 +1000 (EST)
Message-ID: <4E1ADE5F.9030507@windriver.com>
Date: Mon, 11 Jul 2011 19:28:31 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: <ananth@in.ibm.com>
Subject: Re: [v2 PATCH 2/2] booke/kprobe:
	remove	unnecessary	preempt_enable_no_resched
References: <1310351976-24078-1-git-send-email-tiejun.chen@windriver.com>	<1310351976-24078-2-git-send-email-tiejun.chen@windriver.com>	<20110711055516.GA4659@in.ibm.com>
	<4E1AB59A.6050002@windriver.com>
In-Reply-To: <4E1AB59A.6050002@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Cc: "tiejun.chen" <tiejun.chen@windriver.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

tiejun.chen wrote:
> Ananth N Mavinakayanahalli wrote:
>> On Mon, Jul 11, 2011 at 10:39:35AM +0800, Tiejun Chen wrote:
>>> When enable CONFIG_PREEMPT we will trigger the following call trace:
>>>
>>> BUG: scheduling while atomic: swapper/1/0x10000000
>>> ...
>>>
>>> krpobe always goes through the following path:
>>>
>>> program_check_exception()
>>>         |
>>>         + notify_die(DIE_BPT, "breakpoint",...)
>>>                 |
>>>                 + kprobe_handler()
>>>                         |
>>>                         + preempt_disable();
>>>                         + break_handler() <- preempt_enable_no_resched()
>>>                         + emulate_step()
>>>                         + preempt_enable_no_resched()
>>>                         ...
>>>         exit
>>>
>>> We should remove unnecessary preempt_enable_no_resched() inside of break_handler()
>>> since looks longjmp_break_handler() always go the above path.
>> The current code is correct. Reasoning follows...
>>
>> setjmp_pre_handler() and longjmp_break_handler() are used only for
>> jprobes. In the case of a jprobe, the code flow would be:
>>
>> bp hit -> kprobe_handler() -> preempt_disable() -> setjmp_pre_handler()
>> (not that since this routine returns 1, we skip sstep here) -> jp->entry()
>> -> jprobe_return() -> bp hit -> kprobe_handler() -> preempt_disable() again
>> -> longjmp_break_handler() -> preempt_enable() -> sstep -> preempt_enable()
>> (for the second kprobe_handler() entry).
>>
>> You could verify this with a preempt_count() printk with a
>> CONFIG_PREEMPT=y kernel.
>>
>>> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
>> Nack, sorry :-)
> 
> You're right.
> 
> When use EXC_LEVEL_EXCEPTION_PROLOG for Critical/Machine check, if the exception
> came from kernel mode, we copy thread_info flags, *preempt*, and task pointer
> from the process thread_info. So here I steal EXC_LEVEL_EXCEPTION_PROLOG for
> Program Exception, preempt count would be corrupted incorrectly.

Looks I miss the specific return-from-program-exc to restore those necessary
thread information like we did for debug exception with ret_from_debug_exc when
use EXC_LEVEL_EXCEPTION_PROLOG for debug exception.

Will update this on v3.

Tiejun

> 
> Thanks
> Tiejun
> 
>> Ananth
>>
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
