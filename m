Return-Path: <robherring2@gmail.com>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xDYks1swLzDqv7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2017 00:56:53 +1000 (AEST)
Received: by mail-pf0-f193.google.com with SMTP id q85so5012143pfq.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jul 2017 07:56:53 -0700 (PDT)
Date: Fri, 21 Jul 2017 09:56:48 -0500
From: Rob Herring <robh@kernel.org>
To: Ivan Mikhaylov <ivan@de.ibm.com>
Cc: Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Patrice Chotard <patrice.chotard@st.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@jms.id.au>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-mmc@vger.kernel.org,
 kernel@stlinux.com
Subject: Re: [PATCH v1 2/2] 44x/fsp2: enable eMMC arasan for fsp2 platform
Message-ID: <20170721145648.eb35x26aq6nuqkpk@rob-hp-laptop>
References: <20170630115331.73869-3-ivan@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170630115331.73869-3-ivan@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 30, 2017 at 02:53:31PM +0300, Ivan Mikhaylov wrote:
> Add mmc0 changes for enabling arasan emmc and change
> defconfig appropriately.
> 
> Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>
> ---
>  arch/powerpc/boot/dts/fsp2.dts          |   33 +++++++++++++++++-------------
>  arch/powerpc/configs/44x/fsp2_defconfig |    2 +
>  2 files changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/fsp2.dts b/arch/powerpc/boot/dts/fsp2.dts
> index 475953a..6a63026 100644
> --- a/arch/powerpc/boot/dts/fsp2.dts
> +++ b/arch/powerpc/boot/dts/fsp2.dts
> @@ -52,6 +52,7 @@
>  	clocks {
>  		mmc_clk: mmc_clk {
>  			compatible = "fixed-clock";
> +			#clock-cells = <0>;
>  			clock-frequency = <50000000>;
>  			clock-output-names = "mmc_clk";
>  		};
> @@ -359,20 +360,6 @@
>  		interrupts = <31 0x4 15 0x84>;
>  	};
>  
> -	mmc0: sdhci@020c0000 {
> -		compatible	= "st,sdhci-stih407", "st,sdhci";
> -		status		= "disabled";
> -		reg		= <0x020c0000 0x20000>;
> -		reg-names	= "mmc";
> -		interrupt-parent = <&UIC1_3>;
> -		interrupts	= <21 0x4 22 0x4>;
> -		interrupt-names	= "mmcirq";
> -		pinctrl-names	= "default";
> -		pinctrl-0	= <>;
> -		clock-names	= "mmc";
> -		clocks		= <&mmc_clk>;
> -	};
> -
>  	plb6 {
>  		compatible = "ibm,plb6";
>  		#address-cells = <2>;
> @@ -501,6 +488,24 @@
>  					 /*RXDE*/  4 &UIC1_2 13 0x4>;
>  		};
>  
> +		mmc0: sdhci@020c0000 {

Use generic node names and drop leading 0: mmc@20c0000

Rob
