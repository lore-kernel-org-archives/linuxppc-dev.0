Return-Path: <aik@ozlabs.ru>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r529K13bMzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 15:48:52 +1000 (AEST)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Thu, 12 May 2016 15:48:50 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3D40A3578057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 15:48:36 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4C5mNQD8388968
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 15:48:31 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4C5lwZR021647
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 15:47:58 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH kernel 1/2] powerpc/powernv: Fix insufficient memory allocation
Date: Thu, 12 May 2016 15:47:09 +1000
Message-Id: <1463032030-38974-2-git-send-email-aik@ozlabs.ru>
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

The pnv_pci_init_ioda_phb() helper allocates a blob to store auxilary
data such PE and M32/M64 segment allocation maps; this single blob has few
partitions, size of each is derived from the PE number -
phb->ioda.total_pe_num.

It was assumed that the minimum PE number is 8, however it is 4 for NPU
so the pe_alloc part was missing in the allocated blob.
It was invisible till recently as we were not tracking used M64 segments
and NPUs do not use M32 segments so the phb->ioda.m32_segmap
(which was pointing to the same address as phb->ioda.pe_alloc)
has never been written to leaving the pe_alloc memory intact.

After 401203ac2d "powerpc/powernv: Track M64 segment consumption"
the pe_alloc gets corrupted and PE allocation cannot work.
This fixes the issue by enforcing the minimum PE number to 8.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 6cda2a8..d0d32c2 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3507,7 +3507,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 				PNV_IODA1_DMA32_SEGSIZE;
 
 	/* Allocate aux data & arrays. We don't have IO ports on PHB3 */
-	size = _ALIGN_UP(phb->ioda.total_pe_num / 8, sizeof(unsigned long));
+	size = _ALIGN_UP(max_t(unsigned, phb->ioda.total_pe_num, 8) / 8,
+			sizeof(unsigned long));
 	m64map_off = size;
 	size += phb->ioda.total_pe_num * sizeof(phb->ioda.m64_segmap[0]);
 	m32map_off = size;
-- 
2.5.0.rc3
