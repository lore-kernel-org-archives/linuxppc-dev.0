Return-Path: <brking@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C43681007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Jul 2010 07:23:56 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6MLKIQW026687
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jul 2010 15:20:18 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6MLNg8w118804
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jul 2010 15:23:48 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o6MLNc15008112
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jul 2010 15:23:39 -0600
Message-Id: <201007222123.o6MLNYGb007400@d03av02.boulder.ibm.com>
Subject: [PATCH 1/1] powerpc: Increase pseries_cpu_die delay
To: benh@kernel.crashing.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Thu, 22 Jul 2010 16:23:35 -0500
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


In testing SMT disable, we have been regularly seeing the following message:

Querying DEAD? cpu %i (%i) shows %i

This indicates the current delay in pseries_cpu_die where we wait
for the specified CPU to die, is insufficient. Usually, this does
not cause a problem, but we've seen this result in BUG_ON's going
off in the timer code when we try to migrate the timers off the
dead cpu while a timer is still running. Increasing this delay,
as is done in this patch, seems to resolve this issue.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/platforms/pseries/hotplug-cpu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/powerpc/platforms/pseries/hotplug-cpu.c~powerpc_cpu_die_delay arch/powerpc/platforms/pseries/hotplug-cpu.c
--- linux-2.6/arch/powerpc/platforms/pseries/hotplug-cpu.c~powerpc_cpu_die_delay	2010-07-20 09:24:01.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/platforms/pseries/hotplug-cpu.c	2010-07-20 09:24:20.000000000 -0500
@@ -193,12 +193,12 @@ static void pseries_cpu_die(unsigned int
 
 	if (get_preferred_offline_state(cpu) == CPU_STATE_INACTIVE) {
 		cpu_status = 1;
-		for (tries = 0; tries < 1000; tries++) {
+		for (tries = 0; tries < 5000; tries++) {
 			if (get_cpu_current_state(cpu) == CPU_STATE_INACTIVE) {
 				cpu_status = 0;
 				break;
 			}
-			cpu_relax();
+			msleep(1);
 		}
 	} else if (get_preferred_offline_state(cpu) == CPU_STATE_OFFLINE) {
 
_
