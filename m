Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zcRhB6gkBzF0yH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Feb 2018 16:34:01 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@ozlabs.org>, Rob Herring <robh@kernel.org>,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH kernel] powerpc/pci: Fix broken INTx configuration via OF
Date: Thu,  8 Feb 2018 16:33:54 +1100
Message-Id: <20180208053354.41725-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 59f47eff03a0 ("powerpc/pci: Use of_irq_parse_and_map_pci() helper")
correctly states that of_irq_parse_and_map_pci() does the same thing as
of_irq_parse_pci() does as it simply calls
of_irq_parse_pci() and irq_create_of_mapping().

However of_irq_parse_and_map_pci() not only returns 0 for success and
negative value for an error but also a positive virq value from
irq_create_of_mapping() which the mentioned commit ignores and
INTx config fails.

This fixes the of_irq_parse_and_map_pci() return value handling.

Fixes: 59f47eff03a0 "powerpc/pci: Use of_irq_parse_and_map_pci() helper"
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

Found it on POWER9 + powernv system - almost all devices suddenly lost
INTx support.
---
 arch/powerpc/kernel/pci-common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index ae2ede4..acbb44f2 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -370,7 +370,8 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
 	memset(&oirq, 0xff, sizeof(oirq));
 #endif
 	/* Try to get a mapping from the device-tree */
-	if (!of_irq_parse_and_map_pci(pci_dev, 0, 0)) {
+	virq = of_irq_parse_and_map_pci(pci_dev, 0, 0);
+	if (virq <= 0) {
 		u8 line, pin;
 
 		/* If that fails, lets fallback to what is in the config
-- 
2.11.0
