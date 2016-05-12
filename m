Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r52q34DJQzDqBs
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 16:18:07 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 12 May 2016 16:18:03 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 88F8B2BB0064
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 16:17:49 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4C6HVBa59703330
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 16:17:39 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4C6H6Pj024207
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 16:17:07 +1000
Date: Thu, 12 May 2016 16:15:35 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Alistair Popple <alistair@popple.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel 2/2] powerpc/powernv/npu: Add PE to PHB's list
Message-ID: <20160512061535.GA5956@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1463032030-38974-1-git-send-email-aik@ozlabs.ru>
 <1463032030-38974-3-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1463032030-38974-3-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 12, 2016 at 03:47:10PM +1000, Alexey Kardashevskiy wrote:
>Before 3e68dc57 "powerpc/powernv: Remove DMA32 PE list", NPU PEs
>were linked to the NPU PHB via phb->ioda.pe_dma_list; after that fix,
>the phb->ioda.pe_list is used.
>
>During the pe_dma_list removal, list_add_tail(&phb->ioda.pe_dma_list)
>was removed, however no list_add() was added so does this patch.
>
>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
> arch/powerpc/platforms/powernv/pci-ioda.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index d0d32c2..4f9e73a 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -1009,6 +1009,9 @@ static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
> 		return NULL;
> 	}
>
>+	/* Put PE to the list */
>+	list_add_tail(&pe->list, &phb->ioda.pe_list);
>+
> 	return pe;
> }
>
>-- 
>2.5.0.rc3
>
