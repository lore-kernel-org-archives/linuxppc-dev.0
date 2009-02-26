Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D8320DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 07:29:17 +1100 (EST)
Subject: Re: [PATCH 1/1] Fix 64bit Mapple Host Bridge Address and Size Nodes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tiejun Chen <tiejun.china@gmail.com>
In-Reply-To: <7a800c8d0902260208g4a65b07fi1bb287910c51b342@mail.gmail.com>
References: <1235642785-9684-1-git-send-email-tiejun.chen@windriver.com>
	<7a800c8d0902260208g4a65b07fi1bb287910c51b342@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 27 Feb 2009 07:28:59 +1100
Message-Id: <1235680139.7388.15.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-02-26 at 18:08 +0800, Tiejun Chen wrote:
> In the DTB tree created by firmware on Maple 64bit target, host bridge
> parent
> node has specified both of these two properties to be 2. However, the
> actual
> "cell" value for host bridge node is 1. we have to provide one fixup
> function.

Hi !

Thanks for the patch. A couple of things tho: Can you make it a bit
more robust by properly checking the board type first ?

Also, what is this "hostbridge" node ? ie, what does it represent ?

Can you send me a full dump of /proc/device-tree from the machine ?
(ie tar it up)

Finally, it looks like your patch was whitespace damaged by your mailer.

Cheers,
Ben.


> Signed-off-by: Tiejun Chen <tiejun.china@gmail.com>
> ---
>  arch/powerpc/kernel/prom_init.c |   42
> +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 42 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c
> b/arch/powerpc/kernel/prom_init.c
> index 2445945..9cd23b6 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -1948,8 +1948,49 @@ static void __init
> fixup_device_tree_maple(void)
>        prom_setprop(isa, name, "ranges",
>                        isa_ranges, sizeof(isa_ranges));
>  }
> +
> +/* On Maple 64bit target host bridge parent node has specified
> address and
> + * size properties to be 2. But the actual "cell" value for host
> bridge node
> + * is 1 since early MOTLoad internal bug. */
> +static void __init fixup_device_tree_maple_hb(void)
> +{
> +       phandle hb;
> +       u32 hb_ranges[4];
> +       u32 size_cell, addr_cell;
> +       struct prom_t *_prom = &RELOC(prom);
> +       char *name;
> +
> +       name = "/hostbridge@f8000000";
> +       hb = call_prom("finddevice", 1, 1, ADDR(name));
> +       if (!PHANDLE_VALID(hb))
> +               return;
> +
> +       if (prom_getproplen(hb, "reg") != 8)
> +               return;
> +
> +       if (prom_getprop(hb, "reg", hb_ranges, (sizeof(hb_ranges))/2)
> +               == PROM_ERROR)
> +               return;
> +
> +       prom_getprop(_prom->root, "#address-cells", &addr_cell,
> sizeof(addr_cell));
> +       prom_getprop(_prom->root, "#size-cells", &size_cell,
> sizeof(size_cell));
> +
> +       if ((addr_cell != 2) || (size_cell != 2) ||
> +               (hb_ranges[0] != 0xf8000000))
> +               return;
> +
> +       prom_printf("Fixing up bogus HOSTBRIDGE reg on
> Maple/Apache...\n");
> +
> +       hb_ranges[3] = hb_ranges[1];
> +       hb_ranges[1] = hb_ranges[0];
> +       hb_ranges[0] = hb_ranges[2] = 0;
> +       prom_setprop(hb, name, "reg",
> +               hb_ranges, sizeof(hb_ranges));
> +}
> +
>  #else
>  #define fixup_device_tree_maple()
> +#define fixup_device_tree_maple_hb()
>  #endif
> 
>  #ifdef CONFIG_PPC_CHRP
> @@ -2190,6 +2231,7 @@ static void __init fixup_device_tree_efika(void)
>  static void __init fixup_device_tree(void)
>  {
>        fixup_device_tree_maple();
> +       fixup_device_tree_maple_hb();
>        fixup_device_tree_chrp();
>        fixup_device_tree_pmac();
>        fixup_device_tree_efika();
> --
> 1.5.6
> 
> 
> 
