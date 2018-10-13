Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C64C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 08:31:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9551120895
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 08:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9551120895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XHxM2cJ1zF3Hx
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 19:31:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XHvF6yQ3zF0dd
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 19:30:01 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42XHv32Sldz9ttFk;
 Sat, 13 Oct 2018 10:29:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id JD_jAP_Ae2By; Sat, 13 Oct 2018 10:29:51 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42XHv31jCJz9ttFY;
 Sat, 13 Oct 2018 10:29:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 854B48B782;
 Sat, 13 Oct 2018 10:29:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id iGRmdS3gBAs1; Sat, 13 Oct 2018 10:29:56 +0200 (CEST)
Received: from pc13168vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 16F088B74B;
 Sat, 13 Oct 2018 10:29:56 +0200 (CEST)
Subject: Re: [PATCH v2 3/3] powerpc: machine check interrupt is a non-maskable
 interrupt
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Nicholas Piggin <npiggin@gmail.com>
References: <20170719065912.19183-1-npiggin@gmail.com>
 <20170719065912.19183-4-npiggin@gmail.com>
 <30487984-752a-960d-6aae-6571c55c7ba5@c-s.fr>
 <20181009143241.026f3e7f@roar.ozlabs.ibm.com>
 <ccf61fc2-1f2e-7b67-c481-fa4c00a65aae@c-s.fr>
 <20181009153058.2564e7a1@roar.ozlabs.ibm.com>
 <0539727f-8420-3176-30b5-f4a6a1ccd4a4@c-s.fr>
 <20181009211650.042d428c@roar.ozlabs.ibm.com>
 <9f0cbf48-d278-08bf-cb32-8b9608768025@c-s.fr>
