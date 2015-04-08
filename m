Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A56611A09FA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 01:21:49 +1000 (AEST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1YfrnW-001Exx-Lw
 for linuxppc-dev@lists.ozlabs.org; Wed, 08 Apr 2015 15:21:46 +0000
Date: Wed, 8 Apr 2015 08:20:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>
Subject: Re: [PATCH 2/4] hwmon: (ibmpowernv) add support for the new device
 tree
Message-ID: <20150408152029.GA11030@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

On Wed, Apr 01, 2015 at 12:15:04PM +0200, Cédric Le Goater wrote:
> The new OPAL device tree for sensors has a different layout and uses new
> property names, for the type and for the handler used to capture the
> sensor data.
> 
> This patch modifies the ibmpowernv driver to support such a tree in a
> way preserving compatibility with older OPAL firmwares.
> 
> This is achieved by changing the error path of the routine parsing
> an OPAL node name. The node is simply considered being from the new
> device tree layout and fallback values are used.
> 
> Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>

Hi Cedric,

I was about to apply the series, but then I found the following problem.

> ---
>  drivers/hwmon/ibmpowernv.c |   47 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 38 insertions(+), 9 deletions(-)
> 
[ ... ]
>  
> @@ -189,11 +204,16 @@ static u32 get_sensor_hwmon_index(struct sensor_data *sdata,
>  {
>  	int i;
>  
> -	for (i = 0; i < count; i++)
> -		if (sdata_table[i].opal_index == sdata->opal_index &&
> -		    sdata_table[i].type == sdata->type)
> -			return sdata_table[i].hwmon_index;
> +	/*
> +	 * We don't use the OPAL index on newer device trees
> +	 */
> +	if (sdata->opal_index != -1) {

opal_index is u32, so this won't work (or at least the result is
unpredictable).

Also, in patch 4/4 (v4), get_logical_cpu() takes unsigned int as parameter,
but get_hard_smp_processor_id() returns an int, causing gcc to complain
if the code is built with W=1.

Please fix and resubmit the entire series.

When you do that, please also ensure that continuation lines
are aligned (in patch 3/4).

Thanks,
Guenter
