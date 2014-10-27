Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 600F91A1A1E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 00:26:29 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 27 Oct 2014 09:26:26 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 33D836E804C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 09:15:08 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9RDQOfj8782198
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 13:26:24 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9RDQNrw011786
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 09:26:24 -0400
Subject: [PATCH] cpuidle/powernv: Fix return value of idle index in fastsleep
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, mikey@neuling.org, joel.stanley@au1.ibm.com
Date: Mon, 27 Oct 2014 18:56:18 +0530
Message-ID: <20141027132618.9085.97044.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 rjw@rjwysocki.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit dcb18694 : Fix ipi on Palmeto added a workaround to disable
going into fastsleep on Palmeto boards which was reported to fail
to boot when fastsleep was enabled. However it missed returning
an idle index. Fix this.

There is probably no harm in returning the index of fastsleep
although the cpu did not enter this state. The governor will notice
the difference in the residency time in the idle state and the
target residency of the idle state and prevent cpus from entering
fastsleep from that point on. Hence the usage and time statistics
logged for fastsleep will not be out of sync with reality except
for the first entry.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
Do we still need this workaround? Or can we get rid of the check
on powersave_nap altogether?
---

 drivers/cpuidle/cpuidle-powernv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index fa79392..c18da24 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -70,7 +70,7 @@ static int fastsleep_loop(struct cpuidle_device *dev,
 	unsigned long new_lpcr;
 
 	if (powersave_nap < 2)
-		return;
+		return index;
 	if (unlikely(system_state < SYSTEM_RUNNING))
 		return index;
 
