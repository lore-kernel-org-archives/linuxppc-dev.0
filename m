Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 31EFE1007DC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 00:18:10 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 29 Jun 2012 14:08:35 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5TEAQ1h57999608
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 00:10:26 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5TEI4pp000395
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 00:18:04 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au,
 anton@samba.org
Subject: [PATCH -V1 7/9] arch/powerpc: Use 50 bits of VSID in slbmte
Date: Fri, 29 Jun 2012 19:47:35 +0530
Message-Id: <1340979457-26018-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1340979457-26018-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1340979457-26018-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Increase the number of valid VSID bits in slbmte instruction.
We will use the new bits when we increase valid VSID bits.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slb_low.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index c355af6..c1fc81c 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -226,7 +226,7 @@ _GLOBAL(slb_allocate_user)
  */
 slb_finish_load:
 	ASM_VSID_SCRAMBLE(r10,r9,256M)
-	rldimi	r11,r10,SLB_VSID_SHIFT,16	/* combine VSID and flags */
+	rldimi	r11,r10,SLB_VSID_SHIFT,2	/* combine VSID and flags */
 
 	/* r3 = EA, r11 = VSID data */
 	/*
@@ -290,7 +290,7 @@ _GLOBAL(slb_compare_rr_to_size)
 slb_finish_load_1T:
 	srdi	r10,r10,40-28		/* get 1T ESID */
 	ASM_VSID_SCRAMBLE(r10,r9,1T)
-	rldimi	r11,r10,SLB_VSID_SHIFT_1T,16	/* combine VSID and flags */
+	rldimi	r11,r10,SLB_VSID_SHIFT_1T,2	/* combine VSID and flags */
 	li	r10,MMU_SEGSIZE_1T
 	rldimi	r11,r10,SLB_VSID_SSIZE_SHIFT,0	/* insert segment size */
 
-- 
1.7.10
