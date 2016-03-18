Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qRBS15wq9zDqQB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Mar 2016 15:04:17 +1100 (AEDT)
Message-ID: <1458273857.6622.75.camel@neuling.org>
Subject: Re: [PATCH v8 3/6] cpufreq: powernv: Remove cpu_to_chip_id() from
 hot-path
From: Michael Neuling <mikey@neuling.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: ego@linux.vnet.ibm.com, linux-pm@vger.kernel.org,
 viresh.kumar@linaro.org,  rjw@rjwysocki.net, pc@us.ibm.com,
 shreyas@linux.vnet.ibm.com, anton@samba.org
Date: Fri, 18 Mar 2016 15:04:17 +1100
In-Reply-To: <1454442102-1229-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1454442102-1229-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1454442102-1229-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-02-03 at 01:11 +0530, Shilpasri G Bhat wrote:

> cpu_to_chip_id() does a DT walk through to find out the chip id by
> taking a contended device tree lock. This adds an unnecessary overhead
> in a hot path. So instead of calling cpu_to_chip_id() everytime cache
> the chip ids for all cores in the array 'core_to_chip_map' and use it
> in the hotpath.
>=20
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> No changes from v7.

How about this instead?  It removes the linear lookup and seems a lot
less complex.

Mikey

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cp=
ufreq.c
index 547890f..d63d2cb 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -52,6 +52,7 @@ static struct chip {
 } *chips;
=20
 static int nr_chips;
+static DEFINE_PER_CPU(unsigned int, chip_id);
=20
 /*
  * Note: The set of pstates consists of contiguous integers, the
@@ -317,9 +318,7 @@ static void powernv_cpufreq_throttle_check(void *data)
=20
 	pmsr =3D get_pmspr(SPRN_PMSR);
=20
-	for (i =3D 0; i < nr_chips; i++)
-		if (chips[i].id =3D=3D cpu_to_chip_id(cpu))
-			break;
+	i =3D this_cpu_read(chip_id);
=20
 	/* Check for Pmax Capping */
 	pmsr_pmax =3D (s8)PMSR_MAX(pmsr);
@@ -560,6 +559,7 @@ static int init_chip_info(void)
 	for_each_possible_cpu(cpu) {
 		unsigned int id =3D cpu_to_chip_id(cpu);
=20
+		per_cpu(chip_id, cpu) =3D nr_chips;
 		if (prev_chip_id !=3D id) {
 			prev_chip_id =3D id;
 			chip[nr_chips++] =3D id;
