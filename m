Return-Path: <R1AAHA@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe003.messaging.microsoft.com [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0B4FCB6F98
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 04:43:10 +1100 (EST)
Date: Tue, 6 Mar 2012 11:41:12 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: Re: [PATCH] powerpc/dts: fix the compatible string of sec 4.0
Message-ID: <20120306114112.9af0bb75863f36b82e908e3d@freescale.com>
In-Reply-To: <1331018476-27798-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1331018476-27798-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, Liu Shuo <shuo.liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 6 Mar 2012 15:21:16 +0800
Shengzhou Liu <Shengzhou.Liu@freescale.com> wrote:

> From: Liu Shuo <shuo.liu@freescale.com>
> 
> Fix the compatible string of sec 4.0 to match with CAMM driver according
> to the documentation file Documentation/devicetree/bindings/crypto/fsl-sec4.txt.

s/the documentation file//, since it's pretty obvious from the
pathname.

Also, if you wrap your commit text to 75 chars, then people won't
have to use the left- and right-arrow keys when browsing git log.

> +++ b/arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi
> @@ -33,32 +33,32 @@
>   */
>  
>  crypto@30000 {
> -	compatible = "fsl,sec4.4", "fsl,sec4.0";
> +	compatible = "fsl,sec-v4.4", "fsl,sec-v4.0";

so I've tracked the original error down to v3.2-rc3-18-g5652520,
which means v3.2 was released with the error.  Consequently, the
driver should also be updated to check for "fsl,sec-v4.0", and,
failing that, check for "fsl,sec4.0".  The fix should also be sent
to stable@kernel.org [1].

Thanks,

Kim

[1] see Documentation/stable_kernel_rules.txt
