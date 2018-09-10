Return-Path: <ran.wang_1@nxp.com>
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40045.outbound.protection.outlook.com [40.107.4.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 427tm15gR7zF37m
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2018 13:27:58 +1000 (AEST)
From: Ran Wang <ran.wang_1@nxp.com>
To: "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Leo Li <leoyang.li@nxp.com>, Rob
 Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
Subject: RE: [PATCH 1/3] soc: fsl: add Platform PM driver QorIQ platforms
Date: Mon, 10 Sep 2018 03:27:51 +0000
Message-ID: <AM5PR0402MB28658124F24A83D8715F9C6DF1050@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
 <366f03eab44e489b9fef82fb8e8f3c3b@HXTBJIDCEMVIW02.hxtcorp.net>
 <AM5PR0402MB2865774C03981F9808AB3A13F1000@AM5PR0402MB2865.eurprd04.prod.outlook.com>
 <35f171989af34850bd192c2b4de9b43b@HXTBJIDCEMVIW02.hxtcorp.net>
In-Reply-To: <35f171989af34850bd192c2b4de9b43b@HXTBJIDCEMVIW02.hxtcorp.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Dongsheng,

On 2018/9/7 18:16, Dongsheng Wang wrote:
>=20
> On 2018/9/7 16:49, Ran Wang wrote:
> > Hi Dongsheng
> >
> >> On 2018/9/5 11:05, Dongsheng Wang wrote:
> >>
> >> Please change your comments style.
> >>
> >> On 2018/8/31 11:57, Ran Wang wrote:
> >>> This driver is to provide a independent framework for PM service
> >>> provider and consumer to configure system level wake up feature. For
> >>> example, RCPM driver could register a callback function on this
> >>> platform first, and Flex timer driver who want to enable timer wake
> >>> up feature, will call generic API provided by this platform driver,
> >>> and then it will trigger RCPM driver to do it. The benefit is to
> >>> isolate the user and service, such as flex timer driver will not
> >>> have to know the implement details of wakeup function it require.
> >>> Besides, it is also easy for service side to upgrade its logic when
> >>> design is changed and remain user side unchanged.
> >>>
> >>> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> >>> ---
> >>>  drivers/soc/fsl/Kconfig   |   14 +++++
> >>>  drivers/soc/fsl/Makefile  |    1 +
> >>>  drivers/soc/fsl/plat_pm.c |  144
> >> +++++++++++++++++++++++++++++++++++++++++++++
> >>>  include/soc/fsl/plat_pm.h |   22 +++++++
> >>>  4 files changed, 181 insertions(+), 0 deletions(-)  create mode
> >>> 100644 drivers/soc/fsl/plat_pm.c  create mode 100644
> >>> include/soc/fsl/plat_pm.h
> >>>
> >>> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig index
> >>> 7a9fb9b..6517412 100644
> >>> --- a/drivers/soc/fsl/Kconfig
> >>> +++ b/drivers/soc/fsl/Kconfig
> >>> @@ -16,3 +16,17 @@ config FSL_GUTS
> >>>  	  Initially only reading SVR and registering soc device are support=
ed.
> >>>  	  Other guts accesses, such as reading RCW, should eventually be
> >> moved
> >>>  	  into this driver as well.
> >>> +
> >>> +config FSL_PLAT_PM
> >>> +	bool "Freescale platform PM framework"
> >>> +	help
> >>> +	  This driver is to provide a independent framework for PM service
> >>> +	  provider and consumer to configure system level wake up feature.
> >> For
> >>> +	  example, RCPM driver could register a callback function on this
> >>> +	  platform first, and Flex timer driver who want to enable timer wa=
ke
> >>> +	  up feature, will call generic API provided by this platform drive=
r,
> >>> +	  and then it will trigger RCPM driver to do it. The benefit is to
> >>> +	  isolate the user and service, such as  flex timer driver will not
> >>> +	  have to know the implement details of wakeup function it require.
> >>> +	  Besides, it is also easy for service side to upgrade its logic wh=
en
> >>> +	  design changed and remain user side unchanged.
> >>> diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
> >>> index
> >>> 44b3beb..8f9db23 100644
> >>> --- a/drivers/soc/fsl/Makefile
> >>> +++ b/drivers/soc/fsl/Makefile
> >>> @@ -6,3 +6,4 @@ obj-$(CONFIG_FSL_DPAA)                 +=3D qbman/
> >>>  obj-$(CONFIG_QUICC_ENGINE)		+=3D qe/
> >>>  obj-$(CONFIG_CPM)			+=3D qe/
> >>>  obj-$(CONFIG_FSL_GUTS)			+=3D guts.o
> >>> +obj-$(CONFIG_FSL_PLAT_PM)	+=3D plat_pm.o
> >>> diff --git a/drivers/soc/fsl/plat_pm.c b/drivers/soc/fsl/plat_pm.c
> >>> new file mode 100644 index 0000000..19ea14e
> >>> --- /dev/null
> >>> +++ b/drivers/soc/fsl/plat_pm.c
> >>> @@ -0,0 +1,144 @@
> >>> +// SPDX-License-Identifier: GPL-2.0 // // plat_pm.c - Freescale
> >>> +platform PM framework // // Copyright 2018 NXP // // Author: Ran
> >>> +Wang <ran.wang_1@nxp.com>,
> >>> +
> >>> +#include <linux/kernel.h>
> >>> +#include <linux/device.h>
> >>> +#include <linux/list.h>
> >>> +#include <linux/slab.h>
> >>> +#include <linux/err.h>
> >>> +#include <soc/fsl/plat_pm.h>
> >>> +
> >>> +
> >>> +struct plat_pm_t {
> >>> +	struct list_head node;
> >>> +	fsl_plat_pm_handle handle;
> >>> +	void *handle_priv;
> >>> +	spinlock_t	lock;
> >>> +};
> >>> +
> >>> +static struct plat_pm_t plat_pm;
> >>> +
> >>> +// register_fsl_platform_wakeup_source - Register callback function
> >>> +to plat_pm // @handle: Pointer to handle PM feature requirement //
> >>> +@handle_priv: Handler specific data struct // // Return 0 on
> >>> +success other negative errno int
> >>> +register_fsl_platform_wakeup_source(fsl_plat_pm_handle handle,
> >>> +		void *handle_priv)
> >>> +{
> >>> +	struct plat_pm_t *p;
> >>> +	unsigned long	flags;
> >>> +
> >>> +	if (!handle) {
> >>> +		pr_err("FSL plat_pm: Handler invalid, reject\n");
> >>> +		return -EINVAL;
> >>> +	}
> >>> +
> >>> +	p =3D kmalloc(sizeof(*p), GFP_KERNEL);
> >>> +	if (!p)
> >>> +		return -ENOMEM;
> >>> +
> >>> +	p->handle =3D handle;
> >>> +	p->handle_priv =3D handle_priv;
> >>> +
> >>> +	spin_lock_irqsave(&plat_pm.lock, flags);
> >>> +	list_add_tail(&p->node, &plat_pm.node);
> >>> +	spin_unlock_irqrestore(&plat_pm.lock, flags);
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(register_fsl_platform_wakeup_source);
> >>> +
> >>> +// Deregister_fsl_platform_wakeup_source - deregister callback
> >>> +function // @handle_priv: Handler specific data struct // // Return
> >>> +0 on success other negative errno int
> >>> +deregister_fsl_platform_wakeup_source(void *handle_priv) {
> >>> +	struct plat_pm_t *p, *tmp;
> >>> +	unsigned long	flags;
> >>> +
> >>> +	spin_lock_irqsave(&plat_pm.lock, flags);
> >>> +	list_for_each_entry_safe(p, tmp, &plat_pm.node, node) {
> >>> +		if (p->handle_priv =3D=3D handle_priv) {
> >>> +			list_del(&p->node);
> >>> +			kfree(p);
> >>> +		}
> >>> +	}
> >>> +	spin_unlock_irqrestore(&plat_pm.lock, flags);
> >>> +	return 0;
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(deregister_fsl_platform_wakeup_source);
> >>> +
> >>> +// fsl_platform_wakeup_config - Configure wakeup source by calling
> >>> +handlers // @dev: pointer to user's device struct // @flag: to tell
> >>> +enable or disable wakeup source // // Return 0 on success other
> >>> +negative errno int fsl_platform_wakeup_config(struct device *dev,
> >>> +bool flag) {
> >>> +	struct plat_pm_t *p;
> >>> +	int ret;
> >>> +	bool success_handled;
> >>> +	unsigned long	flags;
> >>> +
> >>> +	success_handled =3D false;
> >>> +
> >>> +	// Will consider success if at least one callback return 0.
> >>> +	// Also, rest handles still get oppertunity to be executed
> >>> +	spin_lock_irqsave(&plat_pm.lock, flags);
> >>> +	list_for_each_entry(p, &plat_pm.node, node) {
> >>> +		if (p->handle) {
> >>> +			ret =3D p->handle(dev, flag, p->handle_priv);
> >>> +			if (!ret)
> >>> +				success_handled =3D true;
> >> Miss a break?
> > Actually my idea is to allow more than one registered handler to
> > handle this request, so I define a flag rather than return to
> > indicated if there is at least one handler successfully do it. This des=
ign
> might give more flexibility to framework when running.
> There is only one flag(success_handled) here, how did know which handler
> failed?
>=20
> BTW, I don't think we need this flag. We can only use the return value.

Well, the plat_pm driver will not handle most errors returned by registered
handlers, except -NODEV. For -NODEV, plat_pm driver consider that handler
cannot support this request and will go to call next one.=20

Besides, actually it doesn't restrict that request can be served by only on=
e=20
handler. So I add that flag to cover the case of more than one handler can=
=20
successfully support and others might return -NODEV.

Regards,
Ran

> Cheers,
> Dongsheng
>=20
> >>> +			else if (ret !=3D -ENODEV) {
> >>> +				pr_err("FSL plat_pm: Failed to config wakeup
> >> source:%d\n", ret);
> >> Please unlock before return.
> > Yes, will fix it in next version, thanks for pointing out!
> >
> >>> +				return ret;
> >>> +			}
> >>> +		} else
> >>> +			pr_warn("FSL plat_pm: Invalid handler detected,
> >> skip\n");
> >>> +	}
> >>> +	spin_unlock_irqrestore(&plat_pm.lock, flags);
> >>> +
> >>> +	if (success_handled =3D=3D false) {
> >>> +		pr_err("FSL plat_pm: Cannot find the matchhed handler for
> >> wakeup source config\n");
> >>> +		return -ENODEV;
> >>> +	}
> >> Add this into the loop.
> > My design is that if the 1st handler return -ENODEV to indicated this
> > device it doesn't support, then the framework will continue try 2nd
> handler...
> >
> > So I think it is needed to place this checking out of loop, what do you=
 say?
> >
> > Regards,
> > Ran
> >>> +
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +// fsl_platform_wakeup_enable - Enable wakeup source // @dev:
> >>> +pointer to user's device struct // // Return 0 on success other
> >>> +negative errno int fsl_platform_wakeup_enable(struct device *dev) {
> >>> +	return fsl_platform_wakeup_config(dev, true); }
> >>> +EXPORT_SYMBOL_GPL(fsl_platform_wakeup_enable);
> >>> +
> >>> +// fsl_platform_wakeup_disable - Disable wakeup source // @dev:
> >>> +pointer to user's device struct // // Return 0 on success other
> >>> +negative errno int fsl_platform_wakeup_disable(struct device *dev) {
> >>> +	return fsl_platform_wakeup_config(dev, false); }
> >>> +EXPORT_SYMBOL_GPL(fsl_platform_wakeup_disable);
> >>> +
> >>> +static int __init fsl_plat_pm_init(void) {
> >>> +	spin_lock_init(&plat_pm.lock);
> >>> +	INIT_LIST_HEAD(&plat_pm.node);
> >>> +	return 0;
> >>> +}
> >>> +
> >>> +core_initcall(fsl_plat_pm_init);
> >>> diff --git a/include/soc/fsl/plat_pm.h b/include/soc/fsl/plat_pm.h
> >>> new file mode 100644 index 0000000..bbe151e
> >>> --- /dev/null
> >>> +++ b/include/soc/fsl/plat_pm.h
> >>> @@ -0,0 +1,22 @@
> >>> +// SPDX-License-Identifier: GPL-2.0 // // plat_pm.h - Freescale
> >>> +platform PM Header // // Copyright 2018 NXP // // Author: Ran Wang
> >>> +<ran.wang_1@nxp.com>,
> >>> +
> >>> +#ifndef __FSL_PLAT_PM_H
> >>> +#define __FSL_PLAT_PM_H
> >>> +
> >>> +typedef int (*fsl_plat_pm_handle)(struct device *dev, bool flag,
> >>> +		void *handle_priv);
> >>> +
> >>> +int register_fsl_platform_wakeup_source(fsl_plat_pm_handle handle,
> >>> +		void *handle_priv);
> >>> +int deregister_fsl_platform_wakeup_source(void *handle_priv); int
> >>> +fsl_platform_wakeup_config(struct device *dev, bool flag); int
> >>> +fsl_platform_wakeup_enable(struct device *dev); int
> >>> +fsl_platform_wakeup_disable(struct device *dev);
> >>> +
> >>> +#endif	// __FSL_PLAT_PM_H
> >
