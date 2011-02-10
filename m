Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D5DD1B711E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Feb 2011 08:57:38 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p1ALt1cZ006714
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Feb 2011 14:55:01 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p1ALvXo5128984
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Feb 2011 14:57:33 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p1ALvWOc028456
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Feb 2011 14:57:32 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH powerpc 2/2] powerpc: mask smp_processor_id() false positive
Date: Thu, 10 Feb 2011 13:57:27 -0800
Message-Id: <1297375047-18608-2-git-send-email-paulmck@linux.vnet.ibm.com>
In-Reply-To: <20110210215710.GA18429@linux.vnet.ibm.com>
References: <20110210215710.GA18429@linux.vnet.ibm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The rtas_event_scan() function uses smp_processor_id() to select a
starting point in cpu_online_mask, and does so under the protection
of get_online_cpus().  This might not select the current processor
in any case, so switch to raw_smp_processor_id().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/rtasd.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
index 049dbec..7980ec0 100644
--- a/arch/powerpc/kernel/rtasd.c
+++ b/arch/powerpc/kernel/rtasd.c
@@ -412,7 +412,8 @@ static void rtas_event_scan(struct work_struct *w)
 
 	get_online_cpus();
 
-	cpu = cpumask_next(smp_processor_id(), cpu_online_mask);
+	/* raw_ OK because just using CPU as starting point. */
+	cpu = cpumask_next(raw_smp_processor_id(), cpu_online_mask);
         if (cpu >= nr_cpu_ids) {
 		cpu = cpumask_first(cpu_online_mask);
 
-- 
1.7.3.2
