Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2A700DDF3D
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 07:42:20 +1000 (EST)
Subject: Re: [PATCH] POWERPC: duplicate test of MACIO_FLAG_SCCB_ON
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: roel kluin <roel.kluin@gmail.com>
In-Reply-To: <48A9F8E9.8030303@gmail.com>
References: <48A9F8E9.8030303@gmail.com>
Content-Type: text/plain
Date: Tue, 19 Aug 2008 07:42:13 +1000
Message-Id: <1219095733.28339.77.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-08-18 at 18:34 -0400, roel kluin wrote:
> untested, is it correct?

Your patch is correct. The bug is quite harmless thankfully :-)

Ben.
 
> arch/powerpc/include/asm/pmac_feature.h:359:
> #define MACIO_FLAG_SCCA_ON  0x00000001
> #define MACIO_FLAG_SCCB_ON  0x00000002
> ---
> duplicate test of MACIO_FLAG_SCCB_ON
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
> index 5169ecc..e6c0040 100644
> --- a/arch/powerpc/platforms/powermac/feature.c
> +++ b/arch/powerpc/platforms/powermac/feature.c
> @@ -2677,7 +2677,7 @@ static void __init probe_one_macio(const char *name, const char *compat, int typ
>  	macio_chips[i].of_node	= node;
>  	macio_chips[i].type	= type;
>  	macio_chips[i].base	= base;
> -	macio_chips[i].flags	= MACIO_FLAG_SCCB_ON | MACIO_FLAG_SCCB_ON;
> +	macio_chips[i].flags	= MACIO_FLAG_SCCA_ON | MACIO_FLAG_SCCB_ON;
>  	macio_chips[i].name	= macio_names[type];
>  	revp = of_get_property(node, "revision-id", NULL);
>  	if (revp)
