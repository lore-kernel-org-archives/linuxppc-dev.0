Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id 04200B6F0E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Jul 2010 16:21:52 +1000 (EST)
Received: by gyd10 with SMTP id 10so460721gyd.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Jul 2010 23:21:50 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1279120733-13584-1-git-send-email-msm@freescale.com>
References: <1279120733-13584-1-git-send-email-msm@freescale.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 15 Jul 2010 00:21:30 -0600
Message-ID: <AANLkTimiM1Ky7aIYoQ3efhivypV90LFG-BpueuaPaiPf@mail.gmail.com>
Subject: Re: [PATCH V4] powerpc/prom: Export device tree physical address via
	proc
To: Matthew McClintock <msm@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Kumar Gala <kumar.gala@freescale.com>, linuxppc-dev@lists.ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 14, 2010 at 9:18 AM, Matthew McClintock <msm@freescale.com> wro=
te:
> To build a proper flat device tree for kexec we need to know which
> memreserve region was used for the device tree for the currently
> running kernel, so we can remove it and replace it with the new
> memreserve for the kexec'ed kernel
>
> Signed-off-by: Matthew McClintock <msm@freescale.com>

Hi Matthew.

I don't understand.  Why does userspace need to know about the old
memreserve sections?  Doesn't kexec tear down all of the old
allocations anyway?  How are they relevant for constructing the dtb
for the kexec kernel?  I'll need a lot more details before I consider
merging this.

Also, please cc: me and Ben Herrenschmidt on powerpc related device
tree changes.

Cheers,
g.

> ---
> V4: Fixed misspelling
>
> V3: Remove unneeded cast, and fixed indentation screw up
>
> V2: messed up changes
>
> =A0arch/powerpc/kernel/prom.c | =A0 45 ++++++++++++++++++++++++++++++++++=
++++++++++
> =A01 files changed, 45 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index fd9359a..ff3e240 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -32,6 +32,7 @@
> =A0#include <linux/debugfs.h>
> =A0#include <linux/irq.h>
> =A0#include <linux/lmb.h>
> +#include <linux/bootmem.h>
>
> =A0#include <asm/prom.h>
> =A0#include <asm/rtas.h>
> @@ -911,3 +912,47 @@ static int __init export_flat_device_tree(void)
> =A0}
> =A0__initcall(export_flat_device_tree);
> =A0#endif
> +
> +#ifdef CONFIG_KEXEC
> +static phys_addr_t flat_dt_start;
> +static phys_addr_t flat_dt_end;
> +
> +static struct property flat_dt_start_prop =3D {
> + =A0 =A0 =A0 .name =3D "linux,devicetree-start",
> + =A0 =A0 =A0 .length =3D sizeof(phys_addr_t),
> + =A0 =A0 =A0 .value =3D &flat_dt_start,
> +};
> +
> +static struct property flat_dt_end_prop =3D {
> + =A0 =A0 =A0 .name =3D "linux,devicetree-end",
> + =A0 =A0 =A0 .length =3D sizeof(phys_addr_t),
> + =A0 =A0 =A0 .value =3D &flat_dt_end,
> +};
> +
> +static int __init export_flat_device_tree_phys_addr(void)
> +{
> + =A0 =A0 =A0 struct property *prop;
> + =A0 =A0 =A0 struct device_node *node;
> +
> + =A0 =A0 =A0 node =3D of_find_node_by_path("/chosen");
> + =A0 =A0 =A0 if (!node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOENT;
> +
> + =A0 =A0 =A0 prop =3D of_find_property(node, "linux,devicetree-start", N=
ULL);
> + =A0 =A0 =A0 if (prop)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prom_remove_property(node, prop);
> +
> + =A0 =A0 =A0 prop =3D of_find_property(node, "linux,devicetree-end", NUL=
L);
> + =A0 =A0 =A0 if (prop)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prom_remove_property(node, prop);
> +
> + =A0 =A0 =A0 flat_dt_start =3D virt_to_phys(initial_boot_params);
> + =A0 =A0 =A0 flat_dt_end =3D virt_to_phys(initial_boot_params)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + initial_b=
oot_params->totalsize;
> + =A0 =A0 =A0 prom_add_property(node, &flat_dt_start_prop);
> + =A0 =A0 =A0 prom_add_property(node, &flat_dt_end_prop);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +__initcall(export_flat_device_tree_phys_addr);
> +#endif
> --
> 1.6.6.1
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
