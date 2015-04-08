Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6AA501A0BA8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 01:23:18 +1000 (AEST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1Yfrox-001Fij-Ud
 for linuxppc-dev@lists.ozlabs.org; Wed, 08 Apr 2015 15:23:16 +0000
Date: Wed, 8 Apr 2015 08:21:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>
Subject: Re: [v4] hwmon: (ibmpowernv) pretty print labels
Message-ID: <20150408152158.GA15824@roeck-us.net>
References: <1428500527-7833-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1428500527-7833-1-git-send-email-clg@fr.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, lm-sensors@lm-sensors.org,
 Neelesh Gupta <neelegup@linux.vnet.ibm.com>, skiboot@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 08, 2015 at 03:42:07PM +0200, Cédric Le Goater wrote:
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
> ---
> 
>  Changes since v3:
> 
>  - removed error message in case of an unknown physical cpu number
> 
>  Changes since v2:
> 
>  - fix bogus logical cpu retrieval 
>  - use 'threads_per_core' to print out cpu range
> 
>  Changes since v1:
> 
>  - check cpu validity before printing out the attribute label. 
>    if invalid, use a "phy" prefix to distinguish a linux cpu 
>    number from a physical cpu number. 
> 
>  drivers/hwmon/ibmpowernv.c |   41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> Index: linux.git/drivers/hwmon/ibmpowernv.c
> ===================================================================
> --- linux.git.orig/drivers/hwmon/ibmpowernv.c
> +++ linux.git/drivers/hwmon/ibmpowernv.c
> @@ -30,6 +30,7 @@
>  #include <linux/platform_device.h>
>  #include <asm/opal.h>
>  #include <linux/err.h>
> +#include <asm/cputhreads.h>
>  
>  #define MAX_ATTR_LEN	32
>  #define MAX_LABEL_LEN	64
> @@ -110,12 +111,52 @@ static ssize_t show_label(struct device
>  	return sprintf(buf, "%s\n", sdata->label);
>  }
>  
> +static int __init get_logical_cpu(unsigned int hwcpu)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		if (get_hard_smp_processor_id(cpu) == hwcpu)

drivers/hwmon/ibmpowernv.c: In function 'get_logical_cpu':
drivers/hwmon/ibmpowernv.c:119:38: warning: comparison between signed and
unsigned integer expressions [-Wsign-compare]
   if (get_hard_smp_processor_id(cpu) == hwcpu)
                                         ^

Guenter
