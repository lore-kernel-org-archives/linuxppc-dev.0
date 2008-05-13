Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55819DE2E7
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 02:53:43 +1000 (EST)
Message-ID: <4829C5F6.8010206@freescale.com>
Date: Tue, 13 May 2008 11:46:46 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] [POWERPC] Add i2c pins to dts and board setup
References: <4825C445.4020004@scram.de>
In-Reply-To: <4825C445.4020004@scram.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "Kernel, Linux" <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux I2C <i2c@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jochen Friedrich wrote:
> Initialize I2C pins on boards with CPM1/CPM2 controllers.
> 
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> ---
>  arch/powerpc/boot/dts/mpc8272ads.dts         |   10 ++++++++++
>  arch/powerpc/boot/dts/mpc866ads.dts          |   10 ++++++++++
>  arch/powerpc/boot/dts/mpc885ads.dts          |   10 ++++++++++
>  arch/powerpc/platforms/82xx/mpc8272_ads.c    |    4 ++++
>  arch/powerpc/platforms/8xx/mpc86xads_setup.c |    4 ++++
>  arch/powerpc/platforms/8xx/mpc885ads_setup.c |    3 +++
>  6 files changed, 41 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
> index 46e2da3..57abcc1 100644
> --- a/arch/powerpc/boot/dts/mpc8272ads.dts
> +++ b/arch/powerpc/boot/dts/mpc8272ads.dts
> @@ -217,6 +217,16 @@
>  				linux,network-index = <1>;
>  				fsl,cpm-command = <0x16200300>;
>  			};
> +
> +			i2c@11860 {
> +				compatible = "fsl,mpc8272-i2c",
> +					     "fsl,cpm2-i2c",
> +					     "fsl,cpm-i2c";
> +				reg = <11860 20 8afc 2>;
> +				interrupts = <1 8>;
> +				interrupt-parent = <&PIC>;
> +				fsl,cpm-command = <29600000>;
> +			};
>  		};
>  
>  		PIC: interrupt-controller@10c00 {
> diff --git a/arch/powerpc/boot/dts/mpc866ads.dts b/arch/powerpc/boot/dts/mpc866ads.dts
> index 765e43c..84c190e 100644
> --- a/arch/powerpc/boot/dts/mpc866ads.dts
> +++ b/arch/powerpc/boot/dts/mpc866ads.dts
> @@ -171,6 +171,16 @@
>  				fsl,cpm-command = <0000>;
>  				linux,network-index = <1>;
>  			};
> +
> +			i2c@860 {
> +				compatible = "fsl,mpc866-i2c",
> +					     "fsl,cpm1-i2c",
> +					     "fsl,cpm-i2c";
> +				reg = <860 20 3c80 30>;
> +				interrupts = <10>;
> +				interrupt-parent = <&CPM_PIC>;
> +				fsl,cpm-command = <0010>;
> +			};
>  		};
>  	};
>  
> diff --git a/arch/powerpc/boot/dts/mpc885ads.dts b/arch/powerpc/boot/dts/mpc885ads.dts
> index 9895043..67d0e8d 100644
> --- a/arch/powerpc/boot/dts/mpc885ads.dts
> +++ b/arch/powerpc/boot/dts/mpc885ads.dts
> @@ -215,6 +215,16 @@
>  				fsl,cpm-command = <0x80>;
>  				linux,network-index = <2>;
>  			};
> +
> +			i2c@860 {
> +				compatible = "fsl,mpc885-i2c",
> +					     "fsl,cpm1-i2c",
> +					     "fsl,cpm-i2c";
> +				reg = <860 20 3c80 30>;
> +				interrupts = <10>;
> +				interrupt-parent = <&CPM_PIC>;
> +				fsl,cpm-command = <0010>;
> +			};
>  		};
>  	};
>  

These are v1 dts files -- you need an 0x  prefix on the hex numbers.

-Scott
