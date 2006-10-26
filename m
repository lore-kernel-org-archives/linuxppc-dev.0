Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 205B267E04
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Oct 2006 02:02:04 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so356990ugc
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 09:02:01 -0700 (PDT)
Message-ID: <528646bc0610260902o4d4996a4i3dcf2a9b874037c7@mail.gmail.com>
Date: Thu, 26 Oct 2006 10:02:00 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Nicolas DET" <nd@bplan-gmbh.de>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
In-Reply-To: <4540B0A9.6070404@bplan-gmbh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <453FB582.20802@bplan-gmbh.de>
	<1161816783.22582.132.camel@localhost.localdomain>
	<45409760.7030902@bplan-gmbh.de>
	<1161866964.27827.2.camel@localhost.localdomain>
	<4540B0A9.6070404@bplan-gmbh.de>
Cc: akpm@osdl.org, sl@bplan-gmbh.de, linuxppc-dev@ozlabs.org,
	linuxppc-embedded@ozlabs.org, sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(minor) Whitespace is still inconsistent; mostly spaces used where
they should be tabs and a few lines longer than 80 chars.  Running the
source through scripts/Lindent will help.

On 10/26/06, Nicolas DET <nd@bplan-gmbh.de> wrote:
> --- a/arch/powerpc/sysdev/mpc52xx_pic.c 2006-10-25 19:07:24.000000000 +0200
> +++ b/arch/powerpc/sysdev/mpc52xx_pic.c 2006-10-26 10:55:44.000000000 +0200
> @@ -0,0 +1,371 @@
> +/*
> + * arch/powerpc/sysdev/mpc52xx_pic.c
> + *
> + * Programmable Interrupt Controller functions for the Freescale MPC52xx
> + * embedded CPU.
> + * Modified for CHRP Efika 5K2

Don't really need to add the "Modified for.." line; That's what git is
for.  Besides this code is modified for more than just the Efika now.
:)

> + *
> + * Maintainer : Sylvain Munaut <tnt@246tNt.com>
> + *
> + * Based on (well, mostly copied from) the code from the 2.4 kernel by
> + * Dale Farnsworth <dfarnsworth@mvista.com> and Kent Borg.

Ditto for this; but I know you didn't add it.  :)  Although this kind
of comment is more justified because it captures information not
maintained in git.  (Namely where the original file came from.)

> + *
> + * Copyright (C) 2004 Sylvain Munaut <tnt@246tNt.com>
> + * Copyright (C) 2003 Montavista Software, Inc

You should add a bplan copyright line too.

> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2. This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +//#define DEBUG

C++ style comment bad.  :)

> +
> +#include <linux/stddef.h>
> +#include <linux/init.h>
> +#include <linux/sched.h>
> +#include <linux/signal.h>
> +#include <linux/stddef.h>
> +#include <linux/delay.h>
> +#include <linux/irq.h>
> +
> +#include <asm/io.h>
> +#include <asm/processor.h>
> +#include <asm/system.h>
> +#include <asm/irq.h>
> +#include <asm/prom.h>
> +
> +#include <asm/mpc52xx.h>
> +
> +static struct mpc52xx_intr __iomem *intr;
> +static struct mpc52xx_sdma __iomem *sdma;
> +
> +static struct irq_host *mpc52xx_irqhost = NULL;
> +

(snip)

> --- a/arch/powerpc/Kconfig      2006-10-25 19:07:23.000000000 +0200
> +++ b/arch/powerpc/Kconfig      2006-10-26 11:32:54.000000000 +0200
> @@ -384,6 +384,12 @@ config PPC_CHRP
>         select PPC_RTAS
>         select PPC_MPC106
>         select PPC_UDBG_16550
> +       select PPC_MPC52xx_PIC
> +       default y
> +
> +config PPC_MPC52xx_PIC
> +        bool
> +       depends on PPC_CHRP
>         default y

This isn't good for embedded 52xx boards.  Anything u-boot based
cannot be CHRP.  Please drop the "depends on" line

> --- a/arch/powerpc/platforms/chrp/setup.c       2006-10-25 19:07:23.000000000 +0200
> +++ b/arch/powerpc/platforms/chrp/setup.c       2006-10-26 10:59:39.000000000 +0200
> @@ -51,6 +51,7 @@
>  #include <asm/mpic.h>
>  #include <asm/rtas.h>
>  #include <asm/xmon.h>
> +#include <asm/mpc52xx.h>
>
>  #include "chrp.h"
>
> @@ -435,6 +436,51 @@ static struct irqaction xmon_irqaction =
>  };
>  #endif
>
> +
> +struct device_node *find_mpc52xx_pic(void)
> +{
> +       struct device_node *dev;
> +       const char *piccompatible_list[] =
> +       {
> +               "mpc5200-interrupt-controller",
> +               "mpc52xx-interrupt-controller",
> +               "mpc52xx-pic",
> +               "mpc5200-pic",
> +               "5200-interrupt-controller",
> +               "52xx-interrupt-controller",
> +               "52xx-pic",
> +               "5200-pic",
> +               NULL
> +       };

Considering Efika is the *only* CHRP 52xx board out there at the
moment, and only a handful of embedded folks trying to move it to
arch/powerpc, surely we can come to an agreement now on what this
thing is named.  :)

Seriously, just recommend a name to use and everyone will use it.
Providing a list of names means that every name in your list will be
used.

> +
> +       /* Look for an MPC52xx interrupt controller */
> +       for_each_node_by_type(dev, "interrupt-controller")
> +       {
> +               const char **piccompatible_entry = piccompatible_list;
> +
> +               for(piccompatible_entry = piccompatible_list; *piccompatible_entry; piccompatible_entry++ )
> +               {
> +                       if (device_is_compatible(dev, *piccompatible_entry ))
> +                               return dev;
> +               }
> +       }
> +
> +       return NULL;
> +}
> +
> +static int  __init chrp_find_mpc52xx_pic(void)
> +{
> +       if (find_mpc52xx_pic())
> +       {
> +               printk(KERN_INFO "Found MPC52xx Interrupt Controller\n");
> +               ppc_md.get_irq = mpc52xx_get_irq;
> +               mpc52xx_init_irq();
> +               return 0;
> +       }
> +
> +       return -ENODEV;
> +}
> +
>  static void __init chrp_find_8259(void)
>  {
>         struct device_node *np, *pic = NULL;
> @@ -494,8 +540,12 @@ void __init chrp_init_IRQ(void)
>  #if defined(CONFIG_VT) && defined(CONFIG_INPUT_ADBHID) && defined(XMON)
>         struct device_node *kbd;
>  #endif
> -       chrp_find_openpic();
> -       chrp_find_8259();
> +
> +       if ( chrp_find_mpc52xx_pic() < 0)
> +       {
> +               chrp_find_openpic();
> +               chrp_find_8259();
> +       }

Why?  Why not just add the call to chrp_find_mpc52xx_pic() before or
after the other two chrp_find_ calls?  Will calling them cause things
to break?

Keep the code simple.

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
