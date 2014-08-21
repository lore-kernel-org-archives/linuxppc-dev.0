Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0181.outbound.protection.outlook.com [207.46.163.181])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 115431A0197
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Aug 2014 08:36:47 +1000 (EST)
Message-ID: <1408660593.6510.0.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc: dts: t208x: Change T208x USB controller version
From: Scott Wood <scottwood@freescale.com>
To: Nikhil Badola <nikhil.badola@freescale.com>
Date: Thu, 21 Aug 2014 17:36:33 -0500
In-Reply-To: <1408617090-29692-1-git-send-email-nikhil.badola@freescale.com>
References: <1408617090-29692-1-git-send-email-nikhil.badola@freescale.com>
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

On Thu, 2014-08-21 at 16:01 +0530, Nikhil Badola wrote:
> Change USB controller version to 2.5 in compatible string for T2080/T2081
> 
> Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
> ---
> 	Checkpatch warnings handled by commit 61a8c2c6fe71082de3ea8629589dcdd0cc5c3f02

That checkpatch warning is known to have false positives in cases where
the binding says "<CHIPNAME>-device" or "device-<VERSION>".  If you want
to update the binding to give an example with a version, that's fine,
but checkpatch shouldn't be why.  We're not going to update the binding
example again to match a different version the next time one is added to
a device tree...

> 	Documentation: dts: fsl-usb: Document USB node compatible string for IP version	
> 
>  arch/powerpc/boot/dts/fsl/t2081si-post.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
> index 97479f0..aecee96 100644
> --- a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
> +++ b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
> @@ -410,7 +410,7 @@
>  /include/ "qoriq-gpio-3.dtsi"
>  /include/ "qoriq-usb2-mph-0.dtsi"
>  	usb0: usb@210000 {
> -		compatible = "fsl-usb2-mph-v2.4", "fsl-usb2-mph";
> +		compatible = "fsl-usb2-mph-v2.5", "fsl-usb2-mph";

This is an example of why it's better to rely on version registers when
present.

-Scott
