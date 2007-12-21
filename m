Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 2FE47DDEC0
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 08:19:17 +1100 (EST)
Date: Fri, 21 Dec 2007 15:25:53 -0600
From: Olof Johansson <olof@lixom.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/4] [POWERPC] qe_lib and users: get rid of device_type
	and model
Message-ID: <20071221212553.GA11910@lixom.net>
References: <20071221201844.GA4278@localhost.localdomain>
	<20071221202054.GA4502@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071221202054.GA4502@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On Fri, Dec 21, 2007 at 11:20:54PM +0300, Anton Vorontsov wrote:
> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> index e6c63a5..a152bf8 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
> @@ -94,7 +94,8 @@ static void __init mpc85xx_mds_setup_arch(void)
>  #endif
>  
>  #ifdef CONFIG_QUICC_ENGINE
> -	if ((np = of_find_node_by_name(NULL, "qe")) != NULL) {
> +	np = of_find_node_by_name(NULL, "fsl,qe");
> +	if (np) {

That won't work. Did you mean of_find_compatible_node()? If so, you
still need to fall back to looking up by name for older device trees
that don't have the compatible field.


-Olof
