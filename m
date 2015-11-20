Return-Path: <Julia.Lawall@lip6.fr>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27B0E1A0127
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2015 07:56:29 +1100 (AEDT)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kernel-janitors@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Andrew Lunn <andrew@lunn.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH 6/6] powerpc/cell: add missing of_node_put
Date: Fri, 20 Nov 2015 21:33:24 +0100
Message-Id: <1448051604-25256-7-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1448051604-25256-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1448051604-25256-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

for_each_node_by_name performs an of_node_get on each iteration, so
a break out of the loop requires an of_node_put.

A simplified version of the semantic patch that fixes this problem is as
follows (http://coccinelle.lip6.fr):

// <smpl>
@@
expression e,e1;
local idexpression n;
@@

 for_each_node_by_name(n, e1) {
   ... when != of_node_put(n)
       when != e = n
(
   return n;
|
+  of_node_put(n);
?  return ...;
)
   ...
 }
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 arch/powerpc/platforms/cell/iommu.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 14a582b..4edceff 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -1107,6 +1107,7 @@ static int __init cell_iommu_fixed_mapping_init(void)
 			if (hbase < dbase || (hend > (dbase + dsize))) {
 				pr_debug("iommu: hash window doesn't fit in"
 					 "real DMA window\n");
+				of_node_put(np);
 				return -1;
 			}
 		}
