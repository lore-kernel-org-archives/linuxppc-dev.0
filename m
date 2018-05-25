Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40shp73c46zF1gN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 20:10:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: greg@kroah.com
Cc: stable@vger.kernel.org,
	tglx@linutronix.de,
	linuxppc-dev@ozlabs.org
Subject: [PATCH stable 4.14 22/23] powerpc/64s: Fix section mismatch warnings
 from setup_rfi_flush()
Date: Fri, 25 May 2018 20:09:53 +1000
Message-Id: <20180525100954.31599-23-mpe@ellerman.id.au>
In-Reply-To: <20180525100954.31599-1-mpe@ellerman.id.au>
References: <20180525100954.31599-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The recent LPM changes to setup_rfi_flush() are causing some section
mismatch warnings because we removed the __init annotation on
setup_rfi_flush():

  The function setup_rfi_flush() references
  the function __init ppc64_bolted_size().
  the function __init memblock_alloc_base().

The references are actually in init_fallback_flush(), but that is
inlined into setup_rfi_flush().

These references are safe because:
 - only pseries calls setup_rfi_flush() at runtime
 - pseries always passes L1D_FLUSH_FALLBACK at boot
 - so the fallback flush area will always be allocated
 - so the check in init_fallback_flush() will always return early:
   /* Only allocate the fallback flush area once (at boot time). */
   if (l1d_flush_fallback_area)
   	return;

 - and therefore we won't actually call the freed init routines.

We should rework the code to make it safer by default rather than
relying on the above, but for now as a quick-fix just add a __ref
annotation to squash the warning.

Fixes: abf110f3e1ce ("powerpc/rfi-flush: Make it possible to call setup_rfi_flush() again")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
(cherry picked from commit 501a78cbc17c329fabf8e9750a1e9ab810c88a0e)
---
 arch/powerpc/kernel/setup_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 1146174f45c5..0618aa61b26a 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -831,7 +831,7 @@ void rfi_flush_enable(bool enable)
 	rfi_flush = enable;
 }
 
-static void init_fallback_flush(void)
+static void __ref init_fallback_flush(void)
 {
 	u64 l1d_size, limit;
 	int cpu;
-- 
2.14.1
