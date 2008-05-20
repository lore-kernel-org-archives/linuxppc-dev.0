Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6315FDDF41
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 16:25:14 +1000 (EST)
Message-Id: <4990A008-475B-46B5-821D-0B3FEA6C6F4C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jason Jin <Jason.jin@freescale.com>
In-Reply-To: <1210931447-16234-1-git-send-email-Jason.jin@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 1/4 V3] booting-without-of for Freescale MSI
Date: Tue, 20 May 2008 01:23:22 -0500
References: <1210931447-16234-1-git-send-email-Jason.jin@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 16, 2008, at 4:50 AM, Jason Jin wrote:

> Binding document adding for Freescale MSI support.
>
> Signed-off-by: Jason Jin <Jason.jin@freescale.com>
> ---
> Change the compatible name in this V3 version.
>
> Documentation/powerpc/booting-without-of.txt |   41 +++++++++++++++++ 
> ++++++++-
> 1 files changed, 40 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/powerpc/booting-without-of.txt b/ 
> Documentation/powerpc/booting-without-of.txt
> index 1d2a772..789cd5a 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -57,7 +57,10 @@ Table of Contents
>       n) 4xx/Axon EMAC ethernet nodes
>       o) Xilinx IP cores
>       p) Freescale Synchronous Serial Interface
> -	  q) USB EHCI controllers
> +      q) USB EHCI controllers
> +      r) Freescale Display Interface Unit
> +      s) Freescale on board FPGA
> +      t) Freescael MSI interrupt controller
>
>   VII - Marvell Discovery mv64[345]6x System Controller chips
>     1) The /system-controller node
> @@ -2870,6 +2873,42 @@ platforms are moved over to use the flattened- 
> device-tree model.
> 		reg = <0xe8000000 32>;
> 	};
>
> +    t) Freescale MSI interrupt controller
> +
> +    Reguired properities:
> +    - compatible : set as "fsl,mpc8610-msi" for all the cpu which  
> use MPIC,
> +      and set as "fsl,mpc8379-msi" for those use IPIC.

I'd like to see "fsl,ipic-msi" and "fsl,mpic-msi".  If we are going to  
use "chip" names we should use the first in each family that had the  
support so it would be:

"fsl,mpc8641-msi", "fsl,mpc8379-msi", and "fsl,mpc8548-msi".  However  
I've never been a big fan of using the "first" in family like this.   
It becomes difficult later to use this if we have to deal with errata  
on a given device to distinguish things.

So my preference it that we have:

compatible = "fsl,mpc8610-msi", "fsl,mpic-msi";

for the 8610, and for 8572 we'd have:

compatible = "fsl,mpc8572-msi", "fsl,mpic-msi";

so like DMA its "fsl,CHIP-msi", and either "fsl,mpic-msi" or "fsl,ipic- 
msi" depending on the parent type.

- k
