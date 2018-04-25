Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40WGK82fy1zDrDT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 20:14:51 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id h69so14797217pfe.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 03:14:51 -0700 (PDT)
Date: Wed, 25 Apr 2018 15:44:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, npiggin@gmail.com, linux-pm@vger.kernel.org,
 ppaidipe@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, svaidy@linux.vnet.ibm.com,
 stable@vger.kernel.org
Subject: Re: [PATCH V2] cpufreq: powernv: Fix the hardlockup by synchronus
 smp_call in timer interrupt
Message-ID: <20180425101447.eynrhpyait2emzoa@vireshk-i7>
References: <1524646968-526-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <20180425091701.kxxslgalw3sdpiym@vireshk-i7>
 <a827bf62-efd6-fb8b-86d7-e6b37bcf4a9a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a827bf62-efd6-fb8b-86d7-e6b37bcf4a9a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 25-04-18, 15:32, Shilpasri G Bhat wrote:
> Hi,
> 
> On 04/25/2018 02:47 PM, Viresh Kumar wrote:
> > On 25-04-18, 14:32, Shilpasri G Bhat wrote:
> >> gpstate_timer_handler() uses synchronous smp_call to set the pstate
> >> on the requested core. This causes the below hard lockup:
> >>
> >> [c000003fe566b320] [c0000000001d5340] smp_call_function_single+0x110/0x180 (unreliable)
> >> [c000003fe566b390] [c0000000001d55e0] smp_call_function_any+0x180/0x250
> >> [c000003fe566b3f0] [c000000000acd3e8] gpstate_timer_handler+0x1e8/0x580
> >> [c000003fe566b4a0] [c0000000001b46b0] call_timer_fn+0x50/0x1c0
> >> [c000003fe566b520] [c0000000001b4958] expire_timers+0x138/0x1f0
> >> [c000003fe566b590] [c0000000001b4bf8] run_timer_softirq+0x1e8/0x270
> >> [c000003fe566b630] [c000000000d0d6c8] __do_softirq+0x158/0x3e4
> >> [c000003fe566b710] [c000000000114be8] irq_exit+0xe8/0x120
> >> [c000003fe566b730] [c000000000024d0c] timer_interrupt+0x9c/0xe0
> >> [c000003fe566b760] [c000000000009014] decrementer_common+0x114/0x120
> >> -- interrupt: 901 at doorbell_global_ipi+0x34/0x50
> >> LR = arch_send_call_function_ipi_mask+0x120/0x130
> >> [c000003fe566ba50] [c00000000004876c]
> >> arch_send_call_function_ipi_mask+0x4c/0x130
> >> [c000003fe566ba90] [c0000000001d59f0] smp_call_function_many+0x340/0x450
> >> [c000003fe566bb00] [c000000000075f18] pmdp_invalidate+0x98/0xe0
> >> [c000003fe566bb30] [c0000000003a1120] change_huge_pmd+0xe0/0x270
> >> [c000003fe566bba0] [c000000000349278] change_protection_range+0xb88/0xe40
> >> [c000003fe566bcf0] [c0000000003496c0] mprotect_fixup+0x140/0x340
> >> [c000003fe566bdb0] [c000000000349a74] SyS_mprotect+0x1b4/0x350
> >> [c000003fe566be30] [c00000000000b184] system_call+0x58/0x6c
> >>
> >> One way to avoid this is removing the smp-call. We can ensure that the timer
> >> always runs on one of the policy-cpus. If the timer gets migrated to a
> >> cpu outside the policy then re-queue it back on the policy->cpus. This way
> >> we can get rid of the smp-call which was being used to set the pstate
> >> on the policy->cpus.
> >>
> >> Fixes: 7bc54b652f13 (timers, cpufreq/powernv: Initialize the gpstate timer as pinned)
> >> Cc: <stable@vger.kernel.org>        [4.8+]
> >> Reported-by: Nicholas Piggin <npiggin@gmail.com>
> >> Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
> >> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> >> ---
> >> Changes from V1:
> >> - Remove smp_call in the pstate handler.
> >>
> >>  drivers/cpufreq/powernv-cpufreq.c | 23 ++++++++++++++++++++---
> >>  1 file changed, 20 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> >> index 71f8682..dc8ffb5 100644
> >> --- a/drivers/cpufreq/powernv-cpufreq.c
> >> +++ b/drivers/cpufreq/powernv-cpufreq.c
> >> @@ -679,6 +679,25 @@ void gpstate_timer_handler(struct timer_list *t)
> >>  
> >>  	if (!spin_trylock(&gpstates->gpstate_lock))
> >>  		return;
> >> +	/*
> >> +	 * If the timer has migrated to the different cpu then bring
> >> +	 * it back to one of the policy->cpus
> >> +	 */
> >> +	if (!cpumask_test_cpu(raw_smp_processor_id(), policy->cpus)) {
> >> +		/*
> >> +		 * Timer should be deleted if policy is inactive.
> >> +		 * If policy is active then re-queue on one of the
> >> +		 * policy->cpus.
> >> +		 */
> > 
> > This looks racy. Shouldn't you guarantee that the timer is already
> > removed in a synchronous way before de-activating the policy ?
> > 
> 
> The timer is deleted in driver->stop_cpu(). So we ensure to remove the timer
> before de-activating the policy.
> 
> 
> >> +		if (!cpumask_empty(policy->cpus)) {
> 
> So are you suggesting to remove ^^ the check for active policy here?
> (I put that as a safety check.)

Either you are sure or you are not, and you don't need a safety check
if you are sure :)

-- 
viresh
