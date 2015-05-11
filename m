Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4EC421A0010
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 20:26:16 +1000 (AEST)
In-Reply-To: <1430363091-27722-1-git-send-email-sukadev@linux.vnet.ibm.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [1/1] powerpc/hv-24x7: Check support before registering PMU
Message-Id: <20150511102616.2004E140187@ozlabs.org>
Date: Mon, 11 May 2015 20:26:15 +1000 (AEST)
Cc: gusld@br.ibm.com, dev@codyps.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-30-04 at 03:04:51 UTC, Sukadev Bhattiprolu wrote:
> We currently try to register the 24x7 PMU unconditionally. Not all
> Power systems support 24x7 counters (eg: Power7). On these systems
> we get a backtrace during boot when trying to register the 24x7 PMU.
> 
> Check if the hypervisor supports 24x7 counters before attempting to
> register the 24x7 PMU.

The concept is good, but ..

> diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
> index ec2eb20..19a59a3 100644
> --- a/arch/powerpc/perf/hv-24x7.c
> +++ b/arch/powerpc/perf/hv-24x7.c
> @@ -1268,12 +1268,44 @@ static struct pmu h_24x7_pmu = {
>  	.read        = h_24x7_event_read,
>  };
>  
> +/*
> + * Return 1 if we can access the 24x7 counter catalog from the hypervisor.
> + * Return 0 otherwise.
> + */
> +static int hv_has_24x7(void)

bool please

> +{
> +	int page_size = 4096;
> +	unsigned long hret;
> +	void *page;
> +	struct hv_24x7_catalog_page_0 *page_0;
> +
> +	page_0 = kmalloc(page_size*2, GFP_KERNEL);
> +	if (!page_0)
> +		return 0;
> +
> +	/* buffer for catalog needs to be 4K-aligned */
> +	page = (void *)((long)page_0 & (~page_size-1)) + page_size;
> +	hret = h_get_24x7_catalog_page(page, 0, 0);
> +	kfree(page_0);


It shouldn't need to be this complicated.

You should just be able to do the hcall with bogus args and if you get
H_FUNCTION then 24x7 is not supported.

cheers
