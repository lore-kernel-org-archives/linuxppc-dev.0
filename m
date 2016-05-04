Return-Path: <rjw@rjwysocki.net>
Received: from cloudserver094114.home.net.pl (cloudserver094114.home.net.pl
 [79.96.170.134])
 by lists.ozlabs.org (Postfix) with SMTP id 3r0W4c0cfNzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 07:14:07 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 ego@linux.vnet.ibm.com
Subject: Re: [PATCH v3 0/2] cpufreq: powernv: Ramp-down global pstate slower
 than local-pstate
Date: Wed, 04 May 2016 23:17:14 +0200
Message-ID: <2253617.134ktIcBZI@vostro.rjw.lan>
In-Reply-To: <1461059881-14434-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1461059881-14434-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
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

On Tuesday, April 19, 2016 03:27:59 PM Akshay Adiga wrote:
> The frequency transition latency from pmin to pmax is observed to be in few
> millisecond granurality. And it usually happens to take a performance penalty
> during sudden frequency rampup requests.
> 
> This patch set solves this problem by using a chip-level entity called "global
> pstates". Global pstate manages elements across other dependent core chiplets.
> Typically, the element that needs to be managed is the voltage setting.
> So by holding global pstates higher than local pstate for some amount of time
> ( ~5 seconds) the subsequent rampups could be made faster.
> 
> (1/2) patch removes the flag from cpufreq_policy->driver_data, so that it can
> be used for tracking global pstates.
> 
> (2/2) patch adds code for global pstate management.
> - The iozone results with this patchset, shows improvements in almost all cases.
> - YCSB workload on redis with various  target operations per second shows 
> better MaxLatency with this patch.
> 
> Changes from v1:
> - Fixed coding style
> - Added a routine to reset global_pstate_info instead of hacky memset
> - Handled case where cpufreq_table_validate_and_show() fails
> - changed int queue_gpstate_timer() to void queue_gpstate_timer()
> 
> Changes from v2:
> - dropped the unreated change. 
> 
> Akshay Adiga (1):
>   cpufreq: powernv: Ramp-down global pstate slower than local-pstate
> 
> Shilpasri G Bhat (1):
>   cpufreq: powernv: Remove flag use-case of policy->driver_data
> 
>  drivers/cpufreq/powernv-cpufreq.c | 269 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 256 insertions(+), 13 deletions(-)

Both [1-2/2] applied, thanks!
