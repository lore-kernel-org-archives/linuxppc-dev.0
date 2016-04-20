Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqQvX1XzlzDqBK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 12:34:48 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 20 Apr 2016 12:34:47 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 1CEA03578056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 12:34:35 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3K2YRiU7143710
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 12:34:35 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3K2Y1Xw016540
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 12:34:02 +1000
Date: Wed, 20 Apr 2016 12:33:06 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
Subject: Re: [PATCH v8 37/45] powerpc/powernv: Use firmware PCI slot reset
 infrastructure
Message-ID: <20160420023306.GD28594@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-38-git-send-email-gwshan@linux.vnet.ibm.com>
 <5715FBBF.2000108@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5715FBBF.2000108@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 19, 2016 at 07:34:55PM +1000, Alexey Kardashevskiy wrote:
>On 02/17/2016 02:44 PM, Gavin Shan wrote:
>>The skiboot firmware might provide the PCI slot reset capability
>>which is identified by property "ibm,reset-by-firmware" on the
>>PCI slot associated device node.
>>
>>This checks the property. If it exists, the reset request is routed
>>to firmware. Otherwise, the reset is done by kernel as before.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/platforms/powernv/eeh-powernv.c | 41 +++++++++++++++++++++++++++-
>>  1 file changed, 40 insertions(+), 1 deletion(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>index e23b063..c8a5217 100644
>>--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>>+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>@@ -789,7 +789,7 @@ static int pnv_eeh_root_reset(struct pci_controller *hose, int option)
>>  	return ret;
>>  }
>>
>>-static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
>>+static int __pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
>>  {
>>  	struct pci_dn *pdn = pci_get_pdn_by_devfn(dev->bus, dev->devfn);
>>  	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
>>@@ -840,6 +840,45 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
>>  	return 0;
>>  }
>>
>>+static int pnv_eeh_bridge_reset(struct pci_dev *pdev, int option)
>>+{
>>+	struct pci_controller *hose;
>>+	struct pnv_phb *phb;
>>+	struct device_node *dn = pdev ? pci_device_to_OF_node(pdev) : NULL;
>>+	uint64_t id = (0x1ul << 60);
>
>
>What is this 1<<60 for?
>
>

As you replied in other threads, it's worthy to have some macros for this
piece of business. This bit indicates the ID of the slot behind a switch
port. If this bit is cleared, the ID represents a PHB slot.

>>+	uint8_t scope;
>>+	int64_t rc;
>>+
>>+	/*
>>+	 * If the firmware can't handle it, we will issue hot reset
>>+	 * on the secondary bus despite the requested reset type.
>>+	 */
>>+	if (!dn || !of_get_property(dn, "ibm,reset-by-firmware", NULL))
>>+		return __pnv_eeh_bridge_reset(pdev, option);
>>+
>>+	/* The firmware can handle the request */
>>+	switch (option) {
>>+	case EEH_RESET_HOT:
>>+		scope = OPAL_RESET_PCI_HOT;
>>+		break;
>>+	case EEH_RESET_FUNDAMENTAL:
>>+		scope = OPAL_RESET_PCI_FUNDAMENTAL;
>>+		break;
>>+	case EEH_RESET_DEACTIVATE:
>>+		return 0;
>>+	default:
>>+		dev_warn(&pdev->dev, "%s: Unsupported reset %d\n",
>>+			 __func__, option);
>
>
>Can the userspace trigger this case (via VFIO-EEH) and flood dmesg?
>

It depends on how you defined message flooding actually. It's abnormal
path caused by program internal error, not external users.

>
>
>>+		return -EINVAL;
>>+	}
>>+
>>+	hose = pci_bus_to_host(pdev->bus);
>>+	phb = hose->private_data;
>>+	id |= (pdev->bus->number << 24) | (pdev->devfn << 16) | phb->opal_id;
>>+	rc = opal_pci_reset(id, scope, OPAL_ASSERT_RESET);
>>+	return pnv_pci_poll(id, rc, NULL);
>>+}
>>+
>>  static int pnv_pci_dev_reset_type(struct pci_dev *pdev, void *data)
>>  {
>>  	int *freset = data;
>>
>
>
>-- 
>Alexey
>
