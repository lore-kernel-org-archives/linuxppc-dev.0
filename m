Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJRKh47T8zDvnG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 12:21:12 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAG1J0Ca063953
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 20:21:10 -0500
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26rcgbth3g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 20:21:10 -0500
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 16 Nov 2016 11:21:08 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D62D32CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 12:21:05 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAG1L5PQ52035804
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 12:21:05 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAG1L5NC019931
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 12:21:05 +1100
Date: Wed, 16 Nov 2016 12:22:16 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com,
 alistair@popple.id.au
Subject: Re: [PATCH] powerpc/powernv: Don't warn on PE init if unfreeze is
 unsupported
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20161116011226.24589-1-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161116011226.24589-1-ruscur@russell.cc>
Message-Id: <20161116012216.GA1405@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 16, 2016 at 12:12:26PM +1100, Russell Currey wrote:
>Whenever a PE is initialised in powernv, opal_pci_eeh_freeze_clear() is
>called.  This is to remove any existing freeze, and has no negative side
>effects if the PE is already in an unfrozen state.  On PHB backends that
>don't support this operation and return OPAL_UNSUPPORTED, this creates a
>scary and misleading warning message.
>
>Skip the warning message on init if OPAL_UNSUPPORTED is returned.
>
>As far as I'm aware, this currently only affects NPUs.
>
>Fixes: 313483d ("powerpc/powernv: Unfreeze PE on allocation")
>Signed-off-by: Russell Currey <ruscur@russell.cc>

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
> arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index d4b33dd..dcdfee0 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -145,7 +145,7 @@ static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, int pe_no)
> 	 */
> 	rc = opal_pci_eeh_freeze_clear(phb->opal_id, pe_no,
> 				       OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
>-	if (rc != OPAL_SUCCESS)
>+	if (rc != OPAL_SUCCESS && rc != OPAL_UNSUPPORTED)
> 		pr_warn("%s: Error %lld unfreezing PHB#%d-PE#%d\n",
> 			__func__, rc, phb->hose->global_number, pe_no);
>
>-- 
>2.10.2
>
