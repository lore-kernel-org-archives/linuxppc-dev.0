Return-Path: <lee.nipper@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
 [209.85.213.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B7891B7236
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2011 05:30:39 +1100 (EST)
Received: by ywp27 with SMTP id 27so1526973ywp.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 10:30:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1321552581-29773-3-git-send-email-dbaryshkov@gmail.com>
References: <1321552581-29773-1-git-send-email-dbaryshkov@gmail.com>
 <1321552581-29773-3-git-send-email-dbaryshkov@gmail.com>
Date: Thu, 17 Nov 2011 12:30:36 -0600
Message-ID: <CALg11mj7DG2KE=pODJ526zQdQZSc4vFuDCtEGGYXNiwxpGAcyA@mail.gmail.com>
Subject: Re: [PATCH 3/6] powerpc/85xx: separate MPIC handling code
From: Lee Nipper <lee.nipper@gmail.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: lee.nipper@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 17, 2011 at 11:56 AM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> All mpc85xx boards deal with MPIC initialization in more or less the
> same way. The only difrerences are some flags (WANTS_RESET,
> BROKEN_FRR_NIRQS, SINGLE_DEST_CPU), and some bugs like leaking device
> node counter, etc. To minimize problems, switch all boards to use one
> single instance of code.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

<snip>

> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_common.c b/arch/powerpc/=
platforms/85xx/mpc85xx_common.c
> index fe40668..7579e24 100644
> --- a/arch/powerpc/platforms/85xx/mpc85xx_common.c
> +++ b/arch/powerpc/platforms/85xx/mpc85xx_common.c
> @@ -7,6 +7,9 @@
> =A0*/
> =A0#include <linux/of_platform.h>
>
> +#include <asm/machdep.h>
> +#include <asm/mpic.h>
> +
> =A0#include <sysdev/cpm2_pic.h>
>
> =A0#include "mpc85xx.h"
> @@ -63,3 +66,43 @@ void __init mpc85xx_cpm2_pic_init(void)
> =A0 =A0 =A0 =A0irq_set_chained_handler(irq, cpm2_cascade);
> =A0}
> =A0#endif
> +
> +
> +void __init mpc85xx_init_mpic(bool reset, bool broken_frr, bool singlede=
st)
> +{
> + =A0 =A0 =A0 struct mpic *mpic;
> + =A0 =A0 =A0 struct resource r;
> + =A0 =A0 =A0 struct device_node *np =3D NULL;
> + =A0 =A0 =A0 unsigned int flags =3D MPIC_PRIMARY | MPIC_BIG_ENDIAN |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MPIC_BROKEN=
_FRR_NIRQS | MPIC_SINGLE_DEST_CPU;

since parameters broken_frr and singledest are used later,
flags should probably be just:

        =A0 =A0 unsigned int flags =3D MPIC_PRIMARY | MPIC_BIG_ENDIAN;

> +
> + =A0 =A0 =A0 np =3D of_find_node_by_type(np, "open-pic");
> +
> + =A0 =A0 =A0 if (np =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Could not find open-pic no=
de\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (of_address_to_resource(np, 0, &r)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Failed to map mpic registe=
r space\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(np);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (reset)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D MPIC_WANTS_RESET;
> + =A0 =A0 =A0 if (broken_frr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D MPIC_BROKEN_FRR_NIRQS;
> + =A0 =A0 =A0 if (singledest)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D MPIC_SINGLE_DEST_CPU;
> + =A0 =A0 =A0 if (ppc_md.get_irq =3D=3D mpic_get_coreint_irq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D MPIC_ENABLE_COREINT;
> +
> + =A0 =A0 =A0 mpic =3D mpic_alloc(np, r.start, flags, 0, 256, " OpenPIC =
=A0");
> + =A0 =A0 =A0 BUG_ON(mpic =3D=3D NULL);
> +
> + =A0 =A0 =A0 /* Return the mpic node */
> + =A0 =A0 =A0 of_node_put(np);
> +
> + =A0 =A0 =A0 mpic_init(mpic);
> +}

<snip>

> --
> 1.7.7.1
