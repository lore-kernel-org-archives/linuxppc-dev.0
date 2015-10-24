Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 95C561A01D7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2015 12:24:06 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6135B1412FE
 for <linuxppc-dev@ozlabs.org>; Sat, 24 Oct 2015 12:24:06 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Sat, 24 Oct 2015 11:24:05 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id CCDDD2CE8050
 for <linuxppc-dev@ozlabs.org>; Sat, 24 Oct 2015 12:24:02 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9O1NsnC7340144
 for <linuxppc-dev@ozlabs.org>; Sat, 24 Oct 2015 12:24:02 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9O1NUTZ021695
 for <linuxppc-dev@ozlabs.org>; Sat, 24 Oct 2015 12:23:30 +1100
Date: Sat, 24 Oct 2015 12:23:05 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/eeh: eeh_pci_enable(): fix checking of
 post-request state
Message-ID: <20151024012305.GD26601@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1445581186-10533-1-git-send-email-andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445581186-10533-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 23, 2015 at 05:19:46PM +1100, Andrew Donnellan wrote:
>In eeh_pci_enable(), after making the request to set the new options, we
>call eeh_ops->wait_state() to check that the request finished successfully.
>
>At the moment, if eeh_ops->wait_state() returns 0, we return 0 without
>checking that it reflects the expected outcome. This can lead to callers
>further up the chain incorrectly assuming the slot has been successfully
>unfrozen and continuing to attempt recovery.
>
>On powernv, this will occur if pnv_eeh_get_pe_state() or
>pnv_eeh_get_phb_state() return 0, which in turn occurs if the relevant OPAL
>call returns OPAL_EEH_STOPPED_MMIO_DMA_FREEZE or
>OPAL_EEH_PHB_ERROR respectively.
>
>On pseries, this will occur if pseries_eeh_get_state() returns 0, which in
>turn occurs if RTAS reports that the PE is in the MMIO Stopped and DMA
>Stopped states.
>
>Obviously, none of these cases represent a successful completion of a
>request to thaw MMIO or DMA.
>
>Fix the check so that a wait_state() return value of 0 won't be considered
>successful for the EEH_OPT_THAW_MMIO or EEH_OPT_THAW_DMA cases.
>
>Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
>Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks,
Gavin

>---
> arch/powerpc/kernel/eeh.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>index 40e4d4a..d757e7c 100644
>--- a/arch/powerpc/kernel/eeh.c
>+++ b/arch/powerpc/kernel/eeh.c
>@@ -677,7 +677,7 @@ int eeh_pci_enable(struct eeh_pe *pe, int function)
> 	/* Check if the request is finished successfully */
> 	if (active_flag) {
> 		rc = eeh_ops->wait_state(pe, PCI_BUS_RESET_WAIT_MSEC);
>-		if (rc <= 0)
>+		if (rc < 0)
> 			return rc;
>
> 		if (rc & active_flag)
>-- 
>Andrew Donnellan              Software Engineer, OzLabs
>andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
>+61 2 6201 8874 (work)        IBM Australia Limited
>
