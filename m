Return-Path: <glikely@secretlab.ca>
Received: from mail-iw0-f182.google.com (mail-iw0-f182.google.com
	[209.85.223.182]) by ozlabs.org (Postfix) with ESMTP id DD974B7B7A
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2009 09:10:15 +1100 (EST)
Received: by iwn12 with SMTP id 12so4742274iwn.15
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Oct 2009 15:10:13 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091012155041.GA1071@oksana.dev.rtsoft.ru>
References: <20091012155041.GA1071@oksana.dev.rtsoft.ru>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 12 Oct 2009 15:09:53 -0700
Message-ID: <fa686aa40910121509n1b7dba87nbe9ddf34f0b4d7c@mail.gmail.com>
Subject: Re: [PATCH] of/platform: Implement support for dev_pm_ops
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-pm@lists.linux-foundation.org, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 12, 2009 at 8:50 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> Linux power management subsystem supports vast amount of new PM
> callbacks that are crucial for proper suspend and hibernation support
> in drivers.
>
> This patch implements support for dev_pm_ops, preserving support
> for legacy callbacks.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Hmmm...  I'm not very familiar with the PM callbacks, but change
doesn't look right to me.  In particular, a lot of these new hooks
don't do anything remotely of_platform bus specific.  For example,
of_platform_pm_prepare() checks if there is drv, drv->pm, and
drv->pm->prepare.  If all are true, then it calls drv->pm->prepare().
I see that the platform bus platform_pm_prepare() function is
absolutely identical.  I haven't looked, but I wouldn't be surprised
if other busses do the same.

I think these simple pm ops should be made library functions that
platform, of_platform and other simple busses can just populate their
pm ops structure with.

g.

