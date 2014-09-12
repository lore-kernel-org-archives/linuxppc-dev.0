Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BF00B1A0021
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Sep 2014 05:11:53 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Fri, 12 Sep 2014 15:11:51 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 26F736E8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 15:11:36 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8CJBlnJ6226300
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 19:11:47 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8CJBkwY017544
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 15:11:47 -0400
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH v2 1/2] pseries: Fix endian issues in onlining cpu threads
Date: Fri, 12 Sep 2014 14:11:41 -0500
Message-Id: <1410549102-8410-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ibm,ppc-interrupt-server#s property is in big endian format.
These values need to be converted when used by little endian
architectures.

Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
---
Changes in v2:

 Followed suggestions from Michael Ellerman
   conversion of intserv values occur once
---
 arch/powerpc/platforms/pseries/dlpar.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index c2806c8..9e9f30b2 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -363,7 +363,8 @@ static int dlpar_online_cpu(struct device_node *dn)
 	int rc = 0;
 	unsigned int cpu;
 	int len, nthreads, i;
-	const u32 *intserv;
+	const __be32 *intserv;
+	u32 thread;
 
 	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
 	if (!intserv)
@@ -373,8 +374,9 @@ static int dlpar_online_cpu(struct device_node *dn)
 
 	cpu_maps_update_begin();
 	for (i = 0; i < nthreads; i++) {
+		thread = be32_to_cpu(intserv[i]);
 		for_each_present_cpu(cpu) {
-			if (get_hard_smp_processor_id(cpu) != intserv[i])
+			if (get_hard_smp_processor_id(cpu) != thread)
 				continue;
 			BUG_ON(get_cpu_current_state(cpu)
 					!= CPU_STATE_OFFLINE);
@@ -388,7 +390,7 @@ static int dlpar_online_cpu(struct device_node *dn)
 		}
 		if (cpu == num_possible_cpus())
 			printk(KERN_WARNING "Could not find cpu to online "
-			       "with physical id 0x%x\n", intserv[i]);
+			       "with physical id 0x%x\n", thread);
 	}
 	cpu_maps_update_done();
 
-- 
1.8.5.2
