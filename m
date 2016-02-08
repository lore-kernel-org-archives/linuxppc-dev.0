Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B77D1A02CD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 09:41:57 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 9 Feb 2016 08:41:54 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3208D3578054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 09:41:52 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u18MfgfH9109582
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Feb 2016 09:41:50 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u18MfJt7020042
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Feb 2016 09:41:20 +1100
Date: Tue, 9 Feb 2016 09:40:55 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH 2/2] powerpc/eeh: Reworked eeh_pe_bus_get()
Message-ID: <20160208224055.GA6171@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1454909719-17252-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1454909719-17252-2-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454909719-17252-2-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 08, 2016 at 04:35:19PM +1100, Gavin Shan wrote:
>The original implementation is ugly: unnecessary if statements and
>"out" tag. This reworks the function to avoid above weaknesses. No
>functional changes introduced.
>
>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Michael, please ignore this one now because it conflicts with another
patch which needs to be ported to stable. I'll repost all of them
later.

Thanks,
Gavin

>---
> arch/powerpc/kernel/eeh_pe.c | 28 ++++++++++++----------------
> 1 file changed, 12 insertions(+), 16 deletions(-)
>
>diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
>index 8654cb1..1d64e60 100644
>--- a/arch/powerpc/kernel/eeh_pe.c
>+++ b/arch/powerpc/kernel/eeh_pe.c
>@@ -923,25 +923,21 @@ out:
>  */
> struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe)
> {
>-	struct pci_bus *bus = NULL;
> 	struct eeh_dev *edev;
> 	struct pci_dev *pdev;
>
>-	if (pe->type & EEH_PE_PHB) {
>-		bus = pe->phb->bus;
>-	} else if (pe->type & EEH_PE_BUS ||
>-		   pe->type & EEH_PE_DEVICE) {
>-		if (pe->bus) {
>-			bus = pe->bus;
>-			goto out;
>-		}
>+	if (pe->type & EEH_PE_PHB)
>+		return pe->phb->bus;
>
>-		edev = list_first_entry(&pe->edevs, struct eeh_dev, list);
>-		pdev = eeh_dev_to_pci_dev(edev);
>-		if (pdev)
>-			bus = pdev->bus;
>-	}
>+	/* The primary bus might be cached during probe time */
>+	if (pe->bus)
>+		return pe->bus;
>
>-out:
>-	return bus;
>+	/* Retrieve the parent PCI bus of first (top) PCI device */
>+	edev = list_first_entry_or_null(&pe->edevs, struct eeh_dev, list);
>+	pdev = eeh_dev_to_pci_dev(edev);
>+	if (pdev)
>+		return pdev->bus;
>+
>+	return NULL;
> }
>-- 
>2.1.0
>
