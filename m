Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 275ECB7B9F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Aug 2009 13:48:31 +1000 (EST)
Subject: [PATCH] lmb: Also remove __init from lmb_end_of_RAM() declaration
	in lmb.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain
Date: Mon, 31 Aug 2009 13:48:16 +1000
Message-Id: <1251690496.9499.12.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Previous patch removed __init in lmb.c but missed the fact
that it was also marked as such in the .h

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

And this one I tested :-)

Cheers,
Ben.

diff --git a/include/linux/lmb.h b/include/linux/lmb.h
index c46c895..2442e3f 100644
--- a/include/linux/lmb.h
+++ b/include/linux/lmb.h
@@ -51,7 +51,7 @@ extern u64 __init lmb_alloc_base(u64 size,
 extern u64 __init __lmb_alloc_base(u64 size,
 		u64 align, u64 max_addr);
 extern u64 __init lmb_phys_mem_size(void);
-extern u64 __init lmb_end_of_DRAM(void);
+extern u64 lmb_end_of_DRAM(void);
 extern void __init lmb_enforce_memory_limit(u64 memory_limit);
 extern int __init lmb_is_reserved(u64 addr);
 extern int lmb_find(struct lmb_property *res);
