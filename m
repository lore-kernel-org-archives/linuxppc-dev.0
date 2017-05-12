Return-Path: <andrew@aj.id.au>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wPGSC2Sk3zDqKl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 13:59:07 +1000 (AEST)
From: Andrew Jeffery <andrew@aj.id.au>
To: linuxppc-dev@lists.ozlabs.org
Cc: Andrew Jeffery <andrew@aj.id.au>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, npiggin@gmail.com, anton@samba.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Tweak copy selection parameter in
 __copy_tofrom_user_power7()
Date: Fri, 12 May 2017 13:28:10 +0930
Message-Id: <20170512035810.15070-1-andrew@aj.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Experiments with the netperf benchmark indicated that the size selecting
VMX-based copies in __copy_tofrom_user_power7() was suboptimal on POWER8.
Measurements showed that parity was in the neighbourhood of 3328 bytes,
rather than greater than 4096. The change gives a 1.5-2.0% improvement in
performance for 4096-byte buffers, reducing the relative time spent in
__copy_tofrom_user_power7() from approximately 7% to approximately 5% in
the TCP_RR benchmark.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/powerpc/lib/copyuser_power7.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/copyuser_power7.S b/arch/powerpc/lib/copyuser_power7.S
index a24b4039352c..706b7cc19846 100644
--- a/arch/powerpc/lib/copyuser_power7.S
+++ b/arch/powerpc/lib/copyuser_power7.S
@@ -82,14 +82,14 @@
 _GLOBAL(__copy_tofrom_user_power7)
 #ifdef CONFIG_ALTIVEC
 	cmpldi	r5,16
-	cmpldi	cr1,r5,4096
+	cmpldi	cr1,r5,3328
 
 	std	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)
 	std	r4,-STACKFRAMESIZE+STK_REG(R30)(r1)
 	std	r5,-STACKFRAMESIZE+STK_REG(R29)(r1)
 
 	blt	.Lshort_copy
-	bgt	cr1,.Lvmx_copy
+	bge	cr1,.Lvmx_copy
 #else
 	cmpldi	r5,16
 
-- 
2.9.3
