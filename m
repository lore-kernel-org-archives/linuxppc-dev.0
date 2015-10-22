Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45FFF1A048F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 12:04:10 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1595E141319
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2015 12:04:10 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 22 Oct 2015 11:04:08 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2FD3F2CE8054
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2015 12:04:06 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9M13iZn30408816
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2015 12:03:53 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9M13XZj016127
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2015 12:03:33 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/powernv: Fix M64 resource name in /proc/iomem
Date: Thu, 22 Oct 2015 12:03:08 +1100
Message-Id: <1445475788-30348-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The name of PCI root bus's M64 resource isn't initialized properly.
When dumping "/proc/iomem", "<BAD>" is seen for those M64 resources
on PCI root buses.

   ~# cat /proc/iomem | grep -e "BAD"
   3b0000000000-3b0fefffffff : <BAD>
   3b1000000000-3b1fefffffff : <BAD>
   3c0000000000-3c0fefffffff : <BAD>
   3c1000000000-3c1fefffffff : <BAD>
   3c2000000000-3c2fefffffff : <BAD>

This fixes the issue by setting the name of PCI root bus's M64
resource to that of PHB's device node full name. With the patch,
no "<BAD>" is seen from "/proc/iomem".

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 414fd1a..3b726aa 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -357,6 +357,7 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
 	}
 
 	res = &hose->mem_resources[1];
+	res->name = dn->full_name;
 	res->start = of_translate_address(dn, r + 2);
 	res->end = res->start + of_read_number(r + 4, 2) - 1;
 	res->flags = (IORESOURCE_MEM | IORESOURCE_MEM_64 | IORESOURCE_PREFETCH);
-- 
2.1.0
