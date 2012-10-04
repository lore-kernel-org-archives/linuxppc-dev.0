Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A6AB02C0371
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2012 14:42:16 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Thu, 4 Oct 2012 10:12:13 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q944g9iN065852
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Oct 2012 10:12:09 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q94ABXYT025579
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Oct 2012 20:11:33 +1000
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: [PATCH v1 1/3] cpuidle: (POWER) Fix target residency initialisation
 in pseries cpuidle
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Date: Thu, 04 Oct 2012 10:12:10 +0530
Message-ID: <20121004044207.15921.36114.stgit@deepthi.in.ibm.com>
In-Reply-To: <20121004044154.15921.51256.stgit@deepthi.in.ibm.com>
References: <20121004044154.15921.51256.stgit@deepthi.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove the redundant target residency initialisation in pseries_cpuidle_driver_init().
This is currently over-writing the residency time updated as part of the static
table, resulting in  all the idle states having the same target
residency of 100us which is incorrect. This may result in the menu governor making
wrong state decisions.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---

 arch/powerpc/platforms/pseries/processor_idle.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index 455760b..02e425a 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -246,10 +246,6 @@ static int pseries_cpuidle_driver_init(void)
 		drv->states[drv->state_count] =	/* structure copy */
 			cpuidle_state_table[idle_state];
 
-		if (cpuidle_state_table == dedicated_states)
-			drv->states[drv->state_count].target_residency =
-				__get_cpu_var(smt_snooze_delay);
-
 		drv->state_count += 1;
 	}
 
