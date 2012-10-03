Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id ADC5F2C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2012 23:36:07 +1000 (EST)
Subject: Re: [RFC PATCH] powerpc/fsl: add timer wakeup source
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1349260948-15828-1-git-send-email-dongsheng.wds@gmail.com>
Date: Wed, 3 Oct 2012 08:35:58 -0500
Message-Id: <6170650E-9D3C-4686-BF13-6C41DBFFB79D@kernel.crashing.org>
References: <1349260948-15828-1-git-send-email-dongsheng.wds@gmail.com>
To: Wang Dongsheng <dongsheng.wds@gmail.com>
Cc: Wood Scott-B07421 <b07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Wang Dongsheng <dongsheng.wang@freescale.com>, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 3, 2012, at 5:42 AM, Wang Dongsheng wrote:

> This is only for freescale powerpc platform. The driver provides a way
> to wake up system. Proc interface(/proc/powerpc/wakeup_timer_seconds).
>=20
> eg: "echo 5 > /proc/powerpc/wakeup_timer_seconds", 5 seconds
> after the system will be woken up. echo another time into proc =
interface
> to update the time.
>=20
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
> arch/powerpc/platforms/Kconfig            |   23 +++
> arch/powerpc/platforms/Makefile           |    1 +
> arch/powerpc/platforms/fsl_timer_wakeup.c |  217 =
+++++++++++++++++++++++++++++
> 3 files changed, 241 insertions(+)
> create mode 100644 arch/powerpc/platforms/fsl_timer_wakeup.c

Adding the Linux PM list to see if there is some existing support for =
this on other arch's in kernel.

I'm pretty sure /proc/ is NOT where we want this exposed.

- k

