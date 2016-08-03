Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s44BC38bbzDqQw
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 17:16:35 +1000 (AEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Jack Miller <jack@codezen.org>,  linuxppc-dev@lists.ozlabs.org, 
From: Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20160801205035.18514-1-jack@codezen.org>
Cc: jk@ozlabs.org,  stewart@linux.vnet.ibm.com,  benh@kernel.crashing.org
References: <20160801205035.18514-1-jack@codezen.org>
Message-ID: <147020859492.19099.3536038186529840354@concordia>
Subject: Re: [PATCH] powernv: Search for new flash DT node location
Date: Wed, 03 Aug 2016 17:16:34 +1000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting Jack Miller (2016-08-02 06:50:35)
> Skiboot will place the flash device tree node at ibm,opal/flash/flash@0
> on P9 and later systems, so Linux needs to search for it there as well
> as ibm,opal/flash@0 for backwards compatibility.
> =

> Signed-off-by: Jack Miller <jack@codezen.org>
> ---
>  arch/powerpc/platforms/powernv/opal.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> =

> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platfor=
ms/powernv/opal.c
> index ae29eaf..2847cb0 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -755,9 +755,14 @@ static int __init opal_init(void)
>  =

>         /* Initialize platform devices: IPMI backend, PRD & flash interfa=
ce */
>         opal_pdev_init(opal_node, "ibm,opal-ipmi");
> -       opal_pdev_init(opal_node, "ibm,opal-flash");
> +       opal_pdev_init(opal_node, "ibm,opal-flash"); // old <=3D P8 flash=
 location
>         opal_pdev_init(opal_node, "ibm,opal-prd");
>  =

> +       /* New >=3D P9 flash location */
> +       np =3D of_get_child_by_name(opal_node, "flash");
> +       if (np)
> +               opal_pdev_init(np, "ibm,opal-flash");

We could instead just search for all nodes that are compatible with
"ibm,opal-flash". We do that for i2c, see opal_i2c_create_devs().

Is there a particular reason not to do that?

cheers
