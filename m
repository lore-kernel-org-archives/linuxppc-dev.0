Return-Path: <kniht@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E2A34DDEDE
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 04:42:54 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4GIgp0j028528
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 14:42:51 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4GIgpcC554194
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 14:42:51 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4GIgpgj031320
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 14:42:51 -0400
Received: from [9.67.216.160] (wecm-9-67-216-160.wecm.ibm.com [9.67.216.160])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l4GIgpQm031305
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 14:42:51 -0400
Message-ID: <464B50AA.9060807@us.ibm.com>
Date: Wed, 16 May 2007 13:42:50 -0500
From: Jon Tollefson <kniht@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: move common code out of if/else
Content-Type: text/plain; charset=ISO-8859-1
Reply-To: kniht@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

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
-               native_unlock_hpte(hptep);
                ret = -1;
        } else {
                DBG_LOW(" -> hit\n");
                /* Update the HPTE */
                hptep->r = (hptep->r & ~(HPTE_R_PP | HPTE_R_N)) |
                        (newpp & (HPTE_R_PP | HPTE_R_N | HPTE_R_C));
-               native_unlock_hpte(hptep);
        }
+       native_unlock_hpte(hptep);
 
        /* Ensure it is out of the tlb too. */
        tlbie(va, psize, local);
