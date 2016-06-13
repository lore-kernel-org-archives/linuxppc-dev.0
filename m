Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-wm0-x229.google.com (mail-wm0-x229.google.com
 [IPv6:2a00:1450:400c:c09::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rSxfh21RJzDqWf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 01:34:52 +1000 (AEST)
Received: by mail-wm0-x229.google.com with SMTP id r190so16363854wmr.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jun 2016 08:34:52 -0700 (PDT)
Date: Mon, 13 Jun 2016 17:34:46 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, benh@au1.ibm.com, paulus@ozlabs.org,
 mikey@neuling.org, ego@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Rob Herring <robh+dt@kernel.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v6 10/11] cpuidle/powernv: Add support for POWER ISA v3
 idle states
Message-ID: <20160613153446.GF10634@linaro.org>
References: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1465404871-5406-11-git-send-email-shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465404871-5406-11-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 08, 2016 at 11:54:30AM -0500, Shreyas B. Prabhu wrote:
> POWER ISA v3 defines a new idle processor core mechanism. In summary,
>  a) new instruction named stop is added.
>  b) new per thread SPR named PSSCR is added which controls the behavior
> 	of stop instruction.
> 
> Supported idle states and value to be written to PSSCR register to enter
> any idle state is exposed via ibm,cpu-idle-state-names and
> ibm,cpu-idle-state-psscr respectively. To enter an idle state,
> platform provided power_stop() needs to be invoked with the appropriate
> PSSCR value.
> 
> This patch adds support for this new mechanism in cpuidle powernv driver.
> 
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> Cc: linux-pm@vger.kernel.org
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> ---

[ ... ]

> +	rc = of_property_read_string_array(power_mgt,
> +					   "ibm,cpu-idle-state-names", names,
> +					   dt_idle_states);
> +	if (rc < 0) {
> +		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-names in DT\n");
> +		goto out_free_latency;
> +	}
> +
> +	/*
> +	 * If the idle states use stop instruction, probe for psscr values
> +	 * which are necessary to specify required stop level.
> +	 */
> +	if (flags[0] & (OPAL_PM_STOP_INST_FAST | OPAL_PM_STOP_INST_DEEP)) {
> +		psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val),
> +				    GFP_KERNEL);

if (!psscr_val) check missing.

> +		rc = of_property_read_u64_array(power_mgt,
> +						"ibm,cpu-idle-state-psscr",
> +						psscr_val, dt_idle_states);
> +		if (rc) {
> +			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-states-psscr in DT\n");
> +			goto out_free_psscr;
> +		}
> +	}
>  	residency_ns = kzalloc(sizeof(*residency_ns) * dt_idle_states, GFP_KERNEL);

if (!residency_ns) check missing.

I suppose the code is relying on 'of_property_read_u32_array' to check it, 
right ?


  -- Daniel
