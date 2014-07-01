Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0CA3C1A001A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 14:14:04 +1000 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 30 Jun 2014 22:14:02 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 63E181FF001E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jun 2014 22:13:58 -0600 (MDT)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08025.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s614Dwl1065862
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Jul 2014 06:13:58 +0200
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s614Hwwo016796
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jun 2014 22:17:59 -0600
Subject: [PATCH V2] powerpc/powernv: Check for IRQHAPPENED before sleeping
To: benh@kernel.crashing.org, mikey@neuling.org, mpe@ellerman.id.au
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Tue, 01 Jul 2014 09:39:14 +0530
Message-ID: <20140701040808.6486.59805.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: shreyas@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 8d6f7c5a: "powerpc/powernv: Make it possible to skip the IRQHAPPENED
check in power7_nap()" added code that prevents cpus from checking for pending
interrupts just before entering sleep state, which is wrong. A cpu cannot enter
any idle state with pending interrupts.

Possible consequences of a cpu entering an idle state without checking for pending
interrupts could be a device timeout or a more serious consequence in case of
Power8 would be if doorbell IPIs are delivered when cpus have interrupts soft
disabled. Precisely the state that the cpus are in just before entering an
idle state on PowerPC.

Interrupts delivered during soft disabled state are replayed when the interrupts
are enabled again. Hence since a cpu goes to sleep with interrupts enabled
again, it will receive any pending interrupts. However doorbell IPIs are not
replayed even when the interrupts are re-enabled since they are edge triggered.Hence
not checking for pending interrupts just before going to sleep state would mean
that we will never take the doorbell IPI if it was delivered during the soft
disabled state, unless some other interrupt wakes us up.This could result in the
cpu that sent the doorbell IPI complaining that the sleeping cpu is stuck.

This patch fixes these issues by ensuring that cpus check for pending interrupts
just before entering any idle state as long as they are not in the path of split
core operations.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Acked-by: Michael Neuling <mikey@neuling.org>
---
Changes from V1: Modified the changelog to add the details of the problem
that this patch fixes.

 arch/powerpc/kernel/idle_power7.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index 2480256..5cf3d36 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -131,7 +131,7 @@ _GLOBAL(power7_nap)
 
 _GLOBAL(power7_sleep)
 	li	r3,1
-	li	r4,0
+	li	r4,1
 	b	power7_powersave_common
 	/* No return */
 
