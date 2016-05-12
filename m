Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4znL3HHqzDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 14:01:26 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 12 May 2016 14:01:24 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A53042BB0086
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 14:00:05 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4C3xqSM20971602
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 14:00:00 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4C3xRgu008984
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 13:59:28 +1000
Date: Thu, 12 May 2016 13:48:54 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 mpe@ellerman.id.au, aik@ozlabs.ru, alistair@popple.id.au
Subject: Re: [PATCH v9 26/26] powerpc/powernv: Exclude root bus in
 pnv_pci_reset_secondary_bus()
Message-ID: <20160512034854.GA10460@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1462254105-24128-27-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462254105-24128-27-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 03, 2016 at 03:41:45PM +1000, Gavin Shan wrote:
>The function pnv_pci_reset_secondary_bus() is called like below.
>It's impossible for call the function on root bus. So it's safe
>to remove the root bus case in the function. No functional changes
>introduced.
>
>   pci_parent_bus_reset() / pci_bus_reset() / pci_try_reset_bus()
>   pci_reset_bridge_secondary_bus()
>   pcibios_reset_secondary_bus()
>   pnv_pci_reset_secondary_bus()
>
>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>Reviewed-by: Daniel Axtens <dja@axtens.net>
>Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>---
> arch/powerpc/platforms/powernv/eeh-powernv.c | 12 ++----------
> 1 file changed, 2 insertions(+), 10 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>index 9226df1..593b8dc 100644
>--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>@@ -868,16 +868,8 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
>
> void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
> {
>-	struct pci_controller *hose;
>-
>-	if (pci_is_root_bus(dev->bus)) {
>-		hose = pci_bus_to_host(dev->bus);
>-		pnv_eeh_root_reset(hose, EEH_RESET_HOT);
>-		pnv_eeh_root_reset(hose, EEH_RESET_DEACTIVATE);
>-	} else {
>-		pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
>-		pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
>-	}
>+	pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
>+	pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
> }

Michael, please revert this one as it is already in linux-ppc-next
branch. Sorry for the overhead.

Obviously, I missed the truth that it affects the PCI passthrou path as
reported by Alexey: When passing GPU (0003:01:00.0) which seats behind
the root port, the reset request is routed to skiboot in original code.
In skiboot, the link bouncing events are masked during the reset. So we
don't see EEH (freeze all) error even link bouncing happens. With the
changes included, the reset is done by kernel and the link bouncing
events aren't masked by altering content of PHB3 (or P7IOC) specific
hardware registers which are invisible to kernel (skiboot hides the
hardware specific). It means the link bouncing is seen by the root port
and it causes a EEH (freeze all) error. The PCI passthrough on GPU device
cannot work.

Thanks,
Gavin

>
> static void pnv_eeh_wait_for_pending(struct pci_dn *pdn, const char *type,
>-- 
>2.1.0
>
