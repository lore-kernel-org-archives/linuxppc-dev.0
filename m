Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0101.outbound.protection.outlook.com [207.46.100.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B2921A0050
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 06:44:19 +1000 (AEST)
Message-ID: <1430945040.16357.293.camel@freescale.com>
Subject: Re: [PATCH] powerpc/dts: Add 1588 timer node for eTSEC
From: Scott Wood <scottwood@freescale.com>
To: Yangbo Lu <yangbo.lu@freescale.com>
Date: Wed, 6 May 2015 15:44:00 -0500
In-Reply-To: <1430905256-4930-1-git-send-email-yangbo.lu@freescale.com>
References: <1430905256-4930-1-git-send-email-yangbo.lu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-05-06 at 17:40 +0800, Yangbo Lu wrote:
> Add 1588 timer node in files:
> arch/powerpc/boot/dts/bsc9131rdb.dtsi
> arch/powerpc/boot/dts/bsc9132qds.dtsi
> arch/powerpc/boot/dts/p1010rdb.dtsi
> arch/powerpc/boot/dts/p1020rdb-pd.dts
> arch/powerpc/boot/dts/p1021rdb-pc.dtsi
> arch/powerpc/boot/dts/p1022ds.dtsi
> arch/powerpc/boot/dts/p1025twr.dtsi
> arch/powerpc/boot/dts/p2020rdb-pc.dtsi
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> ---
>  arch/powerpc/boot/dts/bsc9131rdb.dtsi  | 12 ++++++++++++
>  arch/powerpc/boot/dts/bsc9132qds.dtsi  | 12 ++++++++++++
>  arch/powerpc/boot/dts/p1010rdb.dtsi    | 12 ++++++++++++
>  arch/powerpc/boot/dts/p1020rdb-pd.dts  | 12 ++++++++++++
>  arch/powerpc/boot/dts/p1021rdb-pc.dtsi | 12 ++++++++++++
>  arch/powerpc/boot/dts/p1022ds.dtsi     | 12 ++++++++++++
>  arch/powerpc/boot/dts/p1025twr.dtsi    | 12 ++++++++++++
>  arch/powerpc/boot/dts/p2020rdb-pc.dtsi | 15 +++++++++------
>  8 files changed, 93 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/bsc9131rdb.dtsi b/arch/powerpc/boot/dts/bsc9131rdb.dtsi
> index 45efcba..629cc03 100644
> --- a/arch/powerpc/boot/dts/bsc9131rdb.dtsi
> +++ b/arch/powerpc/boot/dts/bsc9131rdb.dtsi
> @@ -80,6 +80,18 @@
>  		status = "disabled";
>  	};
>  
> +	ptp_clock@b0e00 {
> +		compatible = "fsl,etsec-ptp";
> +		reg = <0xb0e00 0xb0>;
> +		interrupts = <68 2 0 0 69 2 0 0>;
> +		fsl,tclk-period	= <5>;
> +		fsl,tmr-prsc	= <2>;
> +		fsl,tmr-add	= <0xcccccccd>;
> +		fsl,tmr-fiper1	= <0x3b9ac9fb>;
> +		fsl,tmr-fiper2	= <0x00018696>;
> +		fsl,max-adj	= <249999999>;

Please don't use hex for numbers that make more sense as decimal.

> --- a/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
> +++ b/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
> @@ -215,12 +215,15 @@
>  	};
>  
>  	ptp_clock@24e00 {
> -		fsl,tclk-period = <5>;
> -		fsl,tmr-prsc = <200>;
> -		fsl,tmr-add = <0xCCCCCCCD>;
> -		fsl,tmr-fiper1 = <0x3B9AC9FB>;
> -		fsl,tmr-fiper2 = <0x0001869B>;
> -		fsl,max-adj = <249999999>;
> +		compatible = "fsl,etsec-ptp";
> +		reg = <0x24e00 0xb0>;
> +		interrupts = <68 2 0 0 69 2 0 0>;
> +		fsl,tclk-period	= <5>;
> +		fsl,tmr-prsc	= <2>;
> +		fsl,tmr-add	= <0xaaaaaaab>;
> +		fsl,tmr-fiper1	= <0x3b9ac9fb>;
> +		fsl,tmr-fiper2	= <0x00018696>;
> +		fsl,max-adj	= <299999999>;
>  	};

This isn't adding a node -- it's changing values.  If the old ones were
wrong, explain that in the changelog.

Also, p2020si-post.dtsi already adds interrupts to this node (and it
contains one more interrupt than the above), and it includes
pq3-etsec1-timer-0.dtsi which contains the compatible and reg (and
interrupts with two specifiers).  Probably all of these should be using
pq3-etsec1-timer-0.dtsi and only specifying the board-specific values.

-Scott
