Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f185.google.com (mail-yx0-f185.google.com
	[209.85.210.185]) by ozlabs.org (Postfix) with ESMTP id 086EBB7EF7
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 02:59:13 +1100 (EST)
Received: by yxe15 with SMTP id 15so2999720yxe.9
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jan 2010 07:59:11 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1264594052-20317-3-git-send-email-agust@denx.de>
References: <1264594052-20317-1-git-send-email-agust@denx.de>
	<1264594052-20317-3-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 27 Jan 2010 08:58:51 -0700
Message-ID: <fa686aa41001270758m349d77ecv6f9cba12e3f47cf4@mail.gmail.com>
Subject: Re: [PATCH 2/8 v2] rtc: Add MPC5121 Real time clock driver
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: wd@denx.de, rtc-linux@googlegroups.com, linuxppc-dev@ozlabs.org,
	dzu@denx.de, Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 27, 2010 at 5:07 AM, Anatolij Gustschin <agust@denx.de> wrote:
> From: John Rigby <jcrigby@gmail.com>

This is your patch now.  You can claim authorship in the git commit record.

> Based on Domen Puncer's rtc driver for 5200.
> Changes to Domen's original:
>
> =A0 =A0Changed filenames/routine names from mpc5200* to mpc5121*
> =A0 =A0Changed match to only care about compatible and use "fsl,"
> =A0 =A0convention for compatible.
>
> =A0 =A0Make alarms more sane by dealing with lack of second alarm
> =A0 =A0resolution.
>
> =A0 =A0Deal with the fact that most of the 5121 rtc registers are not
> =A0 =A0persistent across a reset even with a battery attached:
>
> =A0 =A0 =A0 =A0Use actual_time register for time keeping
> =A0 =A0 =A0 =A0and target_time register as an offset to linux time
>
> =A0 =A0 =A0 =A0The target_time register would normally be used for hibern=
ation
> =A0 =A0 =A0 =A0but hibernation does not work on current silicon

This is a description of what has been done, but it is not a
description of what the patch is.  Think about it this way, if someone
looks at your commit in git after it is merged, will the above text
make sense?

>
> Signed-off-by: John Rigby <jcrigby@gmail.com>
> Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: <rtc-linux@googlegroups.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: John Rigby <jcrigby@gmail.com>
> ---
> Changes since v1 (as requested by Alessandro Zummo):
> =A0- Remove history from the driver file, the same history is in
> =A0 commit message
> =A0- implement alarm/irq interface using ->ops structure, don't
> =A0 use ops->ioctl() any more
> =A0- Clean up probe()
> =A0- replace printk() by dev_*()
> =A0- add arch dependency in Kconfig
> =A0- add requested include linux/init.h
> =A0- move MODULE_XXX to the end
> =A0- use rtc_valid_tm() when returning 'tm'
> =A0- use __init/__exit/__exit_p as this is not a hotpluggable device

Dangerous.  You're assuming that drivers won't be able to be
bound/rebound at runtime.  The kernel has no idea you've done this,
and it will cause a bug.  You should always use
__devinit/__devexit/__devexit_p for the probe/remove hooks in
of_platform drivers.

> +static int __init mpc5121_rtc_probe(struct of_device *op,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 const struct of_device_id *match)

__devinit

