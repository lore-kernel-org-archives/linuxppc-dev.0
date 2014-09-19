Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9101C1A06ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 19:25:30 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 19 Sep 2014 19:25:28 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D5CD32CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 19:25:26 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8J91OHx26804478
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 19:01:24 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8J9PQdJ001055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Sep 2014 19:25:26 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 gwshan@linux.vnet.ibm.com
Subject: [PATCH] powerpc/pci: remove duplicate declaration of
 pci_bus_find_capability
Date: Fri, 19 Sep 2014 17:25:22 +0800
Message-Id: <1411118722-6590-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pci_bus_find_capability() is decleared in pci.h, so it is not necessary to do
it again.

This patch removes it.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-common.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index b2814e2..9cfa069 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1561,7 +1561,6 @@ EARLY_PCI_OP(write, byte, u8)
 EARLY_PCI_OP(write, word, u16)
 EARLY_PCI_OP(write, dword, u32)
 
-extern int pci_bus_find_capability (struct pci_bus *bus, unsigned int devfn, int cap);
 int early_find_capability(struct pci_controller *hose, int bus, int devfn,
 			  int cap)
 {
-- 
1.7.9.5