> ---
> =A0drivers/of/platform.c | =A0305 +++++++++++++++++++++++++++++++++++++++=
+++++++---
> =A01 files changed, 290 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 298de0f..d58ade1 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -65,47 +65,322 @@ static int of_platform_device_remove(struct device *=
dev)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static int of_platform_device_suspend(struct device *dev, pm_message_t s=
tate)
> +static void of_platform_device_shutdown(struct device *dev)
> =A0{
> =A0 =A0 =A0 =A0struct of_device *of_dev =3D to_of_device(dev);
> =A0 =A0 =A0 =A0struct of_platform_driver *drv =3D to_of_platform_driver(d=
ev->driver);
> - =A0 =A0 =A0 int error =3D 0;
>
> - =A0 =A0 =A0 if (dev->driver && drv->suspend)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D drv->suspend(of_dev, state);
> - =A0 =A0 =A0 return error;
> + =A0 =A0 =A0 if (dev->driver && drv->shutdown)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv->shutdown(of_dev);
> =A0}
>
> -static int of_platform_device_resume(struct device * dev)
> +#ifdef CONFIG_PM_SLEEP
> +
> +static int of_platform_legacy_suspend(struct device *dev, pm_message_t m=
esg)
> =A0{
> =A0 =A0 =A0 =A0struct of_device *of_dev =3D to_of_device(dev);
> =A0 =A0 =A0 =A0struct of_platform_driver *drv =3D to_of_platform_driver(d=
ev->driver);
> - =A0 =A0 =A0 int error =3D 0;
> + =A0 =A0 =A0 int ret =3D 0;
>
> - =A0 =A0 =A0 if (dev->driver && drv->resume)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D drv->resume(of_dev);
> - =A0 =A0 =A0 return error;
> + =A0 =A0 =A0 if (dev->driver && drv->suspend)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->suspend(of_dev, mesg);
> + =A0 =A0 =A0 return ret;
> =A0}
>
> -static void of_platform_device_shutdown(struct device *dev)
> +static int of_platform_legacy_resume(struct device *dev)
> =A0{
> =A0 =A0 =A0 =A0struct of_device *of_dev =3D to_of_device(dev);
> =A0 =A0 =A0 =A0struct of_platform_driver *drv =3D to_of_platform_driver(d=
ev->driver);
> + =A0 =A0 =A0 int ret =3D 0;
>
> - =A0 =A0 =A0 if (dev->driver && drv->shutdown)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv->shutdown(of_dev);
> + =A0 =A0 =A0 if (dev->driver && drv->resume)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->resume(of_dev);
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int of_platform_pm_prepare(struct device *dev)
> +{
> + =A0 =A0 =A0 struct device_driver *drv =3D dev->driver;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (drv && drv->pm && drv->pm->prepare)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->pm->prepare(dev);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static void of_platform_pm_complete(struct device *dev)
> +{
> + =A0 =A0 =A0 struct device_driver *drv =3D dev->driver;
> +
> + =A0 =A0 =A0 if (drv && drv->pm && drv->pm->complete)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv->pm->complete(dev);
> +}
> +
> +#ifdef CONFIG_SUSPEND
> +
> +static int of_platform_pm_suspend(struct device *dev)
> +{
> + =A0 =A0 =A0 struct device_driver *drv =3D dev->driver;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (!drv)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (drv->pm) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drv->pm->suspend)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->pm->suspend(de=
v);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D of_platform_legacy_suspend(dev, PMS=
G_SUSPEND);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> =A0}
>
> +static int of_platform_pm_suspend_noirq(struct device *dev)
> +{
> + =A0 =A0 =A0 struct device_driver *drv =3D dev->driver;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (!drv)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (drv->pm) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drv->pm->suspend_noirq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->pm->suspend_no=
irq(dev);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int of_platform_pm_resume(struct device *dev)
> +{
> + =A0 =A0 =A0 struct device_driver *drv =3D dev->driver;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (!drv)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (drv->pm) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drv->pm->resume)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->pm->resume(dev=
);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D of_platform_legacy_resume(dev);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int of_platform_pm_resume_noirq(struct device *dev)
> +{
> + =A0 =A0 =A0 struct device_driver *drv =3D dev->driver;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (!drv)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (drv->pm) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drv->pm->resume_noirq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->pm->resume_noi=
rq(dev);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +#else /* !CONFIG_SUSPEND */
> +
> +#define of_platform_pm_suspend =A0 =A0 =A0 =A0 NULL
> +#define of_platform_pm_resume =A0 =A0 =A0 =A0 =A0NULL
> +#define of_platform_pm_suspend_noirq =A0 NULL
> +#define of_platform_pm_resume_noirq =A0 =A0NULL
> +
> +#endif /* !CONFIG_SUSPEND */
> +
> +#ifdef CONFIG_HIBERNATION
> +
> +static int of_platform_pm_freeze(struct device *dev)
> +{
> + =A0 =A0 =A0 struct device_driver *drv =3D dev->driver;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (!drv)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (drv->pm) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drv->pm->freeze)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->pm->freeze(dev=
);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D of_platform_legacy_suspend(dev, PMS=
G_FREEZE);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int of_platform_pm_freeze_noirq(struct device *dev)
> +{
> + =A0 =A0 =A0 struct device_driver *drv =3D dev->driver;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (!drv)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (drv->pm) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drv->pm->freeze_noirq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->pm->freeze_noi=
rq(dev);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int of_platform_pm_thaw(struct device *dev)
> +{
> + =A0 =A0 =A0 struct device_driver *drv =3D dev->driver;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (!drv)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (drv->pm) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drv->pm->thaw)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->pm->thaw(dev);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D of_platform_legacy_resume(dev);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int of_platform_pm_thaw_noirq(struct device *dev)
> +{
> + =A0 =A0 =A0 struct device_driver *drv =3D dev->driver;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (!drv)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (drv->pm) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drv->pm->thaw_noirq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->pm->thaw_noirq=
(dev);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int of_platform_pm_poweroff(struct device *dev)
> +{
> + =A0 =A0 =A0 struct device_driver *drv =3D dev->driver;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (!drv)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (drv->pm) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drv->pm->poweroff)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->pm->poweroff(d=
ev);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D of_platform_legacy_suspend(dev, PMS=
G_HIBERNATE);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int of_platform_pm_poweroff_noirq(struct device *dev)
> +{
> + =A0 =A0 =A0 struct device_driver *drv =3D dev->driver;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (!drv)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (drv->pm) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drv->pm->poweroff_noirq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->pm->poweroff_n=
oirq(dev);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int of_platform_pm_restore(struct device *dev)
> +{
> + =A0 =A0 =A0 struct device_driver *drv =3D dev->driver;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (!drv)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (drv->pm) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drv->pm->restore)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->pm->restore(de=
v);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D of_platform_legacy_resume(dev);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int of_platform_pm_restore_noirq(struct device *dev)
> +{
> + =A0 =A0 =A0 struct device_driver *drv =3D dev->driver;
> + =A0 =A0 =A0 int ret =3D 0;
> +
> + =A0 =A0 =A0 if (!drv)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 if (drv->pm) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drv->pm->restore_noirq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D drv->pm->restore_no=
irq(dev);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +#else /* !CONFIG_HIBERNATION */
> +
> +#define of_platform_pm_freeze =A0 =A0 =A0 =A0 =A0NULL
> +#define of_platform_pm_thaw =A0 =A0 =A0 =A0 =A0 =A0NULL
> +#define of_platform_pm_poweroff =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NULL
> +#define of_platform_pm_restore =A0 =A0 =A0 =A0 NULL
> +#define of_platform_pm_freeze_noirq =A0 =A0NULL
> +#define of_platform_pm_thaw_noirq =A0 =A0 =A0 =A0 =A0 =A0 =A0NULL
> +#define of_platform_pm_poweroff_noirq =A0NULL
> +#define of_platform_pm_restore_noirq =A0 NULL
> +
> +#endif /* !CONFIG_HIBERNATION */
> +
> +static struct dev_pm_ops of_platform_dev_pm_ops =3D {
> + =A0 =A0 =A0 .prepare =3D of_platform_pm_prepare,
> + =A0 =A0 =A0 .complete =3D of_platform_pm_complete,
> + =A0 =A0 =A0 .suspend =3D of_platform_pm_suspend,
> + =A0 =A0 =A0 .resume =3D of_platform_pm_resume,
> + =A0 =A0 =A0 .freeze =3D of_platform_pm_freeze,
> + =A0 =A0 =A0 .thaw =3D of_platform_pm_thaw,
> + =A0 =A0 =A0 .poweroff =3D of_platform_pm_poweroff,
> + =A0 =A0 =A0 .restore =3D of_platform_pm_restore,
> + =A0 =A0 =A0 .suspend_noirq =3D of_platform_pm_suspend_noirq,
> + =A0 =A0 =A0 .resume_noirq =3D of_platform_pm_resume_noirq,
> + =A0 =A0 =A0 .freeze_noirq =3D of_platform_pm_freeze_noirq,
> + =A0 =A0 =A0 .thaw_noirq =3D of_platform_pm_thaw_noirq,
> + =A0 =A0 =A0 .poweroff_noirq =3D of_platform_pm_poweroff_noirq,
> + =A0 =A0 =A0 .restore_noirq =3D of_platform_pm_restore_noirq,
> +};
> +
> +#define OF_PLATFORM_PM_OPS_PTR (&of_platform_dev_pm_ops)
> +
> +#else /* !CONFIG_PM_SLEEP */
> +
> +#define OF_PLATFORM_PM_OPS_PTR NULL
> +
> +#endif /* !CONFIG_PM_SLEEP */
> +
> =A0int of_bus_type_init(struct bus_type *bus, const char *name)
> =A0{
> =A0 =A0 =A0 =A0bus->name =3D name;
> =A0 =A0 =A0 =A0bus->match =3D of_platform_bus_match;
> =A0 =A0 =A0 =A0bus->probe =3D of_platform_device_probe;
> =A0 =A0 =A0 =A0bus->remove =3D of_platform_device_remove;
> - =A0 =A0 =A0 bus->suspend =3D of_platform_device_suspend;
> - =A0 =A0 =A0 bus->resume =3D of_platform_device_resume;
> =A0 =A0 =A0 =A0bus->shutdown =3D of_platform_device_shutdown;
> =A0 =A0 =A0 =A0bus->dev_attrs =3D of_platform_device_attrs;
> + =A0 =A0 =A0 bus->pm =3D OF_PLATFORM_PM_OPS_PTR;
> =A0 =A0 =A0 =A0return bus_register(bus);
> =A0}
>
> --
> 1.6.3.3
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
