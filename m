Return-Path: <rjw@rjwysocki.net>
Received: from cloudserver094114.home.net.pl (cloudserver094114.home.net.pl
 [79.96.170.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHjqm5JL4zDvhf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 08:11:14 +1100 (AEDT)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com
Subject: Re: [PATCH -next] powernv: cpufreq: Fix uninitialized lpstate_idx in
 gpstates_timer_handler
Date: Mon, 14 Nov 2016 22:18:46 +0100
Message-ID: <3500978.xDPxi6xF2C@vostro.rjw.lan>
In-Reply-To: <1479124767-20165-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1479124767-20165-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, November 14, 2016 05:29:27 PM Akshay Adiga wrote:
> lpstate_idx remains uninitialized in the case when elapsed_time
> is greater than MAX_RAMP_DOWN_TIME. At the end of rampdown
> global pstate should be equal to local pstate.
> 
> Fixes: 20b15b766354 ("cpufreq: powernv: Use PMCR to verify global and
> localpstate")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index c82304b..c5c5bc3 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -624,6 +624,7 @@ void gpstate_timer_handler(unsigned long data)
>  
>  	if (gpstates->elapsed_time > MAX_RAMP_DOWN_TIME) {
>  		gpstate_idx = pstate_to_idx(freq_data.pstate_id);
> +		lpstate_idx = gpstate_idx;
>  		reset_gpstates(policy);
>  		gpstates->highest_lpstate_idx = gpstate_idx;
>  	} else {
> 

Applied.

Thanks,
Rafael
