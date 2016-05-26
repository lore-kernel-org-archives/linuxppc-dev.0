Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rFVt600nMzDqJ1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 May 2016 10:50:05 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rFVt53Gpkz9sf9
 for <linuxppc-dev@ozlabs.org>; Thu, 26 May 2016 10:50:05 +1000 (AEST)
Received: from pps.filterd (m0075420.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u4Q0mgkC000524
 for <linuxppc-dev@ozlabs.org>; Wed, 25 May 2016 20:50:03 -0400
Message-Id: <201605260050.u4Q0mgkC000524@mx0a-001b2d01.pphosted.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 235f4x22bq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 25 May 2016 20:50:03 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 26 May 2016 10:50:00 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C9D792CE8065
 for <linuxppc-dev@ozlabs.org>; Thu, 26 May 2016 10:49:36 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4Q0nJju51052704
 for <linuxppc-dev@ozlabs.org>; Thu, 26 May 2016 10:49:26 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4Q0me2u026077
 for <linuxppc-dev@ozlabs.org>; Thu, 26 May 2016 10:48:40 +1000
Date: Thu, 26 May 2016 10:46:52 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, gpiccoli@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/pseries: Fix PCI config address for DDW
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <201605252359.u4PNx2IH015480@mx0a-001b2d01.pphosted.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201605252359.u4PNx2IH015480@mx0a-001b2d01.pphosted.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 26, 2016 at 09:56:07AM +1000, Gavin Shan wrote:
>In commit <8445a87f7092> ("powerpc/iommu: Remove the dependency
>on EEH struct in DDW mechanism"), the PE address was replaced
>with the PCI config address in order to remove dependency on EEH.
>According to PAPR spec, firmware (pHyp or QEMU) should accept
>"xxBBSSxx" format PCI config address, not "xxxxBBSS" provided
>by the patch. Note that "BB" is PCI bus number and "SS" is the
>combination of slot and function number.
>
>This fixes the PCI address passed to DDW RTAS calls.
>
>Fixes: 8445a87f7092 ("powerpc/iommu: Remove the dependency on EEH struct in DDW mechanism")
>Reported-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>Tested-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
>---
> arch/powerpc/platforms/pseries/iommu.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>

There are two mails sent for same patch. I don't know how is
happening. Maybe there is something wrong in my mailbox scripts.
Please ignore this one and sorry for the noise.

Thanks,
Gavin 

>diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
>index b7dfc13..3e8865b 100644
>--- a/arch/powerpc/platforms/pseries/iommu.c
>+++ b/arch/powerpc/platforms/pseries/iommu.c
>@@ -927,7 +927,7 @@ static int query_ddw(struct pci_dev *dev, const u32 *ddw_avail,
> 	dn = pci_device_to_OF_node(dev);
> 	pdn = PCI_DN(dn);
> 	buid = pdn->phb->buid;
>-	cfg_addr = (pdn->busno << 8) | pdn->devfn;
>+	cfg_addr = ((pdn->busno << 16) | (pdn->devfn << 8));
> 
> 	ret = rtas_call(ddw_avail[0], 3, 5, (u32 *)query,
> 		  cfg_addr, BUID_HI(buid), BUID_LO(buid));
>@@ -956,7 +956,7 @@ static int create_ddw(struct pci_dev *dev, const u32 *ddw_avail,
> 	dn = pci_device_to_OF_node(dev);
> 	pdn = PCI_DN(dn);
> 	buid = pdn->phb->buid;
>-	cfg_addr = (pdn->busno << 8) | pdn->devfn;
>+	cfg_addr = ((pdn->busno << 16) | (pdn->devfn << 8));
> 
> 	do {
> 		/* extra outputs are LIOBN and dma-addr (hi, lo) */
>-- 
>2.1.0
>
>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev
