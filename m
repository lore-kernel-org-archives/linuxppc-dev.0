Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AB4921A00FE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 13:13:22 +1000 (EST)
Message-ID: <1410750802.24738.10.camel@concordia>
Subject: Re: [PATCH 3/4] powerpc/powernv: Check OPAL elog calls exist before
 using
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Date: Mon, 15 Sep 2014 13:13:22 +1000
In-Reply-To: <1408423682-14297-3-git-send-email-mikey@neuling.org>
References: <1408423682-14297-1-git-send-email-mikey@neuling.org>
 <1408423682-14297-3-git-send-email-mikey@neuling.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-08-19 at 14:48 +1000, Michael Neuling wrote:
> Check that the OPAL_ELOG_READ token exists before initalising the elog
> infrastructure.
> 
> This avoids littering the OPAL console with:
>   "OPAL: Called with bad token 74"
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>  arch/powerpc/platforms/powernv/opal-elog.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal-elog.c b/arch/powerpc/platforms/powernv/opal-elog.c
> index bbdb3ff..518fe95 100644
> --- a/arch/powerpc/platforms/powernv/opal-elog.c
> +++ b/arch/powerpc/platforms/powernv/opal-elog.c
> @@ -295,6 +295,10 @@ int __init opal_elog_init(void)
>  {
>  	int rc = 0;
>  
> +	/* ELOG not supported by firmware */
> +	if (!opal_check_token(OPAL_ELOG_READ))
> +		return -1;
> +

The only caller does:

			/* Setup error log interface */
			rc = opal_elog_init();
			/* Setup code update interface */
			opal_flash_init();
			/* Setup platform dump extract interface */
			opal_platform_dump_init();
			/* Setup system parameters interface */
			opal_sys_param_init();
			/* Setup message log interface. */
			opal_msglog_init();
		}
	
		return 0;
	}


So we may as well have it return void. Wanna send a follow-up patch for that.

cheers
