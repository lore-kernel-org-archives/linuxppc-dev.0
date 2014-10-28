Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ABEE51A0053
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Oct 2014 05:19:49 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0106.outbound.protection.outlook.com [157.56.111.106])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 99B6B140081
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2014 05:19:48 +1100 (AEDT)
Message-ID: <1414520373.23458.92.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/4] dt/bindings: Introduce the FSL QorIQ DPAA BMan
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@Freescale.com>
Date: Tue, 28 Oct 2014 13:19:33 -0500
In-Reply-To: <1413986972-621-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1413986972-621-1-git-send-email-Emilian.Medve@Freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, pawel.moll@arm.com,
 ijc+devicetree@hellion.org.uk, Geoff.Thorpe@Freescale.com, corbet@lwn.net,
 linux-doc@vger.kernel.org, linuxppc-dev@ozlabs.org, robh+dt@kernel.org,
 galak@codeaurora.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-10-22 at 09:09 -0500, Emil Medve wrote:
> The Buffer Manager is part of the Data-Path Acceleration Architecture (DPAA).
> BMan supports hardware allocation and deallocation of buffers belonging to
> pools originally created by software with configurable depletion thresholds.
> This binding covers the CCSR space programming model
> 
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> Change-Id: I3ec479bfb3c91951e96902f091f5d7d2adbef3b2
> ---
>  .../devicetree/bindings/powerpc/fsl/bman.txt       | 98 ++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/bman.txt
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/bman.txt b/Documentation/devicetree/bindings/powerpc/fsl/bman.txt
> new file mode 100644
> index 0000000..c30bdde
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/bman.txt
> @@ -0,0 +1,98 @@
> +QorIQ DPAA Buffer Manager Device Tree Bindings
> +
> +Copyright (C) 2008 - 2014 Freescale Semiconductor Inc.
> +
> +CONTENTS
> +
> +	- BMan Node
> +	- BMan Private Memory Node
> +	- Example
> +
> +NOTE:	The bindings described in this document are preliminary and subject to
> +	change
> +
> +BMan Node
> +
> +PROPERTIES
> +
> +- compatible
> +	Usage:		Required
> +	Value type:	<stringlist>
> +	Definition:	Must include "fsl,bman"
> +			May include "fsl,<SoC>-bman"
> +
> +- reg
> +	Usage:		Required
> +	Value type:	<prop-encoded-array>
> +	Definition:	Registers region within the CCSR address space

Is there a version register in reg?  It would be nice to point it out in
the binding along with an example chip for each version, similar to
Documentation/devicetree/bindings/powerpc/fsl/interlaken-lac.txt.  This
would make it clear that the compatible needs to be changed if the
version register moves or no longer works the same way.

> +BMan Private Memory Node
> +
> +BMan requires a contiguous range of physical memory used for the backing store
> +for BMan Free Buffer Proxy Records. This memory is reserved/allocated as a node
> +under the /reserved-memory node
> +
> +The BMan FBPR memory node must be named "bman-fbpr"
> +
> +PROPERTIES
> +
> +- compatible
> +	Usage:		required
> +	Value type:	<stringlist>
> +	Definition:	Must inclide "fsl,bman-fbpr"
> +
> +The following constraints are relevant to the FBPR private memory:
> +	- The size must be 2^(size + 1), with size = 11..33. That is 4 KiB to
> +	  16 GiB
> +	- The alignment must be a muliptle of the memory size
> +
> +The size of the FBPR must be chosen by observing the hardware features configured
> +via the RCW and that are relevant to a specific board (e.g. number of MAC(s)
> +pinned-out, number of offline/host command FMan ports, etc.). The size configured
> +in the DT must reflect the hardware capabilities and not the specific needs of an
> +application

What about accelerators?

> +If the memory reserved in the device tree proves to be larger then the needs of
> +the application a BMan driver may provide a method to release the extra memory
> +back to the OS

What if the memory reserved in the device tree proves to be smaller than
the needs of the application?

I think we should document this size as being a sane default for the
hardware, and add a way of describing that the size is tunable.

Below is the reserved-memory extension that I suggested to you
internally:

resizable (optional) - empty property
    - Indicates that the size of the dynamic allocation is flexible.  If
resizeable is present, the size property is optional.  If both resizable
and size are present, the size property indicates a recommended default
size for this hardware.

pow2-aligned (optional) - empty property
    - Only valid if resizable is present.  Indicates that the size must
be a power of two, and the address must be aligned to its size.  If both
pow2-aligned and alignment properties are present, pow2-aligned is used
if the region is resized, and the alignment property is used if the
region is not resized.

min-size (optional) - Only valid if resizable is present.  Specifies a
minimum acceptable size.

max-size (optional) - Only valid if resizable is present.  Specifies a
maximum acceptable size.

-Scott
