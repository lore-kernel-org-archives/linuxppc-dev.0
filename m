Return-Path: <ego@in.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A9DF6B70AA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 19:26:42 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp09.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5OJJ3xk025202
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2009 05:19:03 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5O9Qfwf475170
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2009 19:26:41 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5O9QeXO026832
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2009 19:26:40 +1000
Subject: [PATCH] pseries: cpu: Reduce the polling interval in __cpu_up()
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Gautham R Shenoy <ego@in.ibm.com>
Date: Wed, 24 Jun 2009 14:56:37 +0530
Message-ID: <20090624092637.32078.88042.stgit@sofia.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Nathan Lynch <ntl@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Time time taken for a single cpu online operation on a pseries machine
is as follows:
Dedicated LPAR (POWER6): ~220ms.
Shared LPAR (POWER5)   : ~240ms.

Of this time, approximately 200ms is taken up by __cpu_up(). This is because
we poll every 200ms to check if the new cpu has notified it's presence
through the cpu_callin_map. We repeat this operation until the new cpu sets
the value in cpu_callin_map or 5 seconds elapse, whichever comes earlier.

However, using completion_structs instead of polling loops,
the time taken by the new processor to indicate it's presence has
found to be less than 1ms on pseries. This method however may not
work on all powerpc platforms due to the time-base synchronization code.

Keeping this in mind, we could reduce msleep polling interval from
200ms to 1ms while retaining the 5 second timeout.

With this, the time taken for a cpu online operation changes as follows:
Dedicated LPAR (POWER6): 20-25ms.
Shared LPAR (POWER5)   : 60-80ms.

In both these cases, it was found that the code polls through the loop
only once indicating that 1ms is a reasonable value, atleast on pseries.

The code needs testing on other powerpc platforms.

Signed-off-by: Gautham R Shenoy <ego@in.ibm.com>
---
 arch/powerpc/kernel/smp.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 65484b2..00c13a1 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -411,9 +411,8 @@ int __cpuinit __cpu_up(unsigned int cpu)
 		 * CPUs can take much longer to come up in the
 		 * hotplug case.  Wait five seconds.
 		 */
-		for (c = 25; c && !cpu_callin_map[cpu]; c--) {
-			msleep(200);
-		}
+		for (c = 5000; c && !cpu_callin_map[cpu]; c--)
+			msleep(1);
 #endif
 
 	if (!cpu_callin_map[cpu]) {
