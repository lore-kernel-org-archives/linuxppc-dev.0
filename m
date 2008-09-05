Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 992C6DDF2B
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 20:20:19 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Subject: Re: [PATCH] powerpc/44x: Add hwmon support to Sequoia device tree
Date: Fri, 5 Sep 2008 12:19:43 +0200
References: <200809041155.02927.matthias.fuchs@esd-electronics.com>
	<200809041628.29460.matthias.fuchs@esd-electronics.com>
	<200809041641.57614.matthias.fuchs@esd-electronics.com>
In-Reply-To: <200809041641.57614.matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809051219.43906.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 04 September 2008, Matthias Fuchs wrote:
> This patch adds support for the AD7414 temperature sensor
> on Sequoia PPC440EPx board.
>
> Signed-off-by: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
> ---
>  arch/powerpc/boot/dts/sequoia.dts |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/boot/dts/sequoia.dts
> b/arch/powerpc/boot/dts/sequoia.dts index 72d15f0..9ba5def 100644
> --- a/arch/powerpc/boot/dts/sequoia.dts
> +++ b/arch/powerpc/boot/dts/sequoia.dts
> @@ -246,13 +246,22 @@
>  	   		};
>
>  			IIC0: i2c@ef600700 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
>  				compatible = "ibm,iic-440epx", "ibm,iic";
>  				reg = <0xef600700 0x00000014>;
>  				interrupt-parent = <&UIC0>;
>  				interrupts = <0x2 0x4>;
> +
> +				hwmon@48 {

Not sure if we shouldn't use

                                ad7414@48 {

here. This is the way it is already done in warp.dts.

Other than this:

Acked-by: Stefan Roese <sr@denx.de>

Best regards,
Stefan
