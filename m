Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 7A9BBDDEC0
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 08:25:13 +1100 (EST)
Message-ID: <45CCE696.5070309@smiths-aerospace.com>
Date: Fri, 09 Feb 2007 16:24:38 -0500
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] Check mac-address first in fsl_soc.c
References: <11710513671236-git-send-email-timur@freescale.com>
In-Reply-To: <11710513671236-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> The mac-address property in the device tree should be checked first,
> before local-mac-address.  This is because mac-address contains the most
> recent MAC address, whereas local-mac-address is the default address.
> Depending on the platform and the version of U-Boot, U-Boot will set
> one or the other, or both.
> 
> This patch updates gfar_of_init() and fs_enet_of_init() to conform to
> this order.  It skips a property if it doesn't exist or if it contains
> an all-zero MAC address.  This patch also adds some NULL-pointer checking
> to make sure there are no panics if no MAC address has been passed.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  arch/powerpc/sysdev/fsl_soc.c |   39 +++++++++++++++++++++++++++++----------
>  1 files changed, 29 insertions(+), 10 deletions(-)
> 
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

If you want to check for common errors, add a check that the first byte 
does not have the multicast flag set.  Note that this will catch the 
error of setting the MAC to the broadcast address of all 0xFFs as well 
as the naive users that set it to 11:22:33:44:55:66 (remarkable number 
of them out there).

if (!mac_addr || (memcmp(mac_addr, "\0\0\0\0\0", 6) == 0)
     || ((*mac_addr & 0x01) == 0x01)) {

or, if you are a terse, excuse me, tight C programmer:

if (!mac_addr || (memcmp(mac_addr, "\0\0\0\0\0", 6) == 0)
     || (*mac_addr & 0x01)) {

gvb
