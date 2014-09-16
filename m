Return-Path: <tlfalcon@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7EE71A0314
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Sep 2014 06:16:00 +1000 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.vnet.ibm.com>;
 Tue, 16 Sep 2014 14:15:58 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 1398719D803E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 14:15:43 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8GKDxKG3342824
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 22:13:59 +0200
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8GKFtve015460
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Sep 2014 14:15:56 -0600
From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/3] pseries: Fix endian issues in onlining cpu threads
Date: Tue, 16 Sep 2014 15:15:46 -0500
Message-Id: <1410898547-12296-3-git-send-email-tlfalcon@linux.vnet.ibm.com>
In-Reply-To: <1410898547-12296-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1410898547-12296-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
Cc: nfont@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
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
index 5acbe59..187e4eb 100644
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
