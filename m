Return-Path: <zch@az84smr01.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 093DC2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 20:01:54 +1000 (EST)
Received: from mail12-ch1 (localhost [127.0.0.1])	by mail12-ch1-R.bigfish.com
 (Postfix) with ESMTP id DB82F100139	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 14 Aug 2012 10:01:51 +0000 (UTC)
Received: from CH1EHSMHS036.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.253])	by mail12-ch1.bigfish.com (Postfix) with ESMTP id
 DAFC280283
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 10:01:34 +0000 (UTC)
Received: from localhost.localdomain ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q7EA1VDP021400	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 03:01:31 -0700
Date: Tue, 14 Aug 2012 18:01:41 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 2/4] fsl_pmc: Add API to enable device as wakeup event
 source
Message-ID: <20120814100141.GB21028@localhost.localdomain>
References: <1344329006-10645-1-git-send-email-chenhui.zhao@freescale.com>
 <1344329006-10645-2-git-send-email-chenhui.zhao@freescale.com>
 <CAOZdJXXdgS5x2ZkuXb4wHckdqLzSM2xy-eYU3+28d_=JH3euxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAOZdJXXdgS5x2ZkuXb4wHckdqLzSM2xy-eYU3+28d_=JH3euxg@mail.gmail.com>
Sender: <zch@az84smr01.freescale.net>
Cc: Li Yang-R58472 <r58472@freescale.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Aug 11, 2012 at 08:19:43AM -0500, Tabi Timur-B04825 wrote:
> On Tue, Aug 7, 2012 at 3:43 AM, Zhao Chenhui <chenhui.zhao@freescale.com> wrote:
> 
> > +int mpc85xx_pmc_set_wake(struct device *dev, bool enable)
> > +{
> > +       int ret = 0;
> > +       struct device_node *clk_np;
> > +       const u32 *prop;
> > +       u32 pmcdr_mask;
> > +
> > +       if (!pmc_regs) {
> > +               pr_err("%s: PMC is unavailable\n", __func__);
> 
> You have a 'struct device', so please use dev_err instead.
> 
> > +               return -ENODEV;
> > +       }
> > +
> > +       if (enable && !device_may_wakeup(dev))
> > +               return -EINVAL;
> > +
> > +       clk_np = of_parse_phandle(dev->of_node, "fsl,pmc-handle", 0);
> > +       if (!clk_np)
> > +               return -EINVAL;
> > +
> > +       prop = of_get_property(clk_np, "fsl,pmcdr-mask", NULL);
> > +       if (!prop) {
> > +               ret = -EINVAL;
> > +               goto out;
> > +       }
> > +       pmcdr_mask = be32_to_cpup(prop);
> > +
> > +       if (enable)
> > +               /* clear to enable clock in low power mode */
> > +               clrbits32(&pmc_regs->pmcdr, pmcdr_mask);
> > +       else
> > +               setbits32(&pmc_regs->pmcdr, pmcdr_mask);
> > +
> > +out:
> > +       of_node_put(clk_np);
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(mpc85xx_pmc_set_wake);
> 
> Use EXPORT_SYMBOL, not EXPORT_SYMBOL_GPL.
> 
> > +
> > +/**
> > + * mpc85xx_pmc_set_lossless_ethernet - enable lossless ethernet
> > + * in (deep) sleep mode
> > + * @enable: True to enable event generation; false to disable
> > + */
> > +void mpc85xx_pmc_set_lossless_ethernet(int enable)
> 
> Should this be 'bool enable'?
> 
> > @@ -21,6 +22,17 @@ struct device_node;
> >
> >  extern void fsl_rstcr_restart(char *cmd);
> >
> > +#ifdef CONFIG_FSL_PMC
> > +extern int mpc85xx_pmc_set_wake(struct device *dev, bool enable);
> > +extern void mpc85xx_pmc_set_lossless_ethernet(int enable);
> 
> Don't use 'extern' for functions.
> 

Why? I think there is no difference.

-Chenhui
