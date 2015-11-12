Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2016C1A0017
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 17:16:29 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 12 Nov 2015 16:16:27 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D8BD2357804F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 17:16:24 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAC6GA9v26935510
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 17:16:18 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAC6Fpre010062
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 17:15:52 +1100
Date: Thu, 12 Nov 2015 17:15:25 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, benh@kernel.crashing.org,
 mpe@ellerman.id.au, aik@ozlabs.ru, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 39/50] powerpc/powernv: Fundamental reset in
 pnv_pci_reset_secondary_bus()
Message-ID: <20151112061525.GA18894@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-40-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446642770-4681-40-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 05, 2015 at 12:12:39AM +1100, Gavin Shan wrote:
>In pnv_pci_reset_secondary_bus(), we should issue fundamental
>reset if any one subordinate device of the specified is requesting
                                        ^^^^^^^^^^^^^^

                                        the specified bus

I put the note reminding me to admend the changelog in next revision.

>that. Otherwise, the device might not come up after the reset.
>
>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>---
> arch/powerpc/platforms/powernv/eeh-powernv.c | 21 ++++++++++++++++++++-
> 1 file changed, 20 insertions(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>index c69b6a1..ab8b93e 100644
>--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>@@ -878,9 +878,28 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
> 	return 0;
> }
>
>+static int pnv_pci_dev_reset_type(struct pci_dev *pdev, void *data)
>+{
>+	int *freset = data;
>+
>+	/*
>+	 * Stop the iteration immediately if there has any one
>+	 * PCI device requesting fundamental reset.
>+	 */
>+	*freset |= pdev->needs_freset;
>+	return *freset;
>+}
>+
> void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
> {
>-	pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
>+	int option, freset = 0;
>+
>+	if (dev->subordinate)
>+		pci_walk_bus(dev->subordinate,
>+			     pnv_pci_dev_reset_type, &freset);
>+
>+	option = freset ? EEH_RESET_FUNDAMENTAL : EEH_RESET_HOT;
>+	pnv_eeh_bridge_reset(dev, option);
> 	pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
> }
>
>-- 
>2.1.0
>
