Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A3FBA1A05D9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 09:40:36 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 11 Dec 2014 08:40:34 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 143E12CE8064
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 09:40:31 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBAMeUMD26738762
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 09:40:31 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBAMeUUn014683
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 09:40:30 +1100
Date: Thu, 11 Dec 2014 09:40:30 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Print the M64 range information
Message-ID: <20141210224030.GA13035@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1418221778-12458-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418221778-12458-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 10, 2014 at 10:29:37PM +0800, Wei Yang wrote:
>The M64 range information is missed, which would be helpful in debug.
>
>This patch print the M64 range information in the same format as M32.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>---
> arch/powerpc/platforms/powernv/pci-ioda.c |    3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index 21c8b4d..34f1a27 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -369,6 +369,9 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
> 	phb->ioda.m64_segsize = phb->ioda.m64_size / phb->ioda.total_pe;
> 	phb->ioda.m64_base = pci_addr;
>
>+	printk(KERN_INFO " MEM64 0x%016llx..0x%016llx -> 0x%016llx\n",
>+			res->start, res->end, pci_addr);
>+

Please output segment size if you think it's helpful as well.

Thanks,
Gavin

> 	/* Use last M64 BAR to cover M64 window */
> 	phb->ioda.m64_bar_idx = 15;
> 	phb->init_m64 = pnv_ioda2_init_m64;
>-- 
>1.7.9.5
>
