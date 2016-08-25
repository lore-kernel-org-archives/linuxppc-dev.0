Return-Path: <wharms@bfs.de>
Received: from mx01-fr.bfs.de (mx01-fr.bfs.de [193.174.231.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKsFG6hbrzDrHp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Aug 2016 03:52:01 +1000 (AEST)
Message-ID: <57BF3038.3000801@bfs.de>
Date: Thu, 25 Aug 2016 19:51:52 +0200
From: walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
MIME-Version: 1.0
CC: linuxppc-dev@lists.ozlabs.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, Wei Yang <weiyang@linux.vnet.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] powerpc/powernv/pci: Use kmalloc_array() in two functions
References: <817567b2-cdf6-7f7b-6041-9a026ea10a0f@users.sourceforge.net>
In-Reply-To: <817567b2-cdf6-7f7b-6041-9a026ea10a0f@users.sourceforge.net>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Am 24.08.2016 22:36, schrieb SF Markus Elfring:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 24 Aug 2016 22:26:37 +0200
> 
> A multiplication for the size determination of a memory allocation
> indicated that an array data structure should be processed.
> Thus reuse the corresponding function "kmalloc_array".
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index fd9444f..2366552 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1305,7 +1305,9 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
>  	else
>  		m64_bars = 1;
>  
> -	pdn->m64_map = kmalloc(sizeof(*pdn->m64_map) * m64_bars, GFP_KERNEL);
> +	pdn->m64_map = kmalloc_array(m64_bars,
> +				     sizeof(*pdn->m64_map),
> +				     GFP_KERNEL);
>  	if (!pdn->m64_map)
>  		return -ENOMEM;
>  	/* Initialize the m64_map to IODA_INVALID_M64 */
> @@ -1572,8 +1574,9 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
>  
>  		/* Allocating pe_num_map */
>  		if (pdn->m64_single_mode)
> -			pdn->pe_num_map = kmalloc(sizeof(*pdn->pe_num_map) * num_vfs,
> -					GFP_KERNEL);
> +			pdn->pe_num_map = kmalloc_array(num_vfs,
> +							sizeof(*pdn->pe_num_map),
> +							GFP_KERNEL);
>  		else
>  			pdn->pe_num_map = kmalloc(sizeof(*pdn->pe_num_map), GFP_KERNEL);
>  


what is the value of num_vfs in the !pdn->m64_single_mode case ?
otherwise someone could make it like:

if (!pdn->m64_single_mode)
   num_vfs=1;

pdn->pe_num_map = kmalloc_array(num_vfs, ....

so it looks a bit oversophisticated.

re,
 wh
