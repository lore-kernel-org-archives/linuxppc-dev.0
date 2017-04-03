Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxpqW0TvDzDqHG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 09:54:31 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id 79so33079836pgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Apr 2017 16:54:30 -0700 (PDT)
Date: Tue, 4 Apr 2017 09:54:17 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Anton Blanchard <anton@ozlabs.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, rjw@rjwysocki.net,
 daniel.lezcano@linaro.org, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] cpuidle: powernv: Avoid a branch in the core
 snooze_loop() loop
Message-ID: <20170404095417.39e62ab3@roar.ozlabs.ibm.com>
In-Reply-To: <20170403215414.16951-3-anton@ozlabs.org>
References: <20170403215414.16951-1-anton@ozlabs.org>
 <20170403215414.16951-3-anton@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue,  4 Apr 2017 07:54:14 +1000
Anton Blanchard <anton@ozlabs.org> wrote:

> From: Anton Blanchard <anton@samba.org>
> 
> When in the snooze_loop() we want to take up the least amount of
> resources. On my version of gcc (6.3), we end up with an extra
> branch because it predicts snooze_timeout_en to be false, whereas it
> is almost always true.
> 
> Use likely() to avoid the branch and be a little nicer to the
> other non idle threads on the core.

Patches 2 and 3 look fine. Should they be replicated to cpuidle-pseries.c
as well?

Thanks,
Nick

> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  drivers/cpuidle/cpuidle-powernv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 8c991c254b95..251a60bfa8ee 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -58,7 +58,7 @@ static int snooze_loop(struct cpuidle_device *dev,
>  	ppc64_runlatch_off();
>  	HMT_very_low();
>  	while (!need_resched()) {
> -		if (snooze_timeout_en && get_tb() > snooze_exit_time)
> +		if (likely(snooze_timeout_en) && get_tb() > snooze_exit_time)
>  			break;
>  	}
>  
