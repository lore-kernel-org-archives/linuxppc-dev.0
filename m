Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0107.outbound.protection.outlook.com [65.55.169.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 545D61A001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 06:40:18 +1000 (AEST)
Message-ID: <1436819959.2993.16.camel@freescale.com>
Subject: Re: [PATCH] powerpc/fsl-booke: Add T1040D4RDB/T1042D4RDB board support
From: Scott Wood <scottwood@freescale.com>
To: Priyanka Jain <b32167@rhuath.am.freescale.net>
CC: <linuxppc-dev@lists.ozlabs.org>, Priyanka Jain
 <Priyanka.Jain@freescale.com>
Date: Mon, 13 Jul 2015 15:39:19 -0500
In-Reply-To: <1436680032-24147-1-git-send-email-b32167@rhuath.am.freescale.net>
References: <1436680032-24147-1-git-send-email-b32167@rhuath.am.freescale.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-07-12 at 00:47 -0500, Priyanka Jain wrote:
> +/ {
> +     model = "fsl,T1040D4RDB";
> +     compatible = "fsl,T1040D4RDB";
> +     #address-cells = <2>;
> +     #size-cells = <2>;
> +     interrupt-parent = <&mpic>;
> +
> +     ifc:  localbus@ffe124000{
> +             cpld@3,0 {
> +                     compatible = "fsl,t1040d4rdb-cpld",
> +                                     "fsl,deepsleep-cpld";
> +             };
> +     };
> +};

What is "fsl,deepsleep-cpld"?  Besides the lack of a binding, it seems too 
vague.  Not all deep sleep capable CPLDs are necessarily going to be 
identical.

> +     ifc:  localbus@ffe124000{
> +             reg = <0xf 0xfe124000 0 0x2000>;
> +             ranges = <0 0 0xf 0xe8000000 0x08000000
> +                       2 0 0xf 0xff800000 0x00010000
> +                       3 0 0xf 0xffdf0000 0x00008000>;
> +
> +             nor@0,0 {
> +                     #address-cells = <1>;
> +                     #size-cells = <1>;
> +                     compatible = "cfi-flash";
> +                     reg = <0x0 0x0 0x8000000>;
> +                     bank-width = <2>;
> +                     device-width = <1>;
> +             };
> +
> +             nand@2,0 {
> +                     #address-cells = <1>;
> +                     #size-cells = <1>;
> +                     compatible = "fsl,ifc-nand";
> +                     reg = <0x2 0x0 0x10000>;
> +             };
> +
> +             cpld@3,0 {
> +                     reg = <3 0 0x300>;
> +             };

I'd rather keep reg with the compatible.

> +                      adt7461@4c{
> +                             compatible = "adi,adt7461";
> +                             reg = <0x4c>;
> +                     };

Node names should be generic.

> +              i2c@118100{
> +                      pca9546@77{
> +                             compatible = "nxp,pca9546";
> +                             reg = <0x77>;
> +                             #address-cells = <1>;
> +                             #size-cells = <0>;
> +                     };

Likewise.

-Scott