> +{
> + =A0 =A0 =A0 struct mpc5121_rtc_data *rtc;
> + =A0 =A0 =A0 int err =3D 0;
> + =A0 =A0 =A0 u32 ka;
> +
> + =A0 =A0 =A0 rtc =3D kzalloc(sizeof(*rtc), GFP_KERNEL);
> + =A0 =A0 =A0 if (!rtc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 rtc->regs =3D of_iomap(op->node, 0);
> + =A0 =A0 =A0 if (!rtc->regs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "%s: couldn't map io spac=
e\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -ENOSYS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_free;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 device_init_wakeup(&op->dev, 1);
> +
> + =A0 =A0 =A0 rtc->rtc =3D rtc_device_register("mpc5121-rtc", &op->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 &mpc5121_rtc_ops, THIS_MODULE);
> + =A0 =A0 =A0 if (IS_ERR(rtc->rtc)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D PTR_ERR(rtc->rtc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_unmap;
> + =A0 =A0 =A0 }

I haven't dug into the rtc layer, but this looks racy.  The device is
getting registered before it is completely set up (irq not mapped,
keepalive register not initialized).  Is this correct?

> +
> + =A0 =A0 =A0 dev_set_drvdata(&op->dev, rtc);
> +
> + =A0 =A0 =A0 rtc->irq =3D irq_of_parse_and_map(op->node, 1);
> + =A0 =A0 =A0 err =3D request_irq(rtc->irq, mpc5121_rtc_handler, IRQF_DIS=
ABLED,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 "mpc5121-rtc", &op->dev);
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "%s: could not request ir=
q: %i\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, rtc->irq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_dispose;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 rtc->irq_periodic =3D irq_of_parse_and_map(op->node, 0);
> + =A0 =A0 =A0 err =3D request_irq(rtc->irq_periodic, mpc5121_rtc_handler_=
upd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_DISABL=
ED, "mpc5121-rtc_upd", &op->dev);
> + =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "%s: could not request ir=
q: %i\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 __func__, rtc->irq_periodic);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_dispose2;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ka =3D in_be32(&rtc->regs->keep_alive);
> + =A0 =A0 =A0 if (ka & 0x02) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&op->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "mpc5121-rtc: Battery or os=
cillator failure!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&rtc->regs->keep_alive, ka);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +
> +out_dispose2:
> + =A0 =A0 =A0 irq_dispose_mapping(rtc->irq_periodic);
> + =A0 =A0 =A0 free_irq(rtc->irq, &op->dev);
> +out_dispose:
> + =A0 =A0 =A0 irq_dispose_mapping(rtc->irq);
> +out_unmap:
> + =A0 =A0 =A0 iounmap(rtc->regs);
> +out_free:
> + =A0 =A0 =A0 kfree(rtc);
> +
> + =A0 =A0 =A0 return err;
> +}
> +
> +static int __exit mpc5121_rtc_remove(struct of_device *op)

__devexit

> +{
> + =A0 =A0 =A0 struct mpc5121_rtc_data *rtc =3D dev_get_drvdata(&op->dev);
> + =A0 =A0 =A0 struct mpc5121_rtc_regs __iomem *regs =3D rtc->regs;
> +
> + =A0 =A0 =A0 /* disable interrupt, so there are no nasty surprises */
> + =A0 =A0 =A0 out_8(&regs->alm_enable, 0);
> + =A0 =A0 =A0 out_8(&regs->int_enable, in_8(&regs->int_enable) & ~0x1);
> +
> + =A0 =A0 =A0 rtc_device_unregister(rtc->rtc);
> + =A0 =A0 =A0 iounmap(rtc->regs);
> + =A0 =A0 =A0 free_irq(rtc->irq, &op->dev);
> + =A0 =A0 =A0 free_irq(rtc->irq_periodic, &op->dev);
> + =A0 =A0 =A0 irq_dispose_mapping(rtc->irq);
> + =A0 =A0 =A0 irq_dispose_mapping(rtc->irq_periodic);
> + =A0 =A0 =A0 dev_set_drvdata(&op->dev, NULL);
> + =A0 =A0 =A0 kfree(rtc);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static struct of_device_id mpc5121_rtc_match[] =3D {

Missing __devinitdata.  Should be like this:

static struct of_device_id mpc5121_rtc_match[] __devinitdata =3D {

> + =A0 =A0 =A0 { .compatible =3D "fsl,mpc5121-rtc", },
> + =A0 =A0 =A0 {},
> +};
> +
> +static struct of_platform_driver mpc5121_rtc_driver =3D {
> + =A0 =A0 =A0 .owner =3D THIS_MODULE,
> + =A0 =A0 =A0 .name =3D "mpc5121-rtc",
> + =A0 =A0 =A0 .match_table =3D mpc5121_rtc_match,
> + =A0 =A0 =A0 .probe =3D mpc5121_rtc_probe,
> + =A0 =A0 =A0 .remove =3D __exit_p(mpc5121_rtc_remove),
> +};
> +
> +static int __init mpc5121_rtc_init(void)
> +{
> + =A0 =A0 =A0 return of_register_platform_driver(&mpc5121_rtc_driver);
> +}
> +module_init(mpc5121_rtc_init);
> +
> +static void __exit mpc5121_rtc_exit(void)
> +{
> + =A0 =A0 =A0 of_unregister_platform_driver(&mpc5121_rtc_driver);
> +}
> +module_exit(mpc5121_rtc_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("John Rigby <jcrigby@gmail.com>");
> --
> 1.5.6.3
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
