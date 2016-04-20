Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqMbZ1jtmzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 10:05:46 +1000 (AEST)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 20 Apr 2016 10:05:45 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 661E12CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 10:05:30 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3K05M5j7668214
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 10:05:30 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3K04vdh030390
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 10:04:58 +1000
Date: Wed, 20 Apr 2016 10:04:32 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
Subject: Re: [PATCH v8 09/45] powerpc/powernv: Simplify pnv_ioda_setup_pe_seg()
Message-ID: <20160420000432.GB11304@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-10-git-send-email-gwshan@linux.vnet.ibm.com>
 <570DEB13.10906@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <570DEB13.10906@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 13, 2016 at 04:45:39PM +1000, Alexey Kardashevskiy wrote:
>On 02/17/2016 02:43 PM, Gavin Shan wrote:
>>The original implementation of pnv_ioda_setup_pe_seg() configures
>>IO and M32 segments by separate logics, which can be merged by
>>by caching @segmap, @seg_size, @win in advance. This shouldn't
>>cause any behavioural changes.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 62 ++++++++++++++-----------------
>>  1 file changed, 28 insertions(+), 34 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index 44cc5f3..fd7d382 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -2940,8 +2940,10 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
>>  	struct pnv_phb *phb = hose->private_data;
>>  	struct pci_bus_region region;
>>  	struct resource *res;
>>-	int i, index;
>>-	int rc;
>>+	unsigned int segsize;
>>+	int *segmap, index, i;
>>+	uint16_t win;
>>+	int64_t rc;
>>
>>  	/*
>>  	 * NOTE: We only care PCI bus based PE for now. For PCI
>>@@ -2958,23 +2960,9 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
>>  		if (res->flags & IORESOURCE_IO) {
>>  			region.start = res->start - phb->ioda.io_pci_base;
>>  			region.end   = res->end - phb->ioda.io_pci_base;
>>-			index = region.start / phb->ioda.io_segsize;
>>-
>>-			while (index < phb->ioda.total_pe_num &&
>>-			       region.start <= region.end) {
>>-				phb->ioda.io_segmap[index] = pe->pe_number;
>>-				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
>>-					pe->pe_number, OPAL_IO_WINDOW_TYPE, 0, index);
>>-				if (rc != OPAL_SUCCESS) {
>>-					pr_err("%s: OPAL error %d when mapping IO "
>>-					       "segment #%d to PE#%d\n",
>>-					       __func__, rc, index, pe->pe_number);
>>-					break;
>>-				}
>>-
>>-				region.start += phb->ioda.io_segsize;
>>-				index++;
>>-			}
>>+			segsize      = phb->ioda.io_segsize;
>>+			segmap       = phb->ioda.io_segmap;
>>+			win          = OPAL_IO_WINDOW_TYPE;
>>  		} else if ((res->flags & IORESOURCE_MEM) &&
>>  			   !pnv_pci_is_mem_pref_64(res->flags)) {
>>  			region.start = res->start -
>>@@ -2983,23 +2971,29 @@ static void pnv_ioda_setup_pe_seg(struct pci_controller *hose,
>>  			region.end   = res->end -
>>  				       hose->mem_offset[0] -
>>  				       phb->ioda.m32_pci_base;
>>-			index = region.start / phb->ioda.m32_segsize;
>>-
>>-			while (index < phb->ioda.total_pe_num &&
>>-			       region.start <= region.end) {
>>-				phb->ioda.m32_segmap[index] = pe->pe_number;
>>-				rc = opal_pci_map_pe_mmio_window(phb->opal_id,
>>-					pe->pe_number, OPAL_M32_WINDOW_TYPE, 0, index);
>>-				if (rc != OPAL_SUCCESS) {
>>-					pr_err("%s: OPAL error %d when mapping M32 "
>>-					       "segment#%d to PE#%d",
>>-					       __func__, rc, index, pe->pe_number);
>>-					break;
>>-				}
>>+			segsize      = phb->ioda.m32_segsize;
>>+			segmap       = phb->ioda.m32_segmap;
>>+			win          = OPAL_M32_WINDOW_TYPE;
>>+		} else {
>>+			continue;
>>+		}
>>
>>-				region.start += phb->ioda.m32_segsize;
>>-				index++;
>>+		index = region.start / segsize;
>>+		while (index < phb->ioda.total_pe_num &&
>>+		       region.start <= region.end) {
>>+			segmap[index] = pe->pe_number;
>>+			rc = opal_pci_map_pe_mmio_window(phb->opal_id,
>>+					pe->pe_number, win, 0, index);
>>+			if (rc != OPAL_SUCCESS) {
>>+				pr_warn("%s: Error %lld mapping (%d) seg#%d to PHB#%d-PE#%d\n",
>>+					__func__, rc, win, index,
>>+					pe->phb->hose->global_number,
>>+					pe->pe_number);
>>+				break;
>
>Please move this loop to a helper and stop caching segsize/segmap/win; this
>will make the code easier to read and the next patch will look much cleaner
>as it will not have to move this exact loop.
>

Thanks. It's good idea and I'll change the code accordingly in next revision.

>>  			}
>>+
>>+			region.start += segsize;
>>+			index++;
>>  		}
>>  	}
>>  }
>>
>
>
>-- 
>Alexey
>
