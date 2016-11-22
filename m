Return-Path: <rjwysocki@gmail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNgXF5qb9zDvx4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 09:45:01 +1100 (AEDT)
Received: by mail-wm0-x244.google.com with SMTP id u144so7241643wmu.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 14:45:01 -0800 (PST)
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <1479820025-15855-1-git-send-email-kda@linux-powerpc.org>
References: <1479820025-15855-1-git-send-email-kda@linux-powerpc.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 22 Nov 2016 23:44:58 +0100
Message-ID: <CAJZ5v0jPhGHsUPHsfMyzxktC_1YMhxdXEmCZO6+_kt6YaJ9fxg@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq, powernv: Disable preemption while checking
 CPU throttling state throttling state
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Linux PM <linux-pm@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 akshay.adiga@linux.vnet.ibm.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 22, 2016 at 2:07 PM, Denis Kirjanov <kda@linux-powerpc.org> wrote:
> With preemption turned on we can read incorrect throttling state while being switched
> to CPU on a different chip.
> The following BUG_() was hit while running the 4.8-rc5 kernel compiled
> with CONFIG_PREEMPT_DEBUG on a POWER machine.
>
>
>     [   67.700897] BUG: using smp_processor_id() in preemptible [00000000] code: cat/7343
>     [   67.700988] caller is .powernv_cpufreq_throttle_check+0x2c/0x710
>     [   67.700998] CPU: 13 PID: 7343 Comm: cat Not tainted 4.8.0-rc5-dirty #1
>     [   67.701038] Call Trace:
>     [   67.701066] [c0000007d25b75b0] [c000000000971378] .dump_stack+0xe4/0x150 (unreliable)
>     [   67.701153] [c0000007d25b7640] [c0000000005162e4] .check_preemption_disabled+0x134/0x150
>     [   67.701238] [c0000007d25b76e0] [c0000000007b63ac] .powernv_cpufreq_throttle_check+0x2c/0x710
>     [   67.701322] [c0000007d25b7790] [c0000000007b6d18] .powernv_cpufreq_target_index+0x288/0x360
>     [   67.701407] [c0000007d25b7870] [c0000000007acee4] .__cpufreq_driver_target+0x394/0x8c0
>     [   67.701491] [c0000007d25b7920] [c0000000007b22ac] .cpufreq_set+0x7c/0xd0
>     [   67.701565] [c0000007d25b79b0] [c0000000007adf50] .store_scaling_setspeed+0x80/0xc0
>     [   67.701650] [c0000007d25b7a40] [c0000000007ae270] .store+0xa0/0x100
>     [   67.701723] [c0000007d25b7ae0] [c0000000003566e8] .sysfs_kf_write+0x88/0xb0
>     [   67.701796] [c0000007d25b7b70] [c0000000003553b8] .kernfs_fop_write+0x178/0x260
>     [   67.701881] [c0000007d25b7c10] [c0000000002ac3cc] .__vfs_write+0x3c/0x1c0
>     [   67.701954] [c0000007d25b7cf0] [c0000000002ad584] .vfs_write+0xc4/0x230
>     [   67.702027] [c0000007d25b7d90] [c0000000002aeef8] .SyS_write+0x58/0x100
>     [   67.702101] [c0000007d25b7e30] [c00000000000bfec] system_call+0x38/0xfc
>
> The task which updates the cpu-frequency checks if the chip was
> throttled. However, it does so without protecting itself against
> preemption. Hence, if the task is preempted and woken up on a CPU on
> another chip, it can end up updating the throttle statistics of the
> incorrect chip.
>
> This patch fixes the issue by ensuring that the throttle_check is
> performed with preemption disabled.
>
> Fixes: 09a972d16209 ("cpufreq: powernv: Report cpu frequency throttling")
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>

That's already queued up for v4.10, you don't have to resend it.

Thanks,
Rafael
