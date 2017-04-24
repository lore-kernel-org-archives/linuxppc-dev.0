Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wB7YY53cwzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 11:10:09 +1000 (AEST)
Message-ID: <1492996197.25397.12.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: roy.pledge@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 robin.murphy@arm.com
Cc: madalin.bucur@nxp.com
Date: Sun, 23 Apr 2017 20:09:57 -0500
In-Reply-To: <1492634930-10765-4-git-send-email-roy.pledge@nxp.com>
References: <1492634930-10765-1-git-send-email-roy.pledge@nxp.com>
 <1492634930-10765-4-git-send-email-roy.pledge@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v2 03/11] dt-bindings: soc/fsl: Update reserved memory
 binding for QBMan
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-19 at 16:48 -0400, Roy Pledge wrote:
> Updates the QMan and BMan device tree bindings for reserved memory
> nodes. This makes the reserved memory allocation compatiable with
> the shared-dma-pool usage.
> 
> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> ---
>  Documentation/devicetree/bindings/soc/fsl/bman.txt | 11 ++++++-----
>  Documentation/devicetree/bindings/soc/fsl/qman.txt | 18 +++++++++++-------
>  2 files changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/bman.txt
> b/Documentation/devicetree/bindings/soc/fsl/bman.txt
> index 47ac834..3cd1e2c 100644
> --- a/Documentation/devicetree/bindings/soc/fsl/bman.txt
> +++ b/Documentation/devicetree/bindings/soc/fsl/bman.txt
> @@ -65,8 +65,8 @@ to the respective BMan instance
>  BMan Private Memory Node
>  
>  BMan requires a contiguous range of physical memory used for the backing
> store
> -for BMan Free Buffer Proxy Records (FBPR). This memory is
> reserved/allocated as a
> -node under the /reserved-memory node
> +for BMan Free Buffer Proxy Records (FBPR). This memory is
> reserved/allocated as
> +a node under the /reserved-memory node.
>  
>  The BMan FBPR memory node must be named "bman-fbpr"
>  
> @@ -75,7 +75,8 @@ PROPERTIES
>  - compatible
>  	Usage:		required
>  	Value type:	<stringlist>
> -	Definition:	Must inclide "fsl,bman-fbpr"
> +	Definition:	PPC platforms: Must include "fsl,bman-fbpr"
> +			ARM platforms: Must include "shared-dma-pool"
>  
>  The following constraints are relevant to the FBPR private memory:
>  	- The size must be 2^(size + 1), with size = 11..33. That is 4 KiB
> to
> @@ -100,10 +101,10 @@ The example below shows a BMan FBPR dynamic allocation
> memory node
>  		ranges;
>  
>  		bman_fbpr: bman-fbpr {
> -			compatible = "fsl,bman-fbpr";
> -			alloc-ranges = <0 0 0x10 0>;
> +			compatible = "shared-mem-pool";
>  			size = <0 0x1000000>;
>  			alignment = <0 0x1000000>;
> +			no-map;
>  		};
>  	};
>  

The requirement for using no-map with shared-mem-pool should be explicitly
stated, not just in the example.

-Scott
