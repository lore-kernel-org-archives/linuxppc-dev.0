Return-Path: <dongsheng.wang@hxt-semitech.com>
Received: from barracuda.hxt-semitech.com (mx01.hxt-semitech.com
 [223.203.96.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424pV02GJszF1nv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 13:05:12 +1000 (AEST)
From: "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
To: Ran Wang <ran.wang_1@nxp.com>, Leo Li <leoyang.li@nxp.com>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] soc: fsl: add Platform PM driver QorIQ platforms
Date: Wed, 5 Sep 2018 03:04:46 +0000
Message-ID: <366f03eab44e489b9fef82fb8e8f3c3b@HXTBJIDCEMVIW02.hxtcorp.net>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
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

Please change your comments style.=0A=
=0A=
On 2018/8/31 11:57, Ran Wang wrote:=0A=
> This driver is to provide a independent framework for PM service=0A=
> provider and consumer to configure system level wake up feature. For=0A=
> example, RCPM driver could register a callback function on this=0A=
> platform first, and Flex timer driver who want to enable timer wake=0A=
> up feature, will call generic API provided by this platform driver,=0A=
> and then it will trigger RCPM driver to do it. The benefit is to=0A=
> isolate the user and service, such as flex timer driver will not have=0A=
> to know the implement details of wakeup function it require. Besides,=0A=
> it is also easy for service side to upgrade its logic when design is=0A=
> changed and remain user side unchanged.=0A=
>=0A=
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>=0A=
> ---=0A=
>  drivers/soc/fsl/Kconfig   |   14 +++++=0A=
>  drivers/soc/fsl/Makefile  |    1 +=0A=
>  drivers/soc/fsl/plat_pm.c |  144 +++++++++++++++++++++++++++++++++++++++=
++++++=0A=
>  include/soc/fsl/plat_pm.h |   22 +++++++=0A=
>  4 files changed, 181 insertions(+), 0 deletions(-)=0A=
>  create mode 100644 drivers/soc/fsl/plat_pm.c=0A=
>  create mode 100644 include/soc/fsl/plat_pm.h=0A=
>=0A=
> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig=0A=
> index 7a9fb9b..6517412 100644=0A=
> --- a/drivers/soc/fsl/Kconfig=0A=
> +++ b/drivers/soc/fsl/Kconfig=0A=
> @@ -16,3 +16,17 @@ config FSL_GUTS=0A=
>  	  Initially only reading SVR and registering soc device are supported.=
=0A=
>  	  Other guts accesses, such as reading RCW, should eventually be moved=
=0A=
>  	  into this driver as well.=0A=
> +=0A=
> +config FSL_PLAT_PM=0A=
> +	bool "Freescale platform PM framework"=0A=
> +	help=0A=
> +	  This driver is to provide a independent framework for PM service=0A=
> +	  provider and consumer to configure system level wake up feature. For=
=0A=
> +	  example, RCPM driver could register a callback function on this=0A=
> +	  platform first, and Flex timer driver who want to enable timer wake=
=0A=
> +	  up feature, will call generic API provided by this platform driver,=
=0A=
> +	  and then it will trigger RCPM driver to do it. The benefit is to=0A=
> +	  isolate the user and service, such as  flex timer driver will not=0A=
> +	  have to know the implement details of wakeup function it require.=0A=
> +	  Besides, it is also easy for service side to upgrade its logic when=
=0A=
> +	  design changed and remain user side unchanged.=0A=
> diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile=0A=
> index 44b3beb..8f9db23 100644=0A=
> --- a/drivers/soc/fsl/Makefile=0A=
> +++ b/drivers/soc/fsl/Makefile=0A=
> @@ -6,3 +6,4 @@ obj-$(CONFIG_FSL_DPAA)                 +=3D qbman/=0A=
>  obj-$(CONFIG_QUICC_ENGINE)		+=3D qe/=0A=
>  obj-$(CONFIG_CPM)			+=3D qe/=0A=
>  obj-$(CONFIG_FSL_GUTS)			+=3D guts.o=0A=
> +obj-$(CONFIG_FSL_PLAT_PM)	+=3D plat_pm.o=0A=
> diff --git a/drivers/soc/fsl/plat_pm.c b/drivers/soc/fsl/plat_pm.c=0A=
> new file mode 100644=0A=
> index 0000000..19ea14e=0A=
> --- /dev/null=0A=
> +++ b/drivers/soc/fsl/plat_pm.c=0A=
> @@ -0,0 +1,144 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +//=0A=
> +// plat_pm.c - Freescale platform PM framework=0A=
> +//=0A=
> +// Copyright 2018 NXP=0A=
> +//=0A=
> +// Author: Ran Wang <ran.wang_1@nxp.com>,=0A=
> +=0A=
> +#include <linux/kernel.h>=0A=
> +#include <linux/device.h>=0A=
> +#include <linux/list.h>=0A=
> +#include <linux/slab.h>=0A=
> +#include <linux/err.h>=0A=
> +#include <soc/fsl/plat_pm.h>=0A=
> +=0A=
> +=0A=
> +struct plat_pm_t {=0A=
> +	struct list_head node;=0A=
> +	fsl_plat_pm_handle handle;=0A=
> +	void *handle_priv;=0A=
> +	spinlock_t	lock;=0A=
> +};=0A=
> +=0A=
> +static struct plat_pm_t plat_pm;=0A=
> +=0A=
> +// register_fsl_platform_wakeup_source - Register callback function to p=
lat_pm=0A=
> +// @handle: Pointer to handle PM feature requirement=0A=
> +// @handle_priv: Handler specific data struct=0A=
> +//=0A=
> +// Return 0 on success other negative errno=0A=
> +int register_fsl_platform_wakeup_source(fsl_plat_pm_handle handle,=0A=
> +		void *handle_priv)=0A=
> +{=0A=
> +	struct plat_pm_t *p;=0A=
> +	unsigned long	flags;=0A=
> +=0A=
> +	if (!handle) {=0A=
> +		pr_err("FSL plat_pm: Handler invalid, reject\n");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
> +=0A=
> +	p =3D kmalloc(sizeof(*p), GFP_KERNEL);=0A=
> +	if (!p)=0A=
> +		return -ENOMEM;=0A=
> +=0A=
> +	p->handle =3D handle;=0A=
> +	p->handle_priv =3D handle_priv;=0A=
> +=0A=
> +	spin_lock_irqsave(&plat_pm.lock, flags);=0A=
> +	list_add_tail(&p->node, &plat_pm.node);=0A=
> +	spin_unlock_irqrestore(&plat_pm.lock, flags);=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +EXPORT_SYMBOL_GPL(register_fsl_platform_wakeup_source);=0A=
> +=0A=
> +// Deregister_fsl_platform_wakeup_source - deregister callback function=
=0A=
> +// @handle_priv: Handler specific data struct=0A=
> +//=0A=
> +// Return 0 on success other negative errno=0A=
> +int deregister_fsl_platform_wakeup_source(void *handle_priv)=0A=
> +{=0A=
> +	struct plat_pm_t *p, *tmp;=0A=
> +	unsigned long	flags;=0A=
> +=0A=
> +	spin_lock_irqsave(&plat_pm.lock, flags);=0A=
> +	list_for_each_entry_safe(p, tmp, &plat_pm.node, node) {=0A=
> +		if (p->handle_priv =3D=3D handle_priv) {=0A=
> +			list_del(&p->node);=0A=
> +			kfree(p);=0A=
> +		}=0A=
> +	}=0A=
> +	spin_unlock_irqrestore(&plat_pm.lock, flags);=0A=
> +	return 0;=0A=
> +}=0A=
> +EXPORT_SYMBOL_GPL(deregister_fsl_platform_wakeup_source);=0A=
> +=0A=
> +// fsl_platform_wakeup_config - Configure wakeup source by calling handl=
ers=0A=
> +// @dev: pointer to user's device struct=0A=
> +// @flag: to tell enable or disable wakeup source=0A=
> +//=0A=
> +// Return 0 on success other negative errno=0A=
> +int fsl_platform_wakeup_config(struct device *dev, bool flag)=0A=
> +{=0A=
> +	struct plat_pm_t *p;=0A=
> +	int ret;=0A=
> +	bool success_handled;=0A=
> +	unsigned long	flags;=0A=
> +=0A=
> +	success_handled =3D false;=0A=
> +=0A=
> +	// Will consider success if at least one callback return 0.=0A=
> +	// Also, rest handles still get oppertunity to be executed=0A=
> +	spin_lock_irqsave(&plat_pm.lock, flags);=0A=
> +	list_for_each_entry(p, &plat_pm.node, node) {=0A=
> +		if (p->handle) {=0A=
> +			ret =3D p->handle(dev, flag, p->handle_priv);=0A=
> +			if (!ret)=0A=
> +				success_handled =3D true;=0A=
Miss a break?=0A=
=0A=
> +			else if (ret !=3D -ENODEV) {=0A=
> +				pr_err("FSL plat_pm: Failed to config wakeup source:%d\n", ret);=0A=
Please unlock before return.=0A=
=0A=
> +				return ret;=0A=
> +			}=0A=
> +		} else=0A=
> +			pr_warn("FSL plat_pm: Invalid handler detected, skip\n");=0A=
> +	}=0A=
> +	spin_unlock_irqrestore(&plat_pm.lock, flags);=0A=
> +=0A=
> +	if (success_handled =3D=3D false) {=0A=
> +		pr_err("FSL plat_pm: Cannot find the matchhed handler for wakeup sourc=
e config\n");=0A=
> +		return -ENODEV;=0A=
> +	}=0A=
Add this into the loop.=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +// fsl_platform_wakeup_enable - Enable wakeup source=0A=
> +// @dev: pointer to user's device struct=0A=
> +//=0A=
> +// Return 0 on success other negative errno=0A=
> +int fsl_platform_wakeup_enable(struct device *dev)=0A=
> +{=0A=
> +	return fsl_platform_wakeup_config(dev, true);=0A=
> +}=0A=
> +EXPORT_SYMBOL_GPL(fsl_platform_wakeup_enable);=0A=
> +=0A=
> +// fsl_platform_wakeup_disable - Disable wakeup source=0A=
> +// @dev: pointer to user's device struct=0A=
> +//=0A=
> +// Return 0 on success other negative errno=0A=
> +int fsl_platform_wakeup_disable(struct device *dev)=0A=
> +{=0A=
> +	return fsl_platform_wakeup_config(dev, false);=0A=
> +}=0A=
> +EXPORT_SYMBOL_GPL(fsl_platform_wakeup_disable);=0A=
> +=0A=
> +static int __init fsl_plat_pm_init(void)=0A=
> +{=0A=
> +	spin_lock_init(&plat_pm.lock);=0A=
> +	INIT_LIST_HEAD(&plat_pm.node);=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +core_initcall(fsl_plat_pm_init);=0A=
> diff --git a/include/soc/fsl/plat_pm.h b/include/soc/fsl/plat_pm.h=0A=
> new file mode 100644=0A=
> index 0000000..bbe151e=0A=
> --- /dev/null=0A=
> +++ b/include/soc/fsl/plat_pm.h=0A=
> @@ -0,0 +1,22 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +//=0A=
> +// plat_pm.h - Freescale platform PM Header=0A=
> +//=0A=
> +// Copyright 2018 NXP=0A=
> +//=0A=
> +// Author: Ran Wang <ran.wang_1@nxp.com>,=0A=
> +=0A=
> +#ifndef __FSL_PLAT_PM_H=0A=
> +#define __FSL_PLAT_PM_H=0A=
> +=0A=
> +typedef int (*fsl_plat_pm_handle)(struct device *dev, bool flag,=0A=
> +		void *handle_priv);=0A=
> +=0A=
> +int register_fsl_platform_wakeup_source(fsl_plat_pm_handle handle,=0A=
> +		void *handle_priv);=0A=
> +int deregister_fsl_platform_wakeup_source(void *handle_priv);=0A=
> +int fsl_platform_wakeup_config(struct device *dev, bool flag);=0A=
> +int fsl_platform_wakeup_enable(struct device *dev);=0A=
> +int fsl_platform_wakeup_disable(struct device *dev);=0A=
> +=0A=
> +#endif	// __FSL_PLAT_PM_H=0A=
=0A=
=0A=
