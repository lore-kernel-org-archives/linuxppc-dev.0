Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 50E0E2C0099
 for <linuxppc-dev@ozlabs.org>; Sat, 27 Jul 2013 07:59:27 +1000 (EST)
Date: Fri, 26 Jul 2013 16:59:16 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 3/3] powerpc/85xx: Add C293PCIE board support
To: Po Liu <Po.Liu@freescale.com>
References: <1366854857-22791-4-git-send-email-Po.Liu@freescale.com>
 <1374806479-812-1-git-send-email-Po.Liu@freescale.com>
 <1374806479-812-3-git-send-email-Po.Liu@freescale.com>
In-Reply-To: <1374806479-812-3-git-send-email-Po.Liu@freescale.com> (from
 Po.Liu@freescale.com on Thu Jul 25 21:41:19 2013)
Message-ID: <1374875956.30721.27@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@ozlabs.org, Mingkai Hu <Mingkai.Hu@freescale.com>,
 afleming@freescale.com, Po Liu <Po.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/25/2013 09:41:19 PM, Po Liu wrote:
> +		partition@1900000 {
> +			/* 7MB for User Area */
> +			reg =3D <0x01900000 0x00700000>;
> +			label =3D "NAND User area";
> +		};
> +
> +		partition@2000000 {
> +			/* 96MB for Root File System */
> +			reg =3D <0x02000000 0x06000000>;
> +			label =3D "NAND Root File System";
> +		};
> +
> +		partition@8000000 {
> +			/* 3968MB for Others */
> +			reg =3D <0x08000000 0xF8000000>;
> +			label =3D "NAND Others";
> +		};

Again, what is the difference between "user area" and "others"?  I'm =20
not even sure why it needs to be separate from "root file system", but =20
at least the root filesystem should be larger given the size of the =20
overall flash.

Also please use lowercase for hex.

> +	};
> +
> +	cpld@2,0 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "fsl,c293pcie-cpld";
> +		reg =3D <0x2 0x0 0x20>;
> +	};

Remove #address-cells/#size-cells

> +			partition@580000 {
> +				/* 10.5MB for Compressed RFS Image */
> +				reg =3D <0x00580000 0x00a80000>;
> +				label =3D "SPI Flash Compressed RFSImage";
> +			};

Space before "Image".  Why specifiy that it's compressed, versus some =20
other filesystem type?

-Scott=
