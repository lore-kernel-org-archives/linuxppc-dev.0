Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0205.outbound.protection.outlook.com [207.46.163.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E03EE1400BE
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Apr 2014 10:00:50 +1100 (EST)
Message-ID: <1396652430.32034.122.camel@snotra.buserror.net>
Subject: Re: [PATCH] cpuidle: add freescale e500 family porcessors idle support
From: Scott Wood <scottwood@freescale.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Date: Fri, 4 Apr 2014 18:00:30 -0500
In-Reply-To: <1396341234-40515-1-git-send-email-dongsheng.wang@freescale.com>
References: <1396341234-40515-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: chenhui.zhao@freescale.com, linux-pm@vger.kernel.org,
 daniel.lezcano@linaro.org, rjw@sisk.pl, jason.jin@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-04-01 at 16:33 +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> Add cpuidle support for e500 family, using cpuidle framework to
> manage various low power modes. The new implementation will remain
> compatible with original idle method.
> 
> I have done test about power consumption and latency. Cpuidle framework
> will make CPU response time faster than original method, but power
> consumption is higher than original method.
> 
> Power consumption:
> The original method, power consumption is 10.51202 (W).
> The cpuidle framework, power consumption is 10.5311 (W).
> 
> Latency:
> The original method, avg latency is 6782 (us).
> The cpuidle framework, avg latency is 6482 (us).
> 
> Initially, this supports PW10, PW20 and subsequent patches will support
> DOZE/NAP and PH10, PH20.

Have you tried tuning the timebase bit for the original method, to match
what you're doing in cpuidle and/or for general optimization?

Do you get similar results for a variety of workloads?

> +static struct cpuidle_state pw_idle_states[] = {
> +	{
> +		.name = "pw10",
> +		.desc = "pw10",
> +		.flags = CPUIDLE_FLAG_TIME_VALID,
> +		.exit_latency = 0,
> +		.target_residency = 0,
> +		.enter = &pw10_enter
> +	},
> +
> +	{
> +		.name = "pw20",
> +		.desc = "pw20-core-idle",
> +		.flags = CPUIDLE_FLAG_TIME_VALID,
> +		.exit_latency = 1,
> +		.target_residency = 50,
> +		.enter = &pw20_enter
> +	},
> +};

Where did exit_latency and target_residency come from?  It looks rather
different from the ~1ms delay before entering PW20 with the original
method.

Though, I'd have expected a shorter PW20 delay to have longer wake
latency, due to entering the lower power state more often...

> +static void replace_orig_idle(void *dummy)
> +{
> +	return;
> +}

Why?  If you're using this as some sort of barrier to ensure that all
CPUs have done something before continuing, explain that, along with why
it matters.

-Scott
