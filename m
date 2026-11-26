Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15FC606A329
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2026 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKqat4bN
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZspT38y1z2xl0;
	Thu, 26 Nov 2026 21:14:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795688049;
	cv=none; b=h6orc0/eHft0QC5e8cjSl0HNV5uPwgwSxnbWU4OWnaZBAYfryytslZooZu+pOb0CgUp6zQU9xpG8g13X0HGRTx8C4M9AKq7XaGoquJrjagApWReV3mqVXJH4BIVm3NPBn+xgvDTNmTEnqmykHxv9DAQp5IUNg9UTZCWcp/RFySWRopsk+V1ChunfLsJx2qow5ta2d790sOYv9R333GvjdvDlemPSdi8/bNAWXA22T1zrY2dVBfrZERS9IqB4mmEwmo/VsLzBqM0V9KTlAPApRmrLBJioZnsGzgf1pI7i1O2X9Y1diEKwN6g49voZ0WkVwFGySalv6V9L/V5cAgJGBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795688049; c=relaxed/relaxed;
	bh=vDriNQ3B2hWeCHBvaX/FNBaF3g0HVn2vF0XkVS24jM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLYT/eiLUAs5em3uugLGk2UhuRUhRNFK714OS8m6T5bkpmxDq/KjqJBo7zz3Q97Ejb/laSOgSz/Pivt5bZCdSEPT43pH/GnhTsiWLfNCdEK0FZp/N9/gYXd6QR/T4ALOkk0Om4NXEdlovS4mr13qnZbQ3eRZIvjXVzl6bW7DMIOsFxiQabKMSmEDliy9+wxAmvHZsu4GEiXy8eHH9MOS+8ku0TMaPjjnuPj4bCC5nYt17Jdp7DKRcZ/4kQqnRw5VQrsouAjLZyCQQYD93w7g8A7p2bdBu11cwL0BUuLcffOW8OcCh0H/2dFt3jm5fccoQvL43tbFm6Lw1ZMkC2SBOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKqat4bN; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKqat4bN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZspS2N9zz2xGw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 21:14:08 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 46C866234B;
	Thu, 26 Nov 2026 10:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352F81F000D1;
	Thu, 26 Nov 2026 10:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795688044;
	bh=vDriNQ3B2hWeCHBvaX/FNBaF3g0HVn2vF0XkVS24jM4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eKqat4bNRTpejCSTRfpkiRlcCOEMRlT8NwZ/pHg6vfu7reJpQHvm1gzUdOLQVH5JN
	 9lFDX8h7Y0IUCW+1ga/TXRpiYly1T9dkiyMoRkx7F3/+moGRuIq1v4lbndzzmBwLoR
	 rWfvP3LYofaD5BsCxZY50BtzGpm9yo9cMQdsuzEChF47ku4oR0fiYUGJpCPR2NzVpD
	 K8tsWciYBubc9AkpRMdQhV/lc0sg3o06lGa/syTxeADyiYztdeTbrhk4W9QVsKmvBl
	 NQOMjnuRtQ+S/dR5bh09pN/Cq42eG5W2KoGys8uv2hfTzV5iHXYQvRmR9069SN6/JZ
	 YAKP4LLfgjWoQ==
Message-ID: <76a1d48f-7425-4cd9-a88b-dbb453c6f95c@kernel.org>
Date: Thu, 26 Nov 2026 11:13:59 +0100
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 2/4] powerpc/watchdog: Disable preemption in
 arch_touch_nmi_watchdog()
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, stable@vger.kernel.org
References: <cover.1795441238.git.ritesh.list@gmail.com>
 <8a70fa42449a63a73b8340d3296974cc519b5826.1795441238.git.ritesh.list@gmail.com>
 <awZ2qXSxXPO3XUUb@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <o6bdjkq1.ritesh.list@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <o6bdjkq1.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 25/11/2026 à 10:58, Ritesh Harjani a écrit :
