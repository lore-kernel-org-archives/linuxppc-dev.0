Return-Path: <viresh.kumar@linaro.org>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHxj007CJzF0Ry
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 20:07:31 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id f14so4173469pga.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 01:07:31 -0800 (PST)
Date: Fri, 12 Jan 2018 14:37:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, mpe@ellerman.id.au, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 ego@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com,
 akshay.adiga@linux.vnet.ibm.com, huntbag@linux.vnet.ibm.com
Subject: Re: [PATCH] cpufreq: powernv: Dont assume distinct pstate values for
 nominal and pmin
Message-ID: <20180112090727.GN3626@vireshk-i7>
References: <1515741233-1442-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1515741233-1442-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12-01-18, 12:43, Shilpasri G Bhat wrote:
> Some OpenPOWER boxes can have same pstate values for nominal and
> pmin pstates. In these boxes the current code will not initialize
> 'powernv_pstate_info.min' variable and result in erroneous CPU
> frequency reporting. This patch fixes this problem.
> 
> Fixes: 09ca4c9b5958 ("cpufreq: powernv: Replacing pstate_id with frequency table index")
> Reported-by: Alvin Wang <wangat@tw.ibm.com>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index b6d7c4c..da7fdb4 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -288,9 +288,9 @@ static int init_powernv_pstates(void)
>  
>  		if (id == pstate_max)
>  			powernv_pstate_info.max = i;
> -		else if (id == pstate_nominal)
> +		if (id == pstate_nominal)
>  			powernv_pstate_info.nominal = i;
> -		else if (id == pstate_min)
> +		if (id == pstate_min)
>  			powernv_pstate_info.min = i;
>  
>  		if (powernv_pstate_info.wof_enabled && id == pstate_turbo) {

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
