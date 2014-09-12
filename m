Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 82F9F1A009D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 21:01:51 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 12 Sep 2014 05:01:49 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id BE7F51FF0028
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 05:01:44 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8CB1jIR48824528
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 13:01:45 +0200
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8CB1jvg002960
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 05:01:45 -0600
Subject: [PATCH] cpuidle/powernv: Enter fastsleep on checking if deep idle
 states are allowed
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
To: mikey@neuling.org, mpe@ellerman.id.au, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org
Date: Fri, 12 Sep 2014 16:31:32 +0530
Message-ID: <20140912110131.7311.86417.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Today the procfs interface /proc/sys/kernel/powersave-nap is used to control
entry into deep idle states beyond snooze. Check for the value of this
parameter before entering fastsleep. We already do this check for nap in
power7_idle().

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---

 drivers/cpuidle/cpuidle-powernv.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index a64be57..b8ba52e 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -69,6 +69,12 @@ static int fastsleep_loop(struct cpuidle_device *dev,
 	unsigned long old_lpcr = mfspr(SPRN_LPCR);
 	unsigned long new_lpcr;
 
+	/*
+	 * Verify if snooze is the only valid cpuidle state
+	 */
+	if (!(powersave_nap > 0))
+		return index;
+
 	if (unlikely(system_state < SYSTEM_RUNNING))
 		return index;
 
