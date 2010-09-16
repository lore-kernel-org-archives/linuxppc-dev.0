Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id A89241007D8
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 18:21:47 +1000 (EST)
Received: by eyg24 with SMTP id 24so664315eyg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 01:21:45 -0700 (PDT)
Date: Thu, 16 Sep 2010 12:21:41 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH 2/3 v3] P4080/mtd: Only make elbc nand driver detect
	nand flash partitions
Message-ID: <20100916082141.GA10978@oksana.dev.rtsoft.ru>
References: <1284619284-23614-1-git-send-email-tie-fei.zang@freescale.com>
	<1284619284-23614-2-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1284619284-23614-2-git-send-email-tie-fei.zang@freescale.com>
Cc: B07421@freescale.com, dedekind1@gmail.com, B25806@freescale.com,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, dwmw2@infradead.org, B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 16, 2010 at 02:41:23PM +0800, Roy Zang wrote:
[...]
> -static int __devinit fsl_elbc_chip_probe(struct fsl_elbc_ctrl *ctrl,
> -                                      struct device_node *node)
> +/*
> + * Currently only one elbc probe is supported.
> + */
> +static int __devinit fsl_elbc_nand_probe(struct platform_device *dev)
>  {
> -     struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
> +     struct fsl_lbc_regs __iomem *lbc;
>       struct fsl_elbc_mtd *priv;
>       struct resource res;
> +     struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = NULL;
[...]
> -     ctrl->chips[bank] = priv;
> +     if (fsl_lbc_ctrl_dev->nand == NULL) {
> +             elbc_fcm_ctrl = kzalloc(sizeof(*elbc_fcm_ctrl), GFP_KERNEL);
> +             if (!elbc_fcm_ctrl) {
[...]
> +                     goto err;
> +             }
> +             fsl_lbc_ctrl_dev->nand = elbc_fcm_ctrl;
> +     }
> +
> +     elbc_fcm_ctrl->chips[bank] = priv;

Again, this will oops on the second probe. And you still don't
lock fsl_lbc_ctrl_dev->nand during check-then-assignment, so
with parallel probing there will be a race. :-(

We do have boards with several NAND chips (e.g.
arch/powerpc/boot/dts/mpc8610_hpcd.dts), so these issues
are all legitimate.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
