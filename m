Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 249721A057D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Apr 2015 02:46:01 +1000 (AEST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1YfWdQ-003moY-TN
 for linuxppc-dev@lists.ozlabs.org; Tue, 07 Apr 2015 16:45:57 +0000
Date: Tue, 7 Apr 2015 09:44:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>
Subject: Re: [PATCH 4/4] hwmon: (ibmpowernv) pretty print labels
Message-ID: <20150407164439.GA4514@roeck-us.net>
References: <5523ECC4.9010609@fr.ibm.com>
 <1428417956-28617-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1428417956-28617-1-git-send-email-clg@fr.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org, Jean Delvare <jdelvare@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 07, 2015 at 04:45:56PM +0200, Cédric Le Goater wrote:
> The new OPAL device tree adds a few properties which can be used to add
> extra information on the sensor label.
> 
> In the case of a cpu core sensor, the firmware exposes the physical 
> identifier of the core in the "ibm,pir" property. The driver 
> translates this identifier in a linux cpu number and prints out a 
> range corresponding to the hardware threads of the core (as they
> share the same sensor).
> 
> The numbering gives a hint on the localization of the core in the 
> system (which socket, which chip). 
> 
> Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>

Hi Cedric,

Please do not send follow-up patches as reply, but as separate e-mail.

Further comments below.

> ---
> 
>  Changes since v1:
> 
>  - check cpu validity before printing out the attribute label. 
>    if invalid, use a "phy" prefix to distinguish a linux cpu 
>    number from a physical cpu number. 
> 
>  drivers/hwmon/ibmpowernv.c |   34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> Index: linux.git/drivers/hwmon/ibmpowernv.c
> ===================================================================
> --- linux.git.orig/drivers/hwmon/ibmpowernv.c
> +++ linux.git/drivers/hwmon/ibmpowernv.c
> @@ -113,9 +113,43 @@ static ssize_t show_label(struct device
>  static void __init make_sensor_label(struct device_node *np,
>  		    struct sensor_data *sdata, const char *label)
>  {
> +	u32 id;
>  	size_t n;
>  
>  	n = snprintf(sdata->label, sizeof(sdata->label), "%s", label);
> +
> +	/*
> +	 * Core temp pretty print
> +	 */
> +	if (!of_property_read_u32(np, "ibm,pir", &id)) {
> +		int i = -1;
> +
> +		for_each_possible_cpu(i)
> +			if (paca[i].hw_cpu_id == id)

I think you should consider using get_hard_smp_processor_id() and avoid
direct access to the paca array.

> +				break;
> +
> +		if (i != -1)

I don't think that works. i is initialized by for_each_possible_cpu(),
either to -1 or 0 depending on the state of CONFIG_SMP. So pre-initializing
it won't make a difference. Its last value is NR_CPUS (SMP) or 1 (non-SMP).

You would need a second variable (which you could pre-initialize)
to determine if the code found a matching ID or not.

> +			/*
> +			 * The digital thermal sensors are associated
> +			 * with a core. Let's print out the range of
> +			 * cpu ids corresponding to the hardware
> +			 * threads of the core.
> +			 */
> +			n += snprintf(sdata->label + n,
> +				      sizeof(sdata->label) - n,
> +				      " %d-%d", i, i+7);

I would really like to see how this looks like in practice.

The id in the devicetree entry is the physical CPU. The resulting index
is the logical CPU number. So let's assume that the logical CPU number
for the first physical CPU is 0. Output would be "0-7". If the second
physical CPU matches logical CPU 1, output would be "1-8". 
How does that make any sense ?

Also, how do you know that the range of CPU IDs is always 8 ?

Can you provide some resulting outputs ?

Thanks,
Guenter
