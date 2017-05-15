Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pf0-x22a.google.com (mail-pf0-x22a.google.com
 [IPv6:2607:f8b0:400e:c00::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wR8By4PnRzDqLb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 15:24:08 +1000 (AEST)
Received: by mail-pf0-x22a.google.com with SMTP id n23so52070807pfb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 May 2017 22:24:08 -0700 (PDT)
Date: Mon, 15 May 2017 10:54:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Mark Rutland <mark.rutland@arm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch 09/18] cpufreq/pasemi: Adjust system_state check
Message-ID: <20170515052403.GX17481@vireshk-i7>
References: <20170514182716.347236777@linutronix.de>
 <20170514183613.160312642@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170514183613.160312642@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14-05-17, 20:27, Thomas Gleixner wrote:
> To enable smp_processor_id() and might_sleep() debug checks earlier, it's
> required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.
> 
> Adjust the system_state check in pas_cpufreq_cpu_exit() to handle the extra
> states.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  drivers/cpufreq/pasemi-cpufreq.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/cpufreq/pasemi-cpufreq.c
> +++ b/drivers/cpufreq/pasemi-cpufreq.c
> @@ -226,7 +226,7 @@ static int pas_cpufreq_cpu_exit(struct c
>  	 * We don't support CPU hotplug. Don't unmap after the system
>  	 * has already made it to a running state.
>  	 */
> -	if (system_state != SYSTEM_BOOTING)
> +	if (system_state >= SYSTEM_RUNNING)
>  		return 0;
>  
>  	if (sdcasr_mapbase)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
