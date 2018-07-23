Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Z34k6r7NzDqmj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2018 23:59:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linux@roeck-us.net
Cc: linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com, stewart@linux.ibm.com,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 2/2] hwmon: ibmpowernv: Add attributes to
 enable/disable sensor groups
In-Reply-To: <1532067143-22022-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1532067143-22022-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1532067143-22022-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 23:59:00 +1000
Message-ID: <87fu0ahx3v.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index f829dad..99afbf7 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -292,12 +344,126 @@ static u32 get_sensor_hwmon_index(struct sensor_data *sdata,
>  	return ++sensor_groups[sdata->type].hwmon_index;
>  }
>  
> +static int init_sensor_group_data(struct platform_device *pdev,
> +				  struct platform_data *pdata)
> +{
> +	struct sensor_group_data *sgrp_data;
> +	struct device_node *groups, *sgrp;
> +	enum sensors type;
> +	int count = 0, ret = 0;
> +
> +	groups = of_find_compatible_node(NULL, NULL, "ibm,opal-sensor-group");
> +	if (!groups)
> +		return ret;
> +
> +	for_each_child_of_node(groups, sgrp) {
> +		type = get_sensor_type(sgrp);
> +		if (type != MAX_SENSOR_TYPE)
> +			pdata->nr_sensor_groups++;
> +	}
> +
> +	if (!pdata->nr_sensor_groups)
> +		goto out;
> +
> +	sgrp_data = devm_kcalloc(&pdev->dev, pdata->nr_sensor_groups,
> +				 sizeof(*sgrp_data), GFP_KERNEL);
> +	if (!sgrp_data) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	for_each_child_of_node(groups, sgrp) {
> +		const __be32 *phandles;
> +		int len, gid;
> +
> +		type = get_sensor_type(sgrp);
> +		if (type == MAX_SENSOR_TYPE)
> +			continue;
> +
> +		if (of_property_read_u32(sgrp, "sensor-group-id", &gid))
> +			continue;
> +
> +		phandles = of_get_property(sgrp, "sensors", &len);
> +		if (!phandles)
> +			continue;

You should be able to use the more modern OF APIs, eg:

		rc = of_count_phandle_with_args(sgrp, "sensors", NULL);

> +		len /= sizeof(u32);
> +		if (!len)
> +			continue;

Which would make that check unnecessary.

> +		sensor_groups[type].attr_count++;
> +		sgrp_data[count].gid = gid;
> +		mutex_init(&sgrp_data[count].mutex);
> +		sgrp_data[count++].enable = false;
> +	}
> +
> +	pdata->sgrp_data = sgrp_data;
> +out:
> +	of_node_put(groups);
> +	return ret;
> +}
> +
> +static struct sensor_group_data *get_sensor_group(struct platform_data *pdata,
> +						  struct device_node *node,
> +						  enum sensors gtype)
> +{
> +	struct sensor_group_data *sgrp_data = pdata->sgrp_data;
> +	struct device_node *groups, *sgrp;
> +
> +	groups = of_find_compatible_node(NULL, NULL, "ibm,opal-sensor-group");
> +	if (!groups)
> +		return NULL;
> +
> +	for_each_child_of_node(groups, sgrp) {
> +		const __be32 *phandles;
> +		int len, gid, i;
> +		enum sensors type;
> +
> +		type = get_sensor_type(sgrp);
> +		if (type != gtype)
> +			continue;
> +
> +		if (of_property_read_u32(sgrp, "sensor-group-id", &gid))
> +			continue;
> +
> +		phandles = of_get_property(sgrp, "sensors", &len);
> +		if (!phandles)
> +			continue;
> +
> +		len /= sizeof(u32);
> +		if (!len)
> +			continue;
> +
> +		while (--len >= 0)
> +			if (be32_to_cpu(phandles[len]) == node->phandle)
> +				break;

Likewise, here you could use of_for_each_phandle().


cheers
