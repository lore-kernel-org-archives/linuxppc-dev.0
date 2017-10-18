Return-Path: <aik@ozlabs.ru>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yH0qx3y04zDrJj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 16:25:01 +1100 (AEDT)
Received: by mail-it0-x242.google.com with SMTP id c3so5220123itc.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 22:25:01 -0700 (PDT)
Subject: Re: [PATCH 2/3] powernv/pci: Use common code in pnv_ioda_pick_m64_pe()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linuxppc-dev@lists.ozlabs.org, Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Rob Herring <robh@kernel.org>, Russell Currey <ruscur@russell.cc>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <549d0b6b-f875-c524-d867-742745117c1e@users.sourceforge.net>
 <84df26ea-74a3-14e5-9f13-a35486e9a95d@users.sourceforge.net>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <6c6611ec-bd22-593c-3cca-106374cf2320@ozlabs.ru>
Date: Wed, 18 Oct 2017 16:24:51 +1100
MIME-Version: 1.0
In-Reply-To: <84df26ea-74a3-14e5-9f13-a35486e9a95d@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18/10/17 02:39, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 17 Oct 2017 17:07:54 +0200
> 
> Add a jump target so that a bit of code can be better reused
> at the end of this function.


Rather than moving bits around, I'd rather allocate pe_alloc on stack and
ditch kfree() at all. I'll make a patch for this.

> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 17c0330bb059..98d9435240f4 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -364,21 +364,20 @@ static struct pnv_ioda_pe *pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>  	/* Figure out reserved PE numbers by the PE */
>  	pnv_ioda_reserve_m64_pe(bus, pe_alloc, all);
>  
> +	master_pe = NULL;
> +
>  	/*
>  	 * the current bus might not own M64 window and that's all
>  	 * contributed by its child buses. For the case, we needn't
>  	 * pick M64 dependent PE#.
>  	 */
> -	if (bitmap_empty(pe_alloc, phb->ioda.total_pe_num)) {
> -		kfree(pe_alloc);
> -		return NULL;
> -	}
> +	if (bitmap_empty(pe_alloc, phb->ioda.total_pe_num))
> +		goto free_pe;
>  
>  	/*
>  	 * Figure out the master PE and put all slave PEs to master
>  	 * PE's list to form compound PE.
>  	 */
> -	master_pe = NULL;
>  	i = -1;
>  	while ((i = find_next_bit(pe_alloc, phb->ioda.total_pe_num, i + 1)) <
>  		phb->ioda.total_pe_num) {
> @@ -416,6 +415,7 @@ static struct pnv_ioda_pe *pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
>  		}
>  	}
>  
> +free_pe:
>  	kfree(pe_alloc);
>  	return master_pe;
>  }
> 



-- 
Alexey
