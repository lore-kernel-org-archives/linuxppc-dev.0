Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4D51BDDFE6
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 09:50:20 +1000 (EST)
Subject: Re: [PATCH 1/1 resend][PPC] replace logical by bitand in
	pci_process_ISA_OF_ranges(), arch/powerpc/kernel/isa-bridge.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roel Kluin <12o3l@tiscali.nl>
In-Reply-To: <47FA9FA6.8090201@tiscali.nl>
References: <47FA9FA6.8090201@tiscali.nl>
Content-Type: text/plain
Date: Tue, 08 Apr 2008 09:50:10 +1000
Message-Id: <1207612210.10388.492.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, lkml <linux-kernel@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-04-08 at 00:26 +0200, Roel Kluin wrote:
> in arch/powerpc/kernel/isa-bridge.c:
> 41:#define ISA_SPACE_MASK 0x1
> 42:#define ISA_SPACE_IO 0x1
> ...
> 
> 83:    if ((range->isa_addr.a_hi && ISA_SPACE_MASK) != ISA_SPACE_IO) {
> ...
> 89:    if ((range->isa_addr.a_hi && ISA_SPACE_MASK) != ISA_SPACE_IO)
> 
> I think these should be single &'s, I can't test it (no hardware)
> please consider the patch below.
> --
> replace logical by bit and for ISA_SPACE_MASK
> 
> Signed-off-by: Roel Kluin <12o3l@tiscali.nl>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> diff --git a/arch/powerpc/kernel/isa-bridge.c b/arch/powerpc/kernel/isa-bridge.c
> index f0f49d1..406a9e6 100644
> --- a/arch/powerpc/kernel/isa-bridge.c
> +++ b/arch/powerpc/kernel/isa-bridge.c
> @@ -80,13 +80,13 @@ static void __devinit pci_process_ISA_OF_ranges(struct device_node *isa_node,
>  	 *			(size depending on dev->n_addr_cells)
>  	 *   cell 5:		the size of the range
>  	 */
> -	if ((range->isa_addr.a_hi && ISA_SPACE_MASK) != ISA_SPACE_IO) {
> +	if ((range->isa_addr.a_hi & ISA_SPACE_MASK) != ISA_SPACE_IO) {
>  		range++;
>  		rlen -= sizeof(struct isa_range);
>  		if (rlen < sizeof(struct isa_range))
>  			goto inval_range;
>  	}
> -	if ((range->isa_addr.a_hi && ISA_SPACE_MASK) != ISA_SPACE_IO)
> +	if ((range->isa_addr.a_hi & ISA_SPACE_MASK) != ISA_SPACE_IO)
>  		goto inval_range;
>  
>  	isa_addr = range->isa_addr.a_lo;
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
