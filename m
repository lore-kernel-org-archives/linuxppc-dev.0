Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E303C2C02C5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jul 2013 03:10:38 +1000 (EST)
Date: Mon, 8 Jul 2013 12:10:29 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V2 2/2] powerpc/85xx: add the P1020RDB-PD DTS support
To: Haijun Zhang <Haijun.Zhang@freescale.com>
In-Reply-To: <1372982700-14416-1-git-send-email-Haijun.Zhang@freescale.com>
 (from Haijun.Zhang@freescale.com on Thu Jul  4 19:05:00 2013)
Message-ID: <1373303429.8183.162@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: AFLEMING@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Haijun Zhang <Haijun.Zhang@freescale.com>,
 Jerry Huang <Chang-Ming.Huang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/04/2013 07:05:00 PM, Haijun Zhang wrote:
> diff --git a/arch/powerpc/boot/dts/p1020rdb-pc.dtsi =20
> b/arch/powerpc/boot/dts/p1020rdb-pc.dtsi
> index c952cd3..9d24501 100644
> --- a/arch/powerpc/boot/dts/p1020rdb-pc.dtsi
> +++ b/arch/powerpc/boot/dts/p1020rdb-pc.dtsi
> @@ -131,9 +131,7 @@
>  	};
>=20
>  	cpld@3,0 {
> -		#address-cells =3D <1>;
> -		#size-cells =3D <1>;
> -		compatible =3D "cpld";
> +		compatible =3D "fsl, p1020rdb-cpld";

No space after "fsl,".

> +			partition@fs {
> +				/* 4MB for Compressed RFS Image */
> +				reg =3D <0x00500000 0x00400000>;
> +				label =3D "file system";
> +			};
> +
> +			partition@jffs-fs {
> +				/* 7MB for JFFS2 based RFS */
> +				reg =3D <0x00900000 0x00700000>;
> +				label =3D "file system jffs2";
> +			};
> +		};
> +		slic@0 {
> +			compatible =3D "zarlink,le88266";
> +			reg =3D <1>;
> +			spi-max-frequency =3D <8000000>;
> +		};
> +		slic@1 {
> +			compatible =3D "zarlink,le88266";
> +			reg =3D <2>;
> +			spi-max-frequency =3D <8000000>;
> +		};
> +
> +	};

Remove that last blank line, and insert a blank line before each =20
"slic@..." (like you do between the partition nodes).

> +	/* USB2 is shared with localbus, so it must be disabled
> +	   by default. We can't put 'status =3D "disabled";' here
> +	   since U-Boot doesn't clear the status property when
> +	   it enables USB2. OTOH, U-Boot does create a new node
> +	   when there isn't any. So, just comment it out.
> +	*/

/*
  * Linux multi-line
  * comment style
  * is like this.
  */

> +	usb@23000 {
> +		status =3D "disabled";
> +		phy_type =3D "ulpi";
> +	};

Didn't you just say above that you can't use status =3D "disabled"?

And can U-Boot be fixed to set status =3D "disabled" on whichever I/O is =20
not usable?

> +/include/ "fsl/p1020si-pre.dtsi"
> +/ {
> +	model =3D "fsl,P1020RDB-PD";
> +	compatible =3D "fsl,P1020RDB-PD";
> +
> +	memory {
> +		device_type =3D "memory";
> +	};
> +
> +	lbc: localbus@ffe05000 {
> +		reg =3D <0x0 0xffe05000 0x0 0x1000>;
> +
> +		/* NOR, NAND flash and L2 switch */
> +		ranges =3D <0x0 0x0 0x0 0xec000000 0x04000000
> +			  0x1 0x0 0x0 0xff800000 0x00040000
> +			  0x2 0x0 0x0 0xffa00000 0x00020000
> +			  0x3 0x0 0x0 0xffb00000 0x00020000>;

If you're going to have a comment here about what is mapped by the =20
ranges, why exclude the CPLD?

-Scott=
