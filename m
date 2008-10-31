Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 165F1DDDF0
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 23:21:24 +1100 (EST)
Date: Fri, 31 Oct 2008 15:21:21 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] powerpc/4xx: Add GPIO, SPI and MMC suport to the Arches
Message-ID: <20081031122121.GA21741@oksana.dev.rtsoft.ru>
References: <1225451506-24727-1-git-send-email-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <1225451506-24727-1-git-send-email-sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Stefan,

On Fri, Oct 31, 2008 at 12:11:46PM +0100, Stefan Roese wrote:
> This patch adds GPIO, SPI & MMC (for onboard uSD) support to the
> Arches dts
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> ---
>  arch/powerpc/boot/dts/arches.dts |   32 ++++++++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/arches.dts b/arch/powerpc/boot/dts/arches.dts
> index d9113b1..c568095 100644
> --- a/arch/powerpc/boot/dts/arches.dts
> +++ b/arch/powerpc/boot/dts/arches.dts
> @@ -195,6 +195,38 @@
>  				interrupts = <0x3 0x4>;
>  			};
>  
> +			SPI0: spi@ef600900 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				device_type = "spi";

device_type isn't needed.

> +				compatible = "ibm,spi-460gt", "ibm,ppc4xx-spi";
> +				reg = <0xef600900 7>;
> +				interrupt-parent = <&UIC1>;
> +				interrupts = <2 4>;
> +
> +				/* gpio(s) representing chip select(s) */
> +				gpios = <&GPIO1 11 0>;
> +
> +				mmc-slot@0 {
> +					compatible = "linux,mmc-spi", "mmc-spi";

According to new (though still not approved) bindings, this should
be "<board-specific>-mmc-slot", "mmc-spi-slot".

> +					reg = <0>;
> +					spi-max-frequency = <10000000>;
> +					voltage-range = <3300 3300>;

For new bindings I changed this to "voltage-ranges", so that we
could specify discontinuous range.

> +				};
> +			};
> +
> +			GPIO0: gpio@ef600b00 {
> +				#gpio-cells = <2>;
> +				compatible = "ibm,460gt-gpio","ibm,ppc4xx-gpio";
> +				reg = <0xef600b00 38>;
> +			};
> +
> +			GPIO1: gpio@ef600c00 {
> +				#gpio-cells = <2>;
> +				compatible = "ibm,460gt-gpio","ibm,ppc4xx-gpio";
> +				reg = <0xef600c00 38>;
> +			};
> +
>  			TAH0: emac-tah@ef601350 {
>  				compatible = "ibm,tah-460gt", "ibm,tah";
>  				reg = <0xef601350 0x00000030>;
> -- 
> 1.6.0.3

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
