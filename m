Return-Path: <paulus@ozlabs.org>
Date: Fri, 10 Sep 2010 15:02:40 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc, perf: Fix sampling enable for PPC970
Message-ID: <20100910050239.GB9100@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Binderman <dcb314@hotmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The logic to distinguish marked instruction events from ordinary events
on PPC970 and derivatives was flawed.  The result is that instruction
sampling didn't get enabled in the PMU for some marked instruction
events, so they would never trigger.  This fixes it by adding the
appropriate break statements in the switch statement.

Reported-by: David Binderman <dcb314@hotmail.com>
Cc: stable@kernel.org
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/ppc970-pmu.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/ppc970-pmu.c b/arch/powerpc/kernel/ppc970-pmu.c
index 8eff48e..3fee685 100644
--- a/arch/powerpc/kernel/ppc970-pmu.c
+++ b/arch/powerpc/kernel/ppc970-pmu.c
@@ -169,9 +169,11 @@ static int p970_marked_instr_event(u64 event)
 	switch (unit) {
 	case PM_VPU:
 		mask = 0x4c;		/* byte 0 bits 2,3,6 */
+		break;
 	case PM_LSU0:
 		/* byte 2 bits 0,2,3,4,6; all of byte 1 */
 		mask = 0x085dff00;
+		break;
 	case PM_LSU1L:
 		mask = 0x50 << 24;	/* byte 3 bits 4,6 */
 		break;
