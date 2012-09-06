Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp07.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 655DF2C0282
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2012 01:29:39 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 7 Sep 2012 01:27:55 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q86FTYYb30867684
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Sep 2012 01:29:34 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q86FTYWq005786
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Sep 2012 01:29:34 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V8 08/11] arch/powerpc: Use the required number of VSID bits
 in slbmte
Date: Thu,  6 Sep 2012 20:59:08 +0530
Message-Id: <1346945351-7672-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1346945351-7672-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1346945351-7672-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Reviewed-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slb_low.S |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index e132dc6..3b75f19 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -223,7 +223,11 @@ _GLOBAL(slb_allocate_user)
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
@@ -287,7 +291,11 @@ _GLOBAL(slb_compare_rr_to_size)
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
