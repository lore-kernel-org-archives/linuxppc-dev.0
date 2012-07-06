Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id F33962C0089
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jul 2012 12:30:40 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id q662UaWE011436
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jul 2012 21:30:36 -0500
Message-ID: <1341541833.6330.49.camel@pasglop>
Subject: [PATCH] powerpc/numa: Avoid stupid uninitialized warning from gcc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 06 Jul 2012 12:30:33 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Newer gcc are being a bit blind here (it's pretty obvious we don't
reach the code path using the array if we haven't initialized the
pointer) but none of that is performance critical so let's just
silence it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 7c28589..39b1597 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -641,7 +641,7 @@ static void __init parse_drconf_memory(struct device_node *memory)
 	unsigned int n, rc, ranges, is_kexec_kdump = 0;
 	unsigned long lmb_size, base, size, sz;
 	int nid;
-	struct assoc_arrays aa;
+	struct assoc_arrays aa = { .arrays = NULL };
 
 	n = of_get_drconf_memory(memory, &dm);
 	if (!n)
