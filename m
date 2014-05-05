Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0236.outbound.protection.outlook.com [207.46.163.236])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 223BD140278
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 May 2014 05:31:18 +1000 (EST)
Message-ID: <1399318262.15726.98.camel@snotra.buserror.net>
Subject: Re: [PATCH v3] powerpc/fsl: Added binding for Freescale CoreNet
 coherency fabric (CCF)
From: Scott Wood <scottwood@freescale.com>
To: Diana Craciun <diana.craciun@freescale.com>
Date: Mon, 5 May 2014 14:31:02 -0500
In-Reply-To: <1399305499-6612-1-git-send-email-diana.craciun@freescale.com>
References: <1399305499-6612-1-git-send-email-diana.craciun@freescale.com>
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

On Mon, 2014-05-05 at 18:58 +0300, Diana Craciun wrote:
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt b/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt
> index 922c30a..09dbc5f 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/cpus.txt
> @@ -20,3 +20,11 @@ PROPERTIES
>  	a property named fsl,eref-[CAT], where [CAT] is the abbreviated category
>  	name with all uppercase letters converted to lowercase, indicates that
>  	the category is supported by the implementation.
> +
> +	- fsl,portid-mapping : <u32>
> +	The Coherency Subdomain ID Port Mapping Registers and Snoop ID Port Mapping
> +	registers which are part of the CoreNet Coherency fabric (CCF) provide a
> +	CoreNet Coherency Subdomain ID/CoreNet Snoop ID to cpu mapping functions.
> +	Certain bits from these registers should be set if the coresponding CPU
> +	should be snooped. This property defines a bitmask which selects the bit that
> +	should be set if this cpu should be snooped.

Please follow existing formatting in this file.

> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/pamu.txt b/Documentation/devicetree/bindings/powerpc/fsl/pamu.txt
> index 1f5e329..827c637 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/pamu.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/pamu.txt
> @@ -26,6 +26,13 @@ Required properties:
>  		  A standard property.
>  - #size-cells	: <u32>
>  		  A standard property.
> +- fsl,portid-mapping : <u32>
> +	The Coherency Subdomain ID Port Mapping Registers and Snoop ID Port Mapping
> +	registers which are part of the CoreNet Coherency fabric (CCF) provide a
> +	CoreNet Coherency Subdomain ID/CoreNet Snoop ID to pamu mapping functions.
> +	Certain bits from these registers should be set if PAMUs should be snooped.
> +	This property defines a bitmask which selects the bits that should be set
> +	if PAMUs should be snooped.

This can't be a required property since existing trees don't have it --
in addition to allowing for the possibility of a PAMU where the snoop ID
is not known or where the snoop domain mechanism does not exist.

-Scott
