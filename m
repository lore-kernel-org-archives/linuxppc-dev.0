Return-Path: <SRS0=TUrV=S5=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 1A557DDE40
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Feb 2008 01:27:44 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] MTD support for the AMCC Taishan
Date: Fri, 8 Feb 2008 15:27:28 +0100
References: <120203530465-git-send-email-kaloz@openwrt.org>
In-Reply-To: <120203530465-git-send-email-kaloz@openwrt.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200802081527.28771.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 03 February 2008, Imre Kaloz wrote:
> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
> ---
>  arch/powerpc/boot/dts/taishan.dts      |   33 +++++++++++-
>  arch/powerpc/configs/taishan_defconfig |   89
> ++++++++++++++++++++++++++++++-- 2 files changed, 116 insertions(+), 6
> deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/taishan.dts
> b/arch/powerpc/boot/dts/taishan.dts index 0706a4a..28c14dd 100644
> --- a/arch/powerpc/boot/dts/taishan.dts
> +++ b/arch/powerpc/boot/dts/taishan.dts
> @@ -174,7 +174,38 @@
>  				interrupts = <5 4>;
>  				interrupt-parent = <&UIC1>;
>
> -				/* TODO: Add other EBC devices */
> +				nor_flash@0,0 {
> +					compatible = "cfi-flash";
> +					bank-width = <4>;
> +					device-width = <2>;
> +					reg = <0 000000 4000000>;
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +					partition@0 {
> +						label = "kernel";
> +						reg = <0 180000>;
> +					};
> +					partition@180000 {
> +						label = "root";
> +						reg = <180000 200000>;
> +					};
> +					partition@380000 {
> +						label = "user";
> +						reg = <380000 3a80000>;
> +					};
> +					partition@3e00000 {
> +						label = "kozio";
> +						reg = <3e00000 140000>;
> +					};

Please remove the kozio partition from this list. It's not used/supported 
anymore.

Thanks.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
