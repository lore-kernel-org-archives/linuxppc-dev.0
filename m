Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6529D1A024F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 11:40:27 +1100 (EST)
Date: Tue, 14 Oct 2014 11:40:26 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH] powerpc/pci: Quieten unset I/O resource warning
Message-ID: <20141014114026.1d340c1c@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Newer POWER designs do not implement PCI I/O space, so we
expect to see a number of these.

Reduce the severity of the warning so it doesn't mask other
real issues.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: b/arch/powerpc/kernel/pci-common.c
===================================================================
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1460,7 +1460,7 @@ static void pcibios_setup_phb_resources(
 	res = &hose->io_resource;
 
 	if (!res->flags) {
-		printk(KERN_WARNING "PCI: I/O resource not set for host"
+		pr_info("PCI: I/O resource not set for host"
 		       " bridge %s (domain %d)\n",
 		       hose->dn->full_name, hose->global_number);
 	} else {
