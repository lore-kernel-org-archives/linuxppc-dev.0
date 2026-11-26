Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB49606A31E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wPPJwvg8
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZxxK0Yqzz2xl0;
	Fri, 27 Nov 2026 00:20:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795699221;
	cv=none; b=PyMl2OWEn+wzdnthS83ka0isyi7/Xg/47sESPSlTH2Q5EKQlwPxb4Qi/tK9W3bJWlPJhjA1zp79ykecK80Wt1Ta0LslIDrY59ClIB7vBngjNmFs5MXAfaOKzNUPZcU2tDCNlRAPa/9LjsQzdAqnLaVE6vwpk3LLoNmfANMRHpFfjQeIH7eWWHfLEJCj35rzmSFceLxBdiie4dxS9RBDjQ81NMCcMLN2w/7NfdDWusIfVOPCjUZWWGa/BhH/5vPinE4kcuwZlub/NEQunZYIvg/s+3YCurJE7D7HpFRxwDtCxhARLkh2uRTLHwF9mL+kVghYI72fHcSzCmo1jOCIBlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795699221; c=relaxed/relaxed;
	bh=6EARNOFZKtzyHY8UuNeSqkUT2fUq1Xc+ICVwn502b0w=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=gn1mlqYkDaI7VN/KWSoAzZPHQUaQey3rcWYDd0vMwMbAUN8CQ9hiEZWYYWxYrKlMQ47Ejt3VJhP/j3FpG8xD+i8ypJeSIPLVR7tjr3jwAuT5zC7ZPYKHOfiFcV6GAsxpBLiB+MCWGCejMmzG5mosml2A6XvS5RB+dmeoaqqMnLpOgFcRTDOJETYs/b2q/szSOYKjtuGPLjOgPUZgUVVEf6480sa8eISBFariWZj+2hZytv4BM6krUV0nmcvNG0XDmUO63UsbaCiRi5CzEO/5oq3Kviq4OCqY9fgaPHUPkaVvU3VsF6/ROqMiyGdmD1X9X4IOXsVfFwD4LmdBYVkILg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wPPJwvg8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wPPJwvg8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com [IPv6:2607:f8b0:4864:20::1332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZxxH3vt1z2xWt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 00:20:18 +1100 (AEDT)
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-386cf1041cdso3370419eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 05:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795699215; x=1796304015; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6EARNOFZKtzyHY8UuNeSqkUT2fUq1Xc+ICVwn502b0w=;
        b=wPPJwvg8/uL2EXs9gCwWpFY+sGT/VTBSaT73qVmk4UO8HmPzjPNpHp5Z/ZcUddD1i5
         9iBhNExoiWJHyFRdeoez0Jtgg3KKOaKLvEVQfuftsrC+EWSCtKShKPk8VPq6I3j661FN
         smw//gQJ/4nPLqBBc5Xqd8ZrgsAnUrl6b3alqzw0EJrwzbSQerSpxncluuUN07AOZ1UR
         w98aYRwF6oEP+XhOeEgdni7++rV/Fa4EoLFClmo902rIaQuiyWtww+0wQ7luZk+dIexh
         86iDOK2Eqf3zi3rMpwBy7PHQHIMyt0P3Zh9QtmCu3sCpOB86vs+U6wJZyPVSdXQ9UMYh
         Yhlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795699215; x=1796304015;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6EARNOFZKtzyHY8UuNeSqkUT2fUq1Xc+ICVwn502b0w=;
        b=V79OrW40I6orYFF4r3wVLBZ78/oE1CY8JYD2+20Ibwv4MQYB2mAiyzWWUNc8o0zmZA
         eUy9FVGsbUwqYxGOjh2hsK3xtlBx1oMrHZZtCoR1KE0KvHWbGAcbDBQ0T/DMK8F7GoRN
         6/U3kARHIpTr0KLhlBD7CsgD4wzmJIhhRO2J9npQMrRfXBP6TvsZO31g0B88moN6PlKU
         PJ6Hrtb+tARiFildokzC39e1T52jfltcYy/sQ5Dn8vWA0CLtbElYC4VOeT2ZJE4XbV+u
         X2DDmyVf5Cwt+3TSNHiaSzKNvODoXVqPywrPienddiMxir0MkPF7Jrn1PBn6n6rlLJz6
         7DxA==
X-Gm-Message-State: APuU4Z8QU0Qh1Y/j1vs0aQb+O0LeHOxtsCWvNOAGy7ji1iMkRry4Oyeu
	dExBAxFolnii5+qzl8bNPb98kCkmRGQ9o+DOkjr6DVdQy7nBsTgJypiQ
X-Gm-Gg: AZFdTZceTzzv37cFn4Y2UOcxLk1H/pXgcft9AnikUAYF+PAbzuacOjt/lGVCMh1ErqC
	1wTaADHiiNKmYftqvaVCATgI2UdClQ7RQs5S7IhbD1SZV+lL/HCjPapzoCuUFPym83DcV7KMOWU
	d1Kwuaoc7QznfT+L4VCg+OKyR7kwQGNOkWa+fIocNMAAoMVviSkbM/BVgBDc2hGHxwdTJTBWi7B
	o6DFTvAYiXHxMgfqYwVk6TXLvzpkPpu30kSh0R3iJ1niRqVBgfHNF+cYpdGNSGmjtsIJsWBUAN7
	Vqsy9j5N2gfirLB/ZJKfiisaBKQeAGeulCQb67BhgR+sYmYVALyZ9YwKND/i0vpya1TDpTY4FKD
	ES23Aj0/y+7y8d5K5tmcznrG7mwek0yJVmJiz5p/s+dAzW76XPIpYgjZEUOs+QUQboOTr/Cw0/e
	W8vfRVUu74Xuz6X1m347AZvq1aNhr9aoCePsURuPn2bj+QYS8do0oAg8mpIIlJBfbMiZsCwHQp1
	4+XSSsNPSa3Ri6UnwSC52Vi/sUn6PDTS4aR/Qre/BuN65aaiGaBNAk++NurDbu7SGwCuORZy0Ch
	yKIsc04oyjojlRQVyxTFFAWnkR0=
X-Received: by 2002:a05:7300:d40e:b0:386:bc40:1508 with SMTP id 5a478bee46e88-386cfc4cb54mr4950902eec.14.1795699215149;
        Thu, 26 Nov 2026 05:20:15 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385f68bc0adsm59029622eec.13.2026.11.26.05.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 05:20:14 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCHv3 2/4] powerpc/watchdog: Disable preemption in arch_touch_nmi_watchdog()
