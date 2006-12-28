Return-Path: <mostrows@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA1DDDDF0D
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Dec 2006 13:41:53 +1100 (EST)
Received: from sp1n294en1.watson.ibm.com (sp1n294en1.watson.ibm.com
	[129.34.20.40])
	by igw2.watson.ibm.com (8.12.11.20060308/8.13.1/8.13.1-2005-04-25 igw)
	with ESMTP id kBS2gwGi017628
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Dec 2006 21:42:58 -0500
Received: from sp1n294en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n294en1.watson.ibm.com (AIX5.2/8.11.6p2/8.11.7/01-14-2004_2) with
	ESMTP id kBS2fnY273840
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Dec 2006 21:41:49 -0500
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n294en1.watson.ibm.com (AIX5.2/8.11.6p2/8.11.7/01-14-2004_1) with
	ESMTP id kBS2fme273838
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Dec 2006 21:41:49 -0500
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id
	kBS2ZlXo026385
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Dec 2006 21:35:47 -0500
Received: from arlx188.austin.ibm.com (arlx188.austin.ibm.com [9.3.61.188])
	by kitch0.watson.ibm.com (AIX5.3/8.11.6p2/8.11.0/03-06-2002) with ESMTP
	id kBS2flA581864
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Dec 2006 21:41:47 -0500
Received: from mostrows by arlx188.austin.ibm.com with local (Exim 4.50)
	id 1GzlHs-0006S9-7p
	for linuxppc-dev@ozlabs.org; Wed, 27 Dec 2006 20:46:32 -0600
Subject: [PATCH] Do not write virq back to PCI config space.
To: <linuxppc-dev@ozlabs.org>
Message-Id: <E1GzlHs-0006S9-7p@arlx188.austin.ibm.com>
From: Michal Ostrowski <mostrows@watson.ibm.com>
Date: Wed, 27 Dec 2006 20:46:32 -0600
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


- Drivers will not rely on the PCI config space value, as they've
  already been conditioned to rely on the irq field in "struct pci_dev".

- The virq value may not be < 256 as it has been remapped.

- The PCI config space should reflect the hardware configuration, which
  is not being changed.  We are only creating a virtual irq mapping that
  exists in the kernel only. One would never expect the PCI hardware to
  generate the "virq" interrupt.

Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>
---
 arch/powerpc/kernel/pci_64.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 9bae8a5..81a73fb 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -1305,7 +1305,6 @@ int pci_read_irq_line(struct pci_dev *pci_dev)
 	DBG(" -> mapped to linux irq %d\n", virq);
 
 	pci_dev->irq = virq;
-	pci_write_config_byte(pci_dev, PCI_INTERRUPT_LINE, virq);
 
 	return 0;
 }
-- 
1.4.4.2
