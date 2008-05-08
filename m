Return-Path: <ncase@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C06D0DDE22
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 03:08:17 +1000 (EST)
Subject: [PATCH] POWERPC: Get rid of leftover printk in isa-bridge.c
From: Nate Case <ncase@xes-inc.com>
To: kernel-janitors@vger.kernel.org
Content-Type: text/plain
Date: Thu, 08 May 2008 11:41:17 -0500
Message-Id: <1210264877.13845.274.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This printk() appears twice in the same function.  Only the latter one
in the inval_range: section appears to be legitimate.

Signed-off-by: Nate Case <ncase@xes-inc.com>
---

diff --git a/arch/powerpc/kernel/isa-bridge.c b/arch/powerpc/kernel/isa-bridge.c
index ee172aa..e35092e 100644
--- a/arch/powerpc/kernel/isa-bridge.c
+++ b/arch/powerpc/kernel/isa-bridge.c
@@ -108,9 +108,6 @@ static void __devinit pci_process_ISA_OF_ranges(struct device_node *isa_node,
 	if (size > 0x10000)
 		size = 0x10000;
 
-	printk(KERN_ERR "no ISA IO ranges or unexpected isa range, "
-	       "mapping 64k\n");
-
 	__ioremap_at(phb_io_base_phys, (void *)ISA_IO_BASE,
 		     size, _PAGE_NO_CACHE|_PAGE_GUARDED);
 	return;
