Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.29])
	by ozlabs.org (Postfix) with ESMTP id C6CBDDDDFA
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 15:30:00 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so360966ywh.39
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 22:29:59 -0700 (PDT)
Message-ID: <fa686aa40806272229s795067d5he962c8a1750a260@mail.gmail.com>
Date: Fri, 27 Jun 2008 22:29:59 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Kim Phillips" <kim.phillips@freescale.com>
Subject: Re: [PATCH v2] update crypto node definition and device tree instances
In-Reply-To: <20080627115243.d76e0814.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080627115243.d76e0814.kim.phillips@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 27, 2008 at 9:52 AM, Kim Phillips
<kim.phillips@freescale.com> wrote:
> delete obsolete device-type property, delete model property
> (use compatible property instead), prepend "fsl," to Freescale
> specific properties. Add nodes to device trees that are missing them,
> and fix broken property values in other trees.
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

Are there any drivers in mainline which use this node?  Do these
changes break backwards compatibility with already deployed boards?
(I know; this patch doesn't change any code; but I'm asking whether
the driver will need to support both old and new bindings).

> ---
> diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
> index 46e2da3..9a3881d 100644
> --- a/arch/powerpc/boot/dts/mpc8272ads.dts
> +++ b/arch/powerpc/boot/dts/mpc8272ads.dts
> @@ -226,22 +226,15 @@
>                        compatible = "fsl,mpc8272-pic", "fsl,cpm2-pic";
>                };
>
> -/* May need to remove if on a part without crypto engine */
>                crypto@30000 {
> -                       device_type = "crypto";
> -                       model = "SEC2";
> -                       compatible = "fsl,mpc8272-talitos-sec2",
> -                                    "fsl,talitos-sec2",
> -                                    "fsl,talitos",
> -                                    "talitos";
> +                       compatible = "fsl,sec1.0";

Should really be encoding the SoC model in the compatible property.
At the very least, compatible should be:
compatible = "fsl,mpc8272-sec", "fsl,sec1.0";

I'm really don't like "fsl,sec1.0" or any of the variants as a
compatible property either because it can easily be abused (it's not
anchored to a specific physical part so the meaning can shift over
time); but that is another argument and it is well documented in other
email threads (http://thread.gmane.org/gmane.linux.ports.ppc64.devel/38977/focus=39147)

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
