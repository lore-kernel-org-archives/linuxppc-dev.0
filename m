Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A69B1A01D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 16:02:48 +1100 (AEDT)
Message-ID: <1448514168.9839.6.camel@ellerman.id.au>
Subject: Re: [PATCH v2 4/6] powerpc/pseries: Add CPU dlpar remove functionality
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 26 Nov 2015 16:02:48 +1100
In-Reply-To: <562FC1E8.9040902@linux.vnet.ibm.com>
References: <562FC0C3.7000303@linux.vnet.ibm.com>
 <562FC1E8.9040902@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-10-27 at 13:26 -0500, Nathan Fontenot wrote:

> Add the ability to dlpar remove CPUs via hotplug rtas events, either by
> specifying the drc-index of the CPU to remove or providing a count of cpus
> to remove.
> 
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> index f080e81..635f0ba 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
> @@ -570,6 +571,143 @@ static ssize_t dlpar_cpu_remove(struct device_node *dn, u32 drc_index)
>  	return 0;
>  }
>  
> +static struct device_node *cpu_drc_index_to_dn(u32 drc_index)
> +{
> +	struct device_node *dn;
> +	u32 my_index;
> +	int rc;
> +
> +	for_each_node_by_type(dn, "cpu") {
> +		rc = of_property_read_u32(dn, "ibm,my-drc-index", &my_index);
> +		if (rc)
> +			continue;
> +
> +		if (my_index == drc_index)
> +			break;
> +	}
> +
> +	return dn;
> +}
> +
> +static int dlpar_cpu_remove_by_index(u32 drc_index)
> +{
> +	struct device_node *dn;
> +	int rc;
> +
> +	dn = cpu_drc_index_to_dn(drc_index);
> +	if (!dn)
> +		return -ENODEV;
> +
> +	rc = dlpar_cpu_remove(dn, drc_index);
> +	of_node_put(dn);

Does dlpar_cpu_remove() work when you still hold a reference to the dn?

It looks like dlpar_detach_node() does an of_node_put() also.

> +	return rc;
> +}
> +
> +static u32 *dlpar_cpus_to_remove(int cpus_to_remove)
> +{
> +	struct device_node *dn;
> +	u32 *cpu_drcs;
> +	int cpus_found = 0;
> +	int i, rc;
> +
> +	cpu_drcs = kcalloc(cpus_to_remove, sizeof(*cpu_drcs), GFP_KERNEL);
> +	if (!cpu_drcs)
> +		return NULL;
> +
> +	i = 0;
> +	for_each_node_by_type(dn, "cpu") {
> +		cpus_found++;
> +
> +		if (cpus_found > cpus_to_remove) {
> +			of_node_put(dn);
> +			break;
> +		}
> +
> +		rc = of_property_read_u32(dn, "ibm,my-drc-index",
> +					  &cpu_drcs[i++]);
> +		if (rc) {
> +			of_node_put(dn);
> +			break;

I'm not sure about the logic here with cpus_found and i. If you break here
cpus_found will be 1, but you found zero, which seems odd.

If instead you delayed the increment of i:

		rc = of_property_read_u32(dn, "ibm,my-drc-index",
					  &cpu_drcs[i]);
		if (rc) {
			of_node_put(dn);
			break;
		}

		i++;
	}

Then i would equal the number of cpus found at all times. If you need to count
one more in the if below you can just do that there.

> +
> +	/* We want to find cpus_to_remove + 1 CPUs to ensure we do not
> +	 * remove the last CPU.
> +	 */
> +	if (cpus_found <= cpus_to_remove) {
> +		pr_warn("Failed to find enough CPUs (%d of %d) to remove\n",
> +			cpus_found, cpus_to_remove);
> +		kfree(cpu_drcs);
> +		cpu_drcs = NULL;
> +	}

On my two cpu system when I do "cpu remove count 1" this always says:

  pseries-hotplug-cpu: Failed to find enough CPUs (1 of 1) to remove

Which confuses me.

I suspect that's because I actually have one cpu *node*, which appears to Linux
as two cpus (due to SMT). So I think it's working as expected, but it's not
very clear from a user's perspective.

cheers
