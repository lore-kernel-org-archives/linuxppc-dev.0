Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 723121A0551
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 23:47:29 +1000 (AEST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 29 May 2015 07:47:26 -0600
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 5AB386E8045
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 09:39:10 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4TDlMu954329412
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 13:47:22 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4TDlMJl027908
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 09:47:22 -0400
Message-ID: <55686DE5.6010001@linux.vnet.ibm.com>
Date: Fri, 29 May 2015 19:17:17 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
CC: linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, anton@samba.org
Subject: Re: [PATCH] cpuidle: powernv/pseries: Decrease the snooze residency
References: <1432902728-31476-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
In-Reply-To: <1432902728-31476-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Shilpa,

The subject does not convey the purpose of this patch clearly IMO.
I would definitely suggest changing the subject to something like
"Auto promotion of snooze to deeper idle state" or similar.

On 05/29/2015 06:02 PM, Shilpasri G Bhat wrote:
> The idle cpus which stay in snooze for a long period can degrade the
> perfomance of the sibling cpus. If the cpu stays in snooze for more
> than target residency of the next available idle state, then exit from
> snooze. This gives a chance to the cpuidle governor to re-evaluate the
> last idle state of the cpu to promote it to deeper idle states.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  drivers/cpuidle/cpuidle-powernv.c | 12 ++++++++++++
>  drivers/cpuidle/cpuidle-pseries.c | 11 +++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
> index bb9e2b6..07135e0 100644
> --- a/drivers/cpuidle/cpuidle-pseries.c
> +++ b/drivers/cpuidle/cpuidle-pseries.c
> @@ -27,6 +27,8 @@ struct cpuidle_driver pseries_idle_driver = {
>  
>  static int max_idle_state;
>  static struct cpuidle_state *cpuidle_state_table;
> +static u64 snooze_timeout;
> +static bool snooze_timeout_en;
>  
>  static inline void idle_loop_prolog(unsigned long *in_purr)
>  {
> @@ -58,14 +60,18 @@ static int snooze_loop(struct cpuidle_device *dev,
>  			int index)
>  {
>  	unsigned long in_purr;
> +	u64 snooze_exit_time;
>  
>  	idle_loop_prolog(&in_purr);
>  	local_irq_enable();
>  	set_thread_flag(TIF_POLLING_NRFLAG);
> +	snooze_exit_time = get_tb() + snooze_timeout;
>  
>  	while (!need_resched()) {
>  		HMT_low();
>  		HMT_very_low();
> +		if (snooze_timeout_en && get_tb() > snooze_exit_time)
> +			break;
>  	}
>  
>  	HMT_medium();
> @@ -244,6 +250,11 @@ static int pseries_idle_probe(void)
>  	} else
>  		return -ENODEV;
>  
> +	if (max_idle_state > 1) {
> +		snooze_timeout_en = true;
> +		snooze_timeout = cpuidle_state_table[1].target_residency *
> +				 tb_ticks_per_usec;
> +	}

Any idea why we don't have snooze defined on the shared lpar configuration ?

Regards
Preeti U Murthy
>  	return 0;
>  }
>  
> 
