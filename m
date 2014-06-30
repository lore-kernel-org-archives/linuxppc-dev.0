Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 116E91A0018
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jun 2014 16:29:02 +1000 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 30 Jun 2014 00:28:58 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 9B58F19D803E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jun 2014 00:28:46 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5U6StPR11796784
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jun 2014 08:28:55 +0200
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5U6Ssrc030699
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jun 2014 00:28:55 -0600
Subject: [PATCH] powerpc/powernv: Check for IRQHAPPENED before sleeping
To: benh@kernel.crashing.org, mikey@neuling.org, mpe@ellerman.id.au
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Mon, 30 Jun 2014 11:54:05 +0530
Message-ID: <20140630062404.29315.23382.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: shreyas@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 8d6f7c5a: "powerpc/powernv: Make it possible to skip the IRQHAPPENED
check in power7_nap()" added code that prevents even cores which enter sleep
on idle, from checking for pending interrupts. Fix this.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/idle_power7.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index 2480256..5cf3d36 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -131,7 +131,7 @@ _GLOBAL(power7_nap)
 
 _GLOBAL(power7_sleep)
 	li	r3,1
-	li	r4,0
+	li	r4,1
 	b	power7_powersave_common
 	/* No return */
 
