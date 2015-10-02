Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5BF611A04E5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Oct 2015 03:18:08 +1000 (AEST)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Fri, 2 Oct 2015 11:18:06 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 573FF19D804A
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 11:06:16 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t92HH7VW5964194
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 10:17:07 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t92HI2Cs026880
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Oct 2015 11:18:03 -0600
Date: Fri, 2 Oct 2015 10:18:00 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Matthew Wilcox <willy@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/iommu: expose IOMMU page shift
Message-ID: <20151002171800.GB41011@linux.vnet.ibm.com>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151002171606.GA41011@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We will leverage this macro in the NVMe driver, which needs to know the
configured IOMMU page shift to properly configure its device's page
size.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

---
Given this is available, it seems reasonable to expose -- and it doesn't
really make sense to make the driver do a log2 call on the existing
IOMMU_PAGE_SIZE() value.

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index ca18cff..6fdf857 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -36,6 +36,7 @@
 #define IOMMU_PAGE_MASK_4K       (~((1 << IOMMU_PAGE_SHIFT_4K) - 1))
 #define IOMMU_PAGE_ALIGN_4K(addr) _ALIGN_UP(addr, IOMMU_PAGE_SIZE_4K)
 
+#define IOMMU_PAGE_SHIFT(tblptr) (tblptr)->it_page_shift
 #define IOMMU_PAGE_SIZE(tblptr) (ASM_CONST(1) << (tblptr)->it_page_shift)
 #define IOMMU_PAGE_MASK(tblptr) (~((1 << (tblptr)->it_page_shift) - 1))
 #define IOMMU_PAGE_ALIGN(addr, tblptr) _ALIGN_UP(addr, IOMMU_PAGE_SIZE(tblptr))
