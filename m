Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F8C41A00AE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 17:56:22 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 18 Nov 2014 01:56:19 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 8CE2738C803B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 01:55:08 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAI6uIiY14876836
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 06:56:18 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAI6uG2w005501
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 01:56:17 -0500
Subject: [PATCH] cpuidle/powernv: Re-enable fastsleep at boot time
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, mikey@neuling.org, joel.stanley@au1.ibm.com
Date: Tue, 18 Nov 2014 12:26:03 +0530
Message-ID: <20141118065603.22544.88816.stgit@preeti.in.ibm.com>
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

Commit dcb18694 "Fix ipi on palmeto" disabled fastsleep at boot time.
Revert this commit since we no longer need this fix. However we can
continue to use powersave_nap parameter to control entry into deep
idle states beyond snooze.

Signed-off-by: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
---

 drivers/cpuidle/cpuidle-powernv.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index b57681d..b430e76 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -69,8 +69,9 @@ static int fastsleep_loop(struct cpuidle_device *dev,
 	unsigned long old_lpcr = mfspr(SPRN_LPCR);
 	unsigned long new_lpcr;
 
-	if (powersave_nap < 2)
-		return;
+	if (!(powersave_nap > 0))
+		return index;
+
 	if (unlikely(system_state < SYSTEM_RUNNING))
 		return index;
 
