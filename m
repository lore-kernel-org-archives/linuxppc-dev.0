Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A8491A0163
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 22:05:01 +1000 (AEST)
In-Reply-To: <20150902153928.GB47557@linux.vnet.ibm.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [v2] powerpc/powernv/pci-ioda: fix 32-bit TCE table init in kdump
 kernel
Message-Id: <20150908120501.13340140129@ozlabs.org>
Date: Tue,  8 Sep 2015 22:05:01 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-02-09 at 15:39:28 UTC, Nishanth Aravamudan wrote:
> When attempting to kdump with the 4.2 kernel, we see for each PCI
> device:
> 
>  pci 0003:01     : [PE# 000] Assign DMA32 space
>  pci 0003:01     : [PE# 000] Setting up 32-bit TCE table at 0..80000000
>  pci 0003:01     : [PE# 000] Failed to create 32-bit TCE table, err -22

<snip>

> is a valid sanity check for pnv_pci_ioda2_table_alloc_pages(), so adjust
> the caller to pass in a smaller window size if our maximum memory value
> is smaller than the DMA window.
> 
> After this change, the PCI devices successfully set up the 32-bit TCE
> table and kdump succeeds.
> 
> The problem was seen on a Firestone machine originally.
>     
> Fixes: aca6913f5551 ("powerpc/powernv/ioda2: Introduce helpers to allocate TCE pages")
> Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/bb0054552d080dd929907c59

cheers
