Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqpX81xsWzDqZc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 03:19:20 +1000 (AEST)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 20 Apr 2016 13:19:17 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 29D1938C804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 13:18:56 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3KHIump33554508
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 17:18:56 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3KHIsJD013006
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 13:18:55 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, rjw@rjwysocki.net,
 viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: ego@linux.vnet.ibm.com, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] cpufreq: powernv: Ramp-down global pstate slower
 than local-pstate
In-Reply-To: <1460701739-31549-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1460701739-31549-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <1460701739-31549-3-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Date: Wed, 20 Apr 2016 10:18:51 -0700
Message-ID: <8737qgmc5g.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Akshay Adiga <akshay.adiga@linux.vnet.ibm.com> writes:
> Iozone results show fairly consistent performance boost.
> YCSB on redis shows improved Max latencies in most cases.

What about power consumption?

> Iozone write/rewite test were made with filesizes 200704Kb and 401408Kb
> with different record sizes . The following table shows IOoperations/sec
> with and without patch.

> Iozone Results ( in op/sec) ( mean over 3 iterations )

What's the variance between runs?

> Tested with YCSB workload (50% update + 50% read) over redis for 1 million
> records and 1 million operation. Each test was carried out with target
> operations per second and persistence disabled.
>
> Max-latency (in us)( mean over 5 iterations )

What's the variance between runs?

std dev? 95th percentile?

> ---------------------------------------------------------------
> op/s    Operation       with patch      without patch   %change
> ---------------------------------------------------------------
> 15000   Read            61480.6         50261.4         22.32

This seems fairly significant regression. Any idea why at 15K op/s
there's such a regression?

> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
[ 15 more citation lines. Click/Enter to show. ]
> @@ -36,12 +36,56 @@
>  #include <asm/reg.h>
>  #include <asm/smp.h> /* Required for cpu_sibling_mask() in UP configs */
>  #include <asm/opal.h>
> +#include <linux/timer.h>
>  
>  #define POWERNV_MAX_PSTATES	256
>  #define PMSR_PSAFE_ENABLE	(1UL << 30)
>  #define PMSR_SPR_EM_DISABLE	(1UL << 31)
>  #define PMSR_MAX(x)		((x >> 32) & 0xFF)
>  
> +#define MAX_RAMP_DOWN_TIME				5120
> +/*
> + * On an idle system we want the global pstate to ramp-down from max value
> to
> + * min over a span of ~5 secs. Also we want it to initially ramp-down
> slowly and
> + * then ramp-down rapidly later on.

Where does 5 seconds come from?

Why 5 and not 10, or not 2? Is there some time period inherit in
hardware or software that this is computed from?

> +/* Interval after which the timer is queued to bring down global pstate */
> +#define GPSTATE_TIMER_INTERVAL				2000

in ms?

-- 
Stewart Smith
OPAL Architect, IBM.
