Return-Path: <scott.wood@nxp.com>
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr30062.outbound.protection.outlook.com [40.107.3.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2qXW3DDGzDvXh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 08:43:22 +1100 (AEDT)
From: Scott Wood <scott.wood@nxp.com>
To: Andy Fleming <afleming@gmail.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "scottwood@freescale.com"
 <scottwood@freescale.com>
CC: "aperez@alexperez.com" <aperez@alexperez.com>
Subject: Re: [PATCH 3/3] corenet: Switch to of_platform_default_populate
Date: Mon, 24 Oct 2016 21:43:01 +0000
Message-ID: <DB5PR0401MB19285D41A04AAC2B055E921891A90@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1477266519-25173-1-git-send-email-afleming@gmail.com>
 <1477266519-25173-3-git-send-email-afleming@gmail.com>
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

On 10/23/2016 06:48 PM, Andy Fleming wrote:=0A=
> Many of the embedded powerpc boards use an array of device names=0A=
> to register the devices from the device tree. Instead, we can use=0A=
> of_platform_default_populate(), which will iterate through all the root n=
odes and register them.=0A=
> =0A=
> Signed-off-by: Andy Fleming <afleming@gmail.com>=0A=
> ---=0A=
> This is necessary to enable the gpio power/reset pins on the Cyrus board.=
=0A=
> =0A=
> I have confirmed that the PCI devices are registered and that the power/r=
eset=0A=
> drivers are registered (and functional). I also tested USB, and saw the=
=0A=
> onboard MMC card report in, so some of the SoC devices are definitely the=
re.=0A=
> =0A=
> If this doesn't break the other corenet boards, I'd be happy to make the=
=0A=
> same change for the other powerpc boards.=0A=
> =0A=
>  arch/powerpc/platforms/85xx/corenet_generic.c | 49 +--------------------=
------=0A=
>  1 file changed, 1 insertion(+), 48 deletions(-)=0A=
> =0A=
> diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc=
/platforms/85xx/corenet_generic.c=0A=
> index 1179115..6347f20 100644=0A=
> --- a/arch/powerpc/platforms/85xx/corenet_generic.c=0A=
> +++ b/arch/powerpc/platforms/85xx/corenet_generic.c=0A=
> @@ -83,56 +83,9 @@ void __init corenet_gen_setup_arch(void)=0A=
>  	mpc85xx_qe_init();=0A=
>  }=0A=
>  =0A=
> -static const struct of_device_id of_device_ids[] =3D {=0A=
> -	{=0A=
> -		.compatible	=3D "simple-bus"=0A=
> -	},=0A=
> -	{=0A=
> -		.compatible	=3D "mdio-mux-gpio"=0A=
> -	},=0A=
> -	{=0A=
> -		.compatible	=3D "fsl,fpga-ngpixis"=0A=
> -	},=0A=
> -	{=0A=
> -		.compatible	=3D "fsl,fpga-qixis"=0A=
> -	},=0A=
> -	{=0A=
> -		.compatible	=3D "fsl,srio",=0A=
> -	},=0A=
> -	{=0A=
> -		.compatible	=3D "fsl,p4080-pcie",=0A=
> -	},=0A=
> -	{=0A=
> -		.compatible	=3D "fsl,qoriq-pcie-v2.2",=0A=
> -	},=0A=
> -	{=0A=
> -		.compatible	=3D "fsl,qoriq-pcie-v2.3",=0A=
> -	},=0A=
> -	{=0A=
> -		.compatible	=3D "fsl,qoriq-pcie-v2.4",=0A=
> -	},=0A=
> -	{=0A=
> -		.compatible	=3D "fsl,qoriq-pcie-v3.0",=0A=
> -	},=0A=
> -	{=0A=
> -		.compatible	=3D "fsl,qe",=0A=
> -	},=0A=
> -	{=0A=
> -		.compatible    =3D "fsl,fman",=0A=
> -	},=0A=
> -	/* The following two are for the Freescale hypervisor */=0A=
> -	{=0A=
> -		.name		=3D "hypervisor",=0A=
> -	},=0A=
> -	{=0A=
> -		.name		=3D "handles",=0A=
> -	},=0A=
> -	{}=0A=
> -};=0A=
> -=0A=
>  int __init corenet_gen_publish_devices(void)=0A=
>  {=0A=
> -	return of_platform_bus_probe(NULL, of_device_ids, NULL);=0A=
> +	return of_platform_default_populate(NULL, NULL, NULL);=0A=
>  }=0A=
=0A=
I think we still need to specify some of these nodes.  Switching from=0A=
probe to populate will take care of probing device nodes under root=0A=
without listing each one, but it won't treat those nodes as buses unless=0A=
they have "simple-bus" or otherwise match the probe list.=0A=
=0A=
-Scott=0A=
=0A=
