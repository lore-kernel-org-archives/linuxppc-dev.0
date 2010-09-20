Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id 8239BB6EF7
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Sep 2010 23:19:16 +1000 (EST)
Received: by eyg24 with SMTP id 24so2353888eyg.15
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Sep 2010 06:19:13 -0700 (PDT)
Date: Mon, 20 Sep 2010 17:19:07 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH 2/3 v4] P4080/mtd: Only make elbc nand driver detect
	nand flash partitions
Message-ID: <20100920131907.GA2184@oksana.dev.rtsoft.ru>
References: <1284706869-12555-1-git-send-email-tie-fei.zang@freescale.com>
	<1284706869-12555-2-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1284706869-12555-2-git-send-email-tie-fei.zang@freescale.com>
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

On Fri, Sep 17, 2010 at 03:01:08PM +0800, Roy Zang wrote:
[...]
> +static struct mutex fsl_elbc_nand_mutex;
> +
> +static int __devinit fsl_elbc_nand_probe(struct platform_device *dev)
>  {
> -	struct fsl_lbc_regs __iomem *lbc = ctrl->regs;
> +	struct fsl_lbc_regs __iomem *lbc;
>  	struct fsl_elbc_mtd *priv;
>  	struct resource res;
> +	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = NULL;

No need for = NULL.

[...]
> -	ctrl->chips[bank] = priv;
> +	mutex_init(&fsl_elbc_nand_mutex);

This may cause all sorts of misbehaviours, e.g.

A: mutex_init(foo)
A: mutex_lock(foo)
B: mutex_init(foo)   <- destroyed "A"-context mutex.
A: mutex_unlock(foo) <- oops

Instead of dynamically initializing the mutex, just define it
with DEFINE_MUTEX() above.

(Btw, #include <linux/mutex.h> is needed.)

> +
> +	mutex_lock(&fsl_elbc_nand_mutex);
[...]
> -static int __devinit fsl_elbc_ctrl_init(struct fsl_elbc_ctrl *ctrl)
> +static int fsl_elbc_nand_remove(struct platform_device *dev)
[...]
> +	struct fsl_elbc_fcm_ctrl *elbc_fcm_ctrl = fsl_lbc_ctrl_dev->nand;
[...]
> +		if (elbc_fcm_ctrl->chips[i])
> +			fsl_elbc_chip_remove(elbc_fcm_ctrl->chips[i]);
[...]
> +	fsl_lbc_ctrl_dev->nand = NULL;
> +	kfree(elbc_fcm_ctrl);

Will cause NULL dereference and/or use-after-free for other
elbc nand instances. To avoid that, reference counting for
elbc_fcm_ctrl is required.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
