Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 20 Dec 2007 14:54:58 +1100
Subject: [PATCH 14/19] [POWERPC] Clear pci_probe_only on 64 bits PowerMac
In-Reply-To: <1198122881.874131.56762399546.qpush@grosgo>
Message-Id: <20071220035501.79285DDF80@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
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

 arch/powerpc/platforms/powermac/pci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-merge.orig/arch/powerpc/platforms/powermac/pci.c	2007-12-14 15:49:34.000000000 +1100
+++ linux-merge/arch/powerpc/platforms/powermac/pci.c	2007-12-14 15:49:35.000000000 +1100
@@ -1041,8 +1041,8 @@ void __init pmac_pci_init(void)
 	}
 	/* pmac_check_ht_link(); */
 
-	/* Tell pci.c to not use the common resource allocation mechanism */
-	pci_probe_only = 1;
+	/* We can allocate missing resources if any */
+	pci_probe_only = 0;
 
 #else /* CONFIG_PPC64 */
 	init_p2pbridge();
