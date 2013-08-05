Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1AE742C007B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 08:16:36 +1000 (EST)
Message-ID: <1375740987.13074.65.camel@snotra.buserror.net>
Subject: Re: [PATCH] Add device file bindings for MAPLE
From: Scott Wood <scottwood@freescale.com>
To: Shaveta Leekha <shaveta@freescale.com>
Date: Mon, 5 Aug 2013 17:16:27 -0500
In-Reply-To: <1375354963-11219-1-git-send-email-shaveta@freescale.com>
References: <1375354963-11219-1-git-send-email-shaveta@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-08-01 at 16:32 +0530, Shaveta Leekha wrote:
> Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
> ---
>  .../devicetree/bindings/powerpc/fsl/maple.txt      |   30 ++++++++++++++++++++
>  1 files changed, 30 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/maple.txt
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/maple.txt b/Documentation/devicetree/bindings/powerpc/fsl/maple.txt
> new file mode 100644
> index 0000000..da51c5f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/maple.txt
> @@ -0,0 +1,30 @@
> +* Freescale MAPLE Multi Accelerator Platform Engine Baseband 3
> +  (MAPLE-B3)device nodes
> +
> +Supported chips:
> +Example: B4860
> +
> +Required properties:
> +
> +- compatible:	Should contain "fsl,maple-b3-liodn" as the value
> +		This identifies Multi Accelerator Platform Engine
> +		Baseband 3 block.This representation is required
> +		for doing the PAMU/LIODN programming on the Linux side.

Device tree bindings should not talk about particular OSes or use cases
(except for use case information that is part of the AMP partitioning,
and thus not at the discretion of the OS).  Just say that this
identifies the LIODN register of the block.

> +
> +- reg:		offset and length of the register set for the device
> +
> +Devices that have LIODNs need to specify links to the parent PAMU controller
> +(the actual PAMU controller that this device is connected to) and a pointer to
> +the LIODN register, if applicable.
> +
> +- fsl,iommu-parent
> +		: <phandle>
> +		This property should be present
> +
> +Example:
> +	/* B4860 */
> +	maple@800000 {
> +		compatible = "fsl,maple-b3-liodn";
> +		reg = <0x8000000 0x10000>;

Unit address doesn't match reg (missing/extra zero).

-Scott