In-Reply-To: <76a1d48f-7425-4cd9-a88b-dbb453c6f95c@kernel.org>
Date: Thu, 26 Nov 2026 18:06:40 +0530
Message-ID: <jylzkbvr.ritesh.list@gmail.com>
References: <cover.1795441238.git.ritesh.list@gmail.com> <8a70fa42449a63a73b8340d3296974cc519b5826.1795441238.git.ritesh.list@gmail.com> <awZ2qXSxXPO3XUUb@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com> <o6bdjkq1.ritesh.list@gmail.com> <76a1d48f-7425-4cd9-a88b-dbb453c6f95c@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> writes:

> Le 25/11/2026 à 10:58, Ritesh Harjani a écrit :
>> Mukesh Kumar Chaurasiya <mkchauras@gmail.com> writes:
>> 
>>> On Mon, Nov 23, 2026 at 07:21:51PM +0530, Ritesh Harjani (IBM) wrote:
>>>> touch_nmi_watchdog() can be called from preemptible context, e.g.
>>>> sysrq-w via /proc/sysrq-trigger. The powerpc implementation uses
>>>> smp_processor_id(), so with DEBUG_PREEMPT we get:
>>>>
>>>>    root@buildroot:/# echo w > /proc/sysrq-trigger
>>>>    sysrq: Show Blocked State
>>>>    BUG: using smp_processor_id() in preemptible [00000000] code: bash/238
>>>>    caller is arch_touch_nmi_watchdog+0x3c/0xd4
>>>>    CPU: 0 UID: 0 PID: 238 Comm: bash Not tainted 7.4.0-rc2-00029-g7664547149ae-dirty #126 PREEMPT
>>>>    Call Trace:
>>>>     dump_stack_lvl+0x138/0x150 (unreliable)
>>>>     check_preemption_disabled+0x120/0x158
>>>>     arch_touch_nmi_watchdog+0x3c/0xd4
>>>>     show_state_filter+0xf0/0x338
>>>>     sysrq_handle_showstate_blocked+0x24/0x38
>>>>     __handle_sysrq+0x134/0x3a8
>>>>     write_sysrq_trigger+0x178/0x22c
>>>>     proc_reg_write+0xf4/0x150
>>>>     vfs_write+0xfc/0x71c
>>>>     ksys_write+0x8c/0x150
>>>>     system_call_exception+0x310/0x590
>>>>     system_call_vectored_common+0x15c/0x2ec
>>>>    ---- interrupt: 3000 at 0x7ffd01755b98
>>>>
>>>> Unlike the generic version, which only sets a flag, we update the CPU's
>>>> timebase stamp and its SMP watchdog pending bit, so a migration in
>>>> between touches the state of a CPU we are no longer on.
>>>>
>>>> Disable preemption across the update. While at it, let's also mark the
>>>> function as notrace (since we might be within a tracer when this
>>>> function gets called).
>>> Do we need to also mark wd_smp_clear_cpu_pending as notrace?
>>>
>> 
>> aah yes, I didn't see that there is another function which is not
>> inlined. Thanks for spotting that. The reason I added "notrace" was
>> mainly to have consistency with kernel/watchdog.c which is due to this
>> commit:
>> 
>> cb9d7fd51d9f ("watchdog: Mark watchdog touch functions as notrace")
>> 
>> 
>> However, after looking more closely now, I don't think we need notrace
>> here at all. To simply put, on powerpc, we don't use stop_machine() from
>> within arch_ftrace_update_code() like how arch/arm does and besides, I
>> think it is even safe for one cpu to be executing the instruction on
>> powerpc, while another cpu modifying that atomically.
>
> But haven't we identified in another discussion that it might be needed 
> to use stop_machine() ? See 
> https://lore.kernel.org/all/qzh06fxn.ritesh.list@gmail.com/
>

