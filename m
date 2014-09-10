Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D1EAE1A0AE3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Sep 2014 08:42:09 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Wed, 10 Sep 2014 18:42:07 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id CB43E6E8028
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 18:41:53 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8AMfvgR1769940
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 22:42:05 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8AMfWOb000574
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 18:41:33 -0400
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] pseries: Fix endian issues in onlining cpu threads
Date: Wed, 10 Sep 2014 17:41:06 -0500
Message-Id: <1410388866-19958-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/pseries/dlpar.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index c2806c8..cd425dc 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -363,7 +363,7 @@ static int dlpar_online_cpu(struct device_node *dn)
 	int rc = 0;
 	unsigned int cpu;
 	int len, nthreads, i;
-	const u32 *intserv;
+	const __be32 *intserv;
 
 	intserv = of_get_property(dn, "ibm,ppc-interrupt-server#s", &len);
 	if (!intserv)
@@ -374,7 +374,7 @@ static int dlpar_online_cpu(struct device_node *dn)
 	cpu_maps_update_begin();
 	for (i = 0; i < nthreads; i++) {
 		for_each_present_cpu(cpu) {
-			if (get_hard_smp_processor_id(cpu) != intserv[i])
+			if (get_hard_smp_processor_id(cpu) != be32_to_cpu(intserv[i]))
 				continue;
 			BUG_ON(get_cpu_current_state(cpu)
 					!= CPU_STATE_OFFLINE);
@@ -388,7 +388,7 @@ static int dlpar_online_cpu(struct device_node *dn)
 		}
 		if (cpu == num_possible_cpus())
 			printk(KERN_WARNING "Could not find cpu to online "
-			       "with physical id 0x%x\n", intserv[i]);
+			       "with physical id 0x%x\n", be32_to_cpu(intserv[i]));
 	}
 	cpu_maps_update_done();
 
-- 
1.8.5.2
