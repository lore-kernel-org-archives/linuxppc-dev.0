Return-Path: <sr@denx.de>
Received: from mout-bounce.kundenserver.de (mout-bounce.kundenserver.de
	[212.227.17.3]) by ozlabs.org (Postfix) with ESMTP id 86D47DDDE7
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 16:41:56 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] AMCC Crypto4xx Device Driver v4]
Date: Fri, 5 Dec 2008 06:41:13 +0100
References: <1228256232.4770.47.camel@jhsiao-usb>
	<20081204193256.12dbc306.kim.phillips@freescale.com>
In-Reply-To: <20081204193256.12dbc306.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200812050641.13753.sr@denx.de>
Cc: jhsiao@amcc.com, herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 05 December 2008, Kim Phillips wrote:
> > diff --git a/arch/powerpc/boot/dts/canyonlands.dts
> > b/arch/powerpc/boot/dts/canyonlands.dts index 79fe412..b0f0096 100644
> > --- a/arch/powerpc/boot/dts/canyonlands.dts
> > +++ b/arch/powerpc/boot/dts/canyonlands.dts
> > @@ -116,6 +116,13 @@
> >  			dcr-reg = <0x010 0x002>;
> >  		};
> >
> > +		CRYPTO: crypto@180000 {
> > +			compatible = "amcc,ppc460ex-crypto", "amcc,ppc4xx-crypto";
> > +			reg = <4 0x00180000 0x80400>;
> > +			interrupt-parent = <&UIC0>;
> > +			interrupts = <0x1d 0x4>;
>
> that's odd, according to the current canyonlands.dts, irq 0x1d is
> already assigned to UART2 (and the request_irq this driver makes
> doesn't specify a shared flag).

UART2 is using irq 0x1d from UIC1. Using 0x1d/UIC0 is correct for Security 
EIP-94 according to the latest users manual. No sharing needed.

Best regards,
Stefan
