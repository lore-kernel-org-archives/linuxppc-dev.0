Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmcKn1txXzDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 01:30:36 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5CFTDiJ091372
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 11:30:34 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b1vhvbh8f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 11:30:33 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 12 Jun 2017 11:30:33 -0400
Date: Mon, 12 Jun 2017 21:00:27 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH 11/14] powerpc/64s: cpuidle read mostly for common globals
Reply-To: ego@linux.vnet.ibm.com
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-12-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170611235835.7400-12-npiggin@gmail.com>
Message-Id: <20170612153027.GH10921@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 12, 2017 at 09:58:32AM +1000, Nicholas Piggin wrote:
> Ensure these don't get put into bouncing cachelines.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

> ---
>  drivers/cpuidle/cpuidle-powernv.c | 10 +++++-----
>  drivers/cpuidle/cpuidle-pseries.c |  8 ++++----
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 50b3c2e0306f..9d03326ac05e 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -32,18 +32,18 @@ static struct cpuidle_driver powernv_idle_driver = {
>  	.owner            = THIS_MODULE,
>  };
> 
> -static int max_idle_state;
> -static struct cpuidle_state *cpuidle_state_table;
> +static int max_idle_state __read_mostly;
> +static struct cpuidle_state *cpuidle_state_table __read_mostly;
> 
>  struct stop_psscr_table {
>  	u64 val;
>  	u64 mask;
>  };
> 
> -static struct stop_psscr_table stop_psscr_table[CPUIDLE_STATE_MAX];
> +static struct stop_psscr_table stop_psscr_table[CPUIDLE_STATE_MAX] __read_mostly;
> 
> -static u64 snooze_timeout;
> -static bool snooze_timeout_en;
> +static u64 snooze_timeout __read_mostly;
> +static bool snooze_timeout_en __read_mostly;
> 
>  static int snooze_loop(struct cpuidle_device *dev,
>  			struct cpuidle_driver *drv,
> diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
> index 7b12bb2ea70f..a404f352d284 100644
> --- a/drivers/cpuidle/cpuidle-pseries.c
> +++ b/drivers/cpuidle/cpuidle-pseries.c
> @@ -25,10 +25,10 @@ struct cpuidle_driver pseries_idle_driver = {
>  	.owner            = THIS_MODULE,
>  };
> 
> -static int max_idle_state;
> -static struct cpuidle_state *cpuidle_state_table;
> -static u64 snooze_timeout;
> -static bool snooze_timeout_en;
> +static int max_idle_state __read_mostly;
> +static struct cpuidle_state *cpuidle_state_table __read_mostly;
> +static u64 snooze_timeout __read_mostly;
> +static bool snooze_timeout_en __read_mostly;
> 
>  static inline void idle_loop_prolog(unsigned long *in_purr)
>  {
> -- 
> 2.11.0
> 
