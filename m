Return-Path: <julia@diku.dk>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mgw2.diku.dk",
	Issuer "KU Security Authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 46898B6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Aug 2011 21:47:25 +1000 (EST)
From: Julia Lawall <julia@diku.dk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 6/9] arch/powerpc/platforms/pseries/iommu.c: add missing kfree
Date: Mon,  8 Aug 2011 13:18:00 +0200
Message-Id: <1312802283-9107-6-git-send-email-julia@diku.dk>
Cc: devicetree-discuss@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Paul Mackerras <paulus@samba.org>,
	Will Schmidt <will_schmidt@vnet.ibm.com>,
	Nishanth Aravamudan <nacc@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Julia Lawall <julia@diku.dk>

At this point, window has not been stored anywhere, so it has to be freed
before leaving the function.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@exists@
local idexpression x;
statement S,S1;
expression E;
identifier fl;
expression *ptr != NULL;
@@

x = \(kmalloc\|kzalloc\|kcalloc\)(...);
...
if (x == NULL) S
<... when != x
     when != if (...) { <+...kfree(x)...+> }
     when any
     when != true x == NULL
x->fl
...>
(
if (x == NULL) S1
|
if (...) { ... when != x
               when forall
(
 return \(0\|<+...x...+>\|ptr\);
|
* return ...;
)
}
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/powerpc/platforms/pseries/iommu.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 2b20b05..6351af8 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -940,14 +940,14 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	if (ret) {
 		dev_info(&dev->dev, "failed to map direct window for %s: %d\n",
 			 dn->full_name, ret);
-		goto out_clear_window;
+		goto out_free_window;
 	}
 
 	ret = prom_add_property(pdn, win64);
 	if (ret) {
 		dev_err(&dev->dev, "unable to add dma window property for %s: %d",
 			 pdn->full_name, ret);
-		goto out_clear_window;
+		goto out_free_window;
 	}
 
 	window->device = pdn;
@@ -959,6 +959,9 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	dma_addr = of_read_number(&create.addr_hi, 2);
 	goto out_unlock;
 
+out_free_window:
+	kfree(window);
+
 out_clear_window:
 	remove_ddw(pdn);
 
