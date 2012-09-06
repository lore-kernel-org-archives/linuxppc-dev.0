Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 48A872C0482
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2012 01:30:09 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 7 Sep 2012 01:28:44 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q86FKahQ22806780
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Sep 2012 01:20:36 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q86FTauZ005898
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Sep 2012 01:29:36 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V8 09/11] arch/powerpc: Use 32bit array for slb cache
Date: Thu,  6 Sep 2012 20:59:09 +0530
Message-Id: <1346945351-7672-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
index 3b75f19..f6a2625 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -270,10 +270,10 @@ _GLOBAL(slb_compare_rr_to_size)
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
