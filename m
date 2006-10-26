Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 9C71067F85
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Oct 2006 05:14:24 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so407122ugc
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 12:14:20 -0700 (PDT)
Message-ID: <528646bc0610261214i34351884reb3171413e4c105@mail.gmail.com>
Date: Thu, 26 Oct 2006 13:14:19 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Nicolas DET" <nd@bplan-gmbh.de>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
In-Reply-To: <4540EB0E.2090000@bplan-gmbh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <453FB582.20802@bplan-gmbh.de>
	<1161816783.22582.132.camel@localhost.localdomain>
	<45409760.7030902@bplan-gmbh.de>
	<1161866964.27827.2.camel@localhost.localdomain>
	<4540B0A9.6070404@bplan-gmbh.de>
	<528646bc0610260902o4d4996a4i3dcf2a9b874037c7@mail.gmail.com>
	<528646bc0610260909x10c3b242i64387f576e625048@mail.gmail.com>
	<4540EB0E.2090000@bplan-gmbh.de>
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

I've already made these comments on IRC; but I'll repeat them here for
posterity.  :)

General:
- Run this code through Lindent; fixes up spacing and line endings

On 10/26/06, Nicolas DET <nd@bplan-gmbh.de> wrote:
> --- a/arch/powerpc/platforms/chrp/setup.c       2006-10-25 19:07:23.000000000 +0200
> +++ b/arch/powerpc/platforms/chrp/setup.c       2006-10-26 18:56:34.000000000 +0200
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

As you mentioned on IRC that benh suggested "mpc52xx-pic"; Just call
it mpc52xx-pic and be done with it.  Don't need to loop over this
table.  If incompatible variants appear in the future; this can
change.

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
> @@ -473,8 +519,11 @@ static void __init chrp_find_8259(void)
>                 break;
>         }
>         if (np == NULL)
> -               printk(KERN_WARNING "Cannot find PCI interrupt acknowledge"
> -                      " address, polling\n");
> +       {
> +               printk(KERN_WARNING "Cannot find PCI/i8259 interrupt acknowledge"
> +                      " Fix your tree!\n");
> +               return;
> +       }
>
>         i8259_init(pic, chrp_int_ack);
>         if (ppc_md.get_irq == NULL)

Missing the fixup to prevent i8258 from clobbering the 52xx-pic.  You
do need to have that change in this patch; or have this patch
dependent on another patch that fixes it.  Otherwise, as you know,
this patch is worthless!  :)

And on the other side of this coin; I don't think that the message
change in chrp_find_8259 has anything to do with adding mpc52xx.  :)
(Unfortunately, I have tendencies towards perfectionism)

And on the flip side, I would (*
> @@ -494,6 +543,8 @@ void __init chrp_init_IRQ(void)
>  #if defined(CONFIG_VT) && defined(CONFIG_INPUT_ADBHID) && defined(XMON)
>         struct device_node *kbd;
>  #endif
> +
> +       chrp_find_mpc52xx_pic();
>         chrp_find_openpic();
>         chrp_find_8259();
>
> diff -uprN a/include/asm-ppc/mpc52xx.h b/include/asm-ppc/mpc52xx.h
> --- a/include/asm-ppc/mpc52xx.h 2006-10-25 19:07:48.000000000 +0200
> +++ b/include/asm-ppc/mpc52xx.h 2006-10-25 19:11:55.000000000 +0200
> @@ -119,7 +119,7 @@ enum ppc_sys_devices {
>  #define MPC52xx_SDMA_IRQ_NUM   17
>  #define MPC52xx_PERP_IRQ_NUM   23
>
> -#define MPC52xx_CRIT_IRQ_BASE  1
> +#define MPC52xx_CRIT_IRQ_BASE  0

Is this *strictly* necessary for adding mpc52xx-pic support to
arch/powerpc?  If not, then move it to a separate patch.

>  #define MPC52xx_MAIN_IRQ_BASE  (MPC52xx_CRIT_IRQ_BASE + MPC52xx_CRIT_IRQ_NUM)
>  #define MPC52xx_SDMA_IRQ_BASE  (MPC52xx_MAIN_IRQ_BASE + MPC52xx_MAIN_IRQ_NUM)
>  #define MPC52xx_PERP_IRQ_BASE  (MPC52xx_SDMA_IRQ_BASE + MPC52xx_SDMA_IRQ_NUM)
> @@ -415,7 +415,7 @@ struct mpc52xx_cdm {
>  #ifndef __ASSEMBLY__
>
>  extern void mpc52xx_init_irq(void);
> -extern int mpc52xx_get_irq(void);
> +extern unsigned int mpc52xx_get_irq(void);

Yeah, you really shouldn't do this without fixing the arch/ppc side too.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
