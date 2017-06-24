Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ww2P52VJ0zDr0T
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Jun 2017 03:29:13 +1000 (AEST)
Message-ID: <1498325341.31581.90.camel@kernel.crashing.org>
Subject: [PATCH v2] powerpc: Invalidate ERAT on powersave wakeup for POWER9
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Date: Sat, 24 Jun 2017 12:29:01 -0500
In-Reply-To: <20170622172616.7598-1-mikey@neuling.org>
References: <20170622172616.7598-1-mikey@neuling.org>
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

On POWER9 the ERAT may be incorrect on wakeup from some stop states
that lose state. This causes random segvs and illegal instructions
when these stop states are enabled.

This patch invalidates the ERAT on wakeup on POWER9 to prevent this
from causing a problem.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

v2. [BenH] Move to a place before we branch off to KVM if the
           core was in a guest. Also add a comment about the
           SRR1 bit extraction.
---
 arch/powerpc/kernel/exceptions-64s.S | 4 +++-
 arch/powerpc/kernel/idle_book3s.S    | 7 +++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index ae418b85c17c..b4b2c3a344c4 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -99,7 +99,9 @@ EXC_VIRT_NONE(0x4000, 0x100)
 #ifdef CONFIG_PPC_P7_NAP
 	/*
 	 * If running native on arch 2.06 or later, check if we are waking up
-	 * from nap/sleep/winkle, and branch to idle handler.
+	 * from nap/sleep/winkle, and branch to idle handler. This tests
+	 * SRR1 bits 46:47. A non-0 value indicates that we are coming from
+	 * a power saving state.
 	 */
 #define IDLETEST(n)							\
 	BEGIN_FTR_SECTION ;						\
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 4898d676dcae..3fd65739e105 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -489,6 +489,13 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
  */
 pnv_restore_hyp_resource_arch300:
 	/*
+	 * Workaround for POWER9, if we lost resources, the ERAT
+	 * might have been mixed up and needs flushing.
+	 */
+	blt	cr3,1f
+	PPC_INVALIDATE_ERAT
+1:
+	/*
 	 * POWER ISA 3. Use PSSCR to determine if we
 	 * are waking up from deep idle state
 	 */
