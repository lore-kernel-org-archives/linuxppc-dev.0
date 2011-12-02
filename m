Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
 [216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 58B9A1007D4
 for <linuxppc-dev@ozlabs.org>; Sat,  3 Dec 2011 10:50:41 +1100 (EST)
Received: from mail164-va3 (localhost [127.0.0.1])	by
 mail164-va3-R.bigfish.com (Postfix) with ESMTP id A48912C06A5	for
 <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 23:50:38 +0000 (UTC)
Received: from VA3EHSMHS007.bigfish.com (unknown [10.7.14.240])	by
 mail164-va3.bigfish.com (Postfix) with ESMTP id 417052A0045	for
 <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 23:50:38 +0000 (UTC)
Message-ID: <4ED96449.8070408@freescale.com>
Date: Fri, 2 Dec 2011 17:50:33 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/85xx: add a 32-bit P1022DS device tree
References: <1322863714-6818-1-git-send-email-timur@freescale.com>
 <1322863714-6818-2-git-send-email-timur@freescale.com>
 <4ED94EF5.2090406@freescale.com> <4ED95006.9010301@freescale.com>
 <4ED95287.1010606@freescale.com> <4ED96236.9030505@freescale.com>
In-Reply-To: <4ED96236.9030505@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/02/2011 05:41 PM, Timur Tabi wrote:
> Scott Wood wrote:
> 
>> Nothing that happens in Linux excuses handing Linux a device tree that
>> is wrong.  That you need special handling in Linux indicates that this
>> is not a simple-bus.
> 
> How about this:
> 
> diff --git a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi b/arch/powerpc/boot/dts
> index 16239b1..2a62edd 100644
> --- a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
> @@ -35,7 +35,11 @@
>  &lbc {
>         #address-cells = <2>;
>         #size-cells = <1>;
> -       compatible = "fsl,p1022-elbc", "fsl,elbc", "simple-bus";
> +       /*
> +        * The localbus on the P1022 is not a simple-bus because of the eLBC
> +        * pin muxing when the DIU is enabled.
> +        */
> +       compatible = "fsl,p1022-elbc", "fsl,elbc";
>         interrupts = <19 2 0 0>;
>  };
>  

OK.

-Scott
