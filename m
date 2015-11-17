Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5996A1A09E4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:39:15 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Nov 2015 11:39:14 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 253002CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:39:11 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAH1cuLm32374916
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:39:04 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAH1cbLt013756
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:38:38 +1100
Date: Tue, 17 Nov 2015 12:38:13 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 14/50] powerpc/powernv: M64 support on P7IOC
Message-ID: <20151117013813.GB31584@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-15-git-send-email-gwshan@linux.vnet.ibm.com>
 <56498D7B.7000307@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56498D7B.7000307@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 16, 2015 at 07:02:03PM +1100, Alexey Kardashevskiy wrote:
>On 11/05/2015 12:12 AM, Gavin Shan wrote:
>>This enables M64 window on P7IOC, which has been enabled on PHB3.
>>Different from PHB3 where 16 M64 BARs are supported and each of
>>them can be owned by one particular PE# exclusively or divided
>>evenly to 256 segments, every P7IOC PHB has 16 M64 BARs and each
>>of them are divided to 8 segments. So every P7IOC PHB supports
>>128 M64 segments in total. P7IOC has M64DT, which helps mapping
>>one particular M64 segment# to arbitrary PE#. PHB3 doesn't have
>>M64DT, indicating that one M64 segment can only be pinned to the
>>fixed PE#. In order to have same code to support M64 on P7IOC and
>>PHB3, we just provide 128 M64 segments on every P7IOC PHB and each
>>of them is pinned to the fixed PE# by bypassing the function of
>>M64DT. In turn, we just need different phb->init_m64() for P7IOC
>>and PHB3 to support M64.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 86 +++++++++++++++++++++++++++++--
>>  arch/powerpc/platforms/powernv/pci.h      |  3 ++
>>  2 files changed, 86 insertions(+), 3 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index 1f7d985..bfe69f1 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -256,6 +256,64 @@ static void pnv_ioda_reserve_dev_m64_pe(struct pci_dev *pdev,
>>  	}
>>  }
>>
>>+static int pnv_ioda1_init_m64(struct pnv_phb *phb)
>>+{
>>+	struct resource *r;
>>+	int index;
>>+
>>+	/*
>>+	 * There are 16 M64 BARs, each of which has 8 segments. So
>>+	 * there are as many M64 segments as the maximum number of
>>+	 * PEs, which is 128.
>>+	 */
>>+	for (index = 0; index < PNV_IODA1_M64_NUM; index++) {
>>+		unsigned long base, segsz = phb->ioda.m64_segsize;
>>+		int64_t rc;
>>+
>>+		base = phb->ioda.m64_base +
>>+		       index * PNV_IODA1_M64_SEGS * segsz;
>>+		rc = opal_pci_set_phb_mem_window(phb->opal_id,
>>+				OPAL_M64_WINDOW_TYPE, index, base, 0,
>>+				PNV_IODA1_M64_SEGS * segsz);
>>+		if (rc != OPAL_SUCCESS) {
>>+			pr_warn("  Error %lld setting M64 PHB#%d-BAR#%d\n",
>>+				rc, phb->hose->global_number, index);
>>+			goto fail;
>>+		}
>>+
>>+		rc = opal_pci_phb_mmio_enable(phb->opal_id,
>>+				OPAL_M64_WINDOW_TYPE, index,
>>+				OPAL_ENABLE_M64_SPLIT);
>>+		if (rc != OPAL_SUCCESS) {
>>+			pr_warn("  Error %lld enabling M64 PHB#%d-BAR#%d\n",
>>+				rc, phb->hose->global_number, index);
>>+			goto fail;
>>+		}
>>+	}
>>+
>>+	/*
>>+	 * Exclude the segment used by the reserved PE, which
>>+	 * is expected to be 0 or last supported PE#.
>>+	 */
>>+	r = &phb->hose->mem_resources[1];
>
>
>What does "1" mean here? A bridge's 64bit prefetchable window?
>

It's PHB's M64 window.

>
>>+	if (phb->ioda.reserved_pe_idx == 0)
>>+		r->start += phb->ioda.m64_segsize;
>>+	else if (phb->ioda.reserved_pe_idx == (phb->ioda.total_pe_num - 1))
>>+		r->end -= phb->ioda.m64_segsize;
>>+	else
>>+		pr_warn("  Cannot cut M64 segment for reserved PE#%d\n",
>>+			phb->ioda.reserved_pe_idx);
>>+

Thanks,
Gavin
