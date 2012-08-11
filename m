Return-Path: <B04825@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BE41A2C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Aug 2012 23:19:50 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Zhao Chenhui-B35336 <B35336@freescale.com>
Subject: Re: [PATCH 2/4] fsl_pmc: Add API to enable device as wakeup event
 source
Date: Sat, 11 Aug 2012 13:19:43 +0000
Message-ID: <CAOZdJXXdgS5x2ZkuXb4wHckdqLzSM2xy-eYU3+28d_=JH3euxg@mail.gmail.com>
References: <1344329006-10645-1-git-send-email-chenhui.zhao@freescale.com>
 <1344329006-10645-2-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1344329006-10645-2-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Li Yang-R58472 <r58472@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 7, 2012 at 3:43 AM, Zhao Chenhui <chenhui.zhao@freescale.com> w=
rote:

> +int mpc85xx_pmc_set_wake(struct device *dev, bool enable)
> +{
> +       int ret =3D 0;
> +       struct device_node *clk_np;
> +       const u32 *prop;
> +       u32 pmcdr_mask;
> +
> +       if (!pmc_regs) {
> +               pr_err("%s: PMC is unavailable\n", __func__);

You have a 'struct device', so please use dev_err instead.

> +               return -ENODEV;
> +       }
> +
> +       if (enable && !device_may_wakeup(dev))
> +               return -EINVAL;
> +
> +       clk_np =3D of_parse_phandle(dev->of_node, "fsl,pmc-handle", 0);
> +       if (!clk_np)
> +               return -EINVAL;
> +
> +       prop =3D of_get_property(clk_np, "fsl,pmcdr-mask", NULL);
> +       if (!prop) {
> +               ret =3D -EINVAL;
> +               goto out;
> +       }
> +       pmcdr_mask =3D be32_to_cpup(prop);
> +
> +       if (enable)
> +               /* clear to enable clock in low power mode */
> +               clrbits32(&pmc_regs->pmcdr, pmcdr_mask);
> +       else
> +               setbits32(&pmc_regs->pmcdr, pmcdr_mask);
> +
> +out:
> +       of_node_put(clk_np);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(mpc85xx_pmc_set_wake);

Use EXPORT_SYMBOL, not EXPORT_SYMBOL_GPL.

> +
> +/**
> + * mpc85xx_pmc_set_lossless_ethernet - enable lossless ethernet
> + * in (deep) sleep mode
> + * @enable: True to enable event generation; false to disable
> + */
> +void mpc85xx_pmc_set_lossless_ethernet(int enable)

Should this be 'bool enable'?

> @@ -21,6 +22,17 @@ struct device_node;
>
>  extern void fsl_rstcr_restart(char *cmd);
>
> +#ifdef CONFIG_FSL_PMC
> +extern int mpc85xx_pmc_set_wake(struct device *dev, bool enable);
> +extern void mpc85xx_pmc_set_lossless_ethernet(int enable);

Don't use 'extern' for functions.

--=20
Timur Tabi
Linux kernel developer at Freescale=
