Return-Path: <CWald@WatchGuardVideo.com>
Received: from wgv4.watchguardvideo.com (mail.watchguardvideo.com
	[69.198.24.138]) by ozlabs.org (Postfix) with ESMTP id 825A8B7BF4
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Dec 2009 01:16:46 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] POWERPC 4xx: Fix PCI in AMCC 440EP Yosemite DTS
Date: Fri, 4 Dec 2009 08:19:16 -0600
Message-ID: <13F6A75BE29CE44F801B912901C3EF27023A420C@wgv4.watchguardvideo.local>
In-Reply-To: <20091204120744.GI2937@zod.rchland.ibm.com>
References: <13F6A75BE29CE44F801B912901C3EF27022A3993@wgv4.watchguardvideo.local>
	<20091130134145.GA2937@zod.rchland.ibm.com>
	<13F6A75BE29CE44F801B912901C3EF270233B6A4@wgv4.watchguardvideo.local>
	<20091204120744.GI2937@zod.rchland.ibm.com>
From: "Curtis Wald" <CWald@WatchGuardVideo.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Josh,
Yes, the patch you provided below is exactly what is needed for PCI
functionality.

I've verified using a 2 port Silicon Image 3512 PCI to SATA controller
card on Yosemite.

-Curtis


> -----Original Message-----
> From: Josh Boyer [mailto:jwboyer@linux.vnet.ibm.com]
> Sent: Friday, December 04, 2009 6:08 AM
> To: Curtis Wald
> Cc: mporter@kernel.crashing.org; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH] POWERPC 4xx: Fix PCI in AMCC 440EP Yosemite DTS
>=20
> On Mon, Nov 30, 2009 at 09:25:51AM -0600, Curtis Wald wrote:
> >Josh,
> >Here is a resend of the Yosemite.dts patch, deleting tabs and spaces
> in
> >the IDSEL section that should look better when viewing as 80 column.
>=20
> Something is still eating your patches when you send them out.  They
> get
> corrupted to the point of being unusable as you can see here:
>=20
> http://patchwork.ozlabs.org/patch/39810/
>=20
> However, your intentions are pretty clear.  Could you look at the
patch
> below
> and see if it was what you intended?  If so, I'll include it in my
> 'next'
> branch today.
>=20
> josh
>=20
> ---
>=20
> diff --git a/arch/powerpc/boot/dts/yosemite.dts
> b/arch/powerpc/boot/dts/yosemite.dts
> index 1fa3cb4..6492324 100644
> --- a/arch/powerpc/boot/dts/yosemite.dts
> +++ b/arch/powerpc/boot/dts/yosemite.dts
> @@ -282,20 +282,10 @@
>  			/* Inbound 2GB range starting at 0 */
>  			dma-ranges =3D <0x42000000 0x0 0x0 0x0 0x0 0x0
> 0x80000000>;
>=20
> -			/* Bamboo has all 4 IRQ pins tied together per
slot
> */
>  			interrupt-map-mask =3D <0xf800 0x0 0x0 0x0>;
>  			interrupt-map =3D <
> -				/* IDSEL 1 */
> -				0x800 0x0 0x0 0x0 &UIC0 0x1c 0x8
> -
> -				/* IDSEL 2 */
> -				0x1000 0x0 0x0 0x0 &UIC0 0x1b 0x8
> -
> -				/* IDSEL 3 */
> -				0x1800 0x0 0x0 0x0 &UIC0 0x1a 0x8
> -
> -				/* IDSEL 4 */
> -				0x2000 0x0 0x0 0x0 &UIC0 0x19 0x8
> +				/* IDSEL 12 */
> +				0x6000 0x0 0x0 0x0 &UIC0 0x19 0x8
>  			>;
>  		};
>  	};
