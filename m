Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 203FFDDF3A
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 03:29:17 +1100 (EST)
Message-ID: <47E290DB.4090105@grandegger.com>
Date: Thu, 20 Mar 2008 17:29:15 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: Oops with TQM5200 on TQM5200
References: <47E2723D.1090101@grandegger.com> <47E281B6.20702@denx.de>
In-Reply-To: <47E281B6.20702@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Anatolij,

Anatolij Gustschin wrote:
> Hello Wolfgang,
> 
> Wolfgang Grandegger wrote:
> 
>> I just tried Linux 2.6.25-rc6 on my TQM5200 module and got the attached
>> oops. Are there any known patches fixing the problems?
> 
> try the patch below for tqm5200.dts, rebuild dtb and boot
> again. Not sure if it works for Linux 2.6.25-rc6, but for
> 2.6.25-rc3 it does.
> 
> Anatolij
> -- 
> diff --git a/arch/powerpc/boot/dts/tqm5200.dts
> b/arch/powerpc/boot/dts/tqm5200.dts
> index c86464f..7c23bb3 100644
> --- a/arch/powerpc/boot/dts/tqm5200.dts
> +++ b/arch/powerpc/boot/dts/tqm5200.dts
> @@ -83,6 +83,7 @@
>         };
> 
>         dma-controller@1200 {
> +            device_type = "dma-controller";

This one actually fixes the Oops. I already had the following fixes.

>             compatible = "fsl,mpc5200-bestcomm";
>             reg = <1200 80>;
>             interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
> @@ -127,10 +128,25 @@
>         ethernet@3000 {
>             device_type = "network";
>             compatible = "fsl,mpc5200-fec";
> -            reg = <3000 800>;
> +            reg = <3000 400>;

This has already been fixed a long time ago, IIRC.

>             local-mac-address = [ 00 00 00 00 00 00 ];
>             interrupts = <2 5 0>;
>             interrupt-parent = <&mpc5200_pic>;
> +            phy-handle = <&phy0>;
> +        };
> +
> +        mdio@3000 {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            compatible = "fsl,mpc5200b-mdio";
> +            reg = <3000 400>;       // fec range, since we need to
> setup fec interrupts
> +            interrupts = <2 5 0>;   // these are for "mii command
> finished", not link changes & co.
> +            interrupt-parent = <&mpc5200_pic>;
> +
> +            phy0:ethernet-phy@0 {
> +                device_type = "ethernet-phy";
> +                reg = <0>;
> +            };

Another question. Is it possible to configure Linux without explicit
PHY-handling.

Thanks,

Wolfgang.
