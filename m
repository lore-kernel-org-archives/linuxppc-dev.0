Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D3601A0C17
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 16:45:07 +1100 (AEDT)
In-Reply-To: <20150119113251.23984.16931.stgit@preeti.in.ibm.com>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>, rafael.j.wysocki@intel.com
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: cpuidle/powernv: Read target_residency value of idle states from
 DT if available
Message-Id: <20150120054506.F13591402E0@ozlabs.org>
Date: Tue, 20 Jan 2015 16:45:06 +1100 (AEDT)
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-19-01 at 11:32:51 UTC, Preeti U Murthy wrote:
> The device tree now exposes the residency values for different idle states. Read
> these values instead of calculating residency from the latency values. The values
> exposed in the DT are validated for optimal power efficiency. However to maintain
> compatibility with the older firmware code which does not expose residency
> values, use default values as a fallback mechanism. While at it, clump
> the common parts of device tree parsing into one chunk.
> 
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> ---
> 
>  drivers/cpuidle/cpuidle-powernv.c |   39 ++++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 2726663..9e732e1 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -162,7 +162,8 @@ static int powernv_add_idle_states(void)
>  	int dt_idle_states;
>  	const __be32 *idle_state_flags;
>  	const __be32 *idle_state_latency;
> -	u32 len_flags, flags, latency_ns;
> +	const __be32 *idle_state_residency;
> +	u32 len_flags, flags, latency_ns, residency_ns;
>  	int i;
>  
>  	/* Currently we have snooze statically defined */
> @@ -186,14 +187,21 @@ static int powernv_add_idle_states(void)
>  		return nr_idle_states;
>  	}
>  
> +	idle_state_residency = of_get_property(power_mgt,
> +			"ibm,cpu-idle-state-residency-ns", NULL);
> +	if (!idle_state_residency) {
> +		pr_warn("DT-PowerMgmt: missing ibm,cpu-idle-state-residency-ns\n");
> +		pr_warn("Falling back to default values\n");
> +	}

This would be better done with something like:

	rc = of_read_property_u32(power_mgt, "ibm,cpu-idle-state-residency-ns", &residency_ns);
	if (!rc) {
		pr_info("cpuidle-powernv: missing ibm,cpu-idle-state-residency-ns\n");
		residency_ns = 300000;
	}

cheers
