Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B45C61A0145
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2015 10:10:21 +1100 (AEDT)
Date: Fri, 20 Mar 2015 10:10:18 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/powernv: Fix return value from power7_nap() et al.
Message-ID: <20150319231018.GC31148@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The power7_nap(), power7_sleep() and power7_winkle() functions are
called from pnv_smp_cpu_kill_self(), which expects them to return the
SRR1 value set by the hardware on wakeup, or 0 if no nap/sleep/winkle
occurred.  However, in the case where an interrupt needs to be
replayed, the logic in power7_powersave_common (the common code for
power7_nap et al.) doesn't set r3 to 0 in this case.  Instead what we
get as the return value is the selector for the type of power-saving
mode requested (1, 2 or 3).  In fact this should not affect the
operation of pnv_smp_cpu_kill_self(), but it is better to get this
correct, so this adds an instruction to set r3 to 0 in this case.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/idle_power7.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index 05adc8b..eeaa0d5 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -94,6 +94,7 @@ _GLOBAL(power7_powersave_common)
 	beq	1f
 	addi	r1,r1,INT_FRAME_SIZE
 	ld	r0,16(r1)
+	li	r3,0			/* Return 0 (no nap) */
 	mtlr	r0
 	blr
 
-- 
2.1.4
