Return-Path: <julia@diku.dk>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BD3DCB70A8
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Aug 2010 05:50:39 +1000 (EST)
Date: Tue, 3 Aug 2010 21:50:32 +0200 (CEST)
From: Julia Lawall <julia@diku.dk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Grant Likely <grant.likely@secretlab.ca>, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] arch/powerpc: Drop unnecessary of_node_put
Message-ID: <Pine.LNX.4.64.1008032149410.20393@ask.diku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Julia Lawall <julia@diku.dk>

for_each_node_by_name only exits when its first argument is NULL, and a
subsequent call to of_node_put on that argument is unnecessary.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
iterator name for_each_node_by_name;
expression np,E;
identifier l;
@@

for_each_node_by_name(np,...) {
  ... when != break;
      when != goto l;
}
... when != np = E
- of_node_put(np);
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/powerpc/platforms/powermac/feature.c |    1 -
 arch/powerpc/platforms/powermac/pci.c     |    2 --
 2 files changed, 3 deletions(-)

diff -u -p a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -2872,7 +2872,6 @@ set_initial_features(void)
 				core99_airport_enable(np, 0, 0);
 			}
 		}
-		of_node_put(np);
 	}
 
 	/* On all machines that support sound PM, switch sound off */
diff -u -p a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -1155,13 +1155,11 @@ void __init pmac_pcibios_after_init(void
 			pmac_call_feature(PMAC_FTR_1394_CABLE_POWER, nd, 0, 0);
 		}
 	}
-	of_node_put(nd);
 	for_each_node_by_name(nd, "ethernet") {
 		if (nd->parent && of_device_is_compatible(nd, "gmac")
 		    && of_device_is_compatible(nd->parent, "uni-north"))
 			pmac_call_feature(PMAC_FTR_GMAC_ENABLE, nd, 0, 0);
 	}
-	of_node_put(nd);
 }
 
 void pmac_pci_fixup_cardbus(struct pci_dev* dev)
