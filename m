Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5EA5E1A0B96
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 01:29:49 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 11 Dec 2014 00:29:46 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 34312357804C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 01:29:44 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBAEThQF25559260
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 01:29:44 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBAETgQ5007096
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 01:29:43 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com
Subject: [PATCH] powerpc/powernv: Print the M64 range information
Date: Wed, 10 Dec 2014 22:29:37 +0800
Message-Id: <1418221778-12458-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The M64 range information is missed, which would be helpful in debug.

This patch print the M64 range information in the same format as M32.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 21c8b4d..34f1a27 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -369,6 +369,9 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
 	phb->ioda.m64_segsize = phb->ioda.m64_size / phb->ioda.total_pe;
 	phb->ioda.m64_base = pci_addr;
 
+	printk(KERN_INFO " MEM64 0x%016llx..0x%016llx -> 0x%016llx\n",
+			res->start, res->end, pci_addr);
+
 	/* Use last M64 BAR to cover M64 window */
 	phb->ioda.m64_bar_idx = 15;
 	phb->init_m64 = pnv_ioda2_init_m64;
-- 
1.7.9.5
