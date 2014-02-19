Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0189.outbound.protection.outlook.com [207.46.163.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B29472C00E5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 11:21:08 +1100 (EST)
Message-ID: <1392769255.6733.752.camel@snotra.buserror.net>
Subject: Re: [PATCH][v2] powerpc/fsl: Add/update miscellaneous missing bindings
From: Scott Wood <scottwood@freescale.com>
To: Harninder Rai <harninder.rai@freescale.com>
Date: Tue, 18 Feb 2014 18:20:55 -0600
In-Reply-To: <1392276554-10368-1-git-send-email-harninder.rai@freescale.com>
References: <1392276554-10368-1-git-send-email-harninder.rai@freescale.com>
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

On Thu, 2014-02-13 at 12:59 +0530, Harninder Rai wrote:
> Missing bindings were found on running checkpatch.pl on bsc9132
> device tree. This patch add/update the following
> 
> - Add bindings for L2 cache controller
> - Add bindings for memory controller
> - Update bindings for USB controller
> 
> Signed-off-by: Harninder Rai <harninder.rai@freescale.com>
> ---
> Changes since base version:
> Incorporated Scott's comments
> - Rename l2cc.txt to l2cache.txt
> - Add information about ePAPR compliance
> - Add missing "cache" in compatible
> - Miscellaneous minors
> 
>  .../devicetree/bindings/powerpc/fsl/l2cache.txt    |   26 ++++++++++++++++++++
>  .../devicetree/bindings/powerpc/fsl/mem-ctrlr.txt  |   16 ++++++++++++
>  Documentation/devicetree/bindings/usb/fsl-usb.txt  |    2 +
>  3 files changed, 44 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/l2cache.txt
>  create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/mem-ctrlr.txt
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/l2cache.txt b/Documentation/devicetree/bindings/powerpc/fsl/l2cache.txt
> new file mode 100644
> index 0000000..79ef4a1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/l2cache.txt
> @@ -0,0 +1,26 @@
> +Freescale L2 Cache Controller
> +
> +L2 cache is present in Freescale's QorIQ and QorIQ Qonverge platforms.
> +The cache bindings explained below are ePAPR compliant
> +
> +Required Properties:
> +
> +- compatible	: Should include "fsl,chip-l2-cache-controller" and "cache"
> +		  where chip is the processor (bsc9132, npc8572 etc.)
> +- reg		: Address and size of L2 cache controller registers
> +- cache-size	: Size of the entire L2 cache
> +- interrupts	: Error interrupt of L2 controller
> +
> +Optional Properties:
> +
> +- cache-line-size : Size of L2 cache lines

cache-line-size is required as per ePAPR.

> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/mem-ctrlr.txt b/Documentation/devicetree/bindings/powerpc/fsl/mem-ctrlr.txt
> new file mode 100644
> index 0000000..70b42bb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/mem-ctrlr.txt
> @@ -0,0 +1,16 @@
> +Freescale DDR memory controller
> +
> +Properties:
> +
> +- compatible	: Should include "fsl,chip-memory-controller" where
> +		  chip is the processor (bsc9132, mpc8572 etc.)

Please also cover newer device trees that use
"fsl,qoriq-memory-controller" and don't have
"fsl,CHIP-memory-controller" (they also use a variant with the block
version, but since the block version is readable in a register I don't
think it's necessary to specify that here).

> diff --git a/Documentation/devicetree/bindings/usb/fsl-usb.txt b/Documentation/devicetree/bindings/usb/fsl-usb.txt
> index bd5723f..afa5809 100644
> --- a/Documentation/devicetree/bindings/usb/fsl-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/fsl-usb.txt
> @@ -9,6 +9,8 @@ Required properties :
>   - compatible : Should be "fsl-usb2-mph" for multi port host USB
>     controllers, or "fsl-usb2-dr" for dual role USB controllers
>     or "fsl,mpc5121-usb2-dr" for dual role USB controllers of MPC5121
> +   Wherever applicable, the IP version of the USB controller should
> +   also be mentioned (for eg. fsl-usb2-dr-v2.2 for bsc9132).

Please terminate the previous sentence with a period.

-Scott
