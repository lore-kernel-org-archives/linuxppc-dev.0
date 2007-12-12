Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 12 Dec 2007 16:23:04 +1100
Subject: [PATCH 13/13] [POWERPC] Clear pci_probe_only on 64 bits PowerMac
In-Reply-To: <1197436973.110379.888292904645.qpush@grosgo>
Message-Id: <20071212052308.F0C3FDE038@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It should now be safe to re-assign unassigned resources on 64 bits PowerMac
machines (G5s). This clears pci_probe_only on those.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/platforms/powermac/pci.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index 5615635..8f808f0 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -1041,8 +1041,8 @@ void __init pmac_pci_init(void)
 	}
 	/* pmac_check_ht_link(); */
 
-	/* Tell pci.c to not use the common resource allocation mechanism */
-	pci_probe_only = 1;
+	/* We can allocate missing resources if any */
+	pci_probe_only = 0;
 
 #else /* CONFIG_PPC64 */
 	init_p2pbridge();
-- 
1.5.3.7
