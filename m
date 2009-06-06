Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 03ECCB70A4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Jun 2009 07:16:01 +1000 (EST)
Subject: Re: [PATCH] Remove machine_is(chrp) from 64-bit kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1244306290.3751.2032.camel@macbook.infradead.org>
References: <1244306290.3751.2032.camel@macbook.infradead.org>
Content-Type: text/plain
Date: Sun, 07 Jun 2009 07:15:46 +1000
Message-Id: <1244322946.31984.37.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-06-06 at 17:38 +0100, David Woodhouse wrote:
> The CHRP platform type only exists in a 32-bit build. Don't bother
> checking machine_is(chrp) if we're in 64-bit mode.
> 
> Signed-off-by: David Woodhouse <David.Woodhouse@intel.com>

Isn't the test bogus anyway ? It should be if (!machine_is(powermac))
but is useless since the function is called via:

machine_device_initcall(powermac, pmac_declare_of_platform_devices);

Cheers,
Ben.

> diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
> index 45936c9..c22f7e8 100644
> --- a/arch/powerpc/platforms/powermac/setup.c
> +++ b/arch/powerpc/platforms/powermac/setup.c
> @@ -518,9 +518,10 @@ static int __init pmac_declare_of_platform_devices(void)
>  {
>  	struct device_node *np;
>  
> +#ifdef CONFIG_PPC32
>  	if (machine_is(chrp))
>  		return -1;
> -
> +#endif
>  	np = of_find_node_by_name(NULL, "valkyrie");
>  	if (np)
>  		of_platform_device_create(np, "valkyrie", NULL);
> 
