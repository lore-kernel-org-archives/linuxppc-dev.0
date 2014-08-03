Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 531251A01A9
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Aug 2014 23:01:18 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Sun, 3 Aug 2014 09:01:15 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 8D64938C804D
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Aug 2014 09:01:11 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s73D1BmY7536986
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Aug 2014 13:01:11 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s73D1Ag5020408
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Aug 2014 09:01:11 -0400
Message-ID: <53DE3293.2050604@linux.vnet.ibm.com>
Date: Sun, 03 Aug 2014 18:31:07 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc/cpuidle: Fix parsing of idle state flags from
 device-tree
References: <20140803075119.10152.52685.stgit@drishya>
In-Reply-To: <20140803075119.10152.52685.stgit@drishya>
Content-Type: text/plain; charset=UTF-8
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/03/2014 01:23 PM, Vaidyanathan Srinivasan wrote:
> Flags from device-tree need to be parsed with accessors for
> interpreting correct value in little-endian.
> 
> Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> ---
>  drivers/cpuidle/cpuidle-powernv.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 74f5788..a64be57 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -160,10 +160,10 @@ static int powernv_cpuidle_driver_init(void)
>  static int powernv_add_idle_states(void)
>  {
>  	struct device_node *power_mgt;
> -	struct property *prop;
>  	int nr_idle_states = 1; /* Snooze */
>  	int dt_idle_states;
> -	u32 *flags;
> +	const __be32 *idle_state_flags;
> +	u32 len_flags, flags;
>  	int i;
>  
>  	/* Currently we have snooze statically defined */
> @@ -174,18 +174,18 @@ static int powernv_add_idle_states(void)
>  		return nr_idle_states;
>  	}
>  
> -	prop = of_find_property(power_mgt, "ibm,cpu-idle-state-flags", NULL);
> -	if (!prop) {
> +	idle_state_flags = of_get_property(power_mgt, "ibm,cpu-idle-state-flags", &len_flags);
> +	if (!idle_state_flags) {
>  		pr_warn("DT-PowerMgmt: missing ibm,cpu-idle-state-flags\n");
>  		return nr_idle_states;
>  	}
>  
> -	dt_idle_states = prop->length / sizeof(u32);
> -	flags = (u32 *) prop->value;
> +	dt_idle_states = len_flags / sizeof(u32);
>  
>  	for (i = 0; i < dt_idle_states; i++) {
>  
> -		if (flags[i] & IDLE_USE_INST_NAP) {
> +		flags = be32_to_cpu(idle_state_flags[i]);
> +		if (flags & IDLE_USE_INST_NAP) {
>  			/* Add NAP state */
>  			strcpy(powernv_states[nr_idle_states].name, "Nap");
>  			strcpy(powernv_states[nr_idle_states].desc, "Nap");
> @@ -196,7 +196,7 @@ static int powernv_add_idle_states(void)
>  			nr_idle_states++;
>  		}
>  
> -		if (flags[i] & IDLE_USE_INST_SLEEP) {
> +		if (flags & IDLE_USE_INST_SLEEP) {
>  			/* Add FASTSLEEP state */
>  			strcpy(powernv_states[nr_idle_states].name, "FastSleep");
>  			strcpy(powernv_states[nr_idle_states].desc, "FastSleep");

Reviewed-by: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
