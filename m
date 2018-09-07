Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 426TSx3SMmzF3BT
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Sep 2018 06:25:05 +1000 (AEST)
Message-ID: <c19f11e200258297dbe5a61392a4bbc1e937d7c3.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Ran Wang <ran.wang_1@nxp.com>, Leo Li <leoyang.li@nxp.com>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Fri, 07 Sep 2018 15:22:48 -0500
In-Reply-To: <20180831035219.31619-2-ran.wang_1@nxp.com>
References: <20180831035219.31619-1-ran.wang_1@nxp.com>
 <20180831035219.31619-2-ran.wang_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 2/3] Documentation: dt: binding: fsl: update property
 description for RCPM
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-08-31 at 11:52 +0800, Ran Wang wrote:
> +Optional properties:
> + - big-endian : Indicate RCPM registers is big-endian. A RCPM node
> +   that doesn't have this property will be regarded as little-endian.

You've just broken all the existing powerpc device trees that are big-endian
and have no big-endian property.

> + - <property 'compatible' string of consumer device> : This string
> +   is referred by RCPM driver to judge if the consumer (such as flex timer)
> +   is able to be regards as wakeup source or not, such as 'fsl,ls1012a-
> ftm'.
> +   Further, this property will carry the bit mask info to control
> +   coresponding wake up source.

What will you do if there are multiple instances of a device with the same
compatible, and different wakeup bits?  Plus, it's an awkward design in
general, and you don't describe what the value actually means (bits in which
register?).  What was wrong with the existing binding?  Alternatively, use the
clock bindings.

> -
> -Example:
> -	lpuart0: serial@2950000 {
> -		compatible = "fsl,ls1021a-lpuart";
> -		reg = <0x0 0x2950000 0x0 0x1000>;
> -		interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&sysclk>;
> -		clock-names = "ipg";
> -		fsl,rcpm-wakeup = <&rcpm 0x0 0x40000000>;
> +		big-endian;
> +		fsl,ls1012a-ftm = <0x20000>;
> +		fsl,pfe = <0xf0000020>;

fsl,pfe is not documented.

-Scott
