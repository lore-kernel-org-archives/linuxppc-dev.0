Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429J8l3bvhzF36g
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 20:35:51 +1000 (AEST)
Message-ID: <84ca69bb04ccbdb4c0ae04ef7e272b11ad8fcf01.camel@kernel.crashing.org>
Subject: Re: [PATCH 4/5] powerpc/powernv/pci: Enable reassigning the bus
 numbers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: linux@yadro.com
Date: Wed, 12 Sep 2018 12:35:44 +0200
In-Reply-To: <20180905154008.11130-5-s.miroshnichenko@yadro.com>
References: <20180905154008.11130-1-s.miroshnichenko@yadro.com>
 <20180905154008.11130-5-s.miroshnichenko@yadro.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-09-05 at 18:40 +0300, Sergey Miroshnichenko wrote:
> PowerNV doesn't depend on PCIe topology info from DT anymore, and now
> it is able to enumerate the fabric and assign the bus numbers.

No it's not, at least unless we drop P7 support.

P7 has constraints on the bus ranges being aligned power-of-two for the
PE assignment to work, which is why we have to honor the firmware
provided numbers.

Additionally, this breaks the mapping between the firmware idea of the
bus numbers and Linux idea. This will probably break all of the SR-IOV
stuff.

Now we should probably fix it all by removing the FW bits completely
and doing it all from Linux, though we really need to better handle how
we deal with the segmented MMIO space.

I would also be weary of what other parts of the code depends on that
matching between the FW bdfn and the Linux bdfn.

Cheers,
Ben.

> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  arch/powerpc/platforms/powernv/pci.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index 6d4280086a08..f6eaca3123cd 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -1104,6 +1104,7 @@ void __init pnv_pci_init(void)
>  	struct device_node *np;
>  
>  	pci_add_flags(PCI_CAN_SKIP_ISA_ALIGN);
> +	pci_add_flags(PCI_REASSIGN_ALL_BUS);
>  
>  	/* If we don't have OPAL, eg. in sim, just skip PCI probe */
>  	if (!firmware_has_feature(FW_FEATURE_OPAL))
