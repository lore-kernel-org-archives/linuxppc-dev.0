Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 20/20] powerpc/perf: Fix handling of L3 events with bank == 1
Date: Fri, 14 Mar 2014 16:00:45 +1100
Message-Id: <1394773245-18328-21-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1394773245-18328-1-git-send-email-mpe@ellerman.id.au>
References: <1394773245-18328-1-git-send-email-mpe@ellerman.id.au>
Cc: cody@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we reject events which have the L3 bank == 1, such as
0x000084918F, because the cache field is non-zero.

However that is incorrect, because although the bank is non-zero, the
value we would write into MMCRC is zero, and so we can count the event.

So fix the check to ignore the bank selector when checking whether the
cache selector is non-zero.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/perf/power8-pmu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 3ad363d..fe2763b 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -325,9 +325,10 @@ static int power8_get_constraint(u64 event, unsigned long *maskp, unsigned long
 		 * HV writable, and there is no API for guest kernels to modify
 		 * it. The solution is for the hypervisor to initialise the
 		 * field to zeroes, and for us to only ever allow events that
-		 * have a cache selector of zero.
+		 * have a cache selector of zero. The bank selector (bit 3) is
+		 * irrelevant, as long as the rest of the value is 0.
 		 */
-		if (cache)
+		if (cache & 0x7)
 			return -1;
 
 	} else if (event & EVENT_IS_L1) {
-- 
1.8.3.2
