Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound2-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 05E65DDF95
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 03:11:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [2.6 patch] char/xilinx_hwicap/ section fix
Date: Fri, 2 May 2008 09:50:05 -0700
In-reply-to: <20080423095138.GA28933@cs181133002.pp.htv.fi>
References: <20080423095138.GA28933@cs181133002.pp.htv.fi>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Adrian Bunk" <bunk@kernel.org>,
	"Grant Likely" <grant.likely@secretlab.ca>, <paulus@samba.org>
Message-Id: <20080502165007.16B3F170006C@mail22-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Acked-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

Grant, please pick this up.

Steve

> -----Original Message-----
> From: Adrian Bunk [mailto:bunk@kernel.org]
> Sent: Wednesday, April 23, 2008 2:52 AM
> To: Stephen Neuendorffer; Grant Likely; paulus@samba.org
> Cc: linuxppc-dev@ozlabs.org; linux-kernel@vger.kernel.org
> Subject: [2.6 patch] char/xilinx_hwicap/ section fix
>=20
> This patch fixes the following build error:
>=20
> <--  snip  -->
>=20
> ...
>   CC [M]  drivers/char/xilinx_hwicap/xilinx_hwicap.o
> ...
>
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/char/xilinx_hwicap/xil
inx_hwicap.c:806: error:
> hwicap_of_match causes a section type conflict
>
/home/bunk/linux/kernel-2.6/git/linux-2.6/drivers/char/xilinx_hwicap/xil
inx_hwicap.c:806: error:
> hwicap_of_match causes a section type conflict
> make[4]: *** [drivers/char/xilinx_hwicap/xilinx_hwicap.o] Error 1
>=20
> <--  snip  -->
>=20
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
>=20
> ---
> 2f0f31d8aa696ca6cc45ab865ec8c68b90cd0e46 diff --git
a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
> b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
> index 016f905..dfe6907 100644
> --- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
> +++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
> @@ -803,7 +803,7 @@ static int __devexit hwicap_of_remove(struct
of_device *op)
>  }
>=20
>  /* Match table for of_platform binding */
> -static const struct of_device_id __devinit hwicap_of_match[] =3D {
> +static const struct of_device_id __devinitconst hwicap_of_match[] =3D =
{
>  	{ .compatible =3D "xlnx,opb-hwicap-1.00.b", .data =3D
&buffer_icap_config},
>  	{ .compatible =3D "xlnx,xps-hwicap-1.00.a", .data =3D
&fifo_icap_config},
>  	{},
>=20
