Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 59DE0DE0B5
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 04:20:44 +1100 (EST)
Date: Thu, 28 Feb 2008 11:20:34 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [PATCH 3/3] ppc64-specific memory notifier support
Message-ID: <20080228172034.GL16241@localdomain>
References: <1204217028.28696.10.camel@dyn9047017100.beaverton.ibm.com>
	<1204217166.28696.15.camel@dyn9047017100.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1204217166.28696.15.camel@dyn9047017100.beaverton.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Badari Pulavarty wrote:

> +static struct notifier_block pseries_smp_nb = {

Rename this to pseries_mem_nb?

> +	.notifier_call = pseries_memory_notifier,
> +};
> +
> +static int __init pseries_memory_hotplug_init(void)
> +{
> +	if (firmware_has_feature(FW_FEATURE_LPAR))
> +		pSeries_reconfig_notifier_register(&pseries_smp_nb);
> +
> +	return 0;
> +}
> +arch_initcall(pseries_memory_hotplug_init);

arch_initcall doesn't seem appropriate.  __initcall should be fine.
