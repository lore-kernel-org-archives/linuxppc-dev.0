Return-Path: <aik@ozlabs.ru>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r52By3rpjzDqDq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 15:50:18 +1000 (AEST)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Thu, 12 May 2016 15:50:16 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9B9772CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 15:50:01 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4C5nrbH51970100
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 15:50:01 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4C5mXnH006926
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 15:48:33 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel 2/2] powerpc/powernv/npu: Add PE to PHB's list
Date: Thu, 12 May 2016 15:47:10 +1000
Message-Id: <1463032030-38974-3-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1463032030-38974-1-git-send-email-aik@ozlabs.ru>
References: <1463032030-38974-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Before 3e68dc57 "powerpc/powernv: Remove DMA32 PE list", NPU PEs
were linked to the NPU PHB via phb->ioda.pe_dma_list; after that fix,
the phb->ioda.pe_list is used.

During the pe_dma_list removal, list_add_tail(&phb->ioda.pe_dma_list)
was removed, however no list_add() was added so does this patch.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d0d32c2..4f9e73a 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1009,6 +1009,9 @@ static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
 		return NULL;
 	}
 
+	/* Put PE to the list */
+	list_add_tail(&pe->list, &phb->ioda.pe_list);
+
 	return pe;
 }
 
-- 
2.5.0.rc3
