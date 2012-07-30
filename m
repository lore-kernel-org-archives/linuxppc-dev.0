Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6E08C2C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 21:22:34 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 30 Jul 2012 16:52:30 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6UBMQYQ15597608
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 16:52:27 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6UBMPFL027658
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 21:22:26 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V5 09/13] arch/powerpc: Use 32bit array for slb cache
Date: Mon, 30 Jul 2012 16:52:15 +0530
Message-Id: <1343647339-25576-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

With larger vsid we need to track more bits of ESID in slb cache
for slb invalidate.

Reviewed-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/paca.h |    2 +-
 arch/powerpc/mm/slb_low.S       |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index daf813f..3e7abba 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -100,7 +100,7 @@ struct paca_struct {
 	/* SLB related definitions */
 	u16 vmalloc_sllp;
 	u16 slb_cache_ptr;
-	u16 slb_cache[SLB_CACHE_ENTRIES];
+	u32 slb_cache[SLB_CACHE_ENTRIES];
 #endif /* CONFIG_PPC_STD_MMU_64 */
 
 #ifdef CONFIG_PPC_BOOK3E
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 8e5c9bd..db2cb3f 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -273,10 +273,10 @@ _GLOBAL(slb_compare_rr_to_size)
 	bge	1f
 
 	/* still room in the slb cache */
-	sldi	r11,r3,1		/* r11 = offset * sizeof(u16) */
-	rldicl	r10,r10,36,28		/* get low 16 bits of the ESID */
-	add	r11,r11,r13		/* r11 = (u16 *)paca + offset */
-	sth	r10,PACASLBCACHE(r11)	/* paca->slb_cache[offset] = esid */
+	sldi	r11,r3,2		/* r11 = offset * sizeof(u32) */
+	srdi    r10,r10,28		/* get the 36 bits of the ESID */
+	add	r11,r11,r13		/* r11 = (u32 *)paca + offset */
+	stw	r10,PACASLBCACHE(r11)	/* paca->slb_cache[offset] = esid */
 	addi	r3,r3,1			/* offset++ */
 	b	2f
 1:					/* offset >= SLB_CACHE_ENTRIES */
-- 
1.7.10
