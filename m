Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtF5K39RmzDr8P
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 20:24:37 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8EAOB4E128562
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 06:24:35 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cyqvb0gq3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 06:24:34 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 14 Sep 2017 04:24:34 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: obh+dt@kernel.org, frowand.list@gmail.com, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: [PATCH] drivers: of: static DT reservations incorrectly added to
 dynamic list
Date: Thu, 14 Sep 2017 20:24:15 +1000
Message-Id: <20170914102415.26395-1-stewart@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are two types of memory reservations firmware can ask the kernel
to make in the device tree: static and dynamic.
See Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt

If you have greater than 16 entries in /reserved-memory (as we do on
POWER9 systems) you would get this scary looking error message:
[    0.000000] OF: reserved mem: not enough space all defined regions.

This is harmless if all your reservations are static (which with OPAL on
POWER9, they are).

It is not harmless if you have any dynamic reservations after the 16th.

In the first pass over the fdt to find reservations, the child nodes of
/reserved-memory are added to a static array in of_reserved_mem.c so that
memory can be reserved in a 2nd pass. The array has 16 entries. This is why,
on my dual socket POWER9 system, I get that error 4 times with 20 static
reservations.

We don't have a problem on ppc though, as in arch/powerpc/kernel/prom.c
we look at the new style /reserved-ranges property to do reservations,
and this logic was introduced in 0962e8004e974 (well before any powernv
system shipped).

Google shows up no occurances of that exact error message, so we're probably
safe in that no machine that people use has memory not being reserved when
it should be.

The fix is simple, as there's a different code path for static and dynamic
allocations, we just don't add the region to the list if it's static. Since
it's a static *OR* dynamic region, this is a perfectly valid thing to do
(although I have not checked every real world device tree on the planet
for this condition)

Fixes: 3f0c8206644836e4f10a6b9fc47cda6a9a372f9b
Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
NOTE: I've done only fairly limited testing of this on POWER, I
certainly haven't tested on ARM or *anything* with dynamic
allocations. So, testing and comments welcome.
---
 drivers/of/fdt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index ce30c9a588a4..a9a44099ed69 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -587,7 +587,7 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 	phys_addr_t base, size;
 	int len;
 	const __be32 *prop;
-	int nomap, first = 1;
+	int nomap;
 
 	prop = of_get_flat_dt_prop(node, "reg", &len);
 	if (!prop)
@@ -614,10 +614,6 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 				uname, &base, (unsigned long)size / SZ_1M);
 
 		len -= t_len;
-		if (first) {
-			fdt_reserved_mem_save_node(node, uname, base, size);
-			first = 0;
-		}
 	}
 	return 0;
 }
-- 
2.13.5
