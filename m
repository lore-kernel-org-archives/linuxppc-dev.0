Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qx1hS5vYwzDqCW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 14:59:36 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 29 Apr 2016 14:59:34 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 824902CE8093
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 14:58:54 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3T4wa5q63832300
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 14:58:44 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3T4wCSs010001
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 14:58:12 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: [PATCH kernel] powerpc/powernv: Fix debug macro
Date: Fri, 29 Apr 2016 14:56:06 +1000
Message-Id: <1461905766-22558-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When cfg_dbg() is enabled (i.e. mapped to printk()), gcc produces
errors as the __func__ parameter is missing (pnv_pci_cfg_read() has one);
this adds the missing parameter.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 73c8dc2..cec1530 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -463,7 +463,7 @@ int pnv_pci_cfg_write(struct pci_dn *pdn,
 	u32 bdfn = (pdn->busno << 8) | pdn->devfn;
 
 	cfg_dbg("%s: bus: %x devfn: %x +%x/%x -> %08x\n",
-		pdn->busno, pdn->devfn, where, size, val);
+		__func__, pdn->busno, pdn->devfn, where, size, val);
 	switch (size) {
 	case 1:
 		opal_pci_config_write_byte(phb->opal_id, bdfn, where, val);
-- 
2.5.0.rc3
