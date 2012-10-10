Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 060FA2C01E5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2012 18:29:32 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Wed, 10 Oct 2012 12:59:25 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9A7T6WM38076526
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2012 12:59:06 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9A7T6pp028659
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2012 18:29:06 +1100
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: [RESEND PATCH v1 1/3] cpuidle: (POWER) Fix target residency
 initialisation in pseries cpuidle
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org
Date: Wed, 10 Oct 2012 12:59:08 +0530
Message-ID: <20121010072906.29317.32144.stgit@deepthi.in.ibm.com>
In-Reply-To: <20121010072859.29317.71472.stgit@deepthi.in.ibm.com>
References: <20121010072859.29317.71472.stgit@deepthi.in.ibm.com>
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
 