> Mukesh Kumar Chaurasiya <mkchauras@gmail.com> writes:
> 
>> On Mon, Nov 23, 2026 at 07:21:51PM +0530, Ritesh Harjani (IBM) wrote:
>>> touch_nmi_watchdog() can be called from preemptible context, e.g.
>>> sysrq-w via /proc/sysrq-trigger. The powerpc implementation uses
>>> smp_processor_id(), so with DEBUG_PREEMPT we get:
>>>
>>>    root@buildroot:/# echo w > /proc/sysrq-trigger
>>>    sysrq: Show Blocked State
>>>    BUG: using smp_processor_id() in preemptible [00000000] code: bash/238
>>>    caller is arch_touch_nmi_watchdog+0x3c/0xd4
>>>    CPU: 0 UID: 0 PID: 238 Comm: bash Not tainted 7.4.0-rc2-00029-g7664547149ae-dirty #126 PREEMPT
>>>    Call Trace:
>>>     dump_stack_lvl+0x138/0x150 (unreliable)
>>>     check_preemption_disabled+0x120/0x158
>>>     arch_touch_nmi_watchdog+0x3c/0xd4
>>>     show_state_filter+0xf0/0x338
>>>     sysrq_handle_showstate_blocked+0x24/0x38
>>>     __handle_sysrq+0x134/0x3a8
>>>     write_sysrq_trigger+0x178/0x22c
>>>     proc_reg_write+0xf4/0x150
>>>     vfs_write+0xfc/0x71c
>>>     ksys_write+0x8c/0x150
>>>     system_call_exception+0x310/0x590
>>>     system_call_vectored_common+0x15c/0x2ec
>>>    ---- interrupt: 3000 at 0x7ffd01755b98
>>>
>>> Unlike the generic version, which only sets a flag, we update the CPU's
>>> timebase stamp and its SMP watchdog pending bit, so a migration in
>>> between touches the state of a CPU we are no longer on.
>>>
>>> Disable preemption across the update. While at it, let's also mark the
>>> function as notrace (since we might be within a tracer when this
>>> function gets called).
>> Do we need to also mark wd_smp_clear_cpu_pending as notrace?
>>
> 
> aah yes, I didn't see that there is another function which is not
> inlined. Thanks for spotting that. The reason I added "notrace" was
> mainly to have consistency with kernel/watchdog.c which is due to this
> commit:
> 
> cb9d7fd51d9f ("watchdog: Mark watchdog touch functions as notrace")
> 
> 
> However, after looking more closely now, I don't think we need notrace
> here at all. To simply put, on powerpc, we don't use stop_machine() from
> within arch_ftrace_update_code() like how arch/arm does and besides, I
> think it is even safe for one cpu to be executing the instruction on
> powerpc, while another cpu modifying that atomically.

But haven't we identified in another discussion that it might be needed 
to use stop_machine() ? See 
https://lore.kernel.org/all/qzh06fxn.ritesh.list@gmail.com/

Christophe

> 
> For e.g. see this -
> 
> commit ee456bb346e75a9b6d941224b108250e6ee5f79f
> Author: Steven Rostedt <srostedt@redhat.com>
> Date:   Thu Apr 26 08:31:17 2012 +0000
> 
>      powerpc/ftrace: Have PPC skip updating with stop_machine()
>      
>      PowerPC does not have the synchronization issues that x86 has with
>      modifying code on one CPU while another CPU is executing it.
>      The other CPU will either see the old or new code without any
>      issues, unlike x86 which may issue a GPF.
>      
>      Instead of calling the heavy stop_machine, just update the code.
>   
> 
> And as I see it, this problem only exists on ARM with THUMB2
> instruction, as can be seen from their implementation of
> arch_ftrace_update_code(), which uses stop_machine().
> 
> 
> So, let me drop the "notrace" as it is not really needed here and
> re-spin a v4 with it being dropped.
> 
> -ritesh
> 
>>> Fixes: 2104180a5369 ("powerpc/64s: implement arch-specific hardlockup watchdog")
>>> Cc: stable@vger.kernel.org
>>> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
>>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>> ---
>>>   arch/powerpc/kernel/watchdog.c | 8 ++++++--
>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
>>> index 44f178e07531..32d4e716cb0a 100644
>>> --- a/arch/powerpc/kernel/watchdog.c
>>> +++ b/arch/powerpc/kernel/watchdog.c
>>> @@ -456,12 +456,16 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
>>>   	return HRTIMER_RESTART;
>>>   }
>>>   
>>> -void arch_touch_nmi_watchdog(void)
>>> +notrace void arch_touch_nmi_watchdog(void)
>>>   {
>>>   	unsigned long ticks = tb_ticks_per_usec * wd_timer_period_ms * 1000;
>>> -	int cpu = smp_processor_id();
>>> +	int cpu;
>>>   	u64 tb;
>>>   
>>> +	/* Callers may be preemptible. Stay on this CPU for the update. */
>>> +	guard(preempt_notrace)();
>>> +	cpu = raw_smp_processor_id();
>>> +
>>>   	if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
>>>   		return;
>>>   
>>> -- 
>>> 2.39.5
>>>


