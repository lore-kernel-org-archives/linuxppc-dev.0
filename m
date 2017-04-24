Return-Path: <srs0=pwla=4a=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBGZr0WK9zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 16:26:44 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wBGZq6ymxz8t5F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 16:26:43 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wBGZp563Kz9sD5
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2017 16:26:42 +1000 (AEST)
Message-ID: <1493015157.25766.211.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 04/11] VAS: Define vas_init() and vas_exit()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: michael.neuling@au1.ibm.com, stewart@linux.vnet.ibm.com,
 apopple@au1.ibm.com, hbabu@us.ibm.com, oohall@gmail.com,
 bsingharora@gmail.com, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Mon, 24 Apr 2017 16:25:57 +1000
In-Reply-To: <1490937224-29149-5-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1490937224-29149-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1490937224-29149-5-git-send-email-sukadev@linux.vnet.ibm.com>
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

On Thu, 2017-03-30 at 22:13 -0700, Sukadev Bhattiprolu wrote:
> 
> +	p = of_get_property(dn, "vas-id", NULL);
> +	if (!p) {
> +		pr_err("VAS: NULL vas-id? %p\n", p);
> +		return -ENODEV;
> +	}
> +
> +	vinst->vas_id = of_read_number(p, 1);

of_property_read_u32()

> +	/*
> +	 * Hardcoded 6 is tied to corresponding code in
> +	 *      skiboot.git/core/vas.c
> +	 */
> +	rc = of_property_read_variable_u64_array(dn, "reg", values,
> 6, 6);
> +	if (rc != 6) {
> +		pr_err("VAS %d: Unable to read reg properties, rc
> %d\n",
> +				vinst->vas_id, rc);
> +		return rc;
> +	}
> +
> +	vinst->hvwc_bar_start = values[0];
> +	vinst->hvwc_bar_len = values[1];
> +	vinst->uwc_bar_start = values[2];
> +	vinst->uwc_bar_len = values[3];
> +	vinst->win_base_addr = values[4];
> +	vinst->win_id_shift = values[5];

If you make the VAS a proper MMIO device on the powerbus (as explained
in my comment to your OPAL patch), and you create this as a platform
device based on the DT, the core will parse the reg property for you
and will populate the device struct resource array for you.

> +	return 0;
> +}
> +
> +/*
> + * Although this is read/used multiple times, it is written to only
> + * during initialization.
> + */
> +struct vas_instance *find_vas_instance(int vasid)
> +{
> +	int i;
> +	struct vas_instance *vinst;
> +
> +	for (i = 0; i < vas_num_instances; i++) {
> +		vinst = &vas_instances[i];
> +		if (vinst->vas_id == vasid)
> +			return vinst;
> +	}
> +	pr_err("VAS instance for vas-id %d not found\n", vasid);
> +	WARN_ON_ONCE(1);
> +	return NULL;
> +}

This is gross. What is it needed for  ?

> +
> +bool vas_initialized(void)
> +{
> +	return init_done;
> +}
> +
> +int vas_init(void)
> +{
> +	int rc;
> +	struct device_node *dn;
> +	struct vas_instance *vinst;
> +
> +	if (!pvr_version_is(PVR_POWER9))
> +		return -ENODEV;

No. Create a platform device that matches the corresponding device-tree
node. One per instance.

The resulting VAS "driver" thus becomes a loadable module which you can
put elsewhere in the tree, matching on the DT node "compatible"
property.

You can then have the copros be chilren of it. The VAS driver can then
create additional platform devices for its children, who can have their
own module (which *can* depend on symbols exportd by the VAS one)
etc...

> +	vas_num_instances = 0;
> +	for_each_node_by_name(dn, "vas")
> +		vas_num_instances++;
> +
> +	if (!vas_num_instances)
> +		return -ENODEV;
> +
> +	vas_instances = kcalloc(vas_num_instances, sizeof(*vinst),
> GFP_KERNEL);
> +	if (!vas_instances)
> +		return -ENOMEM;
> +
> +	vinst = &vas_instances[0];
> +	for_each_node_by_name(dn, "vas") {
> +		rc = init_vas_instance(dn, vinst);
> +		if (rc) {
> +			pr_err("Error %d initializing VAS instance
> %ld\n", rc,
> +					(vinst-&vas_instances[0]));
> +			goto cleanup;
> +		}
> +		vinst++;
> +	}
> +
> +	rc = -ENODEV;
> +	if (vinst == &vas_instances[0]) {
> +		/* Should not happen as we saw some above. */
> +		pr_err("VAS: Did not find any VAS DT nodes now!\n");
> +		goto cleanup;
> +	}
> +
> +	pr_devel("VAS: Initialized %d instances\n",
> vas_num_instances);
> +	init_done = true;
> +
> +	return 0;
> +
> +cleanup:
> +	kfree(vas_instances);
> +	return rc;
> +}
> +
> +void vas_exit(void)
> +{
> +	init_done = false;
> +	kfree(vas_instances);
> +}
> +
> +module_init(vas_init);
> +module_exit(vas_exit);
> +MODULE_DESCRIPTION("IBM Virtual Accelerator Switchboard");
> +MODULE_AUTHOR("Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/arch/powerpc/platforms/powernv/vas.h
> b/arch/powerpc/platforms/powernv/vas.h
> index c63395d..46aaa17 100644
> --- a/arch/powerpc/platforms/powernv/vas.h
> +++ b/arch/powerpc/platforms/powernv/vas.h
> @@ -384,4 +384,7 @@ struct vas_winctx {
>  	enum vas_notify_after_count notify_after_count;
>  };
>  
> +extern bool vas_initialized(void);
> +extern struct vas_instance *find_vas_instance(int vasid);
> +
>  #endif /* _VAS_H */
