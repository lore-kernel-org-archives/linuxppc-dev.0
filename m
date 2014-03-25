Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, rusty@rustcorp.com.au,
 ulrich.weigand@de.ibm.com, amodra@gmail.com, mikey@neuling.org,
 mjw@linux.vnet.ibm.com
Subject: [PATCH 17/33] powerpc/tm: Use STK_PARAM
Date: Tue, 25 Mar 2014 22:44:23 +1100
Message-Id: <1395747879-5948-18-git-send-email-anton@samba.org>
In-Reply-To: <1395747879-5948-1-git-send-email-anton@samba.org>
References: <1395747879-5948-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Get rid of the tm specific STACK_PARAM and use STK_PARAM

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/tm.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index ef47bcb..db02e84 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -41,7 +41,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX);		\
 /* Stack frame offsets for local variables. */
 #define TM_FRAME_L0	TM_FRAME_SIZE-16
 #define TM_FRAME_L1	TM_FRAME_SIZE-8
-#define STACK_PARAM(x)	(48+((x)*8))
 
 
 /* In order to access the TM SPRs, TM must be enabled.  So, do so: */
@@ -113,7 +112,7 @@ _GLOBAL(tm_reclaim)
 
 	/* We've a struct pt_regs at [r1+STACK_FRAME_OVERHEAD]. */
 
-	std	r3, STACK_PARAM(0)(r1)
+	std	r3, STK_PARAM(R3)(r1)
 	SAVE_NVGPRS(r1)
 
 	/* We need to setup MSR for VSX register save instructions.  Here we
@@ -202,7 +201,7 @@ dont_backup_fp:
 	/* Now get some more GPRS free */
 	std	r7, GPR7(r1)			/* Temporary stash */
 	std	r12, GPR12(r1)			/* ''   ''    ''   */
-	ld	r12, STACK_PARAM(0)(r1)		/* Param 0, thread_struct * */
+	ld	r12, STK_PARAM(R3)(r1)		/* Param 0, thread_struct * */
 
 	std	r11, THREAD_TM_PPR(r12)		/* Store PPR and free r11 */
 
-- 
1.8.3.2
