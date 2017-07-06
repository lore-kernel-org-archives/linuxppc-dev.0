Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x3LNV68V5zDr3x
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jul 2017 00:54:02 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id z6so593119pfk.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Jul 2017 07:54:02 -0700 (PDT)
Date: Fri, 7 Jul 2017 00:53:40 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/5] powernv:idle: Move device-tree parsing to one place.
Message-ID: <20170707005340.003c530b@roar.ozlabs.ibm.com>
In-Reply-To: <1499272696-28751-2-git-send-email-ego@linux.vnet.ibm.com>
References: <1499272696-28751-1-git-send-email-ego@linux.vnet.ibm.com>
 <1499272696-28751-2-git-send-email-ego@linux.vnet.ibm.com>
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

On Wed,  5 Jul 2017 22:08:12 +0530
"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> The details of the platform idle state are exposed by the firmware to
> the kernel via device tree.
> 
> In the current code, we parse the device tree twice :
> 
> 1) During the boot up in arch/powerpc/platforms/powernv/idle.c Here,
> the device tree is parsed to obtain the details of the
> supported_cpuidle_states which is used to determine the default idle
> state (which would be used when cpuidle is absent) and the deepest
> idle state (which would be used for cpu-hotplug).
> 
> 2) During the powernv cpuidle driver initializion
> (drivers/cpuidle/cpuidle-powernv.c). Here we parse the device tree to
> populate the cpuidle driver's states.
> 
> This patch moves all the device tree parsing to the platform idle
> code. It defines data-structures for recording the details of the
> parsed idle states. Any other kernel subsystem that is interested in
> the idle states (eg: cpuidle-powernv driver) can just use the
> in-kernel data structure instead of parsing the device tree all over
> again.
> 
> Further, this helps to check the validity of states in one place and
> in case of invalid states (eg : stop states whose psscr values are
> errorenous) flag them as invalid, so that the other subsystems can be
> prevented from using those.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Hi,

I think the overall direction is good. A few small things.


> +
> +#define PNV_IDLE_NAME_LEN     16
> +struct pnv_idle_state {
> +	char name[PNV_IDLE_NAME_LEN];
> +	u32 flags;
> +	u32 latency_ns;
> +	u32 residency_ns;
> +	u64 ctrl_reg_val;   /* The ctrl_reg on POWER8 would be pmicr. */
> +	u64 ctrl_reg_mask;  /* On POWER9 it is psscr */
> +	bool valid;
> +};

Do we use PMICR anywhere in the idle code? What about allowing for some
machine-specific fields?

    union {
        struct { /* p9 */
            u64 psscr_val;
            u64 psscr_mask;
        };
        struct { /* p8 */
            u64 pmicr...;


> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 2abee07..b747bb5 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -58,6 +58,17 @@
>  static u64 pnv_deepest_stop_psscr_mask;
>  static bool deepest_stop_found;
>  
> +/*
> + * Data structure that stores details of
> + * all the platform idle states.
> + */
> +struct pnv_idle_states pnv_idle;
> +
> +struct pnv_idle_states *get_pnv_idle_states(void)
> +{
> +	return &pnv_idle;
> +}

I wouldn't have the wrapper function... but it's your code so it's
up to you. One thing though is that this function you have called get_
just to return the pointer, but it does not take a reference or
allocate memory or initialize the structure. Other functions with the
same prefix do such things. Can we make something more consistent?

...

> +/**
> + * get_idle_prop_u32_array: Returns an array of u32 elements
> + *			    parsed from the device tree corresponding
> + *			    to the property provided in variable propname.
> + *
> + * @np: Pointer to device tree node "/ibm,opal/power-mgt"
> + * @nr_states: Expected number of elements.
> + * @propname : Name of the property whose values is an array of
> + *             u32 elements
> + *
> + * Returns a pointer to a u32 array of size nr_states on success.
> + * Returns NULL on failure.
> + */
> +static inline u32 *get_idle_prop_u32_array(struct device_node *np,
> +					   int nr_states,
> +					   const char *propname)
> +{
> +	u32 *ret_array;
> +	int rc, count;
> +
> +	count = of_property_count_u32_elems(np, propname);
> +	rc = validate_dt_prop_sizes("ibm,cpu-idle-state-flags", nr_states,
> +				    propname, count);
> +	if (rc)
> +		return NULL;
> +
> +	ret_array = kcalloc(nr_states, sizeof(*ret_array), GFP_KERNEL);
> +	if (!ret_array)
> +		return NULL;

So I would say for this, how about moving the allocations into the caller?
You're still doing most of the error handling freeing there, so I would
say it's more balanced if you do that.

Also, perhaps consider dropping most of the inline keywords. Unless it's
performance critical or does some significant optimisation due to constant
parameters I would say avoid the keyword as a rule.

[snip]

There's a lot of code movement, I haven't reviewed it all carefully, but
it looks good in general. I'll apply the patches and check the result
in the next few days when I get a bit of time.

Thanks,
Nick
