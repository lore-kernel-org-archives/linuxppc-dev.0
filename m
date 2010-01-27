Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f175.google.com (mail-yw0-f175.google.com
	[209.85.211.175]) by ozlabs.org (Postfix) with ESMTP id 76902B7E48
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 02:47:16 +1100 (EST)
Received: by ywh5 with SMTP id 5so12649201ywh.11
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2010 07:47:14 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1264594052-20317-2-git-send-email-agust@denx.de>
References: <1264594052-20317-1-git-send-email-agust@denx.de>
	<1264594052-20317-2-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 27 Jan 2010 08:46:54 -0700
Message-ID: <fa686aa41001270746r3355ad62v126222ba10b7f6b0@mail.gmail.com>
Subject: Re: [PATCH 1/8 v2] powerpc/mpc5121: Add machine restart support
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, wd@denx.de, dzu@denx.de,
	Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 27, 2010 at 5:07 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Add reset module registers representation and
> machine restart callback for mpc5121 platform.

one comment below.

>
> Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: John Rigby <jcrigby@gmail.com>
> ---
>
> Changes since v1:
> =A0- use 'struct mpc512x_reset_module *' type for 'reset_module_base'
> =A0- remove empty line
> =A0- remove leftover colon and use pr_err() instead of printk.
>
> =A0arch/powerpc/include/asm/mpc5xxx.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 14 +++=
++++++-
> =A0arch/powerpc/platforms/512x/mpc5121_ads.c =A0 =A0 | =A0 =A01 +
> =A0arch/powerpc/platforms/512x/mpc5121_generic.c | =A0 =A01 +
> =A0arch/powerpc/platforms/512x/mpc512x.h =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/powerpc/platforms/512x/mpc512x_shared.c =A0| =A0 34 +++++++++++++=
++++++++++++
> =A05 files changed, 50 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mpc5xxx.h b/arch/powerpc/include/as=
m/mpc5xxx.h
> index 5ce9c5f..0004986 100644
> --- a/arch/powerpc/include/asm/mpc5xxx.h
> +++ b/arch/powerpc/include/asm/mpc5xxx.h
> @@ -18,5 +18,17 @@
>
> =A0extern unsigned long mpc5xxx_get_bus_frequency(struct device_node *nod=
e);
>
> -#endif /* __ASM_POWERPC_MPC5xxx_H__ */
> +/* MPC512x Reset module registers */
> +struct mpc512x_reset_module {
> + =A0 =A0 =A0 u32 =A0 =A0 rcwlr; =A0/* Reset Configuration Word Low Regis=
ter */
> + =A0 =A0 =A0 u32 =A0 =A0 rcwhr; =A0/* Reset Configuration Word High Regi=
ster */
> + =A0 =A0 =A0 u32 =A0 =A0 reserved1;
> + =A0 =A0 =A0 u32 =A0 =A0 reserved2;
> + =A0 =A0 =A0 u32 =A0 =A0 rsr; =A0 =A0/* Reset Status Register */
> + =A0 =A0 =A0 u32 =A0 =A0 rmr; =A0 =A0/* Reset Mode Register */
> + =A0 =A0 =A0 u32 =A0 =A0 rpr; =A0 =A0/* Reset Protection Register */
> + =A0 =A0 =A0 u32 =A0 =A0 rcr; =A0 =A0/* Reset Control Register */
> + =A0 =A0 =A0 u32 =A0 =A0 rcer; =A0 /* Reset Control Enable Register */
> +};
>
> +#endif /* __ASM_POWERPC_MPC5xxx_H__ */
> diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/pla=
tforms/512x/mpc5121_ads.c
> index 441abc4..2f40404 100644
> --- a/arch/powerpc/platforms/512x/mpc5121_ads.c
> +++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
> @@ -68,4 +68,5 @@ define_machine(mpc5121_ads) {
> =A0 =A0 =A0 =A0.init_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D mpc5121_ads_init=
_IRQ,
> =A0 =A0 =A0 =A0.get_irq =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D ipic_get_irq,
> =A0 =A0 =A0 =A0.calibrate_decr =A0 =A0 =A0 =A0 =3D generic_calibrate_decr=
,
> + =A0 =A0 =A0 .restart =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D mpc512x_restart=
,
> =A0};
> diff --git a/arch/powerpc/platforms/512x/mpc5121_generic.c b/arch/powerpc=
/platforms/512x/mpc5121_generic.c
> index 2479de9..de4c3f7 100644
> --- a/arch/powerpc/platforms/512x/mpc5121_generic.c
> +++ b/arch/powerpc/platforms/512x/mpc5121_generic.c
> @@ -55,4 +55,5 @@ define_machine(mpc5121_generic) {
> =A0 =A0 =A0 =A0.init_IRQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D mpc512x_init_IRQ=
,
> =A0 =A0 =A0 =A0.get_irq =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D ipic_get_irq,
> =A0 =A0 =A0 =A0.calibrate_decr =A0 =A0 =A0 =A0 =3D generic_calibrate_decr=
,
> + =A0 =A0 =A0 .restart =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D mpc512x_restart=
,
> =A0};
> diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platfor=
ms/512x/mpc512x.h
> index 22a5352..c38875c 100644
> --- a/arch/powerpc/platforms/512x/mpc512x.h
> +++ b/arch/powerpc/platforms/512x/mpc512x.h
> @@ -12,5 +12,6 @@
> =A0#ifndef __MPC512X_H__
> =A0#define __MPC512X_H__
> =A0extern void __init mpc512x_init_IRQ(void);
> +extern void mpc512x_restart(char *cmd);
> =A0void __init mpc512x_declare_of_platform_devices(void);
> =A0#endif =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* __MPC512X_H_=
_ */
> diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/=
platforms/512x/mpc512x_shared.c
> index 434d683..4745028 100644
> --- a/arch/powerpc/platforms/512x/mpc512x_shared.c
> +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
> @@ -21,9 +21,43 @@
> =A0#include <asm/ipic.h>
> =A0#include <asm/prom.h>
> =A0#include <asm/time.h>
> +#include <asm/mpc5xxx.h>
>
> =A0#include "mpc512x.h"
>
> +static struct mpc512x_reset_module __iomem *reset_module_base;
> +
> +static int __init mpc512x_restart_init(void)
> +{
> + =A0 =A0 =A0 struct device_node *np;
> +
> + =A0 =A0 =A0 np =3D of_find_compatible_node(NULL, NULL, "fsl,mpc5121-res=
et");
> + =A0 =A0 =A0 if (!np)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> +
> + =A0 =A0 =A0 reset_module_base =3D of_iomap(np, 0);
> + =A0 =A0 =A0 of_node_put(np);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +arch_initcall(mpc512x_restart_init);

Avoid using arch_initcalls for this sort of thing.  Call it explicitly
from your platform code.  Doing an arch_initcall means that platform
code cannot override it, and that on a multiplatform kernel it will
get called on non-5121 platforms.

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
