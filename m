Return-Path: <glikely@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by ozlabs.org (Postfix) with ESMTP id DAE03DE0B1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Mar 2007 02:58:05 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so1862939nfc
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Mar 2007 08:58:03 -0700 (PDT)
Message-ID: <528646bc0703230858h237237c2t5b7bedca6e42cddd@mail.gmail.com>
Date: Fri, 23 Mar 2007 09:58:03 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Domen Puncer" <domen.puncer@telargo.com>
Subject: Re: [PATCH 4/5] mpc52xx suspend: deep-sleep
In-Reply-To: <20070315104307.GE22215@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070315103959.GA22215@moe.telargo.com>
	<20070315104307.GE22215@moe.telargo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 3/15/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> Implement deep-sleep on MPC52xx.
> SDRAM is put into self-refresh with help of SRAM code
> (alternatives would be code in FLASH, I-cache).
> Interrupt code must also not be in SDRAM, so put it
> in I-cache.
> MPC52xx core is static, so contents will remain intact even
> with clocks turned off.

Some more comments...

> Index: grant.git/arch/powerpc/platforms/52xx/mpc52xx_pm.c
> ===================================================================
> --- /dev/null
> +++ grant.git/arch/powerpc/platforms/52xx/mpc52xx_pm.c
> +/* you will want to change this, to match your board gpios, rtc or whatever */
> +static void mpc52xx_set_wakeup_mode(void)
> +{
> +       struct mpc52xx_gpio_wkup __iomem *gpiow;
> +       struct mpc52xx_intr __iomem *intr;
> +#ifdef CONFIG_PPC_LITE5200
> +       int pin = 1; /* GPIO_WKUP_1 (GPIO_PSC2_4) */
> +       int level_low = 1; /* wakeup on low level */
> +#elif defined CONFIG_PPC_EFIKA
> +       int pin = 4; /* GPIO_WKUP_4 (GPIO_PSC6_0 - IRDA_RX) */
> +       int level_low = 0; /* wakeup on high level */
> +       /* IOW. to wake it up, short pins 1 and 3 on IRDA connector */
> +#else
> +#warning "define how would you like your board to wake"
> +#endif

The EFIKA and LITE5200 support needs to coexist.  efika.c and
lite5200.c should each have their own set_wakeup_mode function.  The
correct function pointer should be selected from *_setup_arch().

> +static struct pm_ops mpc52xx_pm_ops = {
> +       .valid          = mpc52xx_pm_valid,
> +       .prepare        = mpc52xx_pm_prepare,
> +       .enter          = mpc52xx_pm_enter,
> +       .finish         = mpc52xx_pm_finish,
> +};
> +
> +static int __init mpc52xx_pm_init(void)
> +{
> +       pm_set_ops(&mpc52xx_pm_ops);
> +       return 0;
> +}
> +
> +arch_initcall(mpc52xx_pm_init);

Adding a new arch_initcall is dangerous.  It gets called on *all*
architectures if the 5200 support is compiled in.  mp52xx_pm_init
should be called from the setup_arch hook; lite5200_setup_arch() &
efika_setup_arch()

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
