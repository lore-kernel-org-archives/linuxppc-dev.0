Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9EC352C00D7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 08:40:21 +1000 (EST)
Date: Tue, 30 Jul 2013 17:40:11 -0500
From: Scott Wood <scottwood@freescale.com>
To: Sandeep Singh <sandeep@freescale.com>
Subject: Re: [4/4] Added device tree entries for Legerity SLIC node on
 various Freescale Platforms
Message-ID: <20130730224011.GA15915@home.buserror.net>
References: <1362655668-26721-4-git-send-email-Sandeep@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1362655668-26721-4-git-send-email-Sandeep@freescale.com>
Cc: Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 07, 2013 at 04:57:48PM +0530, Sandeep Singh wrote:
> diff --git a/arch/powerpc/boot/dts/p1024rdb.dtsi b/arch/powerpc/boot/dts/p1024rdb.dtsi
> index b05dcb4..cec36a3 100644
> --- a/arch/powerpc/boot/dts/p1024rdb.dtsi
> +++ b/arch/powerpc/boot/dts/p1024rdb.dtsi
> @@ -164,6 +164,19 @@
>  				label = "SPI JFFS2 RFS";
>  			};
>  		};
> +
> +                tdm_phy_0: slic@0 {
> +                        compatible = "zarlink,le88266", "tdm-phy-slic";
> +			reg = <1>;
> +			spi-max-frequency = <8000000>;
> +		};
> +
> +                tdm_phy_1: slic@1 {
> +                        compatible = "zarlink,le88266", "tdm-phy-slic";
> +			reg = <2>;
> +			spi-max-frequency = <8000000>;
> +		};
> +
>  	};
>  
>  	i2c@3000 {
> @@ -173,6 +186,11 @@
>  		};
>  	};
>  
> +        tdm@16000 {
> +                num-phy = <2>;
> +                phy-handle = <&tdm_phy_0>, <&tdm_phy_1>;
> +        };
> +
>  	usb@22000 {
>  		phy_type = "ulpi";
>  	};

Whitespace

What is "tdm-phy-slic"?  "num-phy"?  Document these in the binding and
use proper vendor prefixes.

Why "<&tdm_phy_0>, <&tdm_phy_1>" rather than "<&tdm_phy_0 &tdm_phy_1>"? 
And can you just use the length of phy-handle rather than having a
separate num-phy property?

-Scott
 
