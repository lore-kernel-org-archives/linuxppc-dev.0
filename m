Return-Path: <breno.debian@gmail.com>
Received: from mail-qt0-f195.google.com (mail-qt0-f195.google.com
 [209.85.216.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41rpPC0YhjzDqrM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 00:19:26 +1000 (AEST)
Received: by mail-qt0-f195.google.com with SMTP id q12-v6so4824675qtp.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2018 07:19:26 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] powerpc/tm: Do not recheckpoint non-tm task
To: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
References: <201806160346.lDndh49W%fengguang.wu@intel.com>
 <1529362784-14194-1-git-send-email-leitao@debian.org>
 <1529362784-14194-4-git-send-email-leitao@debian.org>
 <cb89f5cf8d751da3de587b33cc07cc9292f5b324.camel@neuling.org>
From: Breno Leitao <leitao@debian.org>
Message-ID: <2d206f31-fb01-2f16-65b7-5135c918156d@debian.org>
Date: Thu, 16 Aug 2018 11:19:17 -0300
MIME-Version: 1.0
In-Reply-To: <cb89f5cf8d751da3de587b33cc07cc9292f5b324.camel@neuling.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hey Mikey,

Thanks for the review.

On 08/15/2018 08:50 PM, Michael Neuling wrote:
> On Mon, 2018-06-18 at 19:59 -0300, Breno Leitao wrote:
>> If __switch_to() tries to context switch from task A to task B, and task A
>>  had task->thread->regs->msr[TM] enabled, then __switch_to_tm() will call
>> tm_recheckpoint_new_task(), which will call trecheckpoint, for task B, which
>>  is clearly wrong since task B might not be an active TM user.
>>
>> This does not cause a lot of damage because tm_recheckpoint() will abort
>> the call since it realize that the current task does not have msr[TM] bit
>> set.
>>
>> Signed-off-by: Breno Leitao <leitao@debian.org>
>> ---
>>  arch/powerpc/kernel/process.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
>> index f8beee03f00a..d26a150766ef 100644
>> --- a/arch/powerpc/kernel/process.c
>> +++ b/arch/powerpc/kernel/process.c
>> @@ -1036,7 +1036,8 @@ static inline void __switch_to_tm(struct task_struct
>> *prev,
>>  				prev->thread.regs->msr &= ~MSR_TM;
>>  		}
>>  
>> -		tm_recheckpoint_new_task(new);
>> +		if (tm_enabled(new))
>> +			tm_recheckpoint_new_task(new);
> 
> I'm not sure we need this patch as tm_recheckpoint_new_task() does this itself.

My plan is to move this check prior to calling these TM functions, doing
early checking and avoiding calling tm_recheckpoint on a non-tm enabled task.
It is very weird when you see, during a tracing, a kernel thread (PF_KTHREAD)
being tm_recheckpointed. :-/

That said, the TM function would do the operation other than "check and do
it" mode.

Ideally I would like to check the thread before calling any TM functions,
and warning (WARN_ON) if we detect, later in the game, that a thread is not
TM enabled.

This helps on two different fronts, in my opinion:

 * Code readability
 * Understanding tracing (ftrace) outputs.
