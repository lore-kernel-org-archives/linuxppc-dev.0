Return-Path: <Chris.Packham@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjHF95dM5zDqKm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 15:30:05 +1000 (AEST)
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: "bp@alien8.de" <bp@alien8.de>, "mchehab@kernel.org" <mchehab@kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v3 1/3] EDAC: mv64x60: check driver registration success
Date: Wed, 7 Jun 2017 05:29:55 +0000
Message-ID: <7b51ad125caf4d4c97157187510626cc@svr-chch-ex1.atlnz.lc>
References: <20170529212142.25572-1-chris.packham@alliedtelesis.co.nz>
 <20170529212142.25572-2-chris.packham@alliedtelesis.co.nz>
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

Hi Borislav,=0A=
=0A=
On 30/05/17 09:21, Chris Packham wrote:=0A=
> Check the return status of platform_driver_register() in=0A=
> mv64x60_edac_init(). Only output messages and initialise the=0A=
> edac_op_state if the registration is successful.=0A=
> =0A=
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
> ---=0A=
> Changes in v3:=0A=
> - catch the retval of platform_register_drivers and return early on failu=
re=0A=
>    (thanks Borislav).=0A=
> =0A=
>   drivers/edac/mv64x60_edac.c | 8 ++++++--=0A=
>   1 file changed, 6 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/drivers/edac/mv64x60_edac.c b/drivers/edac/mv64x60_edac.c=0A=
> index 14b7e7b71eaa..172081551a70 100644=0A=
> --- a/drivers/edac/mv64x60_edac.c=0A=
> +++ b/drivers/edac/mv64x60_edac.c=0A=
> @@ -853,7 +853,11 @@ static struct platform_driver * const drivers[] =3D =
{=0A=
>   =0A=
>   static int __init mv64x60_edac_init(void)=0A=
>   {=0A=
> -	int ret =3D 0;=0A=
> +	int ret;=0A=
> +=0A=
> +	ret =3D platform_register_drivers(drivers, ARRAY_SIZE(drivers));=0A=
> +	if (ret)=0A=
> +		return ret;=0A=
=0A=
I actually think this was wrong. The edac_op_state is set as a module =0A=
param and affects the behaviour of the driver probe function which on =0A=
success could be called before we sanity check it below.=0A=
=0A=
I'm back to thinking that my original v1 of just removing the unused ret =
=0A=
was appropriate. If we still consider the driver too noisy we could just =
=0A=
remove the printks.=0A=
=0A=
What do you think?=0A=
=0A=
>   =0A=
>   	printk(KERN_INFO "Marvell MV64x60 EDAC driver " MV64x60_REVISION "\n")=
;=0A=
>   	printk(KERN_INFO "\t(C) 2006-2007 MontaVista Software\n");=0A=
> @@ -867,7 +871,7 @@ static int __init mv64x60_edac_init(void)=0A=
>   		break;=0A=
>   	}=0A=
>   =0A=
> -	return platform_register_drivers(drivers, ARRAY_SIZE(drivers));=0A=
> +	return 0;=0A=
>   }=0A=
>   module_init(mv64x60_edac_init);=0A=
>   =0A=
> =0A=
=0A=
