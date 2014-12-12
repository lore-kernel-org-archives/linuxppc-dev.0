Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D1D01A03A6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Dec 2014 15:39:55 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 12 Dec 2014 14:39:54 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 44F983578062
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Dec 2014 15:39:51 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBC4dpux35127544
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Dec 2014 15:39:51 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBC4dofo012245
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Dec 2014 15:39:50 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv: Print the M64 range information in bootup log
Date: Fri, 12 Dec 2014 12:39:37 +0800
Message-Id: <1418359178-3264-1-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <20141211215818.GA6584@shangw>
References: <20141211215818.GA6584@shangw>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The M64 range information is missed in dmesg, which would be helpful in debug.

This patch prints the M64 range information in the same format as M32.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

V1:
   * use pr_info() instead of printk(KERN_INFO)

---
 arch/powerpc/platforms/powernv/pci-ioda.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 21c8b4d..4fbdc7d 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -369,6 +369,9 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
 	phb->ioda.m64_segsize = phb->ioda.m64_size / phb->ioda.total_pe;
 	phb->ioda.m64_base = pci_addr;
 
+	pr_info(" MEM64 0x%016llx..0x%016llx -> 0x%016llx\n",
+			res->start, res->end, pci_addr);
+
 	/* Use last M64 BAR to cover M64 window */
 	phb->ioda.m64_bar_idx = 15;
 	phb->init_m64 = pnv_ioda2_init_m64;
-- 
1.7.9.5
