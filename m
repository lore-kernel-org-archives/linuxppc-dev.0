Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 704CF1A044C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 21:46:40 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@ozlabs.org>, mitchelh@codeaurora.org, frowand.list@gmail.com,
 grant.likely@linaro.org
Subject: [PATCH] of: Fix comparison of reserved memory regions
Date: Wed, 18 Nov 2015 21:46:38 +1100
Message-Id: <1447843598-9355-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to check for overlapping reserved memory regions, we first need
to sort the array of memory regions. This is implemented using sort(),
and a custom comparison function __rmem_cmp().

Unfortunatley __rmem_cmp() doesn't work in all cases. Because the two
base values are phys_addr_t, they may be u64 on some platforms, in which
case subtracting one from the other and then (implicitly) casting to int
does not give us the -ve/0/+ve value we need.

This leads to incorrect reports about overlaps, eg:

  ibm,slw-image@1ffe600000 (0x0000001ffe600000--0x0000001ffe700000) overlaps with
  ibm,firmware-allocs-memory@1000000000 (0x0000001000000000--0x0000001000dc0200)

Fix it by just doing the standard double if and return 0 logic.

Fixes: ae1add247bf8 ("of: Check for overlap in reserved memory regions")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/of/of_reserved_mem.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index be77e75c587d..1a3556a9e9ea 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -206,7 +206,13 @@ static int __init __rmem_cmp(const void *a, const void *b)
 {
 	const struct reserved_mem *ra = a, *rb = b;
 
-	return ra->base - rb->base;
+	if (ra->base < rb->base)
+		return -1;
+
+	if (ra->base > rb->base)
+		return 1;
+
+	return 0;
 }
 
 static void __init __rmem_check_for_overlap(void)
-- 
2.5.0
