Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
	[209.85.211.181]) by ozlabs.org (Postfix) with ESMTP id 9C089B7D76
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 13:39:56 +1100 (EST)
Received: by ywh11 with SMTP id 11so167238ywh.9
	for <linuxppc-dev@ozlabs.org>; Tue, 09 Feb 2010 18:39:55 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1265377377-29327-4-git-send-email-agust@denx.de>
References: <1265377377-29327-1-git-send-email-agust@denx.de>
	<1265377377-29327-4-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 9 Feb 2010 19:39:35 -0700
Message-ID: <fa686aa41002091839p7586402ev6fce676bd01b2180@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] rtc: Add MPC5121 Real time clock driver
To: Anatolij Gustschin <agust@denx.de>,
	Alessandro Zummo <alessandro.zummo@towertech.it>
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

On Fri, Feb 5, 2010 at 6:42 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Add support for MPC5121 real time clock module.
>
> Signed-off-by: John Rigby <jcrigby@gmail.com>
> Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> Cc: <rtc-linux@googlegroups.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: John Rigby <jcrigby@gmail.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Alessandro, do you want me to carry this one in my powerpc tree along
with the rest of the 5121 patches, or do you want to carry it?  There
aren't any commit ordering issues on this one.

g.

> ---
>
> Changes since v2:
> =A0- change commit message to describe what the patch is
> =A0- use __devinit/__devexit/__devexit_p for the probe/remove hooks
> =A0 and __devinitdata for the match table
> =A0- register device after it is completely set up
>
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
>
> =A0drivers/rtc/Kconfig =A0 =A0 =A0 | =A0 10 ++
> =A0drivers/rtc/Makefile =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/rtc/rtc-mpc5121.c | =A0387 +++++++++++++++++++++++++++++++++++=
++++++++++
> =A03 files changed, 398 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/rtc/rtc-mpc5121.c
>
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 8167e9e..2bb8a8b 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -868,4 +868,14 @@ config RTC_DRV_MC13783
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0This enables support for the Freescale MC13783 PMIC RT=
C
>
> +config RTC_DRV_MPC5121
> + =A0 =A0 =A0 tristate "Freescale MPC5121 built-in RTC"
> + =A0 =A0 =A0 depends on PPC_MPC512x && RTC_CLASS
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 If you say yes here you will get support for the
> + =A0 =A0 =A0 =A0 built-in RTC MPC5121.
> +
> + =A0 =A0 =A0 =A0 This driver can also be built as a module. If so, the m=
odule
> + =A0 =A0 =A0 =A0 will be called rtc-mpc5121.
> +
> =A0endif # RTC_CLASS
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index e5160fd..b7148af 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_RTC_DRV_MAX6900) +=3D rtc-max6900.o
> =A0obj-$(CONFIG_RTC_DRV_MAX6902) =A0+=3D rtc-max6902.o
> =A0obj-$(CONFIG_RTC_DRV_MC13783) =A0+=3D rtc-mc13783.o
> =A0obj-$(CONFIG_RTC_DRV_MSM6242) =A0+=3D rtc-msm6242.o
> +obj-$(CONFIG_RTC_DRV_MPC5121) =A0+=3D rtc-mpc5121.o
> =A0obj-$(CONFIG_RTC_DRV_MV) =A0 =A0 =A0 +=3D rtc-mv.o
> =A0obj-$(CONFIG_RTC_DRV_NUC900) =A0 +=3D rtc-nuc900.o
> =A0obj-$(CONFIG_RTC_DRV_OMAP) =A0 =A0 +=3D rtc-omap.o
> diff --git a/drivers/rtc/rtc-mpc5121.c b/drivers/rtc/rtc-mpc5121.c
> new file mode 100644
> index 0000000..4313ca0
> --- /dev/null
> +++ b/drivers/rtc/rtc-mpc5121.c
> @@ -0,0 +1,387 @@
> +/*
> + * Real-time clock driver for MPC5121
> + *
> + * Copyright 2007, Domen Puncer <domen.puncer@telargo.com>
> + * Copyright 2008, Freescale Semiconductor, Inc. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/rtc.h>
> +#include <linux/of_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/io.h>
> +
> +struct mpc5121_rtc_regs {
> + =A0 =A0 =A0 u8 set_time; =A0 =A0 =A0 =A0 =A0 =A0/* RTC + 0x00 */
> + =A0 =A0 =A0 u8 hour_set; =A0 =A0 =A0 =A0 =A0 =A0/* RTC + 0x01 */
> + =A0 =A0 =A0 u8 minute_set; =A0 =A0 =A0 =A0 =A0/* RTC + 0x02 */
> + =A0 =A0 =A0 u8 second_set; =A0 =A0 =A0 =A0 =A0/* RTC + 0x03 */
> +
> + =A0 =A0 =A0 u8 set_date; =A0 =A0 =A0 =A0 =A0 =A0/* RTC + 0x04 */
> + =A0 =A0 =A0 u8 month_set; =A0 =A0 =A0 =A0 =A0 /* RTC + 0x05 */
> + =A0 =A0 =A0 u8 weekday_set; =A0 =A0 =A0 =A0 /* RTC + 0x06 */
> + =A0 =A0 =A0 u8 date_set; =A0 =A0 =A0 =A0 =A0 =A0/* RTC + 0x07 */
> +
> + =A0 =A0 =A0 u8 write_sw; =A0 =A0 =A0 =A0 =A0 =A0/* RTC + 0x08 */
> + =A0 =A0 =A0 u8 sw_set; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* RTC + 0x09 */
> + =A0 =A0 =A0 u16 year_set; =A0 =A0 =A0 =A0 =A0 /* RTC + 0x0a */
> +
> + =A0 =A0 =A0 u8 alm_enable; =A0 =A0 =A0 =A0 =A0/* RTC + 0x0c */
> + =A0 =A0 =A0 u8 alm_hour_set; =A0 =A0 =A0 =A0/* RTC + 0x0d */
> + =A0 =A0 =A0 u8 alm_min_set; =A0 =A0 =A0 =A0 /* RTC + 0x0e */
> + =A0 =A0 =A0 u8 int_enable; =A0 =A0 =A0 =A0 =A0/* RTC + 0x0f */
> +
> + =A0 =A0 =A0 u8 reserved1;
> + =A0 =A0 =A0 u8 hour; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* RTC + 0x11 */
> + =A0 =A0 =A0 u8 minute; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* RTC + 0x12 */
> + =A0 =A0 =A0 u8 second; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* RTC + 0x13 */
> +
> + =A0 =A0 =A0 u8 month; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* RTC + 0x14 */
> + =A0 =A0 =A0 u8 wday_mday; =A0 =A0 =A0 =A0 =A0 /* RTC + 0x15 */
> + =A0 =A0 =A0 u16 year; =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* RTC + 0x16 */
> +
> + =A0 =A0 =A0 u8 int_alm; =A0 =A0 =A0 =A0 =A0 =A0 /* RTC + 0x18 */
> + =A0 =A0 =A0 u8 int_sw; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* RTC + 0x19 */
> + =A0 =A0 =A0 u8 alm_status; =A0 =A0 =A0 =A0 =A0/* RTC + 0x1a */
> + =A0 =A0 =A0 u8 sw_minute; =A0 =A0 =A0 =A0 =A0 /* RTC + 0x1b */
> +
> + =A0 =A0 =A0 u8 bus_error_1; =A0 =A0 =A0 =A0 /* RTC + 0x1c */
> + =A0 =A0 =A0 u8 int_day; =A0 =A0 =A0 =A0 =A0 =A0 /* RTC + 0x1d */
> + =A0 =A0 =A0 u8 int_min; =A0 =A0 =A0 =A0 =A0 =A0 /* RTC + 0x1e */
> + =A0 =A0 =A0 u8 int_sec; =A0 =A0 =A0 =A0 =A0 =A0 /* RTC + 0x1f */
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* target_time:
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0intended to be used for hibernation but hib=
ernation
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0does not work on silicon rev 1.5 so use it =
for non-volatile
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0storage of offset between the actual_time r=
egister and linux
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0time
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 u32 target_time; =A0 =A0 =A0 =A0/* RTC + 0x20 */
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* actual_time:
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0readonly time since VBAT_RTC was last conne=
cted
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 u32 actual_time; =A0 =A0 =A0 =A0/* RTC + 0x24 */
> + =A0 =A0 =A0 u32 keep_alive; =A0 =A0 =A0 =A0 /* RTC + 0x28 */
> +};
> +
> +struct mpc5121_rtc_data {
> + =A0 =A0 =A0 unsigned irq;
> + =A0 =A0 =A0 unsigned irq_periodic;
> + =A0 =A0 =A0 struct mpc5121_rtc_regs __iomem *regs;
> + =A0 =A0 =A0 struct rtc_device *rtc;
> + =A0 =A0 =A0 struct rtc_wkalrm wkalarm;
> +};
> +
> +/*
> + * Update second/minute/hour registers.
> + *
> + * This is just so alarm will work.
> + */
> +static void mpc5121_rtc_update_smh(struct mpc5121_rtc_regs __iomem *regs=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stru=
ct rtc_time *tm)
> +{
> + =A0 =A0 =A0 out_8(&regs->second_set, tm->tm_sec);
> + =A0 =A0 =A0 out_8(&regs->minute_set, tm->tm_min);
> + =A0 =A0 =A0 out_8(&regs->hour_set, tm->tm_hour);
> +
> + =A0 =A0 =A0 /* set time sequence */
> + =A0 =A0 =A0 out_8(&regs->set_time, 0x1);
> + =A0 =A0 =A0 out_8(&regs->set_time, 0x3);
> + =A0 =A0 =A0 out_8(&regs->set_time, 0x1);
> + =A0 =A0 =A0 out_8(&regs->set_time, 0x0);
> +}
> +
> +static int mpc5121_rtc_read_time(struct device *dev, struct rtc_time *tm=
)
> +{
> + =A0 =A0 =A0 struct mpc5121_rtc_data *rtc =3D dev_get_drvdata(dev);
> + =A0 =A0 =A0 struct mpc5121_rtc_regs __iomem *regs =3D rtc->regs;
> + =A0 =A0 =A0 unsigned long now;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* linux time is actual_time plus the offset saved in tar=
get_time
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 now =3D in_be32(&regs->actual_time) + in_be32(&regs->target=
_time);
> +
> + =A0 =A0 =A0 rtc_time_to_tm(now, tm);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* update second minute hour registers
> + =A0 =A0 =A0 =A0* so alarms will work
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 mpc5121_rtc_update_smh(regs, tm);
> +
> + =A0 =A0 =A0 return rtc_valid_tm(tm);
> +}
> +
> +static int mpc5121_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> + =A0 =A0 =A0 struct mpc5121_rtc_data *rtc =3D dev_get_drvdata(dev);
> + =A0 =A0 =A0 struct mpc5121_rtc_regs __iomem *regs =3D rtc->regs;
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 unsigned long now;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* The actual_time register is read only so we write the =
offset
> + =A0 =A0 =A0 =A0* between it and linux time to the target_time register.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 ret =3D rtc_tm_to_time(tm, &now);
> + =A0 =A0 =A0 if (ret =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(&regs->target_time, now - in_be32(=
&regs->actual_time));
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* update second minute hour registers
> + =A0 =A0 =A0 =A0* so alarms will work
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 mpc5121_rtc_update_smh(regs, tm);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int mpc5121_rtc_read_alarm(struct device *dev, struct rtc_wkalrm =
*alarm)
> +{
> + =A0 =A0 =A0 struct mpc5121_rtc_data *rtc =3D dev_get_drvdata(dev);
> + =A0 =A0 =A0 struct mpc5121_rtc_regs __iomem *regs =3D rtc->regs;
> +
> + =A0 =A0 =A0 *alarm =3D rtc->wkalarm;
> +
> + =A0 =A0 =A0 alarm->pending =3D in_8(&regs->alm_status);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int mpc5121_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *=
alarm)
> +{
> + =A0 =A0 =A0 struct mpc5121_rtc_data *rtc =3D dev_get_drvdata(dev);
> + =A0 =A0 =A0 struct mpc5121_rtc_regs __iomem *regs =3D rtc->regs;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* the alarm has no seconds so deal with it
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (alarm->time.tm_sec) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 alarm->time.tm_sec =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 alarm->time.tm_min++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (alarm->time.tm_min >=3D 60) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 alarm->time.tm_min =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 alarm->time.tm_hour++;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (alarm->time.tm_hour >=
=3D 24)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 alarm->time=
.tm_hour =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 alarm->time.tm_mday =3D -1;
> + =A0 =A0 =A0 alarm->time.tm_mon =3D -1;
> + =A0 =A0 =A0 alarm->time.tm_year =3D -1;
> +
> + =A0 =A0 =A0 out_8(&regs->alm_min_set, alarm->time.tm_min);
> + =A0 =A0 =A0 out_8(&regs->alm_hour_set, alarm->time.tm_hour);
> +
> + =A0 =A0 =A0 out_8(&regs->alm_enable, alarm->enabled);
> +
> + =A0 =A0 =A0 rtc->wkalarm =3D *alarm;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static irqreturn_t mpc5121_rtc_handler(int irq, void *dev)
> +{
> + =A0 =A0 =A0 struct mpc5121_rtc_data *rtc =3D dev_get_drvdata((struct de=
vice *)dev);
> + =A0 =A0 =A0 struct mpc5121_rtc_regs __iomem *regs =3D rtc->regs;
> +
> + =A0 =A0 =A0 if (in_8(&regs->int_alm)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* acknowledge and clear status */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->int_alm, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->alm_status, 1);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtc_update_irq(rtc->rtc, 1, RTC_IRQF | RTC_=
AF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return IRQ_NONE;
> +}
> +
> +static irqreturn_t mpc5121_rtc_handler_upd(int irq, void *dev)
> +{
> + =A0 =A0 =A0 struct mpc5121_rtc_data *rtc =3D dev_get_drvdata((struct de=
vice *)dev);
> + =A0 =A0 =A0 struct mpc5121_rtc_regs __iomem *regs =3D rtc->regs;
> +
> + =A0 =A0 =A0 if (in_8(&regs->int_sec) && (in_8(&regs->int_enable) & 0x1)=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* acknowledge */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_8(&regs->int_sec, 1);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rtc_update_irq(rtc->rtc, 1, RTC_IRQF | RTC_=
UF);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return IRQ_NONE;
> +}
> +
> +static int mpc5121_rtc_alarm_irq_enable(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 unsigned int enabled)
> +{
> + =A0 =A0 =A0 struct mpc5121_rtc_data *rtc =3D dev_get_drvdata(dev);
> + =A0 =A0 =A0 struct mpc5121_rtc_regs __iomem *regs =3D rtc->regs;
> + =A0 =A0 =A0 int val;
> +
> + =A0 =A0 =A0 if (enabled)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D 1;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D 0;
> +
> + =A0 =A0 =A0 out_8(&regs->alm_enable, val);
> + =A0 =A0 =A0 rtc->wkalarm.enabled =3D val;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int mpc5121_rtc_update_irq_enable(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0unsigned int enabled)
> +{
> + =A0 =A0 =A0 struct mpc5121_rtc_data *rtc =3D dev_get_drvdata(dev);
> + =A0 =A0 =A0 struct mpc5121_rtc_regs __iomem *regs =3D rtc->regs;
> + =A0 =A0 =A0 int val;
> +
> + =A0 =A0 =A0 val =3D in_8(&regs->int_enable);
> +
> + =A0 =A0 =A0 if (enabled)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D (val & ~0x8) | 0x1;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val &=3D ~0x1;
> +
> + =A0 =A0 =A0 out_8(&regs->int_enable, val);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static const struct rtc_class_ops mpc5121_rtc_ops =3D {
> + =A0 =A0 =A0 .read_time =3D mpc5121_rtc_read_time,
> + =A0 =A0 =A0 .set_time =3D mpc5121_rtc_set_time,
> + =A0 =A0 =A0 .read_alarm =3D mpc5121_rtc_read_alarm,
> + =A0 =A0 =A0 .set_alarm =3D mpc5121_rtc_set_alarm,
> + =A0 =A0 =A0 .alarm_irq_enable =3D mpc5121_rtc_alarm_irq_enable,
> + =A0 =A0 =A0 .update_irq_enable =3D mpc5121_rtc_update_irq_enable,
> +};
> +
> +static int __devinit mpc5121_rtc_probe(struct of_device *op,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 const struct of_device_id *match)
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
> + =A0 =A0 =A0 rtc->rtc =3D rtc_device_register("mpc5121-rtc", &op->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 &mpc5121_rtc_ops, THIS_MODULE);
> + =A0 =A0 =A0 if (IS_ERR(rtc->rtc)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D PTR_ERR(rtc->rtc);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_free_irq;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +
> +out_free_irq:
> + =A0 =A0 =A0 free_irq(rtc->irq_periodic, &op->dev);
> +out_dispose2:
> + =A0 =A0 =A0 irq_dispose_mapping(rtc->irq_periodic);
> + =A0 =A0 =A0 free_irq(rtc->irq, &op->dev);
> +out_dispose:
> + =A0 =A0 =A0 irq_dispose_mapping(rtc->irq);
> + =A0 =A0 =A0 iounmap(rtc->regs);
> +out_free:
> + =A0 =A0 =A0 kfree(rtc);
> +
> + =A0 =A0 =A0 return err;
> +}
> +
> +static int __devexit mpc5121_rtc_remove(struct of_device *op)
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
> +static struct of_device_id mpc5121_rtc_match[] __devinitdata =3D {
> + =A0 =A0 =A0 { .compatible =3D "fsl,mpc5121-rtc", },
> + =A0 =A0 =A0 {},
> +};
> +
> +static struct of_platform_driver mpc5121_rtc_driver =3D {
> + =A0 =A0 =A0 .owner =3D THIS_MODULE,
> + =A0 =A0 =A0 .name =3D "mpc5121-rtc",
> + =A0 =A0 =A0 .match_table =3D mpc5121_rtc_match,
> + =A0 =A0 =A0 .probe =3D mpc5121_rtc_probe,
> + =A0 =A0 =A0 .remove =3D __devexit_p(mpc5121_rtc_remove),
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
> 1.6.3.3
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
