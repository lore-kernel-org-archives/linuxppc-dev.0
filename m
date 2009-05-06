Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 9DA56DE03E
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 07:01:59 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 2so185053ywt.39
	for <linuxppc-dev@ozlabs.org>; Wed, 06 May 2009 14:01:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1241640919-4650-9-git-send-email-wd@denx.de>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-9-git-send-email-wd@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 6 May 2009 15:01:38 -0600
Message-ID: <fa686aa40905061401k319313c5q89fd3e245c30808f@mail.gmail.com>
Subject: Re: [PATCH 08/12] mpc5121: Added I2C support.
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Piotr Ziecik <kosmo@semihalf.com>,
	linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 6, 2009 at 2:15 PM, Wolfgang Denk <wd@denx.de> wrote:
> From: Piotr Ziecik <kosmo@semihalf.com>
>
> - Enabled I2C interrupts on MPC5121.
> - Updated Kconfig for i2c-mpc driver.

I think this workaround belongs in the driver itself.

g.

>
> Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Cc: <linux-i2c@vger.kernel.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: John Rigby <jcrigby@gmail.com>
> ---
> =A0arch/powerpc/platforms/512x/mpc5121_ads.c =A0 =A0| =A0 =A02 ++
> =A0arch/powerpc/platforms/512x/mpc512x.h =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0arch/powerpc/platforms/512x/mpc512x_shared.c | =A0 24 ++++++++++++++++=
++++++++
> =A0drivers/i2c/busses/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A09 +++++----
> =A04 files changed, 32 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/pla=
tforms/512x/mpc5121_ads.c
> index 441abc4..a8976b4 100644
> --- a/arch/powerpc/platforms/512x/mpc5121_ads.c
> +++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
> @@ -42,6 +42,8 @@ static void __init mpc5121_ads_setup_arch(void)
> =A0 =A0 =A0 =A0for_each_compatible_node(np, "pci", "fsl,mpc5121-pci")
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mpc83xx_add_bridge(np);
> =A0#endif
> +
> + =A0 =A0 =A0 mpc512x_init_i2c();
> =A0}
>
> =A0static void __init mpc5121_ads_init_IRQ(void)
> diff --git a/arch/powerpc/platforms/512x/mpc512x.h b/arch/powerpc/platfor=
ms/512x/mpc512x.h
> index 9c03693..f4db8a7 100644
> --- a/arch/powerpc/platforms/512x/mpc512x.h
> +++ b/arch/powerpc/platforms/512x/mpc512x.h
> @@ -13,5 +13,6 @@
> =A0#define __MPC512X_H__
> =A0extern unsigned long mpc512x_find_ips_freq(struct device_node *node);
> =A0extern void __init mpc512x_init_IRQ(void);
> +extern void __init mpc512x_init_i2c(void);
> =A0void __init mpc512x_declare_of_platform_devices(void);
> =A0#endif =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* __MPC512X_H_=
_ */
> diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/=
platforms/512x/mpc512x_shared.c
> index 7135d89..b776e45 100644
> --- a/arch/powerpc/platforms/512x/mpc512x_shared.c
> +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
> @@ -65,6 +65,30 @@ void __init mpc512x_init_IRQ(void)
> =A0 =A0 =A0 =A0ipic_set_default_priority();
> =A0}
>
> +void __init mpc512x_init_i2c(void)
> +{
> + =A0 =A0 =A0 struct device_node *np;
> + =A0 =A0 =A0 void __iomem *i2cctl;
> +
> + =A0 =A0 =A0 /* Enable I2C interrupts */
> + =A0 =A0 =A0 np =3D of_find_compatible_node(NULL, NULL, "fsl,mpc5121-i2c=
-ctrl");
> + =A0 =A0 =A0 if (np) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2cctl =3D of_iomap(np, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (i2cctl) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Set interrupt enable b=
its:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0- I2C-0: bit 24,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0- I2C-1: bit 26,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* =A0- I2C-2: bit 28.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 out_be32(i2cctl, 0x15000000=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(i2cctl);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of_node_put(np);
> + =A0 =A0 =A0 }
> +}
> +
> =A0/*
> =A0* Nodes to do bus probe on, soc and localbus
> =A0*/
> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> index a48c8ae..57ed637 100644
> --- a/drivers/i2c/busses/Kconfig
> +++ b/drivers/i2c/busses/Kconfig
> @@ -391,13 +391,14 @@ config I2C_IXP2000
> =A0 =A0 =A0 =A0 =A0instead.
>
> =A0config I2C_MPC
> - =A0 =A0 =A0 tristate "MPC107/824x/85xx/52xx/86xx"
> + =A0 =A0 =A0 tristate "MPC107/824x/85xx/512x/52xx/86xx"
> =A0 =A0 =A0 =A0depends on PPC32
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0If you say yes to this option, support will be include=
d for the
> - =A0 =A0 =A0 =A0 built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC=
8245 and
> - =A0 =A0 =A0 =A0 MPC85xx/MPC8641 family processors. The driver may also =
work on 52xx
> - =A0 =A0 =A0 =A0 family processors, though interrupts are known not to w=
ork.
> + =A0 =A0 =A0 =A0 built-in I2C interface on the MPC107/Tsi107/MPC8240/MPC=
8245,
> + =A0 =A0 =A0 =A0 MPC85xx/MPC8641 and MPC512x family processors. The driv=
er may
> + =A0 =A0 =A0 =A0 also work on 52xx family processors, though interrupts =
are known
> + =A0 =A0 =A0 =A0 not to work.
>
> =A0 =A0 =A0 =A0 =A0This driver can also be built as a module. =A0If so, t=
he module
> =A0 =A0 =A0 =A0 =A0will be called i2c-mpc.
> --
> 1.6.0.6
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
