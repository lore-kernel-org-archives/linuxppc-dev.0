Return-Path: <kniht@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 36516DDEF6
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 04:49:28 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4HInNcC009132
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 14:49:23 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4HInN6j215398
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 12:49:23 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4HInNYI031483
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 12:49:23 -0600
Received: from [9.10.86.203] (skynet.rchland.ibm.com [9.10.86.203])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l4HInM23031476
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 12:49:23 -0600
Message-ID: <464CA3B2.2010202@linux.vnet.ibm.com>
Date: Thu, 17 May 2007 13:49:22 -0500
From: Jon Tollefson <kniht@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: move common code out of if/else
References: <464B50AA.9060807@us.ibm.com>
In-Reply-To: <464B50AA.9060807@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Resubmitting with white space damage repaired.

Move common code out of if/else.

Signed-off-by: Jon Tollefson <kniht@linux.vnet.ibm.com>
----

hash_native_64.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)



diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 4a20d89..bb76814 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -233,15 +233,14 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 	/* Even if we miss, we need to invalidate the TLB */
 	if (!HPTE_V_COMPARE(hpte_v, want_v) || !(hpte_v & HPTE_V_VALID)) {
 		DBG_LOW(" -> miss\n");
-		native_unlock_hpte(hptep);
 		ret = -1;
 	} else {
 		DBG_LOW(" -> hit\n");
 		/* Update the HPTE */
 		hptep->r = (hptep->r & ~(HPTE_R_PP | HPTE_R_N)) |
 			(newpp & (HPTE_R_PP | HPTE_R_N | HPTE_R_C));
-		native_unlock_hpte(hptep);
 	}
+	native_unlock_hpte(hptep);
 
 	/* Ensure it is out of the tlb too. */
 	tlbie(va, psize, local);
