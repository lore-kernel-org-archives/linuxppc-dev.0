Return-Path: <nacc@us.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e7.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4CD74B7121
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Oct 2010 07:26:38 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e7.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o91LBIHP004334
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:11:18 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o91LQVut1798240
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 17:26:31 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o91LQUAO002072
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Oct 2010 18:26:31 -0300
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [RESEND PATCH 2/2] pseries/xics: use cpu_possible_mask rather than
	cpu_all_mask
Date: Fri,  1 Oct 2010 14:26:18 -0700
Message-Id: <1285968378-12805-3-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1285968378-12805-1-git-send-email-nacc@us.ibm.com>
References: <1285968378-12805-1-git-send-email-nacc@us.ibm.com>
Cc: Mark Nelson <markn@au1.ibm.com>, linux-kernel@vger.kernel.org,
	miltonm@bga.com, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current firmware only allows us to send IRQs to the first processor or
all processors. We currently check to see if the passed in mask is equal
to the all_mask, but the firmware is only considering whether the
request is for the equivalent of the possible_mask. Thus, we think the
request is for some subset of CPUs and only assign IRQs to the first CPU
(on systems without irqbalance running) as evidenced by
/proc/interrupts. By using possible_mask instead, we account for this
and proper interleaving of interrupts occurs.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
 arch/powerpc/platforms/pseries/xics.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/pseries/xics.c
index 93834b0..7c1e342 100644
--- a/arch/powerpc/platforms/pseries/xics.c
+++ b/arch/powerpc/platforms/pseries/xics.c
@@ -178,7 +178,7 @@ static int get_irq_server(unsigned int virq, const struct cpumask *cpumask,
 	if (!distribute_irqs)
 		return default_server;
 
-	if (!cpumask_equal(cpumask, cpu_all_mask)) {
+	if (!cpumask_subset(cpu_possible_mask, cpumask)) {
 		int server = cpumask_first_and(cpu_online_mask, cpumask);
 
 		if (server < nr_cpu_ids)
-- 
1.7.0.4
