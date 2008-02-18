Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9E4DEDDFBC
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 01:02:04 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id m1IE1fFI019855
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 01:01:41 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1IE23am3203094
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 01:02:03 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1IE22p9016858
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2008 01:02:03 +1100
Date: Mon, 18 Feb 2008 19:31:59 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] next-20080218 build failure at pmac_ide_macio_attach ()
Message-ID: <20080218140159.GA31310@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-ide@vger.kernel.org, sfr@canb.auug.org.au, linuxppc-dev@ozlabs.org
Reply-To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

The next-20080218 kernel build fails on the powerpc(s)

drivers/ide/ppc/pmac.c: In function ‘pmac_ide_macio_attach’:
drivers/ide/ppc/pmac.c:1094: error: conversion to non-scalar type requested
drivers/ide/ppc/pmac.c: In function ‘pmac_ide_pci_attach’:
drivers/ide/ppc/pmac.c:1232: error: conversion to non-scalar type requested
make[3]: *** [drivers/ide/ppc/pmac.o] Error 1
make[2]: *** [drivers/ide/ppc] Error 2
make[1]: *** [drivers/ide] Error 2
make: *** [drivers] Error 2

I Have tested this patch for build failure only.

Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
--- linux-2.6.25-rc1/drivers/ide/ppc/pmac.c	2008-02-18 18:41:48.000000000 +0530
+++ linux-2.6.25-rc1/drivers/ide/ppc/~pmac.c	2008-02-18 19:20:37.000000000 +0530
@@ -1091,7 +1091,7 @@ pmac_ide_macio_attach(struct macio_dev *
 	int irq, rc;
 	hw_regs_t hw;
 
-	pmif = (struct pmac_ide_hwif)kzalloc(sizeof(*pmif), GFP_KERNEL);
+	pmif = (struct pmac_ide_hwif*)kzalloc(sizeof(*pmif), GFP_KERNEL);
 	if (pmif == NULL)
 		return -ENOMEM;
 
@@ -1229,7 +1229,7 @@ pmac_ide_pci_attach(struct pci_dev *pdev
 		return -ENODEV;
 	}
 
-	pmif = (struct pmac_ide_hwif)kzalloc(sizeof(*pmif), GFP_KERNEL);
+	pmif = (struct pmac_ide_hwif*)kzalloc(sizeof(*pmif), GFP_KERNEL);
 	if (pmif == NULL)
 		return -ENOMEM;
 
-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
