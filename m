Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8J7M41PgzDqhH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 14:28:47 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: powernv: Fix crash in gpstate_timer_handler
In-Reply-To: <20160804164711.GE10348@ubuntu>
References: <1470324557-20711-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <20160804164711.GE10348@ubuntu>
Date: Wed, 10 Aug 2016 14:28:47 +1000
Message-ID: <87oa51tfgg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Viresh Kumar <viresh.kumar@linaro.org> writes:

> On 04-08-16, 20:59, Akshay Adiga wrote:
>> 'commit 09ca4c9b5958 ("cpufreq: powernv: Replacing pstate_id with
>> frequency table index")' changes calc_global_pstate() to use
>> cpufreq_table index instead of pstate_id.
>> 
>> But in gpstate_timer_handler() pstate_id was being passed instead
>> of cpufreq_table index, which caused the index_to_pstate() to access
>> out of bound indices, leading to this crash.
>> 
>> Adding sanity check for index and pstate, to ensure only valid pstate
>> and index values are returned.
>> 
>> Call Trace:
>> [c00000078d66b130] [c00000000011d224] __free_irq+0x234/0x360
>> (unreliable)
>> [c00000078d66b1c0] [c00000000011d44c] free_irq+0x6c/0xa0
>> [c00000078d66b1f0] [c00000000006c4f8] opal_event_shutdown+0x88/0xd0
>> [c00000078d66b230] [c000000000067a4c] opal_shutdown+0x1c/0x90
>> [c00000078d66b260] [c000000000063a00] pnv_shutdown+0x20/0x40
>> [c00000078d66b280] [c000000000021538] machine_restart+0x38/0x90
>> [c0000000078d66b310] [c000000000965ea0] panic+0x284/0x300
>> [c00000078d66b3a0] [c00000000001f508] die+0x388/0x450
>> [c00000078d66b430] [c000000000045a50] bad_page_fault+0xd0/0x140
>> [c00000078d66b4a0] [c000000000008964] handle_page_fault+0x2c/0x30
>>    interrupt: 300 at gpstate_timer_handler+0x150/0x260
>>     LR = gpstate_timer_handler+0x130/0x260
>> [c00000078d66b7f0] [c000000000132b58] call_timer_fn+0x58/0x1c0
>> [c00000078d66b880] [c000000000132e20] expire_timers+0x130/0x1d0
>> [c00000078d66b8f0] [c000000000133068] run_timer_softirq+0x1a8/0x230
>> [c00000078d66b980] [c0000000000b535c] __do_softirq+0x18c/0x400
>> [c00000078d66ba70] [c0000000000b5828] irq_exit+0xc8/0x100
>> [c00000078d66ba90] [c00000000001e214] timer_interrupt+0xa4/0xe0
>> [c00000078d66bac0] [c0000000000027d0] decrementer_common+0x150/0x180
>>    interrupt: 901 at arch_local_irq_restore+0x74/0x90
>>   0] [c000000000106b34] call_cpuidle+0x44/0x90
>> [c00000078d66be50] [c00000000010708c] cpu_startup_entry+0x38c/0x460
>> [c00000078d66bf20] [c00000000003d930] start_secondary+0x330/0x380
>> [c00000078d66bf90] [c000000000008e6c] start_secondary_prolog+0x10/0x14
>> 
>> Fixes: 08d27eb ("cpufreq: powernv: Replacing pstate_id with
>> frequency table index")
>> Reported-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
>> ---
>>  drivers/cpufreq/powernv-cpufreq.c | 21 ++++++++++++++++++++-
>>  1 file changed, 20 insertions(+), 1 deletion(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Who's merging this?

cheers
