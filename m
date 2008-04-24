Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id B0DC2DDF2B
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 16:40:27 +1000 (EST)
Date: Wed, 23 Apr 2008 23:40:26 -0700 (PDT)
Message-Id: <20080423.234026.193720682.davem@davemloft.net>
To: michael@ellerman.id.au
Subject: Re: LMB regression...
From: David Miller <davem@davemloft.net>
In-Reply-To: <1209018933.22532.0.camel@concordia.ozlabs.ibm.com>
References: <20080423.232419.193712136.davem@davemloft.net>
	<1209018933.22532.0.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 24 Apr 2008 16:35:33 +1000

> Sounds like we need a test suite :)

Maybe :-)  Anyways, here is the bug fix I plan to push to
Linus with my sparc64 NUMA changes, unless someone has an
objection:

[LMB]: Fix lmb allocation regression.

Changeset d9024df02ffe74d723d97d552f86de3b34beb8cc ("[LMB] Restructure
allocation loops to avoid unsigned underflow") removed the alignment
of the 'size' argument to call lmb_add_region() done by __lmb_alloc_base().

In doing so it reintroduced the bug fixed by changeset
eea89e13a9c61d3928223d2f9bf2295e22e0efb6 ("[LMB]: Fix bug in
__lmb_alloc_base().").

This puts it back.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 lib/lmb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/lmb.c b/lib/lmb.c
index 896e283..207147a 100644
--- a/lib/lmb.c
+++ b/lib/lmb.c
@@ -346,7 +346,7 @@ u64 __init __lmb_alloc_base(u64 size, u64 align, u64 max_addr)
 			if (j < 0) {
 				/* this area isn't reserved, take it */
 				if (lmb_add_region(&lmb.reserved, base,
-						   size) < 0)
+						   lmb_align_up(size, align)) < 0)
 					return 0;
 				return base;
 			}
-- 
1.5.5.1.57.g5909c
