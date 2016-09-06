Return-Path: <scott.wood@nxp.com>
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0040.outbound.protection.outlook.com [104.47.2.40])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTLrH62mZzDrq6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 08:29:51 +1000 (AEST)
From: Scott Wood <scott.wood@nxp.com>
To: Andy Fleming <afleming@gmail.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "scottwood@freescale.com"
 <scottwood@freescale.com>
CC: "aperez@alexperez.com" <aperez@alexperez.com>
Subject: Re: [PATCH 2/3] corenet: Support gpio power/reset for corenet
Date: Tue, 6 Sep 2016 22:29:42 +0000
Message-ID: <DB5PR0401MB192878019FFA33204D6A3EBD91F90@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1473189119-29458-1-git-send-email-afleming@gmail.com>
 <1473189119-29458-3-git-send-email-afleming@gmail.com>
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

On 09/06/2016 02:12 PM, Andy Fleming wrote:=0A=
> Boards can implement power and reset functionality over gpio using=0A=
> these drivers:=0A=
>   drivers/power/reset/gpio-poweroff.c=0A=
>   drivers/power/reset/gpio-restart.c=0A=
> =0A=
> While not all corenet boards use gpio for power/reset, this=0A=
> support can be added without interfering with boards that do not=0A=
> use this functionality.=0A=
> =0A=
> If a board's device tree has the related nodes, they are now probed.=0A=
> Also, gpio-poweroff uses the global pm_power_off callback to implement=0A=
> the shutdown. However, pm_power_off was not invoked when the kernel=0A=
> halted, although that is usually the desired behavior. If the board=0A=
> provides gpio power and reset support, it is reasonable to assume that=0A=
> halting should also power down the system, unless it has chosen to=0A=
> pass those calls on to hypervisor.=0A=
=0A=
Halt and poweroff are not the same thing.  If userspace requests a=0A=
poweroff, then kernel_power_off() will call machine_power_off() which=0A=
will call pm_power_off().=0A=
=0A=
Why do we need anything corenet-specific here?=0A=
=0A=
> @@ -127,6 +137,12 @@ static const struct of_device_id of_device_ids[] =3D=
 {=0A=
>  	{=0A=
>  		.name		=3D "handles",=0A=
>  	},=0A=
> +	{=0A=
> +		.name		=3D "gpio-poweroff",=0A=
> +	},=0A=
> +	{=0A=
> +		.name		=3D "gpio-restart",=0A=
> +	},=0A=
>  	{}=0A=
>  };=0A=
>  =0A=
=0A=
I don't see any other platforms doing this.  How do the nodes get probed=0A=
for them?=0A=
=0A=
-Scott=0A=
=0A=
