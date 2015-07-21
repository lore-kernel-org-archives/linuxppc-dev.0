Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B88E61A0877
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 14:46:49 +1000 (AEST)
In-Reply-To: <55887728.4030709@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [3/6] pseries: Update CPU hotplug error recovery
Message-Id: <20150721044649.A4DD8140DF7@ozlabs.org>
Date: Tue, 21 Jul 2015 14:46:49 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-22-06 at 20:59:20 UTC, Nathan Fontenot wrote:
> Update the cpu dlpar add/remove paths to do better error recovery when 
> a failure occurs during the add/remove operation. This includes adding
> some pr_info and pr_debug statements.

So I'm happy with the idea there, but ..

> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index f58d902..7890b2f 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -18,6 +18,8 @@
>   *      2 of the License, or (at your option) any later version.
>   */
>  
> +#define pr_fmt(fmt)     "pseries-hotplug-cpu: " fmt

This is good.

>  #include <linux/kernel.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> @@ -386,22 +388,35 @@ static ssize_t dlpar_cpu_add(struct device_node *parent, u32 drc_index)
>  	struct device_node *dn;
>  	int rc;
>  
> +	pr_info("Attempting to add CPU, drc index %x\n", drc_index);
> +
>  	rc = dlpar_acquire_drc(drc_index);
>  	if (rc)
>  		return -EINVAL;
>  
>  	dn = dlpar_configure_connector(cpu_to_be32(drc_index), parent);
> -	if (!dn)
> +	if (!dn) {
> +		pr_debug("Failed call to configure-connector\n");
> +		dlpar_release_drc(drc_index);
>  		return -EINVAL;
> +	}
>  
>  	rc = dlpar_attach_node(dn);
>  	if (rc) {
> +		pr_debug("Failed to attach node (%d)\n", rc);
>  		dlpar_release_drc(drc_index);
>  		dlpar_free_cc_nodes(dn);
>  		return rc;
>  	}
>  
>  	rc = dlpar_online_cpu(dn);
> +	if (rc) {
> +		pr_debug("Failed to online cpu (%d)\n", rc);
> +		dlpar_detach_node(dn);
> +		dlpar_release_drc(drc_index);
> +	}
> +
> +	pr_info("Successfully added CPU, drc index %x\n", drc_index);
>  	return rc;


But this is the opposite of what we want.

By default this will print two info lines for each successful cpu hotplug, but
when we get an error nothing will be printed - because pr_debug() is off by
default. What's worse, if dlpar_online_cpu() fails, the pr_debug() will produce
nothing but we will *still* print "Successfully added CPU".

So the pr_info()s should go entirely and the pr_debugs() should become
pr_warns(). The warning messages should become more verbose so they stand on
their own, ie. include the drc_index.

When everything goes perfectly there should be no output.


> @@ -465,18 +480,29 @@ static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
>  {
>  	int rc;
>  
> +	pr_info("Attemping to remove CPU, drc index %x\n", drc_index);
> +
>  	rc = dlpar_offline_cpu(dn);
> -	if (rc)
> +	if (rc) {
> +		pr_debug("Failed top offline cpu (%d)\n", rc);
                                   ^
				   should be to

>  		return -EINVAL;
> +	}
>  
>  	rc = dlpar_release_drc(drc_index);
> -	if (rc)
> +	if (rc) {
> +		pr_debug("Failed to release drc (%d)\n", rc);
> +		dlpar_online_cpu(dn);
>  		return rc;
> +	}
>  
>  	rc = dlpar_detach_node(dn);
> -	if (rc)
> +	if (rc) {
> +		pr_debug("Failed to detach cpu node (%d)\n", rc);
>  		dlpar_acquire_drc(drc_index);

But that can fail?

> +		dlpar_online_cpu(dn);

And if it did this would presumably not be safe?


cheers