Message-ID: <bb79aa53-8924-b334-93d6-fc907c8880e1@c-s.fr>
Date: Sat, 13 Oct 2018 08:29:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <9f0cbf48-d278-08bf-cb32-8b9608768025@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 10/11/2018 02:31 PM, Christophe LEROY wrote:
> 
> 
> Le 09/10/2018 à 13:16, Nicholas Piggin a écrit :
>> On Tue, 9 Oct 2018 09:36:18 +0000
>> Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>
>>> On 10/09/2018 05:30 AM, Nicholas Piggin wrote:
>>>> On Tue, 9 Oct 2018 06:46:30 +0200
>>>> Christophe LEROY <christophe.leroy@c-s.fr> wrote:
>>>>> Le 09/10/2018 à 06:32, Nicholas Piggin a écrit :
>>>>>> On Mon, 8 Oct 2018 17:39:11 +0200
>>>>>> Christophe LEROY <christophe.leroy@c-s.fr> wrote:
>>>>>>> Hi Nick,
>>>>>>>
>>>>>>> Le 19/07/2017 à 08:59, Nicholas Piggin a écrit :
>>>>>>>> Use nmi_enter similarly to system reset interrupts. This uses NMI
>>>>>>>> printk NMI buffers and turns off various debugging facilities that
>>>>>>>> helps avoid tripping on ourselves or other CPUs.
>>>>>>>>
>>>>>>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>>>>>> ---
>>>>>>>>      arch/powerpc/kernel/traps.c | 9 ++++++---
>>>>>>>>      1 file changed, 6 insertions(+), 3 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/arch/powerpc/kernel/traps.c 
>>>>>>>> b/arch/powerpc/kernel/traps.c
>>>>>>>> index 2849c4f50324..6d31f9d7c333 100644
>>>>>>>> --- a/arch/powerpc/kernel/traps.c
>>>>>>>> +++ b/arch/powerpc/kernel/traps.c
>>>>>>>> @@ -789,8 +789,10 @@ int machine_check_generic(struct pt_regs 
>>>>>>>> *regs)
>>>>>>>>      void machine_check_exception(struct pt_regs *regs)
>>>>>>>>      {
>>>>>>>> -    enum ctx_state prev_state = exception_enter();
>>>>>>>>          int recover = 0;
>>>>>>>> +    bool nested = in_nmi();
>>>>>>>> +    if (!nested)
>>>>>>>> +        nmi_enter();
>>>>>>>
>>>>>>> This alters preempt_count, then when die() is called
>>>>>>> in_interrupt() returns true allthough the trap didn't happen in
>>>>>>> interrupt, so oops_end() panics for "fatal exception in interrupt"
>>>>>>> instead of gently sending SIGBUS the faulting app.
>>>>>>
>>>>>> Thanks for tracking that down.
>>>>>>> Any idea on how to fix this ?
>>>>>>
>>>>>> I would say we have to deliver the sigbus by hand.
>>>>>>
>>>>>>        if ((user_mode(regs)))
>>>>>>            _exception(SIGBUS, regs, BUS_MCEERR_AR, regs->nip);
>>>>>>        else
>>>>>>            die("Machine check", regs, SIGBUS);
>>>>>
>>>>> And what about all the other things done by 'die()' ?
>>>>>
>>>>> And what if it is a kernel thread ?
>>>>>
>>>>> In one of my boards, I have a kernel thread regularly checking the HW,
>>>>> and if it gets a machine check I expect it to gently stop and the die
>>>>> notification to be delivered to all registered notifiers.
>>>>>
>>>>> Until before this patch, it was working well.
>>>>
>>>> I guess the alternative is we could check regs->trap for machine
>>>> check in the die test. Complication is having to account for MCE
>>>> in an interrupt handler.
>>>>
>>>>          if (in_interrupt()) {
>>>>                   if (!IS_MCHECK_EXC(regs) || (irq_count() - 
>>>> (NMI_OFFSET + HARDIRQ_OFFSET)))
>>>>                       panic("Fatal exception in interrupt");
>>>>          }
>>>>
>>>> Something like that might work for you? We needs a ppc64 macro for the
>>>> MCE, and can probably add something like in_nmi_from_interrupt() for
>>>> the second part of the test.
>>>
>>> Don't know, I'm away from home on business trip so I won't be able to
>>> test anything before next week. However it looks more or less like a
>>> hack, doesn't it ?
>>
>> I thought it seemed okay (with the right functions added). Actually it
>> could be a bit nicer to do this, then it works generally :
>>
>>           if (in_interrupt()) {
>>                    if (!in_nmi() || in_nmi_from_interrupt())
>>                        panic("Fatal exception in interrupt");
>>           }
>>
>>>
>>> What about the following ?
>>
>> Hmm, in some ways maybe it's nicer. One complication is I would like the
>> same thing to be available for platform specific machine check
>> handlers, so then you need to pass is_in_interrupt to them. Which you
>> can do without any problem... But is it cleaner than the above?
> 
> For me it looks cleaner than twiddle the preempt_count depending on 
> whether we were or not already in nmi() .
> 
> Let's draft something and see what it looks like.

Ok, finaly I went to your solution, see below, as it avoids having to 
modify all subarch and platform specific machine check handlers.

Unfortunately it doesn't solves the issue, it only delays it:

oops_end() calls do_exit(), which has the following test:

	if (unlikely(in_interrupt()))
		panic("Aiee, killing interrupt handler!");


So at the time being I still have no idea how to fix that, have you ?

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index fd58749b4d6b..3569e826f0c2 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -132,6 +132,21 @@ static void pmac_backlight_unblank(void)
  static inline void pmac_backlight_unblank(void) { }
  #endif

+static bool from_interrupt(void)
+{
+	if (!in_nmi())
+		return in_interrupt();
+	/*
+	 * if we are in NMI, we need to determine if we were already in
+	 * interrupt before entering NMI. To do that, we recalculate irq_count()
+	 * from before the call to nmi_enter().
+	 * If we were already in NMI and reentered in a new one, we have
+	 * increased the preempt count by HARDIRQ_OFFSET, so the calculated
+	 * value will be not null
+	 */
+	return irq_count() - NMI_OFFSET - HARDIRQ_OFFSET;
+}
+
  /*
   * If oops/die is expected to crash the machine, return true here.
   *
@@ -147,8 +162,7 @@ bool die_will_crash(void)
  		return true;
  	if (kexec_should_crash(current))
  		return true;
-	if (in_interrupt() || panic_on_oops ||
-			!current->pid || is_global_init(current))
+	if (from_interrupt() || panic_on_oops || !current->pid || 
is_global_init(current))
  		return true;

  	return false;
@@ -242,12 +256,12 @@ static void oops_end(unsigned long flags, struct 
pt_regs *regs,
  	 * know we are going to panic, delay for 1 second so we have a
  	 * chance to get clean backtraces from all CPUs that are oopsing.
  	 */
-	if (in_interrupt() || panic_on_oops || !current->pid ||
+	if (from_interrupt() || panic_on_oops || !current->pid ||
  	    is_global_init(current)) {
  		mdelay(MSEC_PER_SEC);
  	}

-	if (in_interrupt())
+	if (from_interrupt())
  		panic("Fatal exception in interrupt");
  	if (panic_on_oops)
  		panic("Fatal exception");
@@ -378,15 +392,37 @@ void _exception(int signr, struct pt_regs *regs, 
int code, unsigned long addr)
  	_exception_pkey(signr, regs, code, addr, 0);
  }

+static bool exception_nmi_enter(void)
+{
+	bool nested = in_nmi();
+
+	/*
+	 * In case we are already in an NMI, increase preempt_count by
+	 * HARDIRQ_OFFSET in order to get from_interrupt() return true
+	 */
+	if (nested)
+		preempt_count_add(HARDIRQ_OFFSET);
+	else
+		nmi_enter();
+
+	return nested;
+}
+
+static void exception_nmi_exit(bool nested)
+{
+	if (nested)
+		preempt_count_sub(HARDIRQ_OFFSET);
+	else
+		nmi_exit();
+}
+
  void system_reset_exception(struct pt_regs *regs)
  {
  	/*
  	 * Avoid crashes in case of nested NMI exceptions. Recoverability
  	 * is determined by RI and in_nmi
  	 */
-	bool nested = in_nmi();
-	if (!nested)
-		nmi_enter();
+	bool nested = exception_nmi_enter();

  	__this_cpu_inc(irq_stat.sreset_irqs);

@@ -435,8 +471,7 @@ void system_reset_exception(struct pt_regs *regs)
  	if (!(regs->msr & MSR_RI))
  		nmi_panic(regs, "Unrecoverable System Reset");

-	if (!nested)
-		nmi_exit();
+	exception_nmi_exit(nested);

  	/* What should we do here? We could issue a shutdown or hard reset. */
  }
@@ -737,9 +772,7 @@ int machine_check_generic(struct pt_regs *regs)
  void machine_check_exception(struct pt_regs *regs)
  {
  	int recover = 0;
-	bool nested = in_nmi();
-	if (!nested)
-		nmi_enter();
+	bool nested = exception_nmi_enter();

  	__this_cpu_inc(irq_stat.mce_exceptions);

@@ -772,8 +805,7 @@ void machine_check_exception(struct pt_regs *regs)
  		nmi_panic(regs, "Unrecoverable Machine check");

  bail:
-	if (!nested)
-		nmi_exit();
+	exception_nmi_exit(nested);
  }

  void SMIException(struct pt_regs *regs)

> 
> 
>>
>> I guess one advantage of yours is that a BUG somewhere in the NMI path
>> will panic the system. Or is that a disadvantage?
> 
> Why would it panic the system more than now ? And is it an issue at all 
> ? Doesn't BUG() panic in any case ?
> 

Christophe
