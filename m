Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B63206896A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 30 Dec 2005 07:02:25 +1100 (EST)
Date: Thu, 29 Dec 2005 18:02:37 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Vitaly Bordug <vbordug@ru.mvista.com>, f@dmt.cnet
Message-ID: <20051229200237.GB9203@dmt.cnet>
References: <20051228191803.30378.93344.stgit@vitb.dev.rtsoft.ru>
	<43B2F0FE.4050705@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43B2F0FE.4050705@ru.mvista.com>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 2/2] ppc32: MPC885ADS,
	MPC866ADS and MPC8272ADS-specific platform stuff for fs_enet(resend)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> diff --git a/arch/ppc/syslib/ppc_sys.c b/arch/ppc/syslib/ppc_sys.c
> index e3856e7..9182a36 100644
> --- a/arch/ppc/syslib/ppc_sys.c
> +++ b/arch/ppc/syslib/ppc_sys.c
> @@ -238,7 +238,7 @@ void ppc_sys_device_setfunc(enum ppc_sys
> 		else
> 			*s = 0;
> 	} else if (func != PPC_SYS_FUNC_DUMMY) {
> -		/* do assignment if it is not just "enable"  request */
> +		/* do assignment if it is not just "clear"  request */
> 		sprintf(tmp, "%s:%s", name, ppc_sys_func_names[func]);
> 		strlcpy(name, tmp, BUS_ID_SIZE);
> 	}
> @@ -294,7 +294,7 @@ static int __init ppc_sys_init(void)
> 
> 	for (i = 0; i < cur_ppc_sys_spec->num_devices; i++) {
> 		dev_id = cur_ppc_sys_spec->device_list[i];
> -		if ((dev_id != -1) || 
> +		if ((dev_id != -1) &&
> 		(cur_ppc_sys_spec->config[dev_id] & PPC_SYS_CONFIG_ENABED)) {
> 			if (ppc_sys_device_fixup != NULL)
> 				ppc_sys_device_fixup(&ppc_sys_platform_devices
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 8827daf..ce551b5 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -266,7 +266,7 @@ int platform_device_add(struct platform_
> 		}
> 	}
> 
> -	pr_debug("Registering platform device '%s'. Parent at %s\n",
> +	pr_info("Registering platform device '%s'. Parent at %s\n",
> 		 pdev->dev.bus_id, pdev->dev.parent->bus_id);
> 
> 	ret = device_register(&pdev->dev);

Suppose that all this hunks belong to a different patch?
