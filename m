Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F2DA1A08F6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 15:10:25 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 37C391402C4
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 15:10:25 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 13 Oct 2015 14:10:23 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B1E6D357804F
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 15:10:21 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9D4ADJk459068
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 15:10:21 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9D49mBK032705
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 15:09:48 +1100
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: imunsie@au1.ibm.com, mikey@neuling.org, Daniel Axtens <dja@axtens.net>
Subject: [PATCH] cxl: Free virtual PHB when removing
Date: Tue, 13 Oct 2015 15:09:44 +1100
Message-Id: <1444709384-10360-1-git-send-email-andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When adding a vPHB in cxl_pci_vphb_add(), we allocate a pci_controller
struct using pcibios_alloc_controller(). However, we don't free it in
cxl_pci_vphb_remove(), causing a leak.

Call pcibios_free_controller() in cxl_pci_vphb_remove() to free the vPHB
data structure correctly.

Signed-off-by: Daniel Axtens <dja@axtens.net>
Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

---

This patch depends on "powerpc/pci: export pcibios_free_controller()" [0].

[0] https://patchwork.ozlabs.org/patch/516142/
---
 drivers/misc/cxl/vphb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index 94b5208..c241e15 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -290,8 +290,10 @@ void cxl_pci_vphb_remove(struct cxl_afu *afu)
 		return;
 
 	phb = afu->phb;
+	afu->phb = NULL;
 
 	pci_remove_root_bus(phb->bus);
+	pcibios_free_controller(phb);
 }
 
 struct cxl_afu *cxl_pci_to_afu(struct pci_dev *dev)
-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
