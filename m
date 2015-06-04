Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A1251A0889
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 21:40:29 +1000 (AEST)
In-Reply-To: <20150520233416.GA10270@us.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [1/1] powerpc/perf/hv-24x7: Check support before registering
Message-Id: <20150604114029.0D2AD140280@ozlabs.org>
Date: Thu,  4 Jun 2015 21:40:28 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-20-05 at 23:34:16 UTC, Sukadev Bhattiprolu wrote:
> >From 955102eacf035b19080dc659a15d9b8fbd8fae7f Mon Sep 17 00:00:00 2001
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date: Tue, 28 Apr 2015 18:47:58 -0400
> Subject: [PATCH 1/1] powerpc/perf/hv-24x7: Check support before registering
>  PMU
> 
> We currently try to register the 24x7 PMU unconditionally. Not all
> Power systems support 24x7 counters (eg: Power7). On these systems
> we get a backtrace during boot when trying to register the 24x7 PMU.
> 
> Check if the hypervisor supports 24x7 counters before attempting to
> register the 24x7 PMU.
> 
> Reported-by: Gustavo Luiz Duarte <gusld@br.ibm.com>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
> 
> Changelog[v2]
> 	- [Michael Ellerman] Simplify check with bogus parameters.
> ---
>  arch/powerpc/perf/hv-24x7.c |   21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
> index ec2eb20..c04a332 100644
> --- a/arch/powerpc/perf/hv-24x7.c
> +++ b/arch/powerpc/perf/hv-24x7.c
> @@ -1268,12 +1268,33 @@ static struct pmu h_24x7_pmu = {
>  	.read        = h_24x7_event_read,
>  };
>  
> +/*
> + * Return 1 if we can access the 24x7 counter catalog from the hypervisor.
> + * Return 0 otherwise.

Comment is wrong.

> + */
> +static bool hv_has_24x7(void)
> +{
> +	unsigned long hret;

ret would be fine.

> +
> +	hret = h_get_24x7_catalog_page(0, 0, 0);
> +
> +	if (hret != H_FUNCTION)
> +		pr_err("Error %ld reading catalog, disabling 24x7 PMU\n", hret);
> +
> +	return hret == 0;

I don't get what you're doing here.

You check for something other than H_FUNCTION, and print, and then you just
compare against 0. But I wouldn't ever expect that to return 0, because you
passed it bogus args.

The logic should be:

static bool is_24x7_supported(void)
{
	if (h_get_24x7_catalog_page(0, 0, 0) == H_FUNCTION)
		return false;

	return true;
}

>  static int hv_24x7_init(void)
>  {
>  	int r;
>  	unsigned long hret;
>  	struct hv_perf_caps caps;
>  
> +	if (!hv_has_24x7())
> +		return -ENODEV;
> +

This is no good. You're doing the check, which involves a hcall, before you
even check if you're running with a hypervisor (below).

>  	if (!firmware_has_feature(FW_FEATURE_LPAR)) {
>  		pr_debug("not a virtualized system, not enabling\n");
>  		return -ENODEV;

cheers
