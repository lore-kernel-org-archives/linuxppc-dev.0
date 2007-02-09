Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id DAAC2DDDE9
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 07:52:18 +1100 (EST)
Message-ID: <45CCDEFB.5050504@ru.mvista.com>
Date: Fri, 09 Feb 2007 23:52:11 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] Check mac-address first in fsl_soc.c
References: <11710513671236-git-send-email-timur@freescale.com>
In-Reply-To: <11710513671236-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Timur Tabi wrote:
> The mac-address property in the device tree should be checked first,
> before local-mac-address.  This is because mac-address contains the most
> recent MAC address, whereas local-mac-address is the default address.
> Depending on the platform and the version of U-Boot, U-Boot will set
> one or the other, or both.

    Argh, *when* it will be setting both?

> This patch updates gfar_of_init() and fs_enet_of_init() to conform to
> this order.  It skips a property if it doesn't exist or if it contains
> an all-zero MAC address.  This patch also adds some NULL-pointer checking
> to make sure there are no panics if no MAC address has been passed.

> diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
> index 9f2a9a4..a0586ea 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -233,12 +233,13 @@ static int __init gfar_of_init(void)
>  			goto err;
>  		}
>  
> -		mac_addr = get_property(np, "local-mac-address", NULL);
> -		if (mac_addr == NULL)
> -			mac_addr = get_property(np, "mac-address", NULL);
> -		if (mac_addr == NULL) {
> -			/* Obsolete */
> -			mac_addr = get_property(np, "address", NULL);
> +		mac_addr = get_property(np, "mac-address", NULL);
> +		if (!mac_addr || (memcmp(mac_addr, "\0\0\0\0\0", 6) == 0)) {
> +			mac_addr = get_property(np, "local-mac-address", NULL);
> +			if (!mac_addr || (memcmp(mac_addr, "\0\0\0\0\0", 6) == 0)) {
> +				/* Obsolete */
> +				mac_addr = get_property(np, "address", NULL);
> +			}
>  		}
>  
>  		if (mac_addr)
> @@ -607,7 +608,16 @@ static int __init fs_enet_of_init(void)
>  		}
>  
>  		mac_addr = get_property(np, "mac-address", NULL);
> -		memcpy(fs_enet_data.macaddr, mac_addr, 6);
> +		if (!mac_addr || (memcmp(mac_addr, "\0\0\0\0\0", 6) == 0)) {
> +			mac_addr = get_property(np, "local-mac-address", NULL);
> +			if (!mac_addr || (memcmp(mac_addr, "\0\0\0\0\0", 6) == 0)) {
> +				/* Obsolete */
> +				mac_addr = get_property(np, "address", NULL);
> +			}
> +		}
> +
> +		if (mac_addr)
> +			memcpy(fs_enet_data.macaddr, mac_addr, 6);
>  
>  		ph = get_property(np, "phy-handle", NULL);
>  		phy = of_find_node_by_phandle(*ph);
[...]
> @@ -891,8 +901,17 @@ static int __init fs_enet_of_init(void)
>  			goto err;
>  		r[0].name = enet_regs;
>  
> -		mac_addr = (void *)get_property(np, "mac-address", NULL);
> -		memcpy(fs_enet_data.macaddr, mac_addr, 6);
> +		mac_addr = get_property(np, "mac-address", NULL);
> +		if (!mac_addr || (memcmp(mac_addr, "\0\0\0\0\0", 6) == 0)) {
> +			mac_addr = get_property(np, "local-mac-address", NULL);
> +			if (!mac_addr || (memcmp(mac_addr, "\0\0\0\0\0", 6) == 0)) {
> +				/* Obsolete */
> +				mac_addr = get_property(np, "address", NULL);
> +			}
> +		}
> +
> +		if (mac_addr)
> +			memcpy(fs_enet_data.macaddr, mac_addr, 6);

    These are just asking to be put into a separate function... :-)

>  
>  		ph = (phandle *) get_property(np, "phy-handle", NULL);
>  		if (ph != NULL)

WBR, Sergei
