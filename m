Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9E8D12C0330
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 21:22:42 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 30 Jul 2012 16:52:39 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6UBMP1H23396406
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 16:52:26 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6UBMORb027472
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 21:22:25 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V5 08/13] arch/powerpc: Use the rquired number of VSID bits
 in slbmte
Date: Mon, 30 Jul 2012 16:52:14 +0530
Message-Id: <1343647339-25576-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1343647339-25576-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1343647339-25576-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

ASM_VSID_SCRAMBLE can leave non-zero bits in the high 28 bits of the result
for 256MB segment (40 bits for 1T segment). Properly mask them before using
the values in slbmte

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slb_low.S |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index c355af6..8e5c9bd 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -226,7 +226,11 @@ _GLOBAL(slb_allocate_user)
  */
 slb_finish_load:
 	ASM_VSID_SCRAMBLE(r10,r9,256M)
-	rldimi	r11,r10,SLB_VSID_SHIFT,16	/* combine VSID and flags */
+	/*
+	 * bits above VSID_BITS_256M need to be ignored from r10
+	 * also combine VSID and flags
+	 */
+	rldimi	r11,r10,SLB_VSID_SHIFT,(64 - (SLB_VSID_SHIFT + VSID_BITS_256M))
 
 	/* r3 = EA, r11 = VSID data */
 	/*
@@ -290,7 +294,11 @@ _GLOBAL(slb_compare_rr_to_size)
 slb_finish_load_1T:
 	srdi	r10,r10,40-28		/* get 1T ESID */
 	ASM_VSID_SCRAMBLE(r10,r9,1T)
-	rldimi	r11,r10,SLB_VSID_SHIFT_1T,16	/* combine VSID and flags */
+	/*
+	 * bits above VSID_BITS_1T need to be ignored from r10
+	 * also combine VSID and flags
+	 */
+	rldimi	r11,r10,SLB_VSID_SHIFT_1T,(64 - (SLB_VSID_SHIFT_1T + VSID_BITS_1T))
 	li	r10,MMU_SEGSIZE_1T
 	rldimi	r11,r10,SLB_VSID_SSIZE_SHIFT,0	/* insert segment size */
 
-- 
1.7.10
