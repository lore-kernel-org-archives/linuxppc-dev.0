Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0A86CDDF13
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 09:24:49 +1000 (EST)
Message-ID: <482B74D7.7080508@freescale.com>
Date: Wed, 14 May 2008 18:25:11 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: akpm@linux-foundation.org
Subject: Re: [patch 2/4] powerpc: add i2c pins to dts and board setup
References: <200805142312.m4ENCrIb026259@imap1.linux-foundation.org>
In-Reply-To: <200805142312.m4ENCrIb026259@imap1.linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

akpm@linux-foundation.org wrote:
> From: Jochen Friedrich <jochen@scram.de>
> 
> Initialize I2C pins on boards with CPM1/CPM2 controllers.
> 
> Signed-off-by: Jochen Friedrich <jochen@scram.de>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/powerpc/boot/dts/mpc8272ads.dts         |   10 ++++++++++
>  arch/powerpc/boot/dts/mpc866ads.dts          |   10 ++++++++++
>  arch/powerpc/boot/dts/mpc885ads.dts          |   10 ++++++++++
>  arch/powerpc/platforms/82xx/mpc8272_ads.c    |    4 ++++
>  arch/powerpc/platforms/8xx/mpc86xads_setup.c |    4 ++++
>  arch/powerpc/platforms/8xx/mpc885ads_setup.c |    3 +++
>  6 files changed, 41 insertions(+)
> 
> diff -puN arch/powerpc/boot/dts/mpc8272ads.dts~powerpc-add-i2c-pins-to-dts-and-board-setup arch/powerpc/boot/dts/mpc8272ads.dts
> --- a/arch/powerpc/boot/dts/mpc8272ads.dts~powerpc-add-i2c-pins-to-dts-and-board-setup
> +++ a/arch/powerpc/boot/dts/mpc8272ads.dts
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

As I pointed out earlier, this patch is sticking dts-v0 style constants 
into a dts-v1 file.  It will not work.

We also need to document CPM2 i2c as an exception to the normal 
interpretation of the second resource for a CPM device in 
booting-without-of.txt.

-Scott
