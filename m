Return-Path: <Wei.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EBE612C008E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Sep 2013 11:27:42 +1000 (EST)
Message-ID: <52268C7E.4040209@windriver.com>
Date: Wed, 4 Sep 2013 09:27:26 +0800
From: "Yang,Wei" <Wei.Yang@windriver.com>
MIME-Version: 1.0
To: Jia Hongtao <hongtao.jia@freescale.com>
Subject: Re: [PATCH] powerpc: Add I2C bus multiplexer node for B4 and T4240QDS
References: <1378194704-29909-1-git-send-email-hongtao.jia@freescale.com>
In-Reply-To: <1378194704-29909-1-git-send-email-hongtao.jia@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org, b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/03/2013 03:51 PM, Jia Hongtao wrote:
> In both B4 and T4240QDS platform PCA9547 I2C bus multiplexer is used.

Hi Hongtao,

If you want to support I2C bus multiplexer, for T4 and B4QDS platform, 
since some eeprom devices is connected to PCA9574 I2C bus
multiplexer, so these devices should be connected to pca9547 node. Just 
like the following, what do you think of it?

+                       pca9547@77 {
+                               compatible = "philips,pca9547";
+                               reg = <0x77>;
+                               #address-cells = <1>;
+                               #size-cells = <0>;
+                               channel@0 {
+                                       #address-cells = <1>;
+                                       #size-cells = <0>;
+                                       reg = <0>;
+                                               eeprom@51 {
+                                                       compatible = 
"at24,24c256";
+                                                       reg = <0x51>;
+                                               };
+                                               eeprom@52 {
+                                                       compatible = 
"at24,24c256";
+                                                       reg = <0x52>;
+                                               };
+                                               eeprom@53 {
+                                                       compatible = 
"at24,24c256";
+                                                       reg = <0x53>;
+                                               };
+                                               eeprom@54 {
+                                                       compatible = 
"at24,24c256";
+                                                       reg = <0x54>;
+                                               };
+                                               eeprom@55 {
+                                                       compatible = 
"at24,24c256";
+                                                       reg = <0x55>;
+                                               };
+                                               eeprom@56 {
+                                                       compatible = 
"at24,24c256";
+                                                       reg = <0x56>;
+                                               };
+                                               rtc@68 {
+                                                       compatible = 
"dallas,ds3232";
+                                                       reg = <0x68>;
+                                                       interrupts = 
<0x1 0x1 0 0>;
+                                               };
+                                       };

Wei
>
> Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
> ---
>   arch/powerpc/boot/dts/b4qds.dtsi   | 4 ++++
>   arch/powerpc/boot/dts/t4240qds.dts | 4 ++++
>   2 files changed, 8 insertions(+)
>
> diff --git a/arch/powerpc/boot/dts/b4qds.dtsi b/arch/powerpc/boot/dts/b4qds.dtsi
> index e6d2f8f..2aa3399 100644
> --- a/arch/powerpc/boot/dts/b4qds.dtsi
> +++ b/arch/powerpc/boot/dts/b4qds.dtsi
> @@ -120,6 +120,10 @@
>   		};
>   
>   		i2c@118000 {
> +			pca9547@77 {
> +				compatible = "philips,pca9547";
> +				reg = <0x77>;
> +			};
>   			eeprom@50 {
>   				compatible = "at24,24c64";
>   				reg = <0x50>;
> diff --git a/arch/powerpc/boot/dts/t4240qds.dts b/arch/powerpc/boot/dts/t4240qds.dts
> index 0555976..084db57 100644
> --- a/arch/powerpc/boot/dts/t4240qds.dts
> +++ b/arch/powerpc/boot/dts/t4240qds.dts
> @@ -118,6 +118,10 @@
>   		};
>   
>   		i2c@118000 {
> +			pca9547@77 {
> +				compatible = "philips,pca9547";
> +				reg = <0x77>;
> +			};
>   			eeprom@51 {
>   				compatible = "at24,24c256";
>   				reg = <0x51>;
