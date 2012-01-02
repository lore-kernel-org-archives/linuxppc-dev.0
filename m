Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
 [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 1CB48B6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jan 2012 05:27:54 +1100 (EST)
Received: from mail120-db3 (localhost [127.0.0.1])	by
 mail120-db3-R.bigfish.com (Postfix) with ESMTP id 694F02A03ED	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jan 2012 18:27:48 +0000 (UTC)
Received: from DB3EHSMHS018.bigfish.com (unknown [10.3.81.244])	by
 mail120-db3.bigfish.com (Postfix) with ESMTP id 4E1345E0042	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jan 2012 18:27:48 +0000 (UTC)
Message-ID: <4F01F721.7090407@freescale.com>
Date: Mon, 2 Jan 2012 12:27:45 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <r66093@freescale.com>
Subject: Re: [PATCH] DTS: fix the bug and add the chip compatible for eSDHC
References: <1324620659-7135-1-git-send-email-r66093@freescale.com>
In-Reply-To: <1324620659-7135-1-git-send-email-r66093@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/23/2011 12:10 AM, r66093@freescale.com wrote:
> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> Accordint to latest kernel, the auto-cmd12 property should be
> "sdhci,auto-cmd12", and according to the SDHC binding and the workaround for
> the special chip, add the chip compatible for eSDHC: "fsl,p1022-esdhc",
> "fsl,mpc8536-esdhc", "fsl,p2020-esdhc" and "fsl,p1010-esdhc".
> 
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> ---
>  arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi |    4 ++++
>  arch/powerpc/boot/dts/fsl/p1010si-post.dtsi   |    3 ++-
>  arch/powerpc/boot/dts/fsl/p1022si-post.dtsi   |    3 ++-
>  arch/powerpc/boot/dts/fsl/p2020si-post.dtsi   |    4 ++++
>  4 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
> index 89af626..44e0ed9 100644
> --- a/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
> @@ -236,6 +236,10 @@
>  	};
>  
>  /include/ "pq3-esdhc-0.dtsi"
> +	sdhc@2e000 {
> +		compatible = "fsl,esdhc", "fsl,mpc8536-esdhc";
> +	};

More-specific compatible entries should come first.

-Scott