>=20
> diff --git a/arch/powerpc/platforms/Kconfig =
b/arch/powerpc/platforms/Kconfig
> index b190a6e..7b9232a 100644
> --- a/arch/powerpc/platforms/Kconfig
> +++ b/arch/powerpc/platforms/Kconfig
> @@ -99,6 +99,29 @@ config MPIC_TIMER
> 	  only tested on fsl chip, but it can potentially support
> 	  other global timers complying to Open-PIC standard.
>=20
> +menuconfig FSL_WAKEUP_SOURCE
> +	bool "Freescale wakeup source"
> +	depends on FSL_SOC && SUSPEND
> +	default n
> +	help
> +	  This option enables wakeup source for wake up system
> +	  features. This is only for freescale powerpc platform.
> +
> +if FSL_WAKEUP_SOURCE
> +
> +config FSL_TIMER_WAKEUP
> +	tristate "Freescale mpic global timer wakeup event"
> +	default n
> +	help
> +	  This is only for freescale powerpc platform. The driver
> +	  provides a way to wake up system.
> +	  Proc interface(/proc/powerpc/wakeup_timer_seconds).
> +	  eg: "echo 5 > /proc/powerpc/wakeup_timer_seconds",
> +	  5 seconds after the system will be woken up. echo another
> +	  time into proc interface to update the time.
> +
> +endif
> +
> config PPC_EPAPR_HV_PIC
> 	bool
> 	default n
> diff --git a/arch/powerpc/platforms/Makefile =
b/arch/powerpc/platforms/Makefile
> index 879b4a4..8e9a04f 100644
> --- a/arch/powerpc/platforms/Makefile
> +++ b/arch/powerpc/platforms/Makefile
> @@ -2,6 +2,7 @@
> subdir-ccflags-$(CONFIG_PPC_WERROR) :=3D -Werror
>=20
> obj-$(CONFIG_FSL_ULI1575)	+=3D fsl_uli1575.o
> +obj-$(CONFIG_FSL_TIMER_WAKEUP)	+=3D fsl_timer_wakeup.o
>=20
> obj-$(CONFIG_PPC_PMAC)		+=3D powermac/
> obj-$(CONFIG_PPC_CHRP)		+=3D chrp/
> diff --git a/arch/powerpc/platforms/fsl_timer_wakeup.c =
b/arch/powerpc/platforms/fsl_timer_wakeup.c
> new file mode 100644
> index 0000000..f20199f
> --- /dev/null
> +++ b/arch/powerpc/platforms/fsl_timer_wakeup.c
> @@ -0,0 +1,217 @@
> +/*
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + * Wang Dongsheng <Dongsheng.Wang@freescale.com>
> + * Li Yang <leoli@freescale.com>
> + *
> + * This is only for freescale powerpc platform. The driver provides a =
way
> + * to wake up system. Proc =
interface(/proc/powerpc/wakeup_timer_seconds).
> + *
> + * eg: "echo 5 > /proc/powerpc/wakeup_timer_seconds", 5 seconds
> + * after the system will be woken up. echo another time into proc =
interface
> + * to update the time.
> + *
> + * This program is free software; you can redistribute it and/or =
modify it
> + * under the terms of the GNU General Public License version 2 as =
published
> + * by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/errno.h>
> +#include <linux/fs.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/sysfs.h>
> +#include <linux/slab.h>
> +#include <linux/mutex.h>
> +#include <linux/pm.h>
> +#include <linux/proc_fs.h>
> +#include <asm/uaccess.h>
> +#include <asm/mpic_timer.h>
> +
> +struct fsl_timer_wakeup {
> +	struct mpic_timer *timer;
> +	struct work_struct free_work;
> +	struct mutex mutex;
> +	struct proc_dir_entry *proc_timer_wakeup;
> +	struct timeval time;
> +};
> +
> +static struct fsl_timer_wakeup *priv;
> +
> +static void timer_event_wakeup_free_work(struct work_struct *ws)
> +{
> +	struct fsl_timer_wakeup *priv =3D
> +		container_of(ws, struct fsl_timer_wakeup, free_work);
> +
> +	mutex_lock(&priv->mutex);
> +	mpic_free_timer(priv->timer);
> +	priv->timer =3D NULL;
> +	mutex_unlock(&priv->mutex);
> +}
> +
> +static irqreturn_t timer_event_interrupt(int irq, void *dev_id)
> +{
> +	struct fsl_timer_wakeup *priv =3D dev_id;
> +
> +	schedule_work(&priv->free_work);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static ssize_t timer_wakeup_read(struct file *file, char __user *buf,
> +		size_t count, loff_t *offp)
> +{
> +	struct fsl_timer_wakeup *priv;
> +	struct inode *inode =3D file->f_path.dentry->d_inode;
> +	struct proc_dir_entry *dp;
> +
> +	int ret;
> +	char *kbuf;
> +
> +	dp =3D PDE(inode);
> +	priv =3D dp->data;
> +
> +	mutex_lock(&priv->mutex);
> +
> +	if (!priv->timer ||
> +			(priv->time.tv_sec >=3D 0 && priv->time.tv_usec =
>=3D 0)) {
> +		priv->time.tv_sec =3D -1;
> +		priv->time.tv_usec =3D -1;
> +
> +		mutex_unlock(&priv->mutex);
> +
> +		return 0;
> +	}
> +
> +	mpic_get_remain_time(priv->timer, &priv->time);
> +
> +	mutex_unlock(&priv->mutex);
> +
> +	kbuf =3D kzalloc(count, GFP_KERNEL);
> +	if (!kbuf)
> +		return -ENOMEM;
> +
> +	sprintf(kbuf, "%ld\n%c", priv->time.tv_sec + 1, '\0');
> +
> +	ret =3D strlen(kbuf);
> +
> +	copy_to_user(buf, kbuf, count);
> +
> +	kfree(kbuf);
> +
> +	return ret;
> +}
> +
> +static ssize_t timer_wakeup_write(struct file *file, const char =
__user *buf,
> +		size_t count, loff_t *off)
> +{
> +	struct fsl_timer_wakeup *priv;
> +	struct inode *inode =3D file->f_path.dentry->d_inode;
> +	struct proc_dir_entry *dp;
> +	struct timeval time;
> +	char *kbuf;
> +
> +	dp =3D PDE(inode);
> +	priv =3D dp->data;
> +
> +	kbuf =3D kzalloc(count + 1, GFP_KERNEL);
> +	if (!kbuf)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(kbuf, buf, count)) {
> +		kfree(kbuf);
> +		return -EFAULT;
> +	}
> +
> +	kbuf[count] =3D '\0';
> +
> +	if (kstrtol(kbuf, 0, &time.tv_sec)) {
> +		kfree(kbuf);
> +		return -EINVAL;
> +	}
> +
> +	kfree(kbuf);
> +
> +	time.tv_usec =3D 0;
> +
> +	mutex_lock(&priv->mutex);
> +
> +	if (!time.tv_sec) {
> +		if (priv->timer) {
> +			mpic_free_timer(priv->timer);
> +			priv->timer =3D NULL;
> +		}
> +		mutex_unlock(&priv->mutex);
> +
> +		return count;
> +	}
> +
> +	if (priv->timer) {
> +		mpic_free_timer(priv->timer);
> +		priv->timer =3D NULL;
> +	}
> +
> +	priv->timer =3D mpic_request_timer(timer_event_interrupt, priv, =
&time);
> +	if (!priv->timer) {
> +		mutex_unlock(&priv->mutex);
> +
> +		return -EINVAL;
> +	}
> +
> +	mpic_start_timer(priv->timer);
> +
> +	mutex_unlock(&priv->mutex);
> +
> +	return count;
> +}
> +
> +static const struct file_operations timer_wakeup_fops =3D {
> +	.owner		=3D THIS_MODULE,
> +	.read		=3D timer_wakeup_read,
> +	.write		=3D timer_wakeup_write,
> +	.llseek		=3D no_llseek,
> +};
> +
> +static int timer_wakeup_init(void)
> +{
> +	struct proc_dir_entry *ent;
> +
> +	priv =3D kzalloc(sizeof(struct fsl_timer_wakeup), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	mutex_init(&priv->mutex);
> +	INIT_WORK(&priv->free_work, timer_event_wakeup_free_work);
> +	priv->time.tv_sec =3D -1;
> +	priv->time.tv_usec =3D -1;
> +
> +	ent =3D proc_create_data("powerpc/wakeup_timer_seconds",
> +			S_IRUSR | S_IWUSR, NULL, &timer_wakeup_fops, =
priv);
> +	if (!ent) {
> +		kfree(priv);
> +		return -ENOMEM;
> +	}
> +
> +	priv->proc_timer_wakeup =3D ent;
> +
> +	return 0;
> +}
> +
> +static void timer_wakeup_exit(void)
> +{
> +	if (priv->timer)
> +		mpic_free_timer(priv->timer);
> +
> +	remove_proc_entry("wakeup_timer_seconds",
> +			priv->proc_timer_wakeup->parent);
> +
> +	kfree(priv);
> +}
> +
> +module_init(timer_wakeup_init);
> +module_exit(timer_wakeup_exit);
> +
> +MODULE_DESCRIPTION("Freescale mpic global timer event wake-up =
driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Wang Dongsheng <dongsheng.wang@freescale.com>");
> --=20
> 1.7.9.5