Yes, that is why I also quoted second reason too on why we don't need it
on powerpc. But here is the detailed explaination of what I understood -
while looking at the history of changes on why "notrace" was added to
some arch (like arm or to the generic definition) in the first place.

On ARM, ftrace call sites were patched under stop_machine() and the code
used to rely on other CPUs not executing any call site meanwhile. (Note
that this itself is not needed on PowerPC see commit ee456bb346e7).
However, with a THUMB-2 instruction set on ARM, a 4byte instruction is
only 2 byte aligned, so while patching the instruction it can result
into a 2 x 16bit stores. Now after commit ce4f06dcbb5d ("stop_machine:
Touch_nmi_watchdog() after MULTI_STOP_PREPARE"), stopped cpus started
calling the watchdog touch functions (which were not marked notrace yet)
from multi_cpu_stop(), so a stopped cpu could therefore execute the
ftrace call site of those functions between the two stores. This
resulted into kernel crashes as seen on ARM while enabling/disabling
ftrace on ARM kernels built with THUMB-2 instruction set.
Therefore commit cb9d7fd51d9f ("watchdog: Mark watchdog touch functions
as notrace") was needed on ARM to fix these crashes.

So I still think we don't need a "notrace" on arch_touch_nmi_watchdog()
on powerpc, even if tomorrow, we extend the use of stop_machine() for
patching usecase, as we discussed on that other thread.

Btw, we already use stop_machine() on powerpc for several usecases today like...

# git grep "stop_machine" arch/powerpc/
arch/powerpc/lib/feature-fixups.c:#include <linux/stop_machine.h>
arch/powerpc/lib/feature-fixups.c:       * then stop_machine runs which will ensure all CPUs are out of the
arch/powerpc/lib/feature-fixups.c:      stop_machine(__do_stf_barrier_fixups, &types, NULL);
arch/powerpc/lib/feature-fixups.c:       * Note we are protected by stop_machine() from other CPUs executing the code in a
arch/powerpc/lib/feature-fixups.c:      stop_machine(__do_entry_flush_fixups, &types, NULL);
arch/powerpc/lib/feature-fixups.c:       * stop_machine gets all CPUs out of the interrupt exit handler same
arch/powerpc/lib/feature-fixups.c:       * without stop_machine, so this could be achieved with a broadcast
arch/powerpc/lib/feature-fixups.c:      stop_machine(__do_rfi_flush_fixups, &types, NULL);
arch/powerpc/mm/book3s64/hash_pgtable.c:#include <linux/stop_machine.h>
arch/powerpc/mm/book3s64/hash_pgtable.c:                stop_machine_cpuslocked(change_memory_range_fn, &chmem_parms,
arch/powerpc/mm/numa.c:#include <linux/stop_machine.h>
arch/powerpc/platforms/powernv/subcore.c:#include <linux/stop_machine.h>
arch/powerpc/platforms/powernv/subcore.c:       stop_machine_cpuslocked(cpu_update_split_mode, &new_mode,
arch/powerpc/platforms/pseries/lpar.c:#include <linux/stop_machine.h>
arch/powerpc/platforms/pseries/lpar.c:  rc = stop_machine_cpuslocked(pseries_lpar_resize_hpt_commit,
arch/powerpc/platforms/pseries/mobility.c:#include <linux/stop_machine.h>
arch/powerpc/platforms/pseries/mobility.c:              ret = stop_machine(do_join, &info, cpu_online_mask);

> Christophe
>

Thanks for the review! 

-ritesh


>> 
>> For e.g. see this -
>> 
>> commit ee456bb346e75a9b6d941224b108250e6ee5f79f
>> Author: Steven Rostedt <srostedt@redhat.com>
>> Date:   Thu Apr 26 08:31:17 2012 +0000
>> 
>>      powerpc/ftrace: Have PPC skip updating with stop_machine()
>>      
>>      PowerPC does not have the synchronization issues that x86 has with
>>      modifying code on one CPU while another CPU is executing it.
>>      The other CPU will either see the old or new code without any
>>      issues, unlike x86 which may issue a GPF.
>>      
>>      Instead of calling the heavy stop_machine, just update the code.
>>   
>> 
>> And as I see it, this problem only exists on ARM with THUMB2
>> instruction, as can be seen from their implementation of
>> arch_ftrace_update_code(), which uses stop_machine().
>> 
>> 
>> So, let me drop the "notrace" as it is not really needed here and
>> re-spin a v4 with it being dropped.
>> 
>> -ritesh
>> 
>>>> Fixes: 2104180a5369 ("powerpc/64s: implement arch-specific hardlockup watchdog")
>>>> Cc: stable@vger.kernel.org
>>>> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>>>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>>> ---
>>>>   arch/powerpc/kernel/watchdog.c | 8 ++++++--
>>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
>>>> index 44f178e07531..32d4e716cb0a 100644
>>>> --- a/arch/powerpc/kernel/watchdog.c
>>>> +++ b/arch/powerpc/kernel/watchdog.c
>>>> @@ -456,12 +456,16 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>>>>   	return HRTIMER_RESTART;
>>>>   }
>>>>   
>>>> -void arch_touch_nmi_watchdog(void)
>>>> +notrace void arch_touch_nmi_watchdog(void)
>>>>   {
>>>>   	unsigned long ticks = tb_ticks_per_usec * wd_timer_period_ms * 1000;
>>>> -	int cpu = smp_processor_id();
>>>> +	int cpu;
>>>>   	u64 tb;
>>>>   
>>>> +	/* Callers may be preemptible. Stay on this CPU for the update. */
>>>> +	guard(preempt_notrace)();
>>>> +	cpu = raw_smp_processor_id();
>>>> +
>>>>   	if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
>>>>   		return;
>>>>   
>>>> -- 
>>>> 2.39.5
>>>>

