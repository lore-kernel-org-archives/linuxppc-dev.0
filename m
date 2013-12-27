Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6DF342C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Dec 2013 09:20:14 +1100 (EST)
Message-ID: <1388182804.4373.17.camel@pasglop>
Subject: Re: [PATCH 1/4] powerpc/eeh: Add restore_bars operation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Sat, 28 Dec 2013 09:20:04 +1100
In-Reply-To: <1387961936-20451-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1387961936-20451-1-git-send-email-shangw@linux.vnet.ibm.com>
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

On Wed, 2013-12-25 at 16:58 +0800, Gavin Shan wrote:
> After reset on the specific PE or PHB, we never configure AER
> correctly on PowerNV platform. We needn't care it on pSeries
> platform. The patch introduces additional EEH operation eeh_ops::
> restore_bars() so that we have chance to configure AER correctly
> for PowerNV platform.

Why call it "restore_bars" if it restores something else (in this case
AER) ?

I would call it "restore_config" instead... Also rather than adding
the knowledge of what AER bit works or not for the device, would it
make sense to instead have a FW call to re-init the device ?

Otherwise, you introduce duplication between Linux and Firmware with
the risk of getting out of sync...

Cheers,
Ben.

> Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/eeh.h               |    1 +
>  arch/powerpc/kernel/eeh_pe.c                 |    3 +++
>  arch/powerpc/platforms/pseries/eeh_pseries.c |    4 +++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index d3e5e9b..4b709bf 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -157,6 +157,7 @@ struct eeh_ops {
>  	int (*read_config)(struct device_node *dn, int where, int size, u32 *val);
>  	int (*write_config)(struct device_node *dn, int where, int size, u32 val);
>  	int (*next_error)(struct eeh_pe **pe);
> +	void (*restore_bars)(struct device_node *dn);
>  };
>  
>  extern struct eeh_ops *eeh_ops;
> diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
> index f945053..19eb95a 100644
> --- a/arch/powerpc/kernel/eeh_pe.c
> +++ b/arch/powerpc/kernel/eeh_pe.c
> @@ -737,6 +737,9 @@ static void *eeh_restore_one_device_bars(void *data, void *flag)
>  	else
>  		eeh_restore_device_bars(edev, dn);
>  
> +	if (eeh_ops->restore_bars)
> +		eeh_ops->restore_bars(dn);
> +
>  	return NULL;
>  }
>  
> diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
> index ccb633e..623adaf 100644
> --- a/arch/powerpc/platforms/pseries/eeh_pseries.c
> +++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
> @@ -689,7 +689,9 @@ static struct eeh_ops pseries_eeh_ops = {
>  	.get_log		= pseries_eeh_get_log,
>  	.configure_bridge       = pseries_eeh_configure_bridge,
>  	.read_config		= pseries_eeh_read_config,
> -	.write_config		= pseries_eeh_write_config
> +	.write_config		= pseries_eeh_write_config,
> +	.next_error		= NULL,
> +	.restore_bars		= NULL
>  };
>  
>  /**
