Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1DD591A0452
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 16:48:06 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 12 Jun 2015 16:48:05 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1E6A52BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 16:48:01 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5C6lrJu27263030
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 16:48:01 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5C6lRph004656
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 16:47:28 +1000
Date: Fri, 12 Jun 2015 16:47:03 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Add devices only from
 buses which belong to PE
Message-ID: <20150612064703.GA17776@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1434089957-27135-1-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1434089957-27135-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 12, 2015 at 04:19:17PM +1000, Alexey Kardashevskiy wrote:
>The existing code puts all devices from a root PE to the same IOMMU group.
>However it is a possible situation when subordinate buses belong to
>separate PEs, in this case devices from these subordinate buses
>should be added to lower level PE rather to the root PE.
>
>This limits pnv_ioda_setup_bus_dma() invocation to only PEs which own
>all subordinate buses.
>
>Suggested-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Alexey, I think it's good candidate for stable.

Thanks,
Gavin

>---
>
>This would be nice to have together with the DDW patchset.
>This does not fix anything DDW patchset did, it fixes IOMMU
>groups management which is essential for the whole feature to work.
>
>---
> arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index a0b00c1..3b1dc79 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -1702,7 +1702,7 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
> 		set_iommu_table_base(&dev->dev, pe->table_group.tables[0]);
> 		iommu_add_device(&dev->dev);
>
>-		if (dev->subordinate)
>+		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
> 			pnv_ioda_setup_bus_dma(pe, dev->subordinate);
> 	}
> }
>-- 
>2.4.0.rc3.8.gfb3e7d5
>
