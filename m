Return-Path: <michael@ellerman.id.au>
Message-ID: <1340840734.23635.8.camel@concordia>
Subject: Re: [PATCH 03/21] ppc/eeh: more logs for EEH initialization
From: Michael Ellerman <michael@ellerman.id.au>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Thu, 28 Jun 2012 09:45:34 +1000
In-Reply-To: <1340812911-6793-4-git-send-email-shangw@linux.vnet.ibm.com>
References: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1340812911-6793-4-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-06-28 at 00:01 +0800, Gavin Shan wrote:
> The patch adds more logs to EEH initialization functions for
> debugging purpose. Also, the machine type ("pSeries") is checked
> in the platform initialization to assure it's the correct platform
> to invoke it.

Hi Gavin,

Our boot logs are full enough. pr_info() is not right for this sort of
stuff.

For debug use:
      * pr_debug() - which can be enabled dynamically.
      * pr_devel() - which needs to be built with #define DEBUG
      * printk(KERN_DEBUG) - for things you always want printed, but
        needn't go to the console by default.

> diff --git a/arch/powerpc/platforms/pseries/eeh_dev.c b/arch/powerpc/platforms/pseries/eeh_dev.c
> index 8e3443b..a0cee3a 100644
> --- a/arch/powerpc/platforms/pseries/eeh_dev.c
> +++ b/arch/powerpc/platforms/pseries/eeh_dev.c
> @@ -100,6 +100,8 @@ static int __init eeh_dev_phb_init(void)
>  	list_for_each_entry_safe(phb, tmp, &hose_list, list_node)
>  		eeh_dev_phb_init_dynamic(phb);
>  
> +	pr_info("EEH: devices created\n");

That's not actually very informative.

> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
> index bcf0bb8..bb2bd90 100644
> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
> @@ -561,7 +561,18 @@ static struct eeh_ops pseries_eeh_ops = {
>   */
>  static int __init eeh_pseries_init(void)
>  {
> -	return eeh_ops_register(&pseries_eeh_ops);
> +	int ret = -EINVAL;
> +
> +	if (!machine_is(pseries))
> +		return ret;
> +
> +	ret = eeh_ops_register(&pseries_eeh_ops);
> +	if (!ret)
> +		pr_info("EEH: pSeries platform initialized\n");
> +	else
> +		pr_info("EEH: pSeries platform initialization failure\n");
> +
> +	return ret;
>  }
>  
>  early_initcall(eeh_pseries_init);

You can achieve the same with initcall_debug.

But if you want to keep it at least print the return code, that's the
first thing you will want to know if it fails.

cheers
