Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s5Jc46WxbzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 17:39:48 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u757d7CK126399
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Aug 2016 03:39:46 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24kkam9rex-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Aug 2016 03:39:46 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 5 Aug 2016 17:39:42 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 040722BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Aug 2016 17:39:39 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u757dcT531588524
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Aug 2016 17:39:38 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u757dciU023398
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Aug 2016 17:39:38 +1000
Subject: Re: [PATCH] cpufreq: powernv: Fix crash in gpstate_timer_handler
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, rjw@rjwysocki.net,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <1470324557-20711-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 5 Aug 2016 17:39:36 +1000
MIME-Version: 1.0
In-Reply-To: <1470324557-20711-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <658e389e-7c72-ec11-6c24-055377030e9d@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/08/16 01:29, Akshay Adiga wrote:
> 'commit 09ca4c9b5958 ("cpufreq: powernv: Replacing pstate_id with
> frequency table index")' changes calc_global_pstate() to use
> cpufreq_table index instead of pstate_id.
>
> But in gpstate_timer_handler() pstate_id was being passed instead
> of cpufreq_table index, which caused the index_to_pstate() to access
> out of bound indices, leading to this crash.
>
> Adding sanity check for index and pstate, to ensure only valid pstate
> and index values are returned.
>
> Call Trace:
> [c00000078d66b130] [c00000000011d224] __free_irq+0x234/0x360
> (unreliable)
> [c00000078d66b1c0] [c00000000011d44c] free_irq+0x6c/0xa0
> [c00000078d66b1f0] [c00000000006c4f8] opal_event_shutdown+0x88/0xd0
> [c00000078d66b230] [c000000000067a4c] opal_shutdown+0x1c/0x90
> [c00000078d66b260] [c000000000063a00] pnv_shutdown+0x20/0x40
> [c00000078d66b280] [c000000000021538] machine_restart+0x38/0x90
> [c0000000078d66b310] [c000000000965ea0] panic+0x284/0x300
> [c00000078d66b3a0] [c00000000001f508] die+0x388/0x450
> [c00000078d66b430] [c000000000045a50] bad_page_fault+0xd0/0x140
> [c00000078d66b4a0] [c000000000008964] handle_page_fault+0x2c/0x30
>    interrupt: 300 at gpstate_timer_handler+0x150/0x260
>     LR = gpstate_timer_handler+0x130/0x260
> [c00000078d66b7f0] [c000000000132b58] call_timer_fn+0x58/0x1c0
> [c00000078d66b880] [c000000000132e20] expire_timers+0x130/0x1d0
> [c00000078d66b8f0] [c000000000133068] run_timer_softirq+0x1a8/0x230
> [c00000078d66b980] [c0000000000b535c] __do_softirq+0x18c/0x400
> [c00000078d66ba70] [c0000000000b5828] irq_exit+0xc8/0x100
> [c00000078d66ba90] [c00000000001e214] timer_interrupt+0xa4/0xe0
> [c00000078d66bac0] [c0000000000027d0] decrementer_common+0x150/0x180
>    interrupt: 901 at arch_local_irq_restore+0x74/0x90
>   0] [c000000000106b34] call_cpuidle+0x44/0x90
> [c00000078d66be50] [c00000000010708c] cpu_startup_entry+0x38c/0x460
> [c00000078d66bf20] [c00000000003d930] start_secondary+0x330/0x380
> [c00000078d66bf90] [c000000000008e6c] start_secondary_prolog+0x10/0x14
>
> Fixes: 08d27eb ("cpufreq: powernv: Replacing pstate_id with
> frequency table index")
> Reported-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>

Tested-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
