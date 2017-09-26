Return-Path: <stewart@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y1ZCY3TG8zDsPT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 18:40:25 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8Q8dXox017950
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 04:40:22 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2d7e542qe1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 04:40:22 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 26 Sep 2017 02:40:21 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Rob Herring <robh@kernel.org>
Cc: obh+dt@kernel.org, Frank Rowand <frowand.list@gmail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: [PATCH] drivers: of: increase MAX_RESERVED_REGIONS to 32
Date: Tue, 26 Sep 2017 18:40:00 +1000
In-Reply-To: <CAL_JsqL29j59wJtmOAuD=N7Tccv2rxEMav90yxTyGTfhwHQUsw@mail.gmail.com>
References: <CAL_JsqL29j59wJtmOAuD=N7Tccv2rxEMav90yxTyGTfhwHQUsw@mail.gmail.com>
Message-Id: <20170926084000.29105-1-stewart@linux.vnet.ibm.com>
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

A Google search shows up no occurances of that exact error message, so we're
probably safe in that no machine that people use has memory not being reserved
when it should be.

The simple fix is to bump the length of the array to 32 which "should be
enough for everyone(TM)". The simple fix of not recording static allocations
in the array would cause problems for devices with "memory-region" properties.
A more future-proof fix is likely possible, although more invasive and this
simple fix is perfectly suitable in the meantime while a more future-proof
fix is developed.

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
---
 drivers/of/of_reserved_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index d507c3569a88..32771c2ced7b 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -25,7 +25,7 @@
 #include <linux/sort.h>
 #include <linux/slab.h>
 
-#define MAX_RESERVED_REGIONS	16
+#define MAX_RESERVED_REGIONS	32
 static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
 static int reserved_mem_count;
 
-- 
2.13.5
