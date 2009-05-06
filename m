Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f172.google.com (mail-gx0-f172.google.com
	[209.85.217.172]) by ozlabs.org (Postfix) with ESMTP id 816C3DDF58
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 07:08:02 +1000 (EST)
Received: by gxk20 with SMTP id 20so681291gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 06 May 2009 14:08:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1241640919-4650-12-git-send-email-wd@denx.de>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-12-git-send-email-wd@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 6 May 2009 15:07:41 -0600
Message-ID: <fa686aa40905061407v2bac38e9k3ee8d68c0c58e692@mail.gmail.com>
Subject: Re: [PATCH 11/12] mpc5121: Added MPC512x DMA driver.
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Piotr Ziecik <kosmo@semihalf.com>
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
> This patch adds initial version of MPC512x DMA driver.
> Only memory to memory transfers are currenly supported.
>
> Signed-off-by: Piotr Ziecik <kosmo@semihalf.com>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: John Rigby <jcrigby@gmail.com>

Don't have time to review this in detail right now, but three quick comment=
s:

> =A0drivers/dma/mpc512x_dma.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
642 ++++++++++++++++++++++++++
> =A0drivers/dma/mpc512x_dma.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
192 ++++++++

It looks to me like these two files should be merged.

> diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts=
/mpc5121ads.dts
> index c2d9de9..e7f0e09 100644
> --- a/arch/powerpc/boot/dts/mpc5121ads.dts
> +++ b/arch/powerpc/boot/dts/mpc5121ads.dts
> @@ -373,7 +373,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma@14000 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc5121=
-dma2";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "fsl,mpc512x=
-dma";

Nack.  Compatible values should not use wildcards.  Be specific.  And
be specific about what it is compatible to if another part implements
the same device.

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D <0x14000 0x1800>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D <65 0x8>;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-parent =3D < &ip=
ic >;
> diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c b/arch/powerpc/=
platforms/512x/mpc512x_shared.c
> index b776e45..135fd6b 100644
> --- a/arch/powerpc/platforms/512x/mpc512x_shared.c
> +++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
> @@ -95,6 +95,7 @@ void __init mpc512x_init_i2c(void)
> =A0static struct of_device_id __initdata of_bus_ids[] =3D {
> =A0 =A0 =A0 =A0{ .compatible =3D "fsl,mpc5121-immr", },
> =A0 =A0 =A0 =A0{ .compatible =3D "fsl,mpc5121-localbus", },
> + =A0 =A0 =A0 { .compatible =3D "fsl,mpc5121-dma", },

This doesn't look right either.  Shouldn't the dma device hang off the
IMMR node?

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
