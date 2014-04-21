Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0204.outbound.protection.outlook.com [207.46.163.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2B0D51400FC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Apr 2014 11:11:01 +1000 (EST)
Message-ID: <1398118442.1694.190.camel@snotra.buserror.net>
Subject: Re: [PATCH 5/6] powerpc/corenet: Add DPAA FMan support to the SoC
 device tree(s)
From: Scott Wood <scottwood@freescale.com>
To: Shruti Kanetkar <Shruti@Freescale.com>
Date: Mon, 21 Apr 2014 17:14:02 -0500
In-Reply-To: <1397823693-27977-5-git-send-email-Shruti@Freescale.com>
References: <1397823693-27977-1-git-send-email-Shruti@Freescale.com>
 <1397823693-27977-5-git-send-email-Shruti@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-04-18 at 07:21 -0500, Shruti Kanetkar wrote:
> FMan 1 Gb/s MACs (dTSEC and mEMAC) have support for SGMII PHYs.
> Add support for the internal SerDes TBI PHYs
> 
> Based on prior work by Andy Fleming <afleming@gmail.com>
> 
> Signed-off-by: Shruti Kanetkar <Shruti@Freescale.com>
> ---
>  arch/powerpc/boot/dts/fsl/b4860si-post.dtsi |  28 +++++
>  arch/powerpc/boot/dts/fsl/b4si-post.dtsi    |  51 +++++++++
>  arch/powerpc/boot/dts/fsl/p1023si-post.dtsi |  14 +++
>  arch/powerpc/boot/dts/fsl/p2041si-post.dtsi |  64 ++++++++++++
>  arch/powerpc/boot/dts/fsl/p3041si-post.dtsi |  64 ++++++++++++
>  arch/powerpc/boot/dts/fsl/p4080si-post.dtsi | 104 +++++++++++++++++++
>  arch/powerpc/boot/dts/fsl/p5020si-post.dtsi |  64 ++++++++++++
>  arch/powerpc/boot/dts/fsl/p5040si-post.dtsi | 128 +++++++++++++++++++++++
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 154 ++++++++++++++++++++++++++++
>  9 files changed, 671 insertions(+)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
> index cbc354b..45b0ff5 100644
> --- a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
> @@ -172,6 +172,34 @@
>  		compatible = "fsl,b4860-rcpm", "fsl,qoriq-rcpm-2.0";
>  	};
>  
> +/include/ "qoriq-fman3-0-1g-4.dtsi"
> +/include/ "qoriq-fman3-0-1g-5.dtsi"
> +/include/ "qoriq-fman3-0-10g-0.dtsi"
> +/include/ "qoriq-fman3-0-10g-1.dtsi"
> +	fman@400000 {
> +		ethernet@e8000 {
> +			tbi-handle = <&tbi4>;
> +		};

Binding needed

Where is the "reg" for these unit addresses?

> +		mdio@e9000 {
> +			tbi4: tbi-phy@8 {
> +				reg = <0x8>;
> +				device_type = "tbi-phy";
> +			};
> +		};

Binding needed for tbi-phy device_type.  Why are we using device_type at
all for this?

-Scott
