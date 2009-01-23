Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <1859474fb4aabec9224df5ea2263180d504913fd.1232693349.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/4] powerpc/pseries: Fix MSI-X interrupt querying
Date: Fri, 23 Jan 2009 17:54:31 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We need to increment i in the loop that queries what interrupts firmware
gave us, otherwise we'll incorrectly use the first value over and over.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/msi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index f15222b..4af7aa3 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -199,7 +199,7 @@ static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 
 	i = 0;
 	list_for_each_entry(entry, &pdev->msi_list, list) {
-		hwirq = rtas_query_irq_number(pdn, i);
+		hwirq = rtas_query_irq_number(pdn, i++);
 		if (hwirq < 0) {
 			pr_debug("rtas_msi: error (%d) getting hwirq\n", rc);
 			return hwirq;
-- 
1.5.3.7.1.g4e596e
