Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 98E842C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 16:07:32 +1000 (EST)
Message-ID: <1372140444.3944.190.camel@pasglop>
Subject: Re: [PATCH 04/10] powerpc/eeh: Backends to get/set settings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Tue, 25 Jun 2013 16:07:24 +1000
In-Reply-To: <1372139717-14885-5-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372139717-14885-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372139717-14885-5-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-06-25 at 13:55 +0800, Gavin Shan wrote:
> When the PHB gets fenced, 0xFF's returns from PCI config space and
> MMIO space in the hardware. The operations writting to them should
> be dropped. The patch introduce backends allow to set/get flags that
> indicate the access to PCI-CFG and MMIO should be blocked.

We can't block MMIO without massive overhead. Config space can be
blocked inside the firmware, can't it ?

Cheers,
Ben.

> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/eeh.h               |    6 +++
>  arch/powerpc/platforms/pseries/eeh_pseries.c |   44 ++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index dd65e31..de821c1 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -131,6 +131,10 @@ static inline struct pci_dev *eeh_dev_to_pci_dev(struct eeh_dev *edev)
>  #define EEH_LOG_TEMP		1	/* EEH temporary error log	*/
>  #define EEH_LOG_PERM		2	/* EEH permanent error log	*/
>  
> +/* Settings for platforms */
> +#define EEH_SETTING_BLOCK_CFG	1	/* Blocked PCI config access	*/
> +#define EEH_SETTING_BLOCK_IO	2	/* Blocked MMIO access		*/
> +
>  struct eeh_ops {
>  	char *name;
>  	int (*init)(void);
> @@ -146,6 +150,8 @@ struct eeh_ops {
>  	int (*configure_bridge)(struct eeh_pe *pe);
>  	int (*read_config)(struct device_node *dn, int where, int size, u32 *val);
>  	int (*write_config)(struct device_node *dn, int where, int size, u32 val);
> +	int (*get_setting)(int option, int *value, void *data);
> +	int (*set_setting)(int option, int value, void *data);
>  	int (*next_error)(struct eeh_pe **pe);
>  };
>  
> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
> index 62415f2..8c9509b 100644
> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
> @@ -612,6 +612,48 @@ static int pseries_eeh_write_config(struct device_node *dn, int where, int size,
>  	return rtas_write_config(pdn, where, size, val);
>  }
>  
> +/**
> + * pseries_eeh_get_setting - Retrieve settings that affect EEH core
> + * @option: option
> + * @value: value
> + * @data: dependent data
> + *
> + * Retrieve the settings from the platform in order to affect the
> + * behaviour of EEH core. We don't block PCI config or MMIO access
> + * on pSeries platform.
> + */
> +static int pseries_eeh_get_setting(int option, int *value, void *data)
> +{
> +	int ret = 0;
> +
> +	switch (option) {
> +	case EEH_SETTING_BLOCK_CFG:
> +	case EEH_SETTING_BLOCK_IO:
> +		*value = 0;
> +		break;
> +	default:
> +		pr_warning("%s: Unrecognized option (%d)\n",
> +			   __func__, option);
> +		ret = -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * pseries_eeh_set_setting - Configure settings to affect EEH core
> + * @option: option
> + * @value: value
> + * @data: dependent data
> + *
> + * Configure the settings for the platform in order to affect the
> + * behaviour of EEH core.
> + */
> +static int pseries_eeh_set_setting(int option, int value, void *data)
> +{
> +	return 0;
> +}
> +
>  static struct eeh_ops pseries_eeh_ops = {
>  	.name			= "pseries",
>  	.init			= pseries_eeh_init,
> @@ -626,6 +668,8 @@ static struct eeh_ops pseries_eeh_ops = {
>  	.configure_bridge       = pseries_eeh_configure_bridge,
>  	.read_config		= pseries_eeh_read_config,
>  	.write_config		= pseries_eeh_write_config,
> +	.get_setting		= pseries_eeh_get_setting,
> +	.set_setting		= pseries_eeh_set_setting,
>  	.next_error		= NULL
>  };
>  
