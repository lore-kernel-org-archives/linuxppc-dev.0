Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id EEB3567D8E
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 09:01:40 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so213808ugc
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 16:01:39 -0700 (PDT)
Message-ID: <528646bc0610251601l171eb05k73e1af1c3391ae8@mail.gmail.com>
Date: Wed, 25 Oct 2006 17:01:38 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Nicolas DET" <nd@bplan-gmbh.de>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
In-Reply-To: <453FB582.20802@bplan-gmbh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <453FB582.20802@bplan-gmbh.de>
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

Thanks Nicolas, I'll dig through the PIC code tonight.  I'm really not
sure about the implications of this being a CHRP board vs. the
Lite5200 using u-boot.  ie. Should the Lite5200 also be a CHRP
platform?  Does u-boot provide enough capability (this is where my
ignorance about CHRP shines through)

Cheers,
g.

On 10/25/06, Nicolas DET <nd@bplan-gmbh.de> wrote:
> * mpc5k2.c: As far as I understood, using of_platform_device will allow
> 'smart' of tree parsing. I did not implement it yet.
>
> * mpc5k2_pic.c : The thingy ;-). I moved it into arch/powerpc/sysdev as
> suggested. This code is 99% copy/paste from the ARCH=ppc. I added an
> irq_host with the appropriate xlate and co. However, I have not done
> more as this code has been written by others. I think we should work
> together to move to new Linux style irq. I stay ready to test or code
> upcoming revision/

Why change the naming scheme from mpc52xx to mpc5k3?  All other
freescale supports follow the mpcXXxxx scheme.

>
> * arch/powerpc/platform/*. Here, only small changes has been made. I
> added _CHRP_E5K2 (in asm/processor.h), an entry in chrp_names() and the
> correct detection in arch/powerpc/platform/setup.c / chrp_setup_arch().
> in chrp_init_IRQ(), I set ppc_md.get_irq to mpc52xx_get_irq and call
> mpc52xx_init_irq().
>
> * serial stuff / IBP Freq. As this frequency is MPC52xx specific. I
> think it would make sense to add a new func mpc52xx_getipbfreq(void).
> The way it would be implemented may depend of the architecture. Our
> firmware contains an 'ipb-freq' property in '/builtin/'.
>
> diff -uprN a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
> --- a/arch/powerpc/platforms/chrp/setup.c       2006-10-25 19:07:23.000000000 +0200
> +++ b/arch/powerpc/platforms/chrp/setup.c       2006-10-25 19:10:18.000000000 +0200
> @@ -101,7 +102,8 @@ static const char *chrp_names[] = {
>         "Motorola",
>         "IBM or Longtrail",
>         "Genesi Pegasos",
> -       "Total Impact Briq"
> +       "Total Impact Briq",
> +       "bPlan Efika"
>  };

I agree w/ Paul... the chrp_type stuff is stinky.  :)

> @@ -494,6 +498,12 @@ void __init chrp_init_IRQ(void)
>  #if defined(CONFIG_VT) && defined(CONFIG_INPUT_ADBHID) && defined(XMON)
>         struct device_node *kbd;
>  #endif
> +       if (_chrp_type ==  _CHRP_E5K2) {
> +               ppc_md.get_irq = mpc52xx_get_irq;
> +               mpc52xx_init_irq();
> +               return;
> +       }
> +
>         chrp_find_openpic();
>         chrp_find_8259();

Also, this only covers one 52xx board and does not match the
convention in this function.  Shouldn't this instead call a new
function "chrp_find_mpc52xx_pic()?

>
> @@ -530,6 +540,9 @@ chrp_init2(void)
>         chrp_nvram_init();
>  #endif
>
> +       if (_chrp_type == _CHRP_E5K2)
> +               return;
> +
>         request_region(0x20,0x20,"pic1");
>         request_region(0xa0,0x20,"pic2");
>         request_region(0x00,0x20,"dma1");

There's got to be a better way to go about this.  If all the
request_regions are not required by all CHRP platforms, then they
should be enclosed by an if{} block.  Just bailing from the function
does not seem to be a good idea to me.  For example, at the end of
chrp_init2() there is a progress method called (if enabled).  Bailing
out prevents that progress message.  (not a big issue, but I'm looking
a convention consistency here)

> diff -uprN a/include/asm-powerpc/processor.h b/include/asm-powerpc/processor.h
> --- a/include/asm-powerpc/processor.h   2006-10-25 19:07:48.000000000 +0200
> +++ b/include/asm-powerpc/processor.h   2006-10-25 19:11:54.000000000 +0200
> @@ -33,6 +33,7 @@
>  #define _CHRP_IBM      0x05    /* IBM chrp, the longtrail and longtrail 2 */
>  #define _CHRP_Pegasos  0x06    /* Genesi/bplan's Pegasos and Pegasos2 */
>  #define _CHRP_briq     0x07    /* TotalImpact's briQ */
> +#define _CHRP_E5K2     0x08    /* bPlan's Efika 5k2*/

Ick.  :)

> diff -uprN a/include/asm-ppc/mpc52xx.h b/include/asm-ppc/mpc52xx.h
> --- a/include/asm-ppc/mpc52xx.h 2006-10-25 19:07:48.000000000 +0200
> +++ b/include/asm-ppc/mpc52xx.h 2006-10-25 19:11:55.000000000 +0200
> @@ -119,7 +119,7 @@ enum ppc_sys_devices {
>  #define MPC52xx_SDMA_IRQ_NUM   17
>  #define MPC52xx_PERP_IRQ_NUM   23
>
> -#define MPC52xx_CRIT_IRQ_BASE  1
> +#define MPC52xx_CRIT_IRQ_BASE  0
>  #define MPC52xx_MAIN_IRQ_BASE  (MPC52xx_CRIT_IRQ_BASE + MPC52xx_CRIT_IRQ_NUM)
>  #define MPC52xx_SDMA_IRQ_BASE  (MPC52xx_MAIN_IRQ_BASE + MPC52xx_MAIN_IRQ_NUM)
>  #define MPC52xx_PERP_IRQ_BASE  (MPC52xx_SDMA_IRQ_BASE + MPC52xx_SDMA_IRQ_NUM)

Just curious... why?

> --- a/arch/powerpc/sysdev/mpc52xx_pic.c 1970-01-01 01:00:00.000000000 +0100
> +++ b/arch/powerpc/sysdev/mpc52xx_pic.c 2006-10-25 19:17:48.000000000 +0200

I'll skip commenting on PIC stuff as I'm still working through how it
all works myself.  It still needs to be worked out if we go to a two
level interrupt # table in the device tree (interrupt_cells=3) and
where they will be mapped back into Linux IRQ numbers.

> --- a/arch/powerpc/sysdev/Makefile      2006-10-25 19:07:24.000000000 +0200
> +++ b/arch/powerpc/sysdev/Makefile      2006-10-25 20:33:32.000000000 +0200
> @@ -13,6 +13,7 @@ obj-$(CONFIG_FSL_SOC)         += fsl_soc.o
>  obj-$(CONFIG_PPC_TODC)         += todc.o
>  obj-$(CONFIG_TSI108_BRIDGE)    += tsi108_pci.o tsi108_dev.o
>  obj-$(CONFIG_QUICC_ENGINE)     += qe_lib/
> +obj-$(CONFIG_PPC_CHRP)         += mpc52xx_pic.o
>
>  ifeq ($(CONFIG_PPC_MERGE),y)
>  obj-$(CONFIG_PPC_I8259)                += i8259.o
>
>
>
>


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
