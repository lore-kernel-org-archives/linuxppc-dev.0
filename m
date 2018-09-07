Return-Path: <dongsheng.wang@hxt-semitech.com>
Received: from barracuda.hxt-semitech.com (mx01.hxt-semitech.com
 [223.203.96.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 426Cy164WKzF3Sd
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2018 20:15:51 +1000 (AEST)
From: "Wang, Dongsheng" <dongsheng.wang@hxt-semitech.com>
To: Ran Wang <ran.wang_1@nxp.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Leo Li <leoyang.li@nxp.com>, "Rob
 Herring" <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/3] soc: fsl: add Platform PM driver QorIQ platforms
Date: Fri, 7 Sep 2018 10:15:43 +0000
Message-ID: <35f171989af34850bd192c2b4de9b43b@HXTBJIDCEMVIW02.hxtcorp.net>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
 <366f03eab44e489b9fef82fb8e8f3c3b@HXTBJIDCEMVIW02.hxtcorp.net>
 <AM5PR0402MB2865774C03981F9808AB3A13F1000@AM5PR0402MB2865.eurprd04.prod.outlook.com>
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

On 2018/9/7 16:49, Ran Wang wrote:=0A=
> Hi Dongsheng=0A=
>=0A=
>> On 2018/9/5 11:05, Dongsheng Wang wrote:=0A=
>>=0A=
>> Please change your comments style.=0A=
>>=0A=
>> On 2018/8/31 11:57, Ran Wang wrote:=0A=
>>> This driver is to provide a independent framework for PM service=0A=
>>> provider and consumer to configure system level wake up feature. For=0A=
>>> example, RCPM driver could register a callback function on this=0A=
>>> platform first, and Flex timer driver who want to enable timer wake up=
=0A=
>>> feature, will call generic API provided by this platform driver, and=0A=
>>> then it will trigger RCPM driver to do it. The benefit is to isolate=0A=
>>> the user and service, such as flex timer driver will not have to know=
=0A=
>>> the implement details of wakeup function it require. Besides, it is=0A=
>>> also easy for service side to upgrade its logic when design is changed=
=0A=
>>> and remain user side unchanged.=0A=
>>>=0A=
>>> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>=0A=
>>> ---=0A=
>>>  drivers/soc/fsl/Kconfig   |   14 +++++=0A=
>>>  drivers/soc/fsl/Makefile  |    1 +=0A=
>>>  drivers/soc/fsl/plat_pm.c |  144=0A=
>> +++++++++++++++++++++++++++++++++++++++++++++=0A=
>>>  include/soc/fsl/plat_pm.h |   22 +++++++=0A=
>>>  4 files changed, 181 insertions(+), 0 deletions(-)  create mode=0A=
>>> 100644 drivers/soc/fsl/plat_pm.c  create mode 100644=0A=
>>> include/soc/fsl/plat_pm.h=0A=
>>>=0A=
>>> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig index=0A=
>>> 7a9fb9b..6517412 100644=0A=
>>> --- a/drivers/soc/fsl/Kconfig=0A=
>>> +++ b/drivers/soc/fsl/Kconfig=0A=
>>> @@ -16,3 +16,17 @@ config FSL_GUTS=0A=
>>>  	  Initially only reading SVR and registering soc device are supported=
.=0A=
>>>  	  Other guts accesses, such as reading RCW, should eventually be=0A=
>> moved=0A=
>>>  	  into this driver as well.=0A=
>>> +=0A=
>>> +config FSL_PLAT_PM=0A=
>>> +	bool "Freescale platform PM framework"=0A=
>>> +	help=0A=
>>> +	  This driver is to provide a independent framework for PM service=0A=
>>> +	  provider and consumer to configure system level wake up feature.=0A=
>> For=0A=
>>> +	  example, RCPM driver could register a callback function on this=0A=
>>> +	  platform first, and Flex timer driver who want to enable timer wake=
=0A=
>>> +	  up feature, will call generic API provided by this platform driver,=
=0A=
>>> +	  and then it will trigger RCPM driver to do it. The benefit is to=0A=
>>> +	  isolate the user and service, such as  flex timer driver will not=
=0A=
>>> +	  have to know the implement details of wakeup function it require.=
=0A=
>>> +	  Besides, it is also easy for service side to upgrade its logic when=
=0A=
>>> +	  design changed and remain user side unchanged.=0A=
>>> diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile index=
=0A=
>>> 44b3beb..8f9db23 100644=0A=
>>> --- a/drivers/soc/fsl/Makefile=0A=
>>> +++ b/drivers/soc/fsl/Makefile=0A=
>>> @@ -6,3 +6,4 @@ obj-$(CONFIG_FSL_DPAA)                 +=3D qbman/=0A=
>>>  obj-$(CONFIG_QUICC_ENGINE)		+=3D qe/=0A=
>>>  obj-$(CONFIG_CPM)			+=3D qe/=0A=
>>>  obj-$(CONFIG_FSL_GUTS)			+=3D guts.o=0A=
>>> +obj-$(CONFIG_FSL_PLAT_PM)	+=3D plat_pm.o=0A=
>>> diff --git a/drivers/soc/fsl/plat_pm.c b/drivers/soc/fsl/plat_pm.c new=
=0A=
>>> file mode 100644 index 0000000..19ea14e=0A=
>>> --- /dev/null=0A=
>>> +++ b/drivers/soc/fsl/plat_pm.c=0A=
>>> @@ -0,0 +1,144 @@=0A=
>>> +// SPDX-License-Identifier: GPL-2.0=0A=
>>> +//=0A=
>>> +// plat_pm.c - Freescale platform PM framework // // Copyright 2018=0A=
>>> +NXP // // Author: Ran Wang <ran.wang_1@nxp.com>,=0A=
>>> +=0A=
>>> +#include <linux/kernel.h>=0A=
>>> +#include <linux/device.h>=0A=
>>> +#include <linux/list.h>=0A=
>>> +#include <linux/slab.h>=0A=
>>> +#include <linux/err.h>=0A=
>>> +#include <soc/fsl/plat_pm.h>=0A=
>>> +=0A=
>>> +=0A=
>>> +struct plat_pm_t {=0A=
>>> +	struct list_head node;=0A=
>>> +	fsl_plat_pm_handle handle;=0A=
>>> +	void *handle_priv;=0A=
>>> +	spinlock_t	lock;=0A=
>>> +};=0A=
>>> +=0A=
>>> +static struct plat_pm_t plat_pm;=0A=
>>> +=0A=
>>> +// register_fsl_platform_wakeup_source - Register callback function=0A=
>>> +to plat_pm // @handle: Pointer to handle PM feature requirement //=0A=
>>> +@handle_priv: Handler specific data struct // // Return 0 on success=
=0A=
>>> +other negative errno int=0A=
>>> +register_fsl_platform_wakeup_source(fsl_plat_pm_handle handle,=0A=
>>> +		void *handle_priv)=0A=
>>> +{=0A=
>>> +	struct plat_pm_t *p;=0A=
>>> +	unsigned long	flags;=0A=
>>> +=0A=
>>> +	if (!handle) {=0A=
>>> +		pr_err("FSL plat_pm: Handler invalid, reject\n");=0A=
>>> +		return -EINVAL;=0A=
>>> +	}=0A=
>>> +=0A=
>>> +	p =3D kmalloc(sizeof(*p), GFP_KERNEL);=0A=
>>> +	if (!p)=0A=
>>> +		return -ENOMEM;=0A=
>>> +=0A=
>>> +	p->handle =3D handle;=0A=
>>> +	p->handle_priv =3D handle_priv;=0A=
>>> +=0A=
>>> +	spin_lock_irqsave(&plat_pm.lock, flags);=0A=
>>> +	list_add_tail(&p->node, &plat_pm.node);=0A=
>>> +	spin_unlock_irqrestore(&plat_pm.lock, flags);=0A=
>>> +=0A=
>>> +	return 0;=0A=
>>> +}=0A=
>>> +EXPORT_SYMBOL_GPL(register_fsl_platform_wakeup_source);=0A=
>>> +=0A=
>>> +// Deregister_fsl_platform_wakeup_source - deregister callback=0A=
>>> +function // @handle_priv: Handler specific data struct // // Return 0=
=0A=
>>> +on success other negative errno int=0A=
>>> +deregister_fsl_platform_wakeup_source(void *handle_priv) {=0A=
>>> +	struct plat_pm_t *p, *tmp;=0A=
>>> +	unsigned long	flags;=0A=
>>> +=0A=
>>> +	spin_lock_irqsave(&plat_pm.lock, flags);=0A=
>>> +	list_for_each_entry_safe(p, tmp, &plat_pm.node, node) {=0A=
>>> +		if (p->handle_priv =3D=3D handle_priv) {=0A=
>>> +			list_del(&p->node);=0A=
>>> +			kfree(p);=0A=
>>> +		}=0A=
>>> +	}=0A=
>>> +	spin_unlock_irqrestore(&plat_pm.lock, flags);=0A=
>>> +	return 0;=0A=
>>> +}=0A=
>>> +EXPORT_SYMBOL_GPL(deregister_fsl_platform_wakeup_source);=0A=
>>> +=0A=
>>> +// fsl_platform_wakeup_config - Configure wakeup source by calling=0A=
>>> +handlers // @dev: pointer to user's device struct // @flag: to tell=0A=
>>> +enable or disable wakeup source // // Return 0 on success other=0A=
>>> +negative errno int fsl_platform_wakeup_config(struct device *dev,=0A=
>>> +bool flag) {=0A=
>>> +	struct plat_pm_t *p;=0A=
>>> +	int ret;=0A=
>>> +	bool success_handled;=0A=
>>> +	unsigned long	flags;=0A=
>>> +=0A=
>>> +	success_handled =3D false;=0A=
>>> +=0A=
>>> +	// Will consider success if at least one callback return 0.=0A=
>>> +	// Also, rest handles still get oppertunity to be executed=0A=
>>> +	spin_lock_irqsave(&plat_pm.lock, flags);=0A=
>>> +	list_for_each_entry(p, &plat_pm.node, node) {=0A=
>>> +		if (p->handle) {=0A=
>>> +			ret =3D p->handle(dev, flag, p->handle_priv);=0A=
>>> +			if (!ret)=0A=
>>> +				success_handled =3D true;=0A=
>> Miss a break?=0A=
> Actually my idea is to allow more than one registered handler to handle t=
his=0A=
> request, so I define a flag rather than return to indicated if there is a=
t least one handler successfully=0A=
> do it. This design might give more flexibility to framework when running.=
=0A=
There is only one flag(success_handled) here, how did know which handler=0A=
failed?=0A=
=0A=
BTW, I don't think we need this flag. We can only use the return value.=0A=
=0A=
Cheers,=0A=
Dongsheng=0A=
=0A=
>>> +			else if (ret !=3D -ENODEV) {=0A=
>>> +				pr_err("FSL plat_pm: Failed to config wakeup=0A=
>> source:%d\n", ret);=0A=
>> Please unlock before return.=0A=
> Yes, will fix it in next version, thanks for pointing out!=0A=
>=0A=
>>> +				return ret;=0A=
>>> +			}=0A=
>>> +		} else=0A=
>>> +			pr_warn("FSL plat_pm: Invalid handler detected,=0A=
>> skip\n");=0A=
>>> +	}=0A=
>>> +	spin_unlock_irqrestore(&plat_pm.lock, flags);=0A=
>>> +=0A=
>>> +	if (success_handled =3D=3D false) {=0A=
>>> +		pr_err("FSL plat_pm: Cannot find the matchhed handler for=0A=
>> wakeup source config\n");=0A=
>>> +		return -ENODEV;=0A=
>>> +	}=0A=
>> Add this into the loop.=0A=
> My design is that if the 1st handler return -ENODEV to indicated this dev=
ice it doesn't support, =0A=
> then the framework will continue try 2nd handler...=0A=
>=0A=
> So I think it is needed to place this checking out of loop, what do you s=
ay?=0A=
>=0A=
> Regards,=0A=
> Ran=0A=
>>> +=0A=
>>> +	return 0;=0A=
>>> +}=0A=
>>> +=0A=
>>> +// fsl_platform_wakeup_enable - Enable wakeup source // @dev: pointer=
=0A=
>>> +to user's device struct // // Return 0 on success other negative=0A=
>>> +errno int fsl_platform_wakeup_enable(struct device *dev) {=0A=
>>> +	return fsl_platform_wakeup_config(dev, true); }=0A=
>>> +EXPORT_SYMBOL_GPL(fsl_platform_wakeup_enable);=0A=
>>> +=0A=
>>> +// fsl_platform_wakeup_disable - Disable wakeup source // @dev:=0A=
>>> +pointer to user's device struct // // Return 0 on success other=0A=
>>> +negative errno int fsl_platform_wakeup_disable(struct device *dev) {=
=0A=
>>> +	return fsl_platform_wakeup_config(dev, false); }=0A=
>>> +EXPORT_SYMBOL_GPL(fsl_platform_wakeup_disable);=0A=
>>> +=0A=
>>> +static int __init fsl_plat_pm_init(void) {=0A=
>>> +	spin_lock_init(&plat_pm.lock);=0A=
>>> +	INIT_LIST_HEAD(&plat_pm.node);=0A=
>>> +	return 0;=0A=
>>> +}=0A=
>>> +=0A=
>>> +core_initcall(fsl_plat_pm_init);=0A=
>>> diff --git a/include/soc/fsl/plat_pm.h b/include/soc/fsl/plat_pm.h new=
=0A=
>>> file mode 100644 index 0000000..bbe151e=0A=
>>> --- /dev/null=0A=
>>> +++ b/include/soc/fsl/plat_pm.h=0A=
>>> @@ -0,0 +1,22 @@=0A=
>>> +// SPDX-License-Identifier: GPL-2.0=0A=
>>> +//=0A=
>>> +// plat_pm.h - Freescale platform PM Header // // Copyright 2018 NXP=
=0A=
>>> +// // Author: Ran Wang <ran.wang_1@nxp.com>,=0A=
>>> +=0A=
>>> +#ifndef __FSL_PLAT_PM_H=0A=
>>> +#define __FSL_PLAT_PM_H=0A=
>>> +=0A=
>>> +typedef int (*fsl_plat_pm_handle)(struct device *dev, bool flag,=0A=
>>> +		void *handle_priv);=0A=
>>> +=0A=
>>> +int register_fsl_platform_wakeup_source(fsl_plat_pm_handle handle,=0A=
>>> +		void *handle_priv);=0A=
>>> +int deregister_fsl_platform_wakeup_source(void *handle_priv); int=0A=
>>> +fsl_platform_wakeup_config(struct device *dev, bool flag); int=0A=
>>> +fsl_platform_wakeup_enable(struct device *dev); int=0A=
>>> +fsl_platform_wakeup_disable(struct device *dev);=0A=
>>> +=0A=
>>> +#endif	// __FSL_PLAT_PM_H=0A=
>=0A=
=0A=
