Return-Path: <matt@ozlabs.org>
Message-ID: <4C64ED14.9070602@ozlabs.org>
Date: Fri, 13 Aug 2010 16:58:28 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Initialise paca->kstack before early_setup_secondary
Content-Type: text/plain; charset=ISO-8859-1
Cc: mjwolf@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As early setup calls down to slb_initialize(), we must have kstack
initialised before checking "should we add a bolted SLB entry for our kstack?"

Failing to do so means stack access requires an SLB miss exception to refill
an entry dynamically, if the stack isn't accessible via SLB(0) (kernel text
& static data).  It's not always allowable to take such a miss, and
intermittent crashes will result.

Primary CPUs don't have this issue; an SLB entry is not bolted for their
stack anyway (as that lives within SLB(0)).  This patch therefore only
affects the init of secondaries.

Signed-off-by: Matt Evans <matt@ozlabs.org>
Cc: stable <stable@kernel.org>
---
 arch/powerpc/kernel/head_64.S |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 844a44b..4d6681d 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -572,9 +572,6 @@ __secondary_start:
 	/* Set thread priority to MEDIUM */
 	HMT_MEDIUM
 
-	/* Do early setup for that CPU (stab, slb, hash table pointer) */
-	bl	.early_setup_secondary
-
 	/* Initialize the kernel stack.  Just a repeat for iSeries.	 */
 	LOAD_REG_ADDR(r3, current_set)
 	sldi	r28,r24,3		/* get current_set[cpu#]	 */
@@ -582,6 +579,9 @@ __secondary_start:
 	addi	r1,r1,THREAD_SIZE-STACK_FRAME_OVERHEAD
 	std	r1,PACAKSAVE(r13)
 
+	/* Do early setup for that CPU (stab, slb, hash table pointer) */
+	bl	.early_setup_secondary
+
 	/* Clear backchain so we get nice backtraces */
 	li	r7,0
 	mtlr	r7
-- 
1.7.0.4
