Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 247661A0130
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 10:05:49 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 12 May 2015 10:05:47 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0ABB0357804C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 10:05:47 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4C05cUc29163632
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 10:05:46 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4C05EKX005881
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 10:05:14 +1000
Date: Tue, 12 May 2015 10:04:49 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH v4 10/21] powerpc/powernv: Fundamental reset for PCI bus
 reset
Message-ID: <20150512000449.GD4646@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-11-git-send-email-gwshan@linux.vnet.ibm.com>
 <554E15C2.40506@ozlabs.ru> <20150511064720.GB8241@gwshan>
 <55505796.5030904@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55505796.5030904@ozlabs.ru>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 11, 2015 at 05:17:42PM +1000, Alexey Kardashevskiy wrote:
>On 05/11/2015 04:47 PM, Gavin Shan wrote:
>>On Sun, May 10, 2015 at 12:12:18AM +1000, Alexey Kardashevskiy wrote:
>>>On 05/01/2015 04:02 PM, Gavin Shan wrote:
>>>>Function pnv_pci_reset_secondary_bus() is used to reset specified
>>>>PCI bus, which is leaded by root complex or PCI bridge. That means
>>>>the function shouldn't be called on PCI root bus and the patch
>>>>removes the logic for that case.
>>>>
>>>>Also, some adapters beneath the indicated PCI bus may require
>>>>fundamental reset in order to successfully reload their firmwares
>>>>after the reset. The patch translates hot reset to fundamental reset
>>>>for that case.
>>>>
>>>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>>---
>>>>  arch/powerpc/platforms/powernv/eeh-powernv.c | 35 +++++++++++++++++++++-------
>>>>  1 file changed, 26 insertions(+), 9 deletions(-)
>>>>
>>>>diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>>>index 3c01095..58e4dcf 100644
>>>>--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>>>>+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>>>@@ -888,18 +888,35 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
>>>>  	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
>>>>  }
>>>>
>>>>-void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
>>>
>>>
>>>Why changing dev to pdev? Keeping "dev" could make the patch simpler.
>>>
>>
>>In the early stage when I wrote the EEH code, I had "dev" to refer PCI
>>device, which isn't precisely enough. Actually, "dev" means "struct device"
>>while "pdev" stands for "struct pci_dev". That's why I changed it.
>
>
>The rest of the file and the kernel overall use "dev" for pci_dev just fine.
>I would not bother.
>

Ok. I'll keep it.

>>>>+static int pnv_pci_dev_reset_type(struct pci_dev *pdev, void *data)
>>>>  {
>>>>-	struct pci_controller *hose;
>>>>+	int *freset = data;
>>>>
>>>>-	if (pci_is_root_bus(dev->bus)) {
>>>>-		hose = pci_bus_to_host(dev->bus);
>>>>-		pnv_eeh_phb_reset(hose, EEH_RESET_HOT);
>>>>-		pnv_eeh_phb_reset(hose, EEH_RESET_DEACTIVATE);
>>>>-	} else {
>>>>-		pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
>>>>-		pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
>>>>+	/*
>>>>+	 * Stop the iteration immediately if there is any
>>>>+	 * one PCI device requesting fundamental reset
>>>>+	 */
>>>>+	*freset |= pdev->needs_freset;
>>>>+	return *freset;
>>>>+}
>>>>+
>>>>+void pnv_pci_reset_secondary_bus(struct pci_dev *pdev)
>>>>+{
>>>>+	int option = EEH_RESET_HOT;
>>>>+	int freset = 0;
>>>>+
>>>>+	/* Check if there're any PCI devices asking for fundamental reset */
>>>>+	if (pdev->subordinate) {
>>>>+		pci_walk_bus(pdev->subordinate,
>>>>+			     pnv_pci_dev_reset_type,
>>>>+			     &freset);
>>>>+		if (freset)
>>>>+			option = EEH_RESET_FUNDAMENTAL;
>>>>  	}
>>>>+
>>>>+	/* Issue the requested type of reset */
>>>>+	pnv_eeh_bridge_reset(pdev, option);
>>>>+	pnv_eeh_bridge_reset(pdev, EEH_RESET_DEACTIVATE);
>>>>  }
>>>>
>>>>  /**
>>>>

Thanks,
Gavin
