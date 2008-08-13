Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.226])
	by ozlabs.org (Postfix) with ESMTP id 90D1EDDDF9
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Aug 2008 15:09:28 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so2710041rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 22:09:27 -0700 (PDT)
Date: Tue, 12 Aug 2008 23:09:24 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: John Rigby <jrigby@freescale.com>
Subject: Re: [PATCH 5121 pci 1/3] powerpc: 83xx: pci: Remove need for
	get_immrbase from mpc83xx_add_bridge.
Message-ID: <20080813050924.GD17587@secretlab.ca>
References: <1218130587-31176-1-git-send-email-jrigby@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1218130587-31176-1-git-send-email-jrigby@freescale.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 07, 2008 at 11:36:25AM -0600, John Rigby wrote:
> Modify mpc83xx_add_bridge to get config space register base address from the device
> tree instead of immr + hardcoded offset.
> 
> 83xx pci nodes have these changes:
>     register properties now contain two address length tuples:
> 	First is the pci bridge register base, this has always been there.
> 	Second is the config base, this is new.
>     The primary pci bus should have the "primary" property.
> 
> These are documented in Documentation/powerpc/dts-bindings/fsl/83xx-512x-pci.txt

Looks mostly good to me.  I only have one comment on the device tree
binding...

> diff --git a/Documentation/powerpc/dts-bindings/fsl/83xx-512x-pci.txt b/Documentation/powerpc/dts-bindings/fsl/83xx-512x-pci.txt
> new file mode 100644
> index 0000000..51214a0
> --- /dev/null
> +++ b/Documentation/powerpc/dts-bindings/fsl/83xx-512x-pci.txt
> @@ -0,0 +1,43 @@
> +* Freescale 83xx and 512x PCI bridges
> +
> +Freescale 83xx and 512x SOCs include the same pci bridge core.
> +
> +83xx/512x specific notes:
> +- reg: should contain two address length tuples
> +    The first is for the internal pci bridge registers
> +    The second is for the pci config space access registers
> +- primary: 
> +    This property should be present for the primary pci bridge

Can you use something like 'fsl,primary-pci-bridge' instead?  'primary'
is a little too generic for my taste.  Also, the purpose of identifying
one of the PCI bridges as primary should be documented (This is me
pushing against encoding Linux internal implementation details into the
device tree, I suspect that 'primary' doesn't belong in the device tree
at all).
