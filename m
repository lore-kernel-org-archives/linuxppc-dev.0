Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B8321A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jul 2014 13:54:31 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 1 Jul 2014 21:54:30 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 7903F1FF001C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Jul 2014 21:54:26 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08025.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s623sQCo4850010
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Jul 2014 05:54:27 +0200
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s623sQGH013681
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Jul 2014 21:54:26 -0600
Subject: [PATCH V3] powerpc/powernv: Check for IRQHAPPENED before sleeping
To: benh@kernel.crashing.org, mikey@neuling.org, mpe@ellerman.id.au
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Wed, 02 Jul 2014 09:19:35 +0530
Message-ID: <20140702034811.2956.30873.stgit@preeti.in.ibm.com>
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
check in power7_nap()" added code that prevents cpus from checking for
pending interrupts just before entering sleep state, which is wrong. These
interrupts are delivered during the soft irq disabled state of the cpu.

A cpu cannot enter any idle state with pending interrupts because they will
never be serviced until the next time the cpu is woken up by some other
interrupt. Its only then that the pending interrupts are replayed. This can result
in device timeouts or warnings about this cpu being stuck.

This patch fixes ths issue by ensuring that cpus check for pending interrupts
just before entering any idle state as long as they are not in the path of split
core operations.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
Chanes in V2: https://lkml.org/lkml/2014/7/1/3
Modified the changelog to add the details of the problem that this patch
fixes

Changes in V3:
V2 assumed that this patch would be useful only in the context of doorbell
ipis. But that is not true; this patch is required to correctly handle any
type of interrupt delivered in the idle enter path.


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
 
