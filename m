Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 88C7E1A024F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2015 16:08:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@ozlabs.org>, mitchelh@codeaurora.org, frowand.list@gmail.com,
 grant.likely@linaro.org
Subject: [PATCH] of: Print rather than WARN'ing when overlap check fails
Date: Tue, 10 Nov 2015 16:08:33 +1100
Message-Id: <1447132113-31434-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

__rmem_check_for_overlap() is called very early in boot, and on some
powerpc systems it's not safe to call WARN that early in boot.

If the overlap check fails the system will oops instead of printing a
warning. Furthermore because it's so early in boot the console is not up
and the user doesn't see the oops, they just get a dead system.

Fix it by printing an error instead of calling WARN.

Fixes: ae1add247bf8 ("of: Check for overlap in reserved memory regions")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/of/of_reserved_mem.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 62f467b8ccae..49703916a30e 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -226,10 +226,9 @@ static void __init __rmem_check_for_overlap(void)
 
 			this_end = this->base + this->size;
 			next_end = next->base + next->size;
-			WARN(1,
-			     "Reserved memory: OVERLAP DETECTED!\n%s (%pa--%pa) overlaps with %s (%pa--%pa)\n",
-			     this->name, &this->base, &this_end,
-			     next->name, &next->base, &next_end);
+			pr_err("Reserved memory: OVERLAP DETECTED!\n%s (%pa--%pa) overlaps with %s (%pa--%pa)\n",
+			       this->name, &this->base, &this_end,
+			       next->name, &next->base, &next_end);
 		}
 	}
 }
-- 
2.5.0
